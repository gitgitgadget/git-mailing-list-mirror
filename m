From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Fri, 8 Aug 2008 09:44:22 +0200
Message-ID: <200808080944.23048.J.Wielemaker@uva.nl>
References: <200808061539.50268.J.Wielemaker@uva.nl> <200808071214.25399.J.Wielemaker@uva.nl> <200808080148.27384.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 08 09:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRMfE-0007WY-Cm
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 09:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYHHHoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 03:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYHHHoa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 03:44:30 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:1425 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYHHHo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 03:44:29 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id m787iOPY084441;
	Fri, 8 Aug 2008 09:44:24 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200808080148.27384.trast@student.ethz.ch>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91628>

Hi Thomas,

Thanks for looking into this!

On Friday 08 August 2008 01:48:05 Thomas Rast wrote:
> Jan Wielemaker wrote:
> >   Ref 'refs/tags/V5.6.50' was rewritten
> >   error: Ref refs/tags/V5.6.50 is at
> > 8678b32f71178019c06aefa40e2d3fb9a2e8ef25 but
> > 	expected 2e8aef64e2fed088720a19ac2ffa2481e5bc7806
> >   fatal: Cannot lock the ref 'refs/tags/V5.6.50'.
> >   Could not rewrite refs/tags/V5.6.50
>
> [...]
>
> > Now, if I look in .git/packed-refs [...] and I changed all these to
> > `lightweight' tags
>
> This appears to be a bug.  I've whipped up a patch that will follow
> and should fix the bug.  It has nothing to do with packed-refs; the
> current filter-branch chokes on annotated tags during
> --subdirectory-filter, even though there is support for tag rewriting.
>
> However, to enable tag rewriting, you need to say --tag-name-filter
> cat.

Great.  I knew a more fundamental approach was asked for, but I bet my
simple-minded work-around gives the same result, no?

> > Now it runs to the end.  Unfortunagtely the history is completely
> > screwed up :-(:
> >
> > 	* There are a lot of commits that are not related to the dir
> > 	* Commits start long before the directory came into existence,
> > 	Looks like it just shows the whole project at this place.
>
> For some reason the ancestor detection does not work right.  I'm also
> following up with an RFH patch that significantly improves the success
> rate (in terms of branches and tags successfully mapped to a rewritten
> commit) in the case of your repository.  I doubt more staring at the
> code would yield any more ideas at this hour, so ideas would be
> appreciated.

Thanks. As I'm using the GIT version anyway, I'll apply these patches
and see what happens. The trouble is related to tags and possibly to
branches. I get completely correct result if I delete all branches and
tags before filtering.  That at least helps for this particular subproject
(though some of the tags are useful).

I didn't further investigate branches (I think the packages/chr
directory is not involved in any branch; if you are interested, the boot
directory should show traces of the V57X branch).

I did see that (all/some?) tags that involve changes to the packages/chr
directory nicely end up in its history, but others do not appear on the
filtered master branch and give access to the complete project. See for
example V5.6.59 (the latest release tag). Try (in the filtered branch)

	git diff V5.6.59..

That should only show some small changes, but it diffs the entire project
against the subdir ...

> The rest is just the other commits/tags showing a lot of the history.
> I don't know of any built-in way to prune the branches and tags that
> aren't part of the new master, but
>
>   git branch -a --no-merged master
>
> can tell you which branches aren't ancestors of master.

Thanks for the tip.

	Cheers --- Jan
