From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Mon, 29 May 2006 23:58:56 -0700
Message-ID: <7vu0782e33.fsf@assigned-by-dhcp.cox.net>
References: <11489310153730-git-send-email-1>
	<11489310153598-git-send-email-1> <11489310151293-git-send-email-1>
	<11489310153617-git-send-email-1>
	<7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
	<7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 08:59:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkyBx-0004w5-Kp
	for gcvg-git@gmane.org; Tue, 30 May 2006 08:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWE3G67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 02:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWE3G67
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 02:58:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37827 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932146AbWE3G66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 02:58:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530065857.INXO15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 02:58:57 -0400
To: Ryan Anderson <rda@google.com>
In-Reply-To: <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 29 May 2006 23:45:29 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21020>

Junio C Hamano <junkio@cox.net> writes:

> On top of yours, I think this covers the CC: trouble your test
> triggers.

Sorry, I did not look closely enough.  You are trying to keep
the address human friendly as long as possible so that you can
place them on the headers, so the previous one was bogus.

*BLUSH*

I think this is lower impact.  On the other hand, it appears
that at least whatever pretends to be /usr/lib/sendmail on my
box seems to grok 'A <author@example.com>' just fine, so maybe
the test was bogus (in which case you should just change the
expected command line parameters to include the human name).

I dunno.

-- >8 --
From c95682409346f7acc220ac64f453933d5a59ec3f Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Mon, 29 May 2006 23:53:13 -0700
Subject: [PATCH] send-email: do not pass bogus address to local sendmail binary

This makes t9001 test happy.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-send-email.perl   |    4 +++-
 t/t9001-send-email.sh |   19 +++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d418d6c..ac84553 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -387,7 +387,9 @@ X-Mailer: git-send-email $gitversion
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
 		if (!$pid) {
-			exec($smtp_server,'-i',@recipients) or die $!;
+			exec($smtp_server,'-i',
+			     map { extract_valid_address($_) }
+			     @recipients) or die $!;
 		}
 		print $sm "$header\n$message";
 		close $sm or die $?;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 276cbac..a61da1e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -13,10 +13,14 @@ test_expect_success \
 
 test_expect_success \
     'Setup helper tool' \
-    'echo "#!/bin/sh" > fake.sendmail
-     echo "shift" >> fake.sendmail
-     echo "echo \"\$*\" > commandline" >> fake.sendmail
-     echo "cat > msgtxt" >> fake.sendmail
+    '(echo "#!/bin/sh"
+      echo shift
+      echo for a
+      echo do
+      echo "  echo \"!\$a!\""
+      echo "done >commandline"
+      echo "cat > msgtxt"
+      ) >fake.sendmail
      chmod +x ./fake.sendmail
      git add fake.sendmail
      GIT_AUTHOR_NAME="A" git commit -a -m "Second."'
@@ -26,9 +30,12 @@ test_expect_success \
     'git format-patch -n HEAD^1
      git send-email -from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" ./0001*txt'
 
+cat >expected <<\EOF
+!nobody@example.com!
+!author@example.com!
+EOF
 test_expect_success \
     'Verify commandline' \
-    'cline=$(cat commandline)
-     [ "$cline" == "nobody@example.com author@example.com" ]'
+    'diff commandline expected'
 
 test_done
-- 
1.3.3.g5029f
