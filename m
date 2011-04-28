From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/3] bash: don't declare 'local words' to make zsh happy
Date: Thu, 28 Apr 2011 18:01:53 +0200
Message-ID: <1304006513-19392-3-git-send-email-szeder@ira.uka.de>
References: <20110428160115.GA19003@goldbirke>
	<1304006513-19392-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Stefan Haller <lists@haller-berlin.de>,
	Mark Lodato <lodatom@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTfh-0007jN-VU
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760675Ab1D1QCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 12:02:17 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:20339 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715Ab1D1QCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:02:15 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:10 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 28 Apr
 2011 18:02:13 +0200
X-Mailer: git-send-email 1.7.5.86.g799a6
In-Reply-To: <1304006513-19392-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172371>

The "_get_comp_words_by_ref -n :=3D words" command from the
bash_completion library reassembles a modified version of COMP_WORDS
with ':' and '=3D' no longer treated as word separators and stores it i=
n
the ${words[@]} array.  Git's programmable tab completion script uses
this to abstract away the difference between bash v3's and bash v4's
definitions of COMP_WORDS (bash v3 used shell words, while bash v4
breaks at separator characters); see v1.7.4-rc0~11^2~2 (bash: get
--pretty=3Dm<tab> completion to work with bash v4, 2010-12-02).

zsh has (or rather its completion functions have) another idea about
what ${words[@]} should contain: the array is prepopulated with the
words from the command it is completing.  For reasons that are not
well understood, when git-completion.bash reserves its own "words"
variable with "local words", the variable becomes empty and cannot be
changed from then on.  So the completion script neglects the arguments
it has seen, and words complete like git subcommand names.  For
example, typing "git log origi<TAB>" gives no completions because
there are no "git origi..." commands.

However, when this words variable is not declared as local but is just
populated by _get_comp_words_by_ref() and then read in various
completion functions, then zsh seems to be happy about it and our
completion script works as expected.

So, to get our completion script working again under zsh and to
prevent the words variable from leaking into the shell environment
under bash, we will only declare words as local when using bash.

Reported-by: Stefan Haller <lists@haller-berlin.de>
Suggested-by: Felipe Contreras <felipe.contreras@gmail.com>
Explained-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 862b840..6869765 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2608,9 +2608,11 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+	else
+		local words
 	fi
=20
-	local cur words cword prev
+	local cur cword prev
 	_get_comp_words_by_ref -n =3D: cur words cword prev
 	while [ $c -lt $cword ]; do
 		i=3D"${words[c]}"
@@ -2659,9 +2661,11 @@ _gitk ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+	else
+		local words
 	fi
=20
-	local cur words cword prev
+	local cur cword prev
 	_get_comp_words_by_ref -n =3D: cur words cword prev
=20
 	__git_has_doubledash && return
--=20
1.7.5.86.g799a6
