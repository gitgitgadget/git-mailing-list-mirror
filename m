From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 05/19] bash prompt: don't show the prompt when .git/HEAD is
	unreadable
Date: Wed,  9 May 2012 02:44:36 +0200
Message-ID: <1336524290-30023-6-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv2a-0004xa-0I
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab2EIAp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:45:58 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62230 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab2EIAp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:45:57 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Mgrgq-1Sny9v3lJI-00MKlN; Wed, 09 May 2012 02:45:52 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:fYX2mpOlq8lVUHW/7eUDjfXLQbS9tZUMfZ9sz3BQQFn
 pegRIj5WcDYYTpXq2+DloH8OmUoVDeuB5bmIdQRA5J2E/gk1oe
 3MTGV5zCONKszZpcaoY5HlON92OVBWBIr5mcY9x5NBfd/faini
 qw2Tz2eR6GLgv1hTHxbN2yRLDtdmVvbhg93WmIoFeoI5AMS/kl
 hMbew2Su//TXTzaXDomQsC1MCsHrK14bXPqMDuIuWnoKqB6d1k
 Tfn3pQ6CwF05vw5wd/kVmwpH7do4cKqtQzH3gH1ja6+azYWU/M
 bILnq1281aLQ8jRVRi6JzgLHnGgT81x3lCCsPApZ/3RrL+HyRy
 M1EN4cJd5wECaIc4Xo5RdsoJWvvuzL1vaPvg6COmaXBZuXH1NO
 HLp35PlyYYgDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197437>

__git_ps1() has a chain of commands to figure out what to display in
the prompt as current branch, i.e. the branch name, or a described
detached head, or the 7 hexdigits abbreviated object name, or
"(unknown)" when all of the above fails.

Now, when the 7 hexdigits case fails, then '/path/to/.git/HEAD' can't
be read.  This can happen when the file became unreadable after
__gitdir() found it: unlikely, but a parallel process can racily
delete it or change it's permissions in that short timeframe.
Alternatively, it is possible that either the subshell or the 'cut'
command fail.  Either way, when HEAD is not readable, then the path is
not considered to be a git repository, therefore the bash prompt
shouldn't be displayed at all.  And there is no point in continuing
the execution of __git_ps1(), because its subsequent git commands will
error out anyway.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ab26bdc8..cd6a5f12 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -258,7 +258,7 @@ __git_ps1 ()
 				esac 2>/dev/null)" ||
=20
 				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				b=3D"unknown"
+				return
 				b=3D"($b)"
 			}
 		fi
--=20
1.7.10.1.541.gb1be298
