From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 09/20] mingw: accomodate t0060-path-utils for MSYS2
Date: Wed, 27 Jan 2016 17:19:40 +0100 (CET)
Message-ID: <66a33c0f9dc0619c808cd604c1c061fabc963110.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSow-0002FK-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbcA0QTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:59567 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbcA0QTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:45 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lusmr-1Zy6NZ3cp7-0102sE; Wed, 27 Jan 2016 17:19:40
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mMOmO9GkcZrp7M79zy4jAXqyOxlbj5VXK/sLi0ok5LbPEwNitoC
 gbPr31zNeXQJ96ea28cpHct7CsV6opDEYQ73Zx6RcPqucIZGlqxaitDSvT1vDyrpJ8aYSFF
 49ahXs9GGRbNTxpFOoL22xF3HTGAUt33KxLyr2NdojzxPE88x4izvDJfovLYIfn2naPG6Y8
 Pn0xuGYSPUdx1Ho0PvMtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XaCo9ZQSouE=:K1LicRBlpEnrPIVRzE1oGM
 4i0JLOWB8gk1p4GnUXscfHSymeaTnVqHx7pwalJvQDr3Oyb04tSNAspnuqwhyfgFvG/8FP7/e
 hapnQ195zcVvrXW7Nv8NQcZP6oDS/W6HS1e4pJG7X2pXKKDVe2EZcTWGd+TZVdiYOt60sh/2e
 xilJaufRBBXSWqofavg0uo1H1pAhpcabwYBb9LSTVHm22XP05pmst7mfnFaQe3fvROZ9ls6Ey
 02d9hAYtiLBQvLvOV0jvdbJQoR8gW5l89HmhHAnN4hC6Ag3G83KrpZOZ/D60DIWUN8gWP6WY3
 u1FCz7aGaZuB+FSOEQgVUreatS/5zJaQ7ZtvwL/6DXwUJW+4/U2I0cxwoYYbGMxuBc6VsGDwm
 Twoh7gSGocKp1usL31ozQyy5cWmUN011JGHxl4uf/rYG2pm9WqifMpwPDUyucEbbWfPlDs60Z
 EUuGj2ZR5My4TQ+WYP8fZX+j4pfliO7waynYti4IUXx40Hpk9VaLySvzqshMYvmXcvZ/kdvDZ
 7kfZ/xTv7cafuDHTirJ6ucDTG7Jwbva0kWAwR8dcs74oviOC+0FmVfLSDYNOQdEo4MfZRXgVx
 LpB9mnBCAUKJfRqWAhkFEIpZa3t9t4e+poIfuvUAy9wQxk+x/bzGfY6lOPXjagUq7hzLQNj0h
 HkSP91PYCwQWigq0eRblHtYhY8Ia6Sto7uxle63rRiNuCngOz16kp4+FW16EnWQTmVtlI//XM
 ibiSUS2zJyfb14IrZn0HAmssOAb0Y/39oCoFMGZ9mQR0qpYZ5TFVnNXoPeAkxafoipiqEuOh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284927>

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

Originally, the Git for Windows project patched MSYS2's runtime to
accomodate Git's regression test, but we really should do it the other
way round.

To work with both of MSys1's and MSYS2's behaviors, we simply test what
the current system does in the beginning of t0060-path-utils.sh and then
adjust the expected longest ancestor length accordingly.

It looks quite a bit tricky what we actually do in this patch: first, we
adjust the expected length for the trailing slash we did not originally
expect (subtracting one). So far, so good.

But now comes the part where things work in a surprising way: when the
expected length was 0, the prefix to match is the root directory. If the
root directory is converted into a path with a trailing slash, however,
we know that the logic in longest_ancestor_length() cannot match: to
avoid partial matches of the last directory component, it verifies that
the character after the matching prefix is a slash (but because the
slash was part of the matching prefix, the next character cannot be a
slash). So the return value is -1. Alas, this is exactly what the
expected length is after subtracting the value of $rootslash! So we skip
adding the $rootoff value in that case (and only in that case).

Directories other than the root directory are handled fine (as they are
specified without a trailing slash, something not possible for the root
directory, and MSYS2 converts them into Windows paths that also lack
trailing slashes), therefore we do not need any more special handling.

Thanks to Ray Donnelly for his patient help with this issue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index f0152a7..8532a02 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -36,12 +36,21 @@ if test $rootoff = 2; then
 	rootoff=	# we are on Unix
 else
 	rootoff=$(($rootoff-1))
+	# In MSYS2, the root directory "/" is translated into a Windows
+	# directory *with* trailing slash. Let's test for that and adjust
+	# our expected longest ancestor length accordingly.
+	case "$(test-path-utils print_path /)" in
+	*/) rootslash=1;;
+	*) rootslash=0;;
+	esac
 fi
 
 ancestor() {
 	# We do some math with the expected ancestor length.
 	expected=$3
 	if test -n "$rootoff" && test "x$expected" != x-1; then
+		expected=$(($expected-$rootslash))
+		test $expected -lt 0 ||
 		expected=$(($expected+$rootoff))
 	fi
 	test_expect_success "longest ancestor: $1 $2 => $expected" \
-- 
2.7.0.windows.1.7.g55a05c8
