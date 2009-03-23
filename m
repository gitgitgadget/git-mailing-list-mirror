From: Benny Halevy <bhalevy@panasas.com>
Subject: git rebase + fuzz = possible bad merge
Date: Mon, 23 Mar 2009 12:41:34 +0200
Message-ID: <49C7675E.9000309@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llhcg-0007aF-Fy
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724AbZCWKln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbZCWKln
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:41:43 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:43873 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbZCWKlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:41:42 -0400
Received: by qyk16 with SMTP id 16so2378196qyk.33
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=wqOy4ZrmyA0+vqt1HlJuR2FFEXsbSDkQXolU6L2MmjI=;
        b=cI5DuNvI/l4Bey2uzCROHLXPnjnnx/tNuzKXNRYA3HLfg7wtw3usgeQaxUeBSWAqZr
         SqsiDG0YYpEgaeAxhD8ZhIBuUA8W4x7HjizsKRmvvSYbpMjFyV+ErVpC8KOEqT9OCuBR
         6vGjihCk/tbduLNhOaD6L84am+B/mkESU7JMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mtYyJBlR2GQWYvkZ/FvoK+3/NjmwQ8MH/ggr1OpApgWD+6IPYv0AE6VxRjBhoRqQHv
         zOAwOVs7AM78BVux2CJvKX3Bv1klOaR4xIfDBfSVVzLXPOSXn4/d6IlOnaBbIZgjZF8v
         gCsFxt/zF/yF8oKcYyzyhx9g3+mKHCv5W4gEw=
Received: by 10.224.6.130 with SMTP id 2mr8520158qaz.366.1237804899884;
        Mon, 23 Mar 2009 03:41:39 -0700 (PDT)
Received: from fs1.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 9sm6879547yxs.56.2009.03.23.03.41.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:41:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1b3pre) Gecko/20090223 Thunderbird/3.0b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114283>

I'm hitting bad merges with (non interactive) git rebase
when a hunk is merged pre-maturely into an inexact match
when there's fuzz.

The following shell script reproduce this with
git version 1.6.2.1:

#!/bin/sh

rm -rf test_file .git
git init

cat >test_file <<EOF
struct one {
	line 1;
	line 2;
	line 3;
	line 4;
	line 5;
	line 6;
	line 7;
};

struct two {
	line 1;
	line 2;
	line 3;
	line 4;
	line 5;
	line 6;
	line 7;
};
EOF

git add test_file
git commit -m test_file

git am <<EOF
From: Benny Halevy <bhalevy@panasas.com>
Subject: change struct two

diff --git a/test_file b/test_file
--- a/test_file
+++ b/test_file
@@ -12,7 +12,7 @@ struct two {
 	line 1;
 	line 2;
 	line 3;
-	line 4;
+	LINE 4;
 	line 5;
 	line 6;
 	line 7;
EOF

git checkout -b test_branch HEAD^
{ for i in {1..10}; do echo fuzz $i; done; echo; cat test_file; } > fuzz_file
mv fuzz_file test_file

git commit -a -m fuzz

git rebase --onto test_branch master^ master

if [ $(awk '/LINE/ {print NR}' test_file) != 26 ]; then
	echo 1>&2 $0: test failed
	exit 1
else
	echo 1>&2 $0: test succeeded
fi
