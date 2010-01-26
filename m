From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 3/3] am: fix patch format detection for Thunderbird "Save As" emails
Date: Mon, 25 Jan 2010 16:33:59 -0800
Message-ID: <1264466039-22431-4-git-send-email-bebarino@gmail.com>
References: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Blake <ebb9@byu.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 01:34:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZZOA-0003ys-Lt
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 01:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab0AZAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 19:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868Ab0AZAeP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 19:34:15 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51812 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab0AZAeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 19:34:12 -0500
Received: by mail-gx0-f217.google.com with SMTP id 9so6019367gxk.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sgOqw5kYCMXdaeM1nhYdFwWCP0yUFl4BSLNHTJheT5M=;
        b=oa+HIcO9b1dkLfUd0ZKLwNl7ysXRnXDvr91S/8Um9Qe5rwxHwRL9F+OGgCR++PWTP4
         174c1S3v+un0vFA6e9beJofS/AQmSeuHju21VTqrzktqD6XgoYSXFbH7/2xqucI2zlxb
         uFlEXvLtU3Hj1ivEvifiQsbkht2avgp6t7o3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cj3CijEs8TSZrWuoQMI3DArdrXPZyfAN2p/NRx7nfe6k4Anq6Z9RDuhc59PG5IPy2D
         dWiKngVoKPZpocLqebug5EHB0kMuaQ09V+jDC5Ai7gU8ndoYk2MsG/V0a8bp+GgxMe53
         Vhu4ZozYeQGCNgJkXRqlv7ur1gl1LOWzTqnZ8=
Received: by 10.151.3.27 with SMTP id f27mr9367524ybi.339.1264466051812;
        Mon, 25 Jan 2010 16:34:11 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 4sm1851237yxd.70.2010.01.25.16.34.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Jan 2010 16:34:11 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc0
In-Reply-To: <1264466039-22431-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138014>

The patch detection wants to inspect all the headers of a rfc2822 message
and ensure that they look like header fields. The headers are always
separated from the message body with a blank line. When Thunderbird saves
the message the blank line separating the headers from the body includes a
CR. The patch detection is failing because a CRLF doesn't match /^$/. Fix
this by allowing a CR to exist on the separating line.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I gave up trying to make it portable and now just use append_cr() from
test-lib. Hopefully this is a much better and simpler approach.

 git-am.sh     |    3 ++-
 t/t4150-am.sh |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2f46fda..c8b9cbb 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -205,7 +205,8 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			tr -d '\015' <"$1" |
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8296605..a034918 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -83,6 +83,12 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1.eml &&
+	{
+		echo "X-Fake-Field: Line One" &&
+		echo "X-Fake-Field: Line Two" &&
+		echo "X-Fake-Field: Line Three" &&
+		git format-patch --stdout first | sed -e "1d"
+	} | append_cr >patch1-crlf.eml &&
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -123,6 +129,15 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
+	git checkout first &&
+	git am patch1-crlf.eml &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
 GIT_AUTHOR_NAME="Another Thor"
 GIT_AUTHOR_EMAIL="a.thor@example.com"
 GIT_COMMITTER_NAME="Co M Miter"
-- 
1.7.0.rc0
