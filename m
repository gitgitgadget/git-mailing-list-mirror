From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] adapt request-pull tests for new pull request format
Date: Sat, 24 Apr 2010 07:29:52 -0500
Message-ID: <20100424122952.GA14196@progeny.tock>
References: <20100424120437.GA12237@progeny.tock>
 <20100424121151.GA12312@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 14:29:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5eUO-0005NA-HW
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 14:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0DXM3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 08:29:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60263 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0DXM3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 08:29:21 -0400
Received: by gwj19 with SMTP id 19so3165047gwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pVI0n3/jGHuYWG86K5sjMUFQVt7cxdetjthqL5jiPdw=;
        b=OGmmSi6Qy39P5LY7uLu6oOq1PCO5gxtMANH2RLz8zZVUqZgy6I7xss9TNzO3PN2OJ7
         IEV6aDHpInLCJEFA8wU8YSmtAsv/Z9Zd+KvSH6LxeUshaqQMNVru69o8nq23JZ9kTF8p
         ZPxQqhIj14HljjBeR0CJ8uw3rq5ve/CWDTJQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EhzcTq+HJmFj4cSfdgv6AQF7TqIxQ94qHF4CV5hPe5jV+XApV8RoahpvgqBgEA/Ut9
         FN9zUVAKY5EhIFs3oW53JRlgWfWfRTGX+EN9W6JvH60nc+nX7mqlfDJwrH0T6AuFOnOd
         7cL612OxY6CSGV+cCEq+bPZ4MUdAml4LKdwUM=
Received: by 10.150.48.27 with SMTP id v27mr1655210ybv.53.1272112160380;
        Sat, 24 Apr 2010 05:29:20 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1467438iwn.2.2010.04.24.05.29.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 05:29:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424121151.GA12312@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145671>

10eb0007 (request-pull: avoid mentioning that the start point is a
single commit, 2010-01-29), changed the pull request format, so the
test needs some changes to still pass:

 - tolerate a missing blank line between =E2=80=9Cin the git repository=
 at:=E2=80=9D
   and the name of repository and branch

 - recognize subject and date in the new request format

 - update the expected request template to match the new format

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t5150-request-pull.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 4c7f48a..b31b828 100644
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -69,8 +69,7 @@ test_expect_success 'setup: two scripts for reading p=
ull requests' '
 	#!/bin/sed -nf
 	/ in the git repository at:$/! d
 	n
-	/^$/! q
-	n
+	/^$/ n
 	s/^[ 	]*\(.*\) \([^ ]*\)/please pull\
 	\1\
 	\2/p
@@ -81,7 +80,9 @@ test_expect_success 'setup: two scripts for reading p=
ull requests' '
 	#!/bin/sed -nf
 	s/$_x40/OBJECT_NAME/g
 	s/A U Thor/AUTHOR/g
+	s/[-0-9]\{10\} [:0-9]\{8\} [-+][0-9]\{4\}/DATE/g
 	s/        [^ ].*/        SUBJECT/g
+	s/  [^ ].* (DATE)/  SUBJECT (DATE)/g
 	s/$downstream_url_for_sed/URL/g
 	s/for-upstream/BRANCH/g
 	s/mnemonic.txt/FILENAME/g
@@ -188,11 +189,10 @@ test_expect_success 'pull request format' '
 	git init --bare downstream.git &&
 	cat <<-\EOT >expect &&
 	The following changes since commit OBJECT_NAME:
-	  AUTHOR (1):
-	        SUBJECT
=20
-	are available in the git repository at:
+	  SUBJECT (DATE)
=20
+	are available in the git repository at:
 	  URL BRANCH
=20
 	SHORTLOG
--=20
1.7.1.rc1
