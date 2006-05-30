From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Mon, 29 May 2006 23:45:29 -0700
Message-ID: <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net>
References: <11489310153730-git-send-email-1>
	<11489310153598-git-send-email-1> <11489310151293-git-send-email-1>
	<11489310153617-git-send-email-1>
	<7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 08:45:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkxz8-0003Oa-6O
	for gcvg-git@gmane.org; Tue, 30 May 2006 08:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWE3Gpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 02:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWE3Gpd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 02:45:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57003 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932169AbWE3Gpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 02:45:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530064530.MMNS5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 02:45:30 -0400
To: Ryan Anderson <rda@google.com>
In-Reply-To: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 29 May 2006 22:57:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21019>

Junio C Hamano <junkio@cox.net> writes:

>> 64ea8c0210c2e9d1711a870460eca326778a4ffc
>>  t/t9001-send-email.sh |   34 ++++++++++++++++++++++++++++++++++
>>  1 files changed, 34 insertions(+), 0 deletions(-)
>>  create mode 100755 t/t9001-send-email.sh
>
> Adds test, alright, but I do not see the fix.  Is this a thinko?

On top of yours, I think this covers the CC: trouble your test
triggers.

-- >8 -
send-email: fix cc address fed to underlying sendmail

---
diff --git a/git-send-email.perl b/git-send-email.perl
index d418d6c..d61ef8e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -448,9 +448,11 @@ foreach my $t (@files) {
 					else {
 						$author_not_sender = $2;
 					}
-					printf("(mbox) Adding cc: %s from line '%s'\n",
-						$2, $_) unless $quiet;
-					push @cc, $2;
+					my $cc = extract_valid_address($2);
+					printf("(mbox) Adding cc: %s from ".
+					       "line '%s'\n",
+						$cc, $_) unless $quiet;
+					push @cc, $cc;
 				}
 
 			} else {
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
