From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH JGIT] Circular references shouldn't be created
Date: Fri, 18 Sep 2009 00:51:47 +0200
Message-ID: <200909180051.47794.robin.rosenberg@dewire.com>
References: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp> <32541b130909171440w1a6d2394t4acc6a2f791c143@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Sohn, Matthias" <matthias.sohn@sap.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 00:51:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoPpW-0004CV-9G
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 00:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbZIQWvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 18:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbZIQWvs
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 18:51:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:13014 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbZIQWvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 18:51:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9F24B147DB2E;
	Fri, 18 Sep 2009 00:51:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B8Fbk1Rm6RfX; Fri, 18 Sep 2009 00:51:49 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id ED520147DB2B;
	Fri, 18 Sep 2009 00:51:48 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <32541b130909171440w1a6d2394t4acc6a2f791c143@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128778>

torsdag 17 september 2009 23:40:12 skrev Avery Pennarun <apenwarr@gmail.com>:
> On Thu, Sep 17, 2009 at 3:23 PM, Sohn, Matthias <matthias.sohn@sap.com> wrote:
> >        void link(final String name, final String target) throws IOException {
> > +               if (name.equals(target))
> > +                       throw new IllegalArgumentException(
> > +                                       "illegal circular reference : symref " + name
> > +                                                       + " cannot refer to " + target);
> 
> This isn't a very thorough fix.  It doesn't catch longer loops, like
> 
>     HEAD -> chicken -> HEAD
> 
> or
> 
>    a -> b -> c -> d -> a
> 
> Experimenting with original git.git's implementation, I see that this
> is allowed:
> 
>    git symbolic-ref refs/heads/boink refs/heads/boink
> 
> It succeeds and creates a file that looks like this:
> 
>    ref: refs/heads/boink
> 
> And "git show-ref refs/heads/boink" says: nothing (but returns an error code).
> 
> And "git log refs/heads/boink" says:
> 
>    warning: ignoring dangling symref refs/heads/boink.
>    fatal: ambiguous argument 'refs/heads/boink': unknown revision or
> path not in the working tree.
>    Use '--' to separate paths from revisions
> 
> Clearly, in git.git, symref loops are caught at ref read time, not
> write time.  This makes sense, since someone might foolishly twiddle
> the repository by hand and you don't want to get into an infinite loop
> in that case.  Also, it's potentially useful to allow people to set
> invalid symrefs *temporarily*, as part of a multi step process.

I had already written a patch much like this when I decided we need to do much better.

I think we should do this in the UI by not allowing the user to make a
choice that would result in a loop and fixing the way the UI resolves
choices. When creating a new branch we should analyze the selected 
ref and dereference it if it is a symbolic name like HEAD or if it is a tag, 
and perhaps show it like "HEAD (refs/heads/master)" in the the dialog.

Using unresolvable refs as the base for a new branch should be disallowed.

-- robin
