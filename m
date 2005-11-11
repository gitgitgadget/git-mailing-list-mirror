From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 12:45:11 +0100
Message-ID: <20051111114511.GQ30496@pasky.or.cz>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com> <20051111075257.GA4765@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 12:47:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaXLO-00043N-6z
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKKLpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVKKLpP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:45:15 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34016 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750702AbVKKLpO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 06:45:14 -0500
Received: (qmail 31191 invoked by uid 2001); 11 Nov 2005 12:45:11 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20051111075257.GA4765@c165.ib.student.liu.se>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11589>

Dear diary, on Fri, Nov 11, 2005 at 08:52:57AM CET, I got a letter
where Fredrik Kuivinen <freku045@student.liu.se> said that...
> On Thu, Nov 10, 2005 at 01:38:35PM +1300, Martin Langhoff wrote:
> > We are working with a series of closely related heads, and merging
> > among them. I am sometimes finding merge conflicts that I don't think
> > I should be seeing. Assuming two branches, 'local' and 'remote', where
> > local has with remote before (*), and I have no conflicting changes in
> > local...
> > 
> >  1 - pull and merge from remote. The merge touches file A, B and C
> >  2 - on local, develop on unrelated files O,P,Q, commit
> >  3 - pull and merge from remote. The merge touches file B, C and D. I
> > am sometimes seeing conflicts on file B and C, which was never touched
> > on local.
> > 
> > * - In the case i have, the ancestry before the merge is a bit
> > convoluted. AFAIK, this shouldn't affect us going forward. Both
> > branches have a common ancestor, though, and are now merging often
> > from remote to local.
> > 
> > We are using cogito for this, although on step 3 I have also tested
> > with git-merge.sh and I get the same result.  It could still be a
> > problem related to how the merge on step 1 is recording the merge.
> > 
> > For an example, clone
> > http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
> > register also the
> > http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
> > two heads:
> > 
> >  master: 214e6374d49e6d014f0ba6f159d585a3fe468909
> >  remote: 05059be73c9e09e22b98bc796be35c595e551ed6
> > 
> > On git-merge 'testing merge' master remote you'll see conflicts over
> > mod/quiz/editlib.php -- doing the same with cg-merge gets an
> > additional conflict on mod/quiz/export.php. Neither of those files
> > were ever modified on local -- however, both merges brought in changes
> > to the same lines of code.
> > 
> > I suspect this is because the merge itself is being considered a
> > commit on the local branch. Fair enough -- git has no way of ensuring
> > that I haven't slipped in a few changes of mine in the merge. OTOH,
> > it's pretty unexpected to see this on files that are not one char
> > different from the 'remote' branch. Am I doing something wrong?
> > 
> 
> This merge has two common ancestors, 
> 
>     $ git-merge-base --all master remote
>     3b12fc6420c26a6556c2d806fca79dd96e8e22b9
>     2163a9076d9515f00494ba9df7dbc85c9804790f
> 
> This may explain the results you get with cg-merge, as that script
> seems to use 'git-merge-base' without the '--all' flag.

Hmm. So what should I do with that? :-)

I wondered about adding multi-base merge support to Cogito, but it seems
to be a bit funny, and totally undocumented. Especially, is it right
that I would end up with _four_ stages in case of two-base "three"-way
merge? That would mean complete rewrite of the one-file merger, right?
And it seems git-merge-index would overflow and crash. :-)

I guess I really don't want to do that, but instead choose one of the
bases. Hmm. Well, I suppose it's as good as anything to leave this
decision on the user. Kind of:

	if [ $(wc -l merge-bases) -ge 1 ]; then
		echo "Multiple merge bases, please select one by the -b parameter:" >&2
		cat merge-bases
		echo -n "The most conservative base (but likely a lot of conflicts):" >&2
		while true; do
			git-merge-base --all $(cat merge-bases) >merge-bases~
			mv merge-bases~ merge-bases
			[ $(wc -l merge-bases) -eq 1 ] && break
		done
		cat merge-bases
		exit 1
	fi

Does core GIT have support for multibase merges, except for the
recursive merge strategy? How do you do it?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
