From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/6] Use a special exit code for bugs
Date: Thu, 20 Mar 2008 01:31:34 +0100
Message-ID: <20080320003134.13102.73631.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iA-0006sd-I5
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163276AbYCTAbo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163195AbYCTAbm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:31:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2849 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763323AbYCTAbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:31:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8gv-0004ry-00; Thu, 20 Mar 2008 00:31:33 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77597>

Use a special exit code (4) for any error condition that indicates a
bug in StGit. This will be useful in the test suite.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/main.py  |   11 +++++++----
 stgit/utils.py |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)


diff --git a/stgit/main.py b/stgit/main.py
index 79044b0..663fdec 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -18,7 +18,7 @@ along with this program; if not, write to the Free So=
ftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
+import sys, os, traceback
 from optparse import OptionParser
=20
 import stgit.commands
@@ -279,10 +279,13 @@ def main():
     except (StgException, IOError, ParsingError, NoSectionError), err:
         out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
-            raise
-        else:
-            sys.exit(utils.STGIT_COMMAND_ERROR)
+            traceback.print_exc()
+        sys.exit(utils.STGIT_COMMAND_ERROR)
     except KeyboardInterrupt:
         sys.exit(utils.STGIT_GENERAL_ERROR)
+    except:
+        out.error('Unhandled exception:')
+        traceback.print_exc()
+        sys.exit(utils.STGIT_BUG_ERROR)
=20
     sys.exit(ret or utils.STGIT_SUCCESS)
diff --git a/stgit/utils.py b/stgit/utils.py
index b75c3b4..cd52382 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -327,6 +327,7 @@ STGIT_SUCCESS =3D 0        # everything's OK
 STGIT_GENERAL_ERROR =3D 1  # seems to be non-command-specific error
 STGIT_COMMAND_ERROR =3D 2  # seems to be a command that failed
 STGIT_CONFLICT =3D 3       # merge conflict, otherwise OK
+STGIT_BUG_ERROR =3D 4      # a bug in StGit
=20
 def strip_leading(prefix, s):
     """Strip leading prefix from a string. Blow up if the prefix isn't
