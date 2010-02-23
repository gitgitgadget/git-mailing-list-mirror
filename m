From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/4] bash: improve aliased command recognition
Date: Tue, 23 Feb 2010 22:02:57 +0100
Message-ID: <90724961a941edd1317514dea0a1c64112dab61d.1266958460.git.szeder@ira.uka.de>
References: <20100131191936.GA30466@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:03:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1vA-0002Ue-Pg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab0BWVDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:03:52 -0500
Received: from francis.fzi.de ([141.21.7.5]:22973 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752486Ab0BWVDv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:03:51 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 22:03:50 +0100
X-Mailer: git-send-email 1.7.0.119.g9b76
In-Reply-To: <20100131191936.GA30466@neumann>
In-Reply-To: <cover.1266958460.git.szeder@ira.uka.de>
References: <cover.1266958460.git.szeder@ira.uka.de>
X-OriginalArrivalTime: 23 Feb 2010 21:03:50.0487 (UTC) FILETIME=[B2D0CE70:01CAB4CB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140834>

To support completion for aliases, the completion script tries to
figure out which git command is invoked by an alias.  Its
implementation in __git_aliased_command() is rather straightforward:
it returns the first word from the alias.  For simple aliases starting
with the git command (e.g. alias.last =3D cat-file commit HEAD) this
gives the right results.  Unfortunately, it does not work with shell
command aliases, which can get rather complex, as illustrated by one
of Junio's aliases:

[alias]
    lgm =3D "!sh -c 'GIT_NOTES_REF=3Drefs/notes/amlog git log \"$@\" ||=
 :' -"

In this case the current implementation returns "!sh" as the aliased
git command, which is obviosly wrong.

The full parsing of a shell command alias like that in the completion
code is clearly unfeasible.  However, we can easily improve on aliased
command recognition by eleminating stuff that is definitely not a git
command: shell commands (anything starting with '!'), command line
options (anything starting with '-'), environment variables (anything
with a '=3D' in it), and git itself.  This way the above alias would be
handled correctly, and the completion script would correctly recognize
"log" as the aliased git command.

Of course, this solution is not perfect either, and could be fooled
easily.  It's not hard to construct an alias, in which a word does not
match any of these filter patterns, but is still not a git command
(e.g.  by setting an environment variable to a value which contains
spaces).  It may even return false positives, when the output of a git
command is piped into an other git command, and the second gets the
command line options via $@, but options for the first one are
offered.  However, the following patches will enable the user to
supply custom completion scripts for aliases, which can be used to
remedy these problematic cases.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index fe93747..78c4983 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -625,10 +625,15 @@ __git_aliased_command ()
 	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
 		config --get "alias.$1")
 	for word in $cmdline; do
-		if [ "${word##-*}" ]; then
-			echo $word
+		case "$word" in
+		\!*)	: shell command alias ;;
+		-*)	: option ;;
+		*=3D*)	: setting env ;;
+		git)	: git itself ;;
+		*)
+			echo "$word"
 			return
-		fi
+		esac
 	done
 }
=20
--=20
1.7.0.119.g9b76
