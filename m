From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Automatically spell check commit messages as the user types
Date: Mon, 4 Feb 2008 04:03:18 -0500
Message-ID: <20080204090318.GL24004@spearce.org>
References: <20080204084153.GA9997@spearce.org> <5ED970B8-0196-4616-8968-6788B803EA7F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Flott <adam@npjh.com>, git@vger.kernel.org,
	Christian Stimming <stimming@tuhh.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 10:06:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLxGA-0003b3-Gl
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 10:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbYBDJDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 04:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbYBDJDs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 04:03:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59531 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbYBDJDY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 04:03:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLxEV-0006d5-59; Mon, 04 Feb 2008 04:03:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 118C120FBAE; Mon,  4 Feb 2008 04:03:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <5ED970B8-0196-4616-8968-6788B803EA7F@wincent.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72481>

Wincent Colaiuta <win@wincent.com> wrote:
> El 4/2/2008, a las 9:41, Shawn O. Pearce escribi=C3=B3:
>=20
> Rather than sending off the text to be spellchecked at intervals, =20
> couldn't you refrain from sending it when the cursor hasn't yet moved=
 =20
> past a word boundary? This is what most "check spelling as you type =20
> implementations do".
>=20
> eg. If you type "spellnig" and leave the cursor immediately after the=
 =20
> "g", the word won't be highlighted until you hit space or otherwise =20
> cause the cursor to move beyond the word boundary.

Indeed, that's brillant.  Something like this on top would work:

diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index c032725..088812d 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
@@ -71,6 +71,14 @@ proc spellcheck_commit_buffer {} {
 		SPELL_i SPELL_sent SPELL_last \
 		SPELL_fd SPELL_line SPELL_suggest
=20
+	if {![regexp {^\W$} [$ui_comm get {insert -1c} insert]]} {
+		$ui_comm tag remove misspelled \
+			{insert -1c wordstart} \
+			{insert -1c wordend}
+		set SPELL_i [after 300 spellcheck_commit_buffer]
+		return
+	}
+
 	set buf [$ui_comm get 1.0 end]
 	if {$buf ne $SPELL_sent && $buf eq $SPELL_last} {
 		foreach line [split $buf "\n"] {

--=20
Shawn.
