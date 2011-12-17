From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: fix skipSubmitEdit regression
Date: Sat, 17 Dec 2011 12:39:03 -0500
Message-ID: <20111217173903.GA13674@padd.com>
References: <1315514452.10046.0.camel@uncle-pecos>
 <4E6DB5F0.7080303@diamand.org>
 <1315847540.10046.29.camel@uncle-pecos>
 <20111018004500.GA31768@arf.padd.com>
 <4E9DBD0B.7020505@diamand.org>
 <20111020011610.GA7292@arf.padd.com>
 <CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
 <4EEBA106.9010001@diamand.org>
 <CAFLRbor3Gnqhudmg8G_U37Nbo7ENoCEy0iFVGRP4i_AmatJHxw@mail.gmail.com>
 <CAFLRboqJAC0h27m=B9Tw5SFcupEgn4fe9YvWksgqxOVs20nFHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	"L. A. Linden Levy" <alevy@mobitv.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 18:41:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbyGI-0004D3-Nm
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 18:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab1LQRlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 12:41:07 -0500
Received: from honk.padd.com ([74.3.171.149]:57523 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578Ab1LQRjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 12:39:08 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id A852B1C89;
	Sat, 17 Dec 2011 09:39:06 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 939C6314A8; Sat, 17 Dec 2011 12:39:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAFLRboqJAC0h27m=B9Tw5SFcupEgn4fe9YvWksgqxOVs20nFHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187386>

Commit 7c766e5 (git-p4: introduce skipSubmitEdit, 2011-12-04)
made it easier to automate submission to p4, but broke the most
common case.

Add a test for when the user really does edit and save the change
template, and fix the bug that causes the test to fail.

Also add a confirmation message when submission is cancelled.

Reported-by: Michael Horowitz <michael.horowitz@ieee.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
michael.horowitz@ieee.org wrote on Fri, 16 Dec 2011 19:49 -0500:
> Oh, and in the case where you do edit the template, it doesn't give
> you an error or anything, it looks like it succeeded, but you'll
> notice the change never got submitted to Perforce.  If you look
> carefully though, you can see it reverting each of your edited files
> in the P4 tree.
[..]
> >> On 16/12/11 15:38, Michael Horowitz wrote:
> >>>
> >>> It appears that this change has introduced a bug that causes subm=
it to
> >>> fail every time if you do not skip the submit edit.
> >>>
> >>>=A0From what I can tell, this is because the new edit_template met=
hod
> >>> does not return True at the end.

Oops.  In adding this code, I failed to test what should be the
normal code path.  How sad.

Junio:  this bug is in master.  Could you apply this fix?

		-- Pete

 contrib/fast-import/git-p4  |   18 +++++++++++-------
 t/t9805-skip-submit-edit.sh |   24 +++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3571362..d501eac 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -878,13 +878,16 @@ class P4Submit(Command, P4UserMap):
         if gitConfig("git-p4.skipSubmitEditCheck") =3D=3D "true":
             return True
=20
-        if os.stat(template_file).st_mtime <=3D mtime:
-            while True:
-                response =3D raw_input("Submit template unchanged. Sub=
mit anyway? [y]es, [n]o (skip this patch) ")
-                if response =3D=3D 'y':
-                    return True
-                if response =3D=3D 'n':
-                    return False
+        # modification time updated means user saved the file
+        if os.stat(template_file).st_mtime > mtime:
+            return True
+
+        while True:
+            response =3D raw_input("Submit template unchanged. Submit =
anyway? [y]es, [n]o (skip this patch) ")
+            if response =3D=3D 'y':
+                return True
+            if response =3D=3D 'n':
+                return False
=20
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=3D1 --pr=
etty=3Doneline %s" % id))
@@ -1068,6 +1071,7 @@ class P4Submit(Command, P4UserMap):
                         self.modifyChangelistUser(changelist, p4User)
             else:
                 # skip this patch
+                print "Submission cancelled, undoing p4 changes."
                 for f in editedFiles:
                     p4_revert(f)
                 for f in filesToAdd:
diff --git a/t/t9805-skip-submit-edit.sh b/t/t9805-skip-submit-edit.sh
index 734ccf2..df929e0 100755
--- a/t/t9805-skip-submit-edit.sh
+++ b/t/t9805-skip-submit-edit.sh
@@ -38,7 +38,7 @@ test_expect_success 'no config, unedited, say no' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 3 (not really)" &&
-		printf "bad response\nn\n" | "$GITP4" submit
+		printf "bad response\nn\n" | "$GITP4" submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count =3D 2 wc
 	)
@@ -74,6 +74,28 @@ test_expect_success 'skipSubmitEditCheck' '
 	)
 '
=20
+# check the normal case, where the template really is edited
+test_expect_success 'no config, edited' '
+	"$GITP4" clone --dest=3D"$git" //depot &&
+	test_when_finished cleanup_git &&
+	ed=3D"$TRASH_DIRECTORY/ed.sh" &&
+	test_when_finished "rm \"$ed\"" &&
+	cat >"$ed" <<-EOF &&
+		#!$SHELL_PATH
+		sleep 1
+		touch "\$1"
+		exit 0
+	EOF
+	chmod 755 "$ed" &&
+	(
+		cd "$git" &&
+		echo line >>file1 &&
+		git commit -a -m "change 5" &&
+		EDITOR=3D"\"$ed\"" "$GITP4" submit &&
+		p4 changes //depot/... >wc &&
+		test_line_count =3D 5 wc
+	)
+'
=20
 test_expect_success 'kill p4d' '
 	kill_p4d
--=20
1.7.8.154.g767b7.dirty
