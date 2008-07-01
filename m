From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with
 "--root=<root>"
Date: Tue, 1 Jul 2008 18:34:20 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807011831130.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.DEB.1.00.0807010043440.9925@racer> <7vvdzqnemk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDip8-0000Sa-8A
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbYGAQeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbYGAQeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:34:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:33850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750995AbYGAQeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:34:24 -0400
Received: (qmail invoked by alias); 01 Jul 2008 16:34:21 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 01 Jul 2008 18:34:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ii6l4kCMIp1nLH3aCnD4sFPnfD84efMqBmJ0Ff5
	BBc4/ic8K4fb+0
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvdzqnemk.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87049>

Hi,

On Tue, 1 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > With "git apply --root=<root>", all file names in the patch are prepended
> > with <root>.  If a "-p" value was given, the paths are stripped _before_
> > prepending <root>.
> 
> > @@ -182,6 +182,10 @@ behavior:
> >  	by inspecting the patch (e.g. after editing the patch without
> >  	adjusting the hunk headers appropriately).
> >  
> > +--root=<root>::
> > +	Prepend <root> to all filenames.  If a "-p" argument was passed, too,
> > +	it is applied before prepending the new root.
> > +
> 
> I looked for precedence of this concept outside git but did not find
> anything that exactly matched.
> 
> The -p<num> came from patch where it is also called --strip=num.  This 
> new option --root is about the reverse operation and it is about 
> inserting at the beginning --- it is rerooting, in other words, but then 
> --root is good enough and shorter.  mkisofs uses the word "graft" when 
> it allows tree shifting (enabled with --graft-points), but the word 
> "graft" means a totally different thing to us, so we would not want to 
> use that word.
> 
> I am not complaining (--root is fine by me), but just thinking aloud, 
> hoping somebody's brainwave is provoked while reading this babbling and 
> comes up with a better wording ;-).

Yeah, I am not too happy, but I saw you and hpa on IRC agreeing on that 
option name.  I would have said "--prefix", but that is too ambiguous, 
what with "prefix" already meaning "path relative to the working directory 
root".

> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 9fcfe39..d56d913 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -58,6 +58,8 @@ static int whitespace_error;
> > @@ -3240,6 +3252,18 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
> >  			options |= RECOUNT;
> >  			continue;
> >  		}
> > +		if (!strncmp(arg, "--root=", strlen("--root="))) {
> 
> prefixcmp()?

D'oh.

I mean, thanks!

> > +			arg += strlen("--root=");
> > +			root_len = strlen(arg);
> > +			if (root_len && arg[root_len + 1] != '/') {
> 
> Ah, being nice not to force trailing slash on users --- how unlike you 
> ;-)

Seems to be the new favorite sports, Dscho bashing.

> but I think you meant "arg[root_len - 1]" there...

I did.  An earlier version (as I found out by using the reflogs, as I tend 
to do a lot these last couple of weeks) even had a "-".  Musta been late.

Ciao,
Dscho
