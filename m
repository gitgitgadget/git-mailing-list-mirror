From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/7] tests: Fix race condition in t7006-pager
Date: Mon, 22 Feb 2010 02:46:33 -0600
Message-ID: <20100222084633.GA14432@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
 <20100219071857.GF29916@progeny.tock>
 <7v8wanq0c3.fsf@alter.siamese.dyndns.org>
 <20100221020317.GA7651@progeny.tock>
 <4B823E21.1060707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:05:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjU2m-000391-Eu
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 09:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab0BVIx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 03:53:27 -0500
Received: from mail-gx0-f225.google.com ([209.85.217.225]:43378 "EHLO
	mail-gx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0BVIx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 03:53:27 -0500
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2010 03:53:27 EST
Received: by gxk25 with SMTP id 25so260747gxk.17
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/V9/coCGbgbIHkKjF4YC0VHG8tvjAp1s7Hi3K9X404s=;
        b=By6Nl/VIzUIJX+/RskXUYxwM+VsD0dhGuoAQfytmSr1nWo+N/2q5ARKXC7HgjuH+qS
         yHKSlOkhIqdgiB/Z75vf5zQ3TR0LMdOtgwmzZEMNqfo8JkK3UXH4xSGzcfimBTCJ1UD4
         bst9Q6nyqCfol0MjbghSHJGmTCbDjkUzZow6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wD1JKqtgdjzAk9Dj26kB2r7BYs4gnqgI6J0wN9WjD7GHn3XfhqOf+wDm+/w3NpCnA/
         twTbWrhPtDoyjjeIN3GcIhvLwNmr4q9xUR8nrR9r2RSWzF7KsxNNc4qI73l/eWle7zlo
         cLTrU8L8UjGWIEuYg9wHTKjTQTLU1d4O1KrR8=
Received: by 10.90.7.13 with SMTP id 13mr3980771agg.75.1266828389124;
        Mon, 22 Feb 2010 00:46:29 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1705167yxe.0.2010.02.22.00.46.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 00:46:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B823E21.1060707@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140654>

Pagers that do not consume their input are dangerous: for example,

 $ GIT_PAGER=: git log
 $ echo $?
 141
 $

The only reason these tests were able to work before was that
'git log' would write to the pipe (and not fill it) before the
pager had time to terminate and close the pipe.

Fix it by using a program that consumes its input, namely wc (as
suggested by Johannes).

Reported-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Johannes Sixt wrote:

> Don't the following pager settings suffer from a race condition?

Yes.  Thanks for noticing.

 t/t7006-pager.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index da0f962..ec6fd06 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -137,7 +137,7 @@ rm -f default_pager_used
 test_expect_success SIMPLEPAGER 'default pager is used by default' '
 	cat > $less <<-EOF &&
 	#!$SHELL_PATH
-	: > default_pager_used
+	wc > default_pager_used
 	EOF
 	chmod +x $less &&
 	PATH=.:$PATH test_terminal git log &&
@@ -148,7 +148,7 @@ unset GIT_PAGER
 git config --unset core.pager
 rm -f PAGER_used
 test_expect_success TTY 'PAGER overrides default pager' '
-	PAGER=": > PAGER_used" &&
+	PAGER="wc > PAGER_used" &&
 	export PAGER &&
 	test_terminal git log &&
 	test -e PAGER_used
@@ -159,7 +159,7 @@ rm -f core.pager_used
 test_expect_success TTY 'core.pager overrides PAGER' '
 	PAGER=: &&
 	export PAGER &&
-	git config core.pager ": > core.pager_used" &&
+	git config core.pager "wc > core.pager_used" &&
 	test_terminal git log &&
 	test -e core.pager_used
 '
@@ -167,7 +167,7 @@ test_expect_success TTY 'core.pager overrides PAGER' '
 rm -f GIT_PAGER_used
 test_expect_success TTY 'GIT_PAGER overrides core.pager' '
 	git config core.pager : &&
-	GIT_PAGER=": > GIT_PAGER_used" &&
+	GIT_PAGER="wc > GIT_PAGER_used" &&
 	export GIT_PAGER &&
 	test_terminal git log &&
 	test -e GIT_PAGER_used
-- 
1.7.0
