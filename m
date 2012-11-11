From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git p4: handle servers without move support
Date: Sun, 11 Nov 2012 17:52:13 -0500
Message-ID: <20121111225213.GA15548@padd.com>
References: <1342135740-30290-1-git-send-email-pw@padd.com>
 <1342135740-30290-3-git-send-email-pw@padd.com>
 <loom.20121105T183530-627@post.gmane.org>
 <20121105175724.GB889@padd.com>
 <CAOpHH-VRhOHqeROfjeLBQxqft23VemJZntGNJ-y7CX0A8N3q1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ggibbons@perforce.com, Git Mailing List <git@vger.kernel.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXgOF-0003EX-Jq
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 23:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab2KKWwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 17:52:18 -0500
Received: from honk.padd.com ([74.3.171.149]:45231 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810Ab2KKWwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 17:52:17 -0500
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 87CAE20B7;
	Sun, 11 Nov 2012 14:52:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 25A5324005; Sun, 11 Nov 2012 17:52:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-VRhOHqeROfjeLBQxqft23VemJZntGNJ-y7CX0A8N3q1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209452>

Support for the "p4 move" command was added in 8e9497c (git p4:
add support for 'p4 move' in P4Submit, 2012-07-12), which checks
to make sure the client and server support the command.

But older versions of p4d may not handle the "-k" argument, and
newer p4d allow disabling "p4 move" with a configurable.  Check
for both these cases by testing a p4 move command on bogus
filenames and looking for strings in the error messages.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
vitor.hda@gmail.com wrote on Wed, 07 Nov 2012 21:06 +0000:
> On Mon, Nov 5, 2012 at 5:57 PM, Pete Wyckoff <pw@padd.com> wrote:
> > vitor.hda@gmail.com wrote on Mon, 05 Nov 2012 17:37 +0000:
> >> Hi Pete,
> >>
> >> I've just been hit by a situation where this command is available but is
> >> disabled in the server. I don't know what is the best approach to avoid
> >> this issue.
> >
> > Really?  The command exists in the server because it returns the
> > text output for "p4 help move".  But "p4 move" itself fails
> > because it is somehow disabled in the server?
> >
> > I didn't even know it was possible to administratively disable
> > commands.
> >
> > What's the actual error message?  And versions of your client and
> > server (p4 -V, p4d -V, p4 info).
> >
> > Any ideas Gary?
> 
> I don't feel comfortable in testing this again because I'm working in a
> production server. Can Gary provide any details on this type of
> configuration on the server side?

Gary explained how to administratively disable "p4 move".  This
patch checks for that condition, and "p4 move -k", which is
missing in p4d 2009.1.

I'm not super happy with it, due to the string-searching in the
error messages.  But I can't think of a better way:  if "p4 move
-k src dest" returns 1, is it because the server doesn't support
it?  arguments were wrong?  printer on fire?

Vitor, can you test that it works for you?  It's probably worth
putting in the code just so no one else finds the same mysterious
failure.

		-- Pete

 git-p4.py                | 21 ++++++++++++++++++++-
 t/t9814-git-p4-rename.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 882b1bb..417a66a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -129,6 +129,25 @@ def p4_has_command(cmd):
     p.communicate()
     return p.returncode == 0
 
+def p4_has_move_command():
+    """See if the move command exists, that it supports -k, and that
+       it has not been administratively disabled.  The arguments
+       must be correct, but the filenames do not have to exist.  Use
+       ones with wildcards so even if they exist, it will fail."""
+
+    if not p4_has_command("move"):
+        return False
+    cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
+    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    (out, err) = p.communicate()
+    # return code will be 1 in either case
+    if err.find("Invalid option") >= 0:
+        return False
+    if err.find("disabled") >= 0:
+        return False
+    # assume it failed because @... was invalid changelist
+    return True
+
 def system(cmd):
     expand = isinstance(cmd,basestring)
     if verbose:
@@ -871,7 +890,7 @@ class P4Submit(Command, P4UserMap):
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
         self.exportLabels = False
-        self.p4HasMoveCommand = p4_has_command("move")
+        self.p4HasMoveCommand = p4_has_move_command()
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 3bf1224..be802e0 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -199,6 +199,41 @@ test_expect_success 'detect copies' '
 	)
 '
 
+# See if configurables can be set, and in particular if the run.move.allow
+# variable exists, which allows admins to disable the "p4 move" command.
+test_expect_success 'p4 configure command and run.move.allow are available' '
+	p4 configure show run.move.allow >out ; retval=$? &&
+	test $retval = 0 &&
+	{
+		egrep ^run.move.allow: out &&
+		test_set_prereq P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW ||
+		true
+	} || true
+'
+
+# If move can be disabled, turn it off and test p4 move handling
+test_expect_success P4D_HAVE_CONFIGURABLE_RUN_MOVE_ALLOW \
+		    'do not use p4 move when administratively disabled' '
+	test_when_finished "p4 configure set run.move.allow=1" &&
+	p4 configure set run.move.allow=0 &&
+	(
+		cd "$cli" &&
+		echo move-disallow-file >move-disallow-file &&
+		p4 add move-disallow-file &&
+		p4 submit -d "add move-disallow-file"
+	) &&
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.detectRenames true &&
+		git mv move-disallow-file move-disallow-file-moved &&
+		git commit -m "move move-disallow-file" &&
+		git p4 submit
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.12.1.457.g468b3ef
