From: Sina Siadat <siadat@gmail.com>
Subject: [PATCH] git-add-interactive: edit current file in editor
Date: Tue, 28 Jul 2015 04:11:22 +0430
Message-ID: <1438040482-4599-1-git-send-email-siadat@gmail.com>
Cc: Sina Siadat <siadat@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 01:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJs1Z-0006bh-L5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 01:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbbG0Xlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 19:41:32 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35445 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbbG0Xl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 19:41:29 -0400
Received: by qkbm65 with SMTP id m65so45362017qkb.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z8yAo5FhXxgdRAI2GKzDtPc3hJWlwYgpoaysGIPE0vA=;
        b=d3l8npGEfIyLdJw86y0gBGt++QNM4ylgGcIYPe/NiY5l1/YOBHkv0zKzR4Ph+8EG7C
         U2UhqcU2IRN/yzZBQ5RFUxyDMHvheGpVPPjySeIye4aI9raNWOirnJeiRSKrNZXfkoQX
         sFTZqjcmb7+cA13Pu9Q3KhWIs9N6ZusE3gAJxV7Q4tjuVf+fCGfqueZuzx60k2aQ6qU6
         +kGH7L6sdLgFRnb76uz5QWfb2eTrNAnPvS+EUzhNNp3kyJyx2fqAU5YxoEVTMOctiGRn
         fcHMfX8uMW86+sZARXftEjCnTW0IFJPkfcqux4QNAWs4lbx1HYZPZ4O1yQRrzIHZ8w+t
         W8rw==
X-Received: by 10.55.25.143 with SMTP id 15mr43906289qkz.72.1438040488960;
        Mon, 27 Jul 2015 16:41:28 -0700 (PDT)
Received: from linode.com (li1237-175.members.linode.com. [45.79.138.175])
        by smtp.gmail.com with ESMTPSA id 74sm10210593qgo.13.2015.07.27.16.41.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 16:41:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.2.g6f9504c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274722>

Adds a new option 'o' to the 'add -p' command that lets you open and edit the
current file.

The existing 'e' mode is used to manually edit the hunk.  The new 'o' option
allows you to open and edit the file without having to quit the loop. The hunks
are updated when the editing is done, and the user will be able to review the
updated hunks.  Without this option you would have to quit the loop, edit the
file, and execute 'add -p filename' again.

I would appreciate it if you could let me know what you think about this
option. I will write more tests if there is any interest at all.

Thank you. :)

---
 Documentation/git-add.txt  |  1 +
 git-add--interactive.perl  | 11 ++++++++++-
 t/t3701-add-interactive.sh |  6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index fe5282f..6752eb0 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -312,6 +312,7 @@ patch::
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       o - open this file in editor
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 77876d4..a44f3b3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1175,6 +1175,7 @@ k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
+o - open this file in editor
 ? - print help
 EOF
 }
@@ -1359,7 +1360,7 @@ sub patch_update_file {
 		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
 		   ' this hunk'),
 		  $patch_mode_flavour{TARGET},
-		  " [y,n,q,a,d,/$other,?]? ";
+		  " [y,n,q,a,d,o,/$other,?]? ";
 		my $line = prompt_single_character;
 		last unless defined $line;
 		if ($line) {
@@ -1378,6 +1379,14 @@ sub patch_update_file {
 				}
 				next;
 			}
+			elsif ($line =~ /^o/) {
+				chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
+				system('sh', '-c', $editor.' "$@"', $editor, $path);
+				($head, @hunk) = parse_diff($path);
+				$num = scalar @hunk;
+				$ix = 0;
+				next;
+			}
 			elsif ($other =~ /g/ && $line =~ /^g(.*)/) {
 				my $response = $1;
 				my $no = $ix > 10 ? $ix - 10 : 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index deae948..e5dd1c6 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -98,6 +98,12 @@ test_expect_success 'dummy edit works' '
 	test_cmp expected diff
 '
 
+test_expect_success 'dummy open works' '
+	(echo o; echo a) | git add -p &&
+	git diff > diff &&
+	test_cmp expected diff
+'
+
 test_expect_success 'setup patch' '
 cat >patch <<EOF
 @@ -1,1 +1,4 @@
-- 
2.5.0.rc3.2.g6f9504c.dirty
