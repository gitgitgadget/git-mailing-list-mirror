From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 09/19] mingw: accomodate t0060-path-utils for MSYS2
Date: Tue, 26 Jan 2016 15:35:02 +0100 (CET)
Message-ID: <79b66a84a41557be3c37c693de1f6b1f498a8c04.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4iP-0004mL-M5
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966307AbcAZOfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:35:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:58733 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966299AbcAZOfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:35:07 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MVN0w-1abx291Vni-00YlRf; Tue, 26 Jan 2016 15:35:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9Viw9JnsMB9kQQEzQqaGuEvfnKrhsCEAGkbBBftXjud1dAgseWN
 HZcKFXBA5Loa43hAeZzVg+AH48HqbAxQ9lA+J20JyLtJ6R0M7VpXDBE1ELnelOWrZm8bgiE
 Rst1lHYbiqe0k2GGXA94rfRxYdnXxP8+a+VrzAk6ZfVJIBpMHVSgmsFxMxLsL2faD7XFYjy
 MDc921+8RA39s9ZFrmD5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FKkdtUOaSJA=:ypZ5WX4tjHYWfl5ZjAN5C0
 woOagR+JRCE6WUCyQrxhetVEMyqgyLTuIkf3LM5fj+85vKGCaeuUTiO95+fIRLkxXNCgr2lS+
 2XUWu1oYd4OxXlBye9z+L/CMYVmo/bKWh2ELvtbq06xXNINgGuqtWGtJDL1wWqUHXvlaTQnER
 ZS8V9AJtUvXoyxa5zkGV01CPGN8GYXb+9stLxMuxRqqtNHv2BHbXxkUqz5LZTv2VN4yMJzPrO
 +nc6hpbCHkjnwPvpxW1e6SxLZ0ErnOkIiYDiyU3tyhsRz5ZujJyQDIahWorzQlL3FW3CLrJeb
 31TVehXr1xiY6d6XJoPK4LoDzVVGd9Dd56jkGKJq4Xro8MT5C5bixWLpE6PTkxbexlAY1HuuZ
 LL8t9uJRGTF9dZkkquNhnTeV4OYbGgWnymGucVTuUFquaLvT+ZII+0xbVOmCyTH+nzr3YLQW6
 oZoMjD68Dq7IcNwnNDG+c+IPHCHqeNvMXSpLZtk4sPycqOnbmdmcqjNIeK7TCSPAp0nc22Uvq
 ne02AjLUQ/9MaCL7bHfxDw9DH28ab3MrrnFnjvtMDfSFfBfRQFBA6UEOSHLkHARjol8CPjUp/
 ZnXRhoSHP4im46vPfEPlRRcrUcTleGnlc1ZDjIB+d31CONSSWFpH0arIfOuaxejGR0G2FjOSi
 Ce+ONFEbAeLGWVUFhBXx7L9iT4LatgLi3y0trAzpuXkxRPUMfA/kiPXdCz2f5m4+1MYlodugo
 T0svucRk3gL+q0BTiax7kjF/Zrj2m0YmCIPpncmu/XxQ+i1HBZVptVb1oC3F4GiU6IJLEebR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284822>

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
