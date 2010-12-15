From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] bash: simple reimplementation of _get_comp_words_by_ref
Date: Wed, 15 Dec 2010 00:27:51 -0600
Message-ID: <20101215062751.GC20492@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
 <20101207194923.GD22587@burratino>
 <7v1v5tpa7b.fsf@alter.siamese.dyndns.org>
 <20101215062403.GA20492@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 07:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSkqS-0005Km-5c
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 07:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500Ab0LOG2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 01:28:05 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:54557 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab0LOG2D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 01:28:03 -0500
Received: by gwb20 with SMTP id 20so1209731gwb.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 22:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V4QGs5Uh4PjNQw0ooYhky8YILF6eIlDczoQHYjoCgYY=;
        b=xFnajfDUK5pWlCxVcn0OMytqrTVsABo+gglW4xmIy46UzR9eA0X3cIreqdrVmZ54l3
         QCLtmvATHfPxbIUdZSHox+1KHHMG2TUD4lF4rHkZqkhza2/9ltlTvZjMS3IDm2GrtASu
         YY+gK4DeqYWZHJa8K2y0LDT/c2SGbOb8fT2jA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Oiw4CNXm2SFlvaZwiywWZoOUF2GhWD3axLPbLyF6ObAX1fwkVkUoGWoIBxDkthydIv
         ecrPWOCTb7MVrUyZzsktwEQhBn+CCSCJdchB//9nK4LxZG4bPN2m2Xjt3clq40ZWINZV
         5PL1CjaEkbqNkpLrqfTsAoDxEnU4dl8r8Ts+I=
Received: by 10.90.113.17 with SMTP id l17mr3121726agc.20.1292394482834;
        Tue, 14 Dec 2010 22:28:02 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id 35sm1061013ano.11.2010.12.14.22.28.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 22:28:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101215062403.GA20492@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163735>

Add a minimal implementation of _get_comp_words_by_ref so

	$ git show head:g <tab><tab>

on bash 4 can complete paths within the head commit without requiring
the bash_completion functions to be loaded.  This is a follow-up to
the previous patch (bash: get --pretty=3Dm<tab> completion to work with
bash v4).

Based on bash-completion 2.x (commit bf763033, 2010-10-26) but tweaked
for simplicity and to allow zsh to parse the code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |  118 ++++++++++++++++++++++++=
+++++--
 1 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 68b68d0..1747091 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,26 +321,128 @@ __gitcomp_1 ()
 	done
 }
=20
+# The following function is based on code from:
+#
+#   bash_completion - programmable completion functions for bash 3.2+
+#
+#   Copyright =C2=A9 2006-2008, Ian Macdonald <ian@caliban.org>
+#             =C2=A9 2009-2010, Bash Completion Maintainers
+#                     <bash-completion-devel@lists.alioth.debian.org>
+#
+#   This program is free software; you can redistribute it and/or modi=
fy
+#   it under the terms of the GNU General Public License as published =
by
+#   the Free Software Foundation; either version 2, or (at your option=
)
+#   any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, write to the Free Software Founda=
tion,
+#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+#
+#   The latest version of this software can be obtained here:
+#
+#   http://bash-completion.alioth.debian.org/
+#
+#   RELEASE: 2.x
+
+# This function can be used to access a tokenized list of words
+# on the command line:
+#
+#	__git_reassemble_comp_words_by_ref '=3D:'
+#	if test "${words_[cword_-1]}" =3D -w
+#	then
+#		...
+#	fi
+#
+# The argument should be a collection of characters from the list of
+# word completion separators (COMP_WORDBREAKS) to treat as ordinary
+# characters.
+#
+# This is roughly equivalent to going back in time and setting
+# COMP_WORDBREAKS to exclude those characters.  The intent is to
+# make option types like --date=3D<type> and <rev>:<path> easy to
+# recognize by treating each shell word as a single token.
+#
+# It is best not to set COMP_WORDBREAKS directly because the value is
+# shared with other completion scripts.  By the time the completion
+# function gets called, COMP_WORDS has already been populated so local
+# changes to COMP_WORDBREAKS have no effect.
+#
+# Output: words_, cword_, cur_.
+
+__git_reassemble_comp_words_by_ref()
+{
+	local exclude i j first
+	# Which word separators to exclude?
+	exclude=3D"${1//[^$COMP_WORDBREAKS]}"
+	cword_=3D$COMP_CWORD
+	if [ -z "$exclude" ]; then
+		words_=3D("${COMP_WORDS[@]}")
+		return
+	fi
+	# List of word completion separators has shrunk;
+	# re-assemble words to complete.
+	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+		# Append each nonempty word consisting of just
+		# word separator characters to the current word.
+		first=3Dt
+		while
+			[ $i -gt 0 ] &&
+			[ -n "${COMP_WORDS[$i]}" ] &&
+			# word consists of excluded word separators
+			[ "${COMP_WORDS[$i]//[^$exclude]}" =3D "${COMP_WORDS[$i]}" ]
+		do
+			# Attach to the previous token,
+			# unless the previous token is the command name.
+			if [ $j -ge 2 ] && [ -n "$first" ]; then
+				((j--))
+			fi
+			first=3D
+			words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
+			if [ $i =3D $COMP_CWORD ]; then
+				cword_=3D$j
+			fi
+			if (($i < ${#COMP_WORDS[@]} - 1)); then
+				((i++))
+			else
+				# Done.
+				return
+			fi
+		done
+		words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
+		if [ $i =3D $COMP_CWORD ]; then
+			cword_=3D$j
+		fi
+	done
+}
+
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
+	local exclude cur_ words_ cword_
+	if [ "$1" =3D "-n" ]; then
+		exclude=3D$2
+		shift 2
+	fi
+	__git_reassemble_comp_words_by_ref "$exclude"
+	cur_=3D${words_[cword_]}
 	while [ $# -gt 0 ]; do
 		case "$1" in
 		cur)
-			cur=3D${COMP_WORDS[COMP_CWORD]}
+			cur=3D$cur_
 			;;
 		prev)
-			prev=3D${COMP_WORDS[COMP_CWORD-1]}
+			prev=3D${words_[$cword_-1]}
 			;;
 		words)
-			words=3D("${COMP_WORDS[@]}")
+			words=3D("${words_[@]}")
 			;;
 		cword)
-			cword=3D$COMP_CWORD
-			;;
-		-n)
-			# assume COMP_WORDBREAKS is already set sanely
-			shift
+			cword=3D$cword_
 			;;
 		esac
 		shift
--=20
1.7.3.3.573.g0bcfc
