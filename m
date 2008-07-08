From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: offer only paths after '--'
Date: Tue, 8 Jul 2008 18:56:14 +0200
Message-ID: <20080708165614.GB8224@neumann>
References: <279b37b20807071341k3551e61cl10c5969600ba8218@mail.gmail.com>
	<20080708044922.GD2542@spearce.org>
	<7vprppvt7a.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:57:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGGV9-0002u4-IX
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 18:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbYGHQ4R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbYGHQ4Q
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 12:56:16 -0400
Received: from francis.fzi.de ([141.21.7.5]:23444 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755590AbYGHQ4P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 12:56:15 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 8 Jul 2008 18:56:13 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807081335470.4319@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 08 Jul 2008 16:56:13.0455 (UTC) FILETIME=[878C61F0:01C8E11B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87772>

Many git commands use '--' to separate subcommands, options, and refs
from paths.  However, the programmable completion for several of these
commands does not respect the '--', and offer subcommands, options, or
refs after a '--', although only paths are permitted.  e.g. 'git bisect
-- <TAB>' offers subcommands, 'git log -- --<TAB>' offers options and
'git log -- git<TAB>' offers all gitgui tags.

The completion for the following commands share this wrong behaviour:
  am add bisect commit diff log reset shortlog submodule gitk.

To avoid this, we check the presence of a '--' on the command line firs=
t
and let the shell do filename completion, if one is found.

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Tue, Jul 08, 2008 at 01:36:43PM +0200, Johannes Schindelin wrote:
> It shows two bugs, actually: completions do not care about "--",=20
I think I have found and corrected all the places where '--' was not
handled properly, but might have overlooked something.

Hope that I got the commit message right (;


 contrib/completion/git-completion.bash |   30 ++++++++++++++++++++++++=
++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6a15522..e7d8a75 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -451,6 +451,18 @@ __git_find_subcommand ()
 	done
 }
=20
+__git_has_doubledash ()
+{
+	local c=3D1
+	while [ $c -lt $COMP_CWORD ]; do
+		if [ "--" =3D "${COMP_WORDS[c]}" ]; then
+			return 0
+		fi
+		c=3D$((++c))
+	done
+	return 1
+}
+
 __git_whitespacelist=3D"nowarn warn error error-all strip"
=20
 _git_am ()
@@ -497,6 +509,8 @@ _git_apply ()
=20
 _git_add ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
@@ -511,6 +525,8 @@ _git_add ()
=20
 _git_bisect ()
 {
+	__git_has_doubledash && return
+
 	local subcommands=3D"start bad good skip reset visualize replay log r=
un"
 	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -612,6 +628,8 @@ _git_cherry_pick ()
=20
 _git_commit ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
@@ -631,6 +649,8 @@ _git_describe ()
=20
 _git_diff ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
@@ -733,6 +753,8 @@ _git_ls_tree ()
=20
 _git_log ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--pretty=3D*)
@@ -1088,6 +1110,8 @@ _git_remote ()
=20
 _git_reset ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
@@ -1100,6 +1124,8 @@ _git_reset ()
=20
 _git_shortlog ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--*)
@@ -1157,6 +1183,8 @@ _git_stash ()
=20
 _git_submodule ()
 {
+	__git_has_doubledash && return
+
 	local subcommands=3D"add status init update"
 	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
 		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
@@ -1362,6 +1390,8 @@ _git ()
=20
 _gitk ()
 {
+	__git_has_doubledash && return
+
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
 	local merge=3D""
--=20
1.5.6.1.118.g82b2fef
