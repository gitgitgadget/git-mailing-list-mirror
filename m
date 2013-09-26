From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] git submodule foreach: Skip eval for more than one
 argument
Date: Thu, 26 Sep 2013 16:10:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1309261605330.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 22:15:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPHyC-0006jf-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab3IZUPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Sep 2013 16:15:23 -0400
Received: from dmz-mailsec-scanner-5.mit.edu ([18.7.68.34]:48508 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753559Ab3IZUPV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:15:21 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2013 16:15:21 EDT
X-AuditID: 12074422-b7ef78e000000935-14-524494ac1433
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.5C.02357.CA494425; Thu, 26 Sep 2013 16:10:20 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id r8QKAIaD010162;
	Thu, 26 Sep 2013 16:10:19 -0400
Received: from localhost (dr-wily.mit.edu [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r8QKAGGW019138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 26 Sep 2013 16:10:17 -0400
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixG6nrrtmikuQwfulfBZdV7qZLBp6rzBb
	zLu7i8mB2ePSy+9sHhcvKXt83iQXwBzFZZOSmpNZllqkb5fAlbHsl11BO1fFoZY7jA2MOzm6
	GDk5JARMJI58Pc8CYYtJXLi3ng3EFhLYxyhxpMu3i5ELyN7IKNHYd5kZwtnGJPF75Tb2LkYO
	DhYBbYl7H2pBGtgE1CTmbpjMDmKLANkT2w6BDWUWsJJ419rKCGILC/hJ/Jk0E2wBr4CjxN5p
	C8BsUQFdib2HzrBDxAUlTs58AtWrLnHg00VGCFtb4v7NNrYJjPyzkJTNQlI2C0nZAkbmVYyy
	KblVurmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGMHB6aK0g/HnQaVDjAIcjEo8vAIZLkFC
	rIllxZW5hxglOZiURHkTJwKF+JLyUyozEosz4otKc1KLDzFKcDArifCujwXK8aYkVlalFuXD
	pKQ5WJTEeW9x2AcJCaQnlqRmp6YWpBbBZGU4OJQkeAWAUSgkWJSanlqRlplTgpBm4uAEGc4D
	NFwIpIa3uCAxtzgzHSJ/ilFRSpxXDyQhAJLIKM2D64Ulj1eM4kCvCPM+mQxUxQNMPHDdr4AG
	MwENduhwAhlckoiQkmpgdAvK0BeVObCzsmN7DmfQprnqjGuFxL0fOyddbGWcEllmrSTB57bk
	wcffp+J+9XI+9DX6qnfi1q5jG+P+HBNZt+G5yhl398yPheZTUlnrpOZ+zX754u9Gvm1PJZnP
	Kh/++2a64rJjF99Iah6aVSBce815z/s5VgtOze9/dp89fZ7k3ei+n51695RYijMS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235430>

=E2=80=98eval "$@"=E2=80=99 created an extra layer of shell interpretat=
ion, which was
probably not expected by a user who passed multiple arguments to git
submodule foreach:

$ git grep "'"
[searches for single quotes]
$ git submodule foreach git grep "'"
Entering '[submodule]'
/usr/lib/git-core/git-submodule: 1: eval: Syntax error: Unterminated qu=
oted string
Stopping at '[submodule]'; script returned non-zero status.

To fix this, if the user passed more than one argument, just execute
"$@" directly instead of passing it to eval.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 git-submodule.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c17bef1..3381864 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -545,7 +545,12 @@ cmd_foreach()
 				sm_path=3D$(relative_path "$sm_path") &&
 				# we make $path available to scripts ...
 				path=3D$sm_path &&
-				eval "$@" &&
+				if [ $# -eq 1 ]
+				then
+					eval "$1"
+				else
+					"$@"
+				fi &&
 				if test -n "$recursive"
 				then
 					cmd_foreach "--recursive" "$@"
--=20
1.8.4
