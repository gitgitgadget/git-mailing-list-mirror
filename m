From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 2/2] completion: list variable names reliably with 'git config --names-only'
Date: Mon, 10 Aug 2015 11:46:07 +0200
Message-ID: <1439199967-9655-3-git-send-email-szeder@ira.uka.de>
References: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:46:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjfJ-0001Gm-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbbHJJqn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 05:46:43 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50858 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754672AbbHJJql (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:46:41 -0400
Received: from x590c3bfd.dyn.telefonica.de ([89.12.59.253] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZOjf9-0006Y1-7y; Mon, 10 Aug 2015 11:46:36 +0200
X-Mailer: git-send-email 2.5.0.245.gff6622b
In-Reply-To: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1439199996.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275584>

Recenty I created a multi-line branch description with '.' and '=3D'
characters on one of the lines, and noticed that fragments of that line
show up when completing set variable names for 'git config', e.g.:

  $ git config --get branch.b.description
  Branch description to fool the completion script with a
  second line containing dot . and equals =3D characters.
  $ git config --unset <TAB>
  ...
  second line containing dot . and equals
  ...

The completion script runs 'git config --list' and processes its output
to strip the values and keep only the variable names.  It does so by
looking for lines containing '.' and '=3D' and outputting everything
before the '=3D', which was fooled by my multi-line branch description.

A similar issue exists with aliases and pretty format aliases with
multi-line values, but in that case 'git config --get-regexp' is run an=
d
lines in its output are simply stripped after the first space, so
subsequent lines don't even have to contain '.' and '=3D' to fool the
completion script.

Use the new '--names-only' option added in the previous commit to list
config variable names reliably in both cases, without error-prone post
processing.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6eaab141e2..7200828fc4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -744,9 +744,8 @@ __git_compute_porcelain_commands ()
 __git_get_config_variables ()
 {
 	local section=3D"$1" i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "^$secti=
on\..*" 2>/dev/null); do
-		i=3D"${i#$section.}"
-		echo "${i/ */}"
+	for i in $(git --git-dir=3D"$(__gitdir)" config --names-only --get-re=
gexp "^$section\..*" 2>/dev/null); do
+		echo "${i#$section.}"
 	done
 }
=20
@@ -1774,15 +1773,7 @@ __git_config_get_set_variables ()
 		c=3D$((--c))
 	done
=20
-	git --git-dir=3D"$(__gitdir)" config $config_file --list 2>/dev/null =
|
-	while read -r line
-	do
-		case "$line" in
-		*.*=3D*)
-			echo "${line/=3D*/}"
-			;;
-		esac
-	done
+	git --git-dir=3D"$(__gitdir)" config $config_file --names-only --list=
 2>/dev/null
 }
=20
 _git_config ()
--=20
2.5.0.245.gff6622b
