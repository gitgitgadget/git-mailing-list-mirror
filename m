From: Csaba Henk <csaba-ml@creo.hu>
Subject: Re: import files w/ history
Date: Mon, 9 Mar 2009 05:15:16 +0000 (UTC)
Message-ID: <slrngr99ei.1t4t.csaba-ml@beastie.creo.hu>
References: <slrngqqa4l.1t4t.csaba-ml@beastie.creo.hu> <20090303130046.GA7867@coredump.intra.peff.net> <slrngr299k.1t4t.csaba-ml@beastie.creo.hu> <20090308001021.GA26167@coredump.intra.peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 06:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgXsA-0006JB-O4
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 06:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbZCIFP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 01:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbZCIFP2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 01:15:28 -0400
Received: from main.gmane.org ([80.91.229.2]:59515 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZCIFP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 01:15:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LgXpk-0007Rc-Hq
	for git@vger.kernel.org; Mon, 09 Mar 2009 05:15:24 +0000
Received: from www.creo.hu ([217.113.62.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 05:15:24 +0000
Received: from csaba-ml by www.creo.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 05:15:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: www.creo.hu
User-Agent: slrn/0.9.8.1 (FreeBSD)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112677>

On 2009-03-08, Jeff King <peff@peff.net> wrote:
> What you really want to do is say:
>
>   - for every commit, narrow the tree to _just_ the one file
>
>   - if there were no changes in the narrowed tree, just throw out the
>     commit
>
> You can use an --index-filter to do the former, and a --commit-filter to
> do the latter (or just use --prune-empty, which is a shorthand).
>
> Another poster had a similar problem, and you can see the right
> filter-branch recipe there:
>
>   http://article.gmane.org/gmane.comp.version-control.git/111991

Thanks, this did the job.

>
> I think you need an extra '--' to separate the paths from the revisions
> in the rev-list arguments:
>
>   git filter-branch -- master -- sys/dev/disk/vn/vn.c
>
> but even that doesn't quite do what you want. It limits the commits that
> are shown, similar to your first attempt above, but it doesn't cut down
> the tree itself (OTOH, limiting by path rather than using --prune-empty
> is likely to run faster, since you won't even look at commits that are
> uninteresting. However, it may change the shape of your history with
> respect to branching and merging).

Finally I choose to add the path to the rev-list args -- 80 vs
15000 commits does make a difference. (I can still check if there was
any histroy [I just coined this from "history" and "destroy" :)] and
go back to the full-scan way if yes.)

But I still had a hard time with it... Finally I realized that if I do
filtering this way, I have to start filtering from the topmost commit
which affects the given file.

If I just start from origin/HEAD (assuming that it's on a commit which
does not affect the file), then it won't be found as a key of the mapping
created by git-filter-branch (as it's ignored because rev-listing was
narrowed down to the file), and therefore filter-branch finally punts
with "WARNING: Ref '<sha1>' is unchanged". I don't know if it's an
intended behaviour, or something which could/should be improved, or at
least documented... seems to be some sort of POLS violation to me (at
least I was surprised :) ).

Regards,
Csaba
