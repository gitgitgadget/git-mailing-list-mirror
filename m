From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 00:42:57 +0200
Message-ID: <20050414224257.GM22699@pasky.ji.cz>
References: <20050413075441.GD16489@pasky.ji.cz> <1113381672.23299.47.camel@nosferatu.lan> <20050413092656.GO16489@pasky.ji.cz> <1113394537.23299.51.camel@nosferatu.lan> <20050413221936.GI25711@pasky.ji.cz> <1113461754.23299.68.camel@nosferatu.lan> <1113467335.23299.77.camel@nosferatu.lan> <1113467905.23299.81.camel@nosferatu.lan> <20050414091106.GX25711@pasky.ji.cz> <1113471609.23299.95.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:41:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMD0r-0001SI-1M
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDNWnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDNWnv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:43:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16589 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261613AbVDNWm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 18:42:58 -0400
Received: (qmail 15848 invoked by uid 2001); 14 Apr 2005 22:42:57 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113471609.23299.95.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 11:40:09AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> (PS, can you check the fact that your mail client keeps on adding a 'Re:
> ' ...)

Hmm. I guess my ancient reply_regexp
"^((\\[|\\()([^B]|B([^u]|u([^g]|g([^ ]|AnTiMaTcH))))[^]]+(\\]|\\)))?[
 \t]*((re([\\[0-9\\]+])*|aw):[ \t]*)?" is broken... ;-)

> On Thu, 2005-04-14 at 11:11 +0200, Petr Baudis wrote:
> > I'm lost. Why do you do --update-modes? That makes no sense to me.
> > You introduce them to the cache out-of-order w.r.t. commits, that means
> > in the normal git usage they are already unrevertable.
> > 
> 
> Right, afterwards I thought I did add it to the wrong place.

So, could you please do something with it? :-)

> > What are you trying to do? Mode changes _are_ real changes. You _don't_
> > want to silence them. What you want is to even show them more explicitly
> > in show-diff.
> > 
> 
> No, you do not understand.  If you actually change the mode, it will
> show.  What now happens, is that say I track the 'linus' branch, then
> untrack, and then track 'pasky' again, the Patches will be applied, but
> not the mode changes which are stored in the cache ...  Let me show you:
> 
> -----
> $ ls -l $(./show-diff -s | cut -d: -f1)
..directroy listing with no 'x' bit..
> -----
> 
> (Note no 'x' bit ...)
> 
> And that is _after_ doing:
> 
>  $ git track linus; git track
> 
> So basically the modes that are stored in the cache are not applied ...
> Although, yes, I prob should add the relevant code to checkout-cache.

This should be fixed now, BTW. git apply didn't correctly apply the
mode changes, but now it should. Several bugs prevented it to, in fact.
;-)

> > > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > > --- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
> > > +++ uncommitted/show-diff.c
> > > @@ -5,13 +5,18 @@
> > >   */
> > >  #include "cache.h"
> > > 
> > > -static void show_differences(char *name,
> > > +static void show_differences(struct cache_entry *ce,
> > >         void *old_contents, unsigned long long old_size)
> > >  {
> > >         static char cmd[1000];
> > > +       static char sha1[41];
> > > +       int n;
> > >         FILE *f;
> > > 
> > > -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
> > > +       for (n = 0; n < 20; n++)
> > > +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
> > > +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u -N  - %s",
> > > +               sha1, ce->name, ce->name, ce->name);
> > 
> > The "directory" sha1 is the sha1 of the tree, not of the particular
> > file - that one is in the "attributes" list (parentheses after the
> > filename), together with mode.
> > 
> 
> Does it really matter?  It is more just to get the patch prefix right,
> and I did it as it went nicely with the printed:
> 
> ----
> show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> ----
> 
> for example ...

Yes, it matters, and I don't care how nicely it wents with what you
print before.

Either print there some nonsense which is clear not to be a tree ID, or
(much more preferably) print the real tree ID there. If some tool ever
uses it (e.g. to help resolve conflicts, perhaps even actually doing a
real merge based on the patch), you just confused it.

Also, do you think you could separate this patch from the other
(--update-modes) patch? (If we actually still need the --update-modes
patch after git apply was fixed.)

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
