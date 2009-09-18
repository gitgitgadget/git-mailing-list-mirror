From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: RE: [PATCH JGIT] Circular references shouldn't be created
Date: Fri, 18 Sep 2009 07:37:56 +0100
Message-ID: <C89280B882467443A695734861B942B28759DEAA@DEWDFECCR09.wdf.sap.corp>
References: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp>
 <32541b130909171440w1a6d2394t4acc6a2f791c143@mail.gmail.com>
 <200909180051.47794.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 08:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoX74-0000sd-J6
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 08:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZIRGiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 02:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbZIRGiL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 02:38:11 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:47136 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbZIRGiC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 02:38:02 -0400
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n8I6c0wu009119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Sep 2009 08:38:00 +0200 (MEST)
Thread-Topic: [PATCH JGIT] Circular references shouldn't be created
Thread-Index: Aco36YWlwI9rr4WsSIyVUGkXb8bh7QAP1CsA
In-Reply-To: <200909180051.47794.robin.rosenberg@dewire.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, de-DE
X-Scanner: Virus Scanner virwal06
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128786>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote on Freitag, 18. September 2009 00:52
>torsdag 17 september 2009 23:40:12 skrev Avery Pennarun
> <apenwarr@gmail.com>:
> > On Thu, Sep 17, 2009 at 3:23 PM, Sohn, Matthias
> <matthias.sohn@sap.com> wrote:
> > >        void link(final String name, final String target) throws
> IOException {
> > > +               if (name.equals(target))
> > > +                       throw new IllegalArgumentException(
> > > +                                       "illegal circular reference
> : symref " + name
> > > +                                                       + " cannot
> refer to " + target);
> >
> > This isn't a very thorough fix.  It doesn't catch longer loops, like
> >
> >     HEAD -> chicken -> HEAD
> >
> > or
> >
> >    a -> b -> c -> d -> a
> >
> > Experimenting with original git.git's implementation, I see that this
> > is allowed:
> >
> >    git symbolic-ref refs/heads/boink refs/heads/boink
> >
> > It succeeds and creates a file that looks like this:
> >
> >    ref: refs/heads/boink
> >
> > And "git show-ref refs/heads/boink" says: nothing (but returns an
> error code).
> >
> > And "git log refs/heads/boink" says:
> >
> >    warning: ignoring dangling symref refs/heads/boink.
> >    fatal: ambiguous argument 'refs/heads/boink': unknown revision or
> > path not in the working tree.
> >    Use '--' to separate paths from revisions
> >
> > Clearly, in git.git, symref loops are caught at ref read time, not
> > write time.  This makes sense, since someone might foolishly twiddle
> > the repository by hand and you don't want to get into an infinite loop
> > in that case.  Also, it's potentially useful to allow people to set
> > invalid symrefs *temporarily*, as part of a multi step process.

Looks like I was a bit short-sighted yesterday, I will try to cook a better
solution.

> 
> I had already written a patch much like this when I decided we need to
> do much better.
> 
> I think we should do this in the UI by not allowing the user to make a
> choice that would result in a loop and fixing the way the UI resolves
> choices. When creating a new branch we should analyze the selected
> ref and dereference it if it is a symbolic name like HEAD or if it is a
> tag,
> and perhaps show it like "HEAD (refs/heads/master)" in the the dialog.
> 
> Using unresolvable refs as the base for a new branch should be
> disallowed.
> 

If we would do it in the EGit UI how about catching such cases 
in other applications using JGit ?

--
Matthias
