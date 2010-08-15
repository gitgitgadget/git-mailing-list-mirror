From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2 git-gui] git-gui--askpass: Do not hang on exit
Date: Mon, 16 Aug 2010 00:53:18 +0100
Message-ID: <87mxsnh1qp.fsf@fox.patthoyts.tk>
References: <20100704203342.6064.32250.reportbug@balanced-tree>
	<20100704212125.GA1613@burratino> <20100704212439.GA1765@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 01:53:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okn1D-00026D-VD
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 01:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675Ab0HOXxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 19:53:30 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:54392 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab0HOXxa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 19:53:30 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Okn14-0001sl-UY; Mon, 16 Aug 2010 00:53:27 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Okn0x-0004zq-OU; Mon, 16 Aug 2010 00:53:19 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 17B4323AC7; Mon, 16 Aug 2010 00:53:19 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20100704212439.GA1765@burratino> (Jonathan Nieder's message of
	"Sun, 4 Jul 2010 16:24:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153631>

Jonathan Nieder <jrnieder@gmail.com> writes:

>Anders Kaseorg wrote:
>
>> When git-gui--askpass is manually copied from the source into
>> /usr/lib/git-core, though, it doesn=92t particularly work; its windo=
w
>> just freezes after the password is typed.
>
>The problem seems to be the
>
>  bind . <Destroy>    {exit $::rc}
>
>line; apparently each exit causes the window to be destroyed again,
>resulting in git gui hanging.
>
>Reported-by: Anders Kaseorg <andersk@mit.edu>
>Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>---
> I wrote:
>
> > @@ -52,7 +52,9 @@ proc finish {} {
> > =20
> >  	set ::rc 0
> >  	puts $::answer
> > +	bind . <Destroy> {}
> >  	destroy .
>
> but that does nothing to help the case when the destroy event
> comes from the window manager.  Here=92s a saner patch (sorry for
> the noise).
>
>diff --git a/git-gui--askpass b/git-gui--askpass
>index 12e117e..20b8799 100755
>--- a/git-gui--askpass
>+++ b/git-gui--askpass
>@@ -39,7 +39,10 @@ pack .b -side bottom -fill x -padx 10 -pady 10
> bind . <Visibility> {focus -force .e}
> bind . <Key-Return> finish
> bind . <Key-Escape> {destroy .}
>-bind . <Destroy>    {exit $rc}
>+bind . <Destroy>    {
>+	bind . <Destroy> {}
>+	exit $::rc
>+}
>=20
> proc finish {} {
> 	if {$::yesno} {

I'm not so keen to take this patch for git-gui. Exiting from bindings
isn't such great Tk style and I'd rather we used a vwait to explicitly
run the event loop and exit after terminating that. The following patch
does this. 'git-gui: change the termination checks to avoid potential h=
ang'

I'm not certain of the conditions that produced the error this is
supposed to fix. I have not reproduced the hang so far on a linux syste=
m
using Tk 8.5. It would be good to get confirmation that my proposed
patch actually solves the issue reported.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
