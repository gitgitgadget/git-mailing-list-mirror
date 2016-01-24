From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 09/19] mingw: accomodate t0060-path-utils for MSYS2
Date: Sun, 24 Jan 2016 16:44:49 +0100 (CET)
Message-ID: <12c030323940de4a0845eda9bdd7b67c4e90864a.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqX-00018e-6K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbcAXPoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:44:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:56863 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbcAXPow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:44:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MFMEG-1aHovN3NvY-00ELsO; Sun, 24 Jan 2016 16:44:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3dgpSqcwGdXxo9RxoUQkvXoVQ+UclYw4bYtT0T2vGDRBl5j7JIp
 MGlVj3eidtReRvqn0re34AxNff6lnIt45xh79AKniV8cPy32yWMJIt17rlFaNinFxUYYMK8
 Er6hKz1rzB2eh1nZ785HhWiHmvPNZKxF90YLNkv8G7NpR64ofTizV5kqL7GPNy11U/jtHBw
 kmpfIlErLdxaXozXOIvew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0kq+rWVGW/E=:hWjEe2/0RrefHwlD2VsByr
 kxI5qQ0twcqQhM5FPiO5BzaUGDcBbIQ/1xJYdjTj2p66TSqMY1N0DFPg1e90jGdQmJuTAPGU7
 QxBB2DHbDySphN4g2RPSkWhpC5NPX0lthXtwnZf8zXSjkKOxKHhgCE0rWRP/AT8ZjDxcLFlG+
 ID62Lt6pDJadX3MKisX1EM+W2V2H8V+ZrIV+UBeWxI6aUl+QZ1g3alHTLsiFw38wnpvSCzC7V
 D5R1yCdQD+NZR0JzDHQ6NLlw3AALal65tKN3HkPjYvoaWsOhwxPin2DPRnQhd6oHsmMMJ7cym
 +vocnU05p4fmcm6kdAIAe/FPJhD0llDYXZczqOCdOe20IwW+3h25F2k2NUj0w3O2nX9Z3Db21
 z+gR03r08EdlrWGxwU+8bu5yzmmUtOpu7HXvn2hmZgtT3u0UCHqZ1qeuVuIoxFu/ZzXYUJBa2
 CkSuEeBI9iwH3JIGIX5Y5NduK8nzBQC5J6dpH7pZMpZCiEyQ9lpi5D14oFgtaSJALRK4OZXVS
 bljT/Vrbo5KBi0iGCw5JSanm3sMZ0QfzUqWAv712+cAaxbwBR7jP2DPjnul+sk7bgiXEUkCQf
 H0VDVFryRS1mcOK1TQAW9nI3L/JqdO3AM5HjubIeeG3GdeeRGMPA9x7wAhLGMft2EqfdwsYi4
 74ik6pTjLInnFWwMJqWUaNMJU6bQdEeoriK+KaSvqkCjzQRu3tcPsW4825Sy0YYlRs8igejSs
 39rjaU3zZ40rHobq2o6Gs5mXRgGRVNcD718WFpIiy0972lnAMGec3sN7b63TdX1a0ziEM6Yu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284673>

On Windows, there are no POSIX paths, only Windows ones (an absolute
Windows path looks like "C:\Program Files\Git\ReleaseNotes.html", under
most circumstances, forward slashes are also allowed and synonymous to
backslashes).

So when a POSIX shell (such as MSYS2's Bash, which is used by Git for
Windows to execute all those shell scripts that are part of Git) passes
a POSIX path to test-path-utils.exe (which is not POSIX-aware), the path
is translated into a Windows path. For example, /etc/profile becomes
C:/Program Files/Git/etc/profile.

This path translation poses a problem when passing the root directory as
parameter to test-path-utils.exe, as it is not well defined whether the
translated root directory should end in a slash or not. MSys1 stripped
the trailing slash, but MSYS2 does not.

To work with both behaviors, we simply test what the current system does
in the beginning of t0060-path-utils.sh and then adjust the expected
longest ancestor length accordingly.

Originally, the Git for Windows project patched MSYS2's runtime to
accomodate Git's regression test, but we really should do it the other
way round.

Thanks to Ray Donnelly for his patient help with this issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index f0152a7..89d03e7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -7,6 +7,13 @@ test_description='Test various path utilities'
 
 . ./test-lib.sh
 
+# On Windows, the root directory "/" is translated into a Windows directory.
+# As it is not well-defined whether that Windows directory should end in a
+# slash or not, let's test for that and adjust our expected longest ancestor
+# length accordingly.
+root_offset=0
+case "$(test-path-utils print_path /)" in ?*/) root_offset=-1;; esac
+
 norm_path() {
 	expected=$(test-path-utils print_path "$2")
 	test_expect_success $3 "normalize path: $1 => $2" \
@@ -112,30 +119,30 @@ norm_path /d1/.../d2 /d1/.../d2
 norm_path /d1/..././../d2 /d1/d2
 
 ancestor / / -1
-ancestor /foo / 0
+ancestor /foo / $root_offset
 ancestor /foo /fo -1
 ancestor /foo /foo -1
 ancestor /foo /bar -1
 ancestor /foo /foo/bar -1
 ancestor /foo /foo:/bar -1
-ancestor /foo /:/foo:/bar 0
-ancestor /foo /foo:/:/bar 0
-ancestor /foo /:/bar:/foo 0
-ancestor /foo/bar / 0
+ancestor /foo /:/foo:/bar $root_offset
+ancestor /foo /foo:/:/bar $root_offset
+ancestor /foo /:/bar:/foo $root_offset
+ancestor /foo/bar / $root_offset
 ancestor /foo/bar /fo -1
-ancestor /foo/bar /foo 4
+ancestor /foo/bar /foo $((4+$root_offset))
 ancestor /foo/bar /foo/ba -1
-ancestor /foo/bar /:/fo 0
-ancestor /foo/bar /foo:/foo/ba 4
+ancestor /foo/bar /:/fo $root_offset
+ancestor /foo/bar /foo:/foo/ba $((4+$root_offset))
 ancestor /foo/bar /bar -1
 ancestor /foo/bar /fo -1
-ancestor /foo/bar /foo:/bar 4
-ancestor /foo/bar /:/foo:/bar 4
-ancestor /foo/bar /foo:/:/bar 4
-ancestor /foo/bar /:/bar:/fo 0
-ancestor /foo/bar /:/bar 0
-ancestor /foo/bar /foo 4
-ancestor /foo/bar /foo:/bar 4
+ancestor /foo/bar /foo:/bar $((4+$root_offset))
+ancestor /foo/bar /:/foo:/bar $((4+$root_offset))
+ancestor /foo/bar /foo:/:/bar $((4+$root_offset))
+ancestor /foo/bar /:/bar:/fo $root_offset
+ancestor /foo/bar /:/bar $root_offset
+ancestor /foo/bar /foo $((4+$root_offset))
+ancestor /foo/bar /foo:/bar $((4+$root_offset))
 ancestor /foo/bar /bar -1
 
 test_expect_success 'strip_path_suffix' '
-- 
2.7.0.windows.1.7.g55a05c8
