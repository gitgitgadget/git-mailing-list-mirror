From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 21:23:39 +0100
Message-ID: <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZGx-0004Q6-5X
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYG1UXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYG1UXm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:23:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52973 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbYG1UXl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:23:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2169629fgg.17
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dhRTeNnlSMECTPf8HWd0Pjr5mphkI1U2ug8om70wXnY=;
        b=WPoSciPKNiZdwh4hrfFIGeNTjgmJ/ezMbNjn7T6JKPsdeTKUwY68wNo/sQMmFCHT17
         IpyeQ/wf7ybeFXeNzV/9aeQOuiAn9eQRvD/3aQMXQVJh1D/sdSI/6i1hW9cXoRgcVMTI
         ZTU6mn0Koj9h7uYB5OwGEtYx9Rep3pUsujxCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fRqPJvYtW9q2JU4gBsxdDJ6VgwWWaQR07oAgP24mDSCUnfJPzBJdy8/8DdxTlbmfig
         +Mpg9DlgPXYCNQXjDWfTyVWUMyMaKnIQZ3i4cKbSMNyyv81cFq0J2rC58VVVClxhEjJO
         4eQst5yyewtbg0IO+kIHFSSyBm0YeD+02pS9k=
Received: by 10.103.11.7 with SMTP id o7mr2996240mui.103.1217276619848;
        Mon, 28 Jul 2008 13:23:39 -0700 (PDT)
Received: by 10.103.8.13 with HTTP; Mon, 28 Jul 2008 13:23:39 -0700 (PDT)
In-Reply-To: <20080728162003.GA4584@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90500>

>
> While trying to sum up some things I'd like submodules to do, and things
> like that, I came to ask myself why the heck we were doing things the
> way we currently do wrt submodules.
>
> This question is related to the `.git` directories of submodules. I
> wonder why we didn't chose to use a new reference namespace
> (refs/submodules/$path/$remote/$branch).
>
I'm maybe being a bit slow - what would be the contents of (say)
refs/submodules/moduleA/remotes/origin/master ? The ref
that's currently in moduleA/.git/refs/remotes/origin/master ?

> This would have the net benefit that most of the plumbing tasks would be
> easier if they have to deal with submodules, because they aren't in this
> uncomfortable situation where they have to recurse into another git
> directory to know what to do.
>
> It also has the absolutely nice property to share objects, so that
> projects that replaced a subdirectory with a submodule don't see their
> checkouts grow too large.
>

Ah.. are you meaning that the top-level repository contains all the
commits in all the submodules?

> We probably still want submodules to act like plain independant git
> repositories, but one can still *fake* that this way: submodules have
> only a .git/config file (also probably an index and a couple of things
> like that, but that's almost a different issue for what I'm considering
> now) that has the setting:
>
>    [core]
>        submodule = true
>
> This could make all the builtins look for the real $GIT_DIR up, which in
> turn gives the submodule "name". Then, for this submodule, every
> reference, remote name, ... would be virtualized using the
> "remote/$submodule_name" prefix. IOW, in a submodule "some/sub/module"
> the branch "origin/my/topic/branch" is under:
>  refs/submodules/some/sub/module/origin/my/topic/branch
>  <-- submod. --><-- submod.  --><-- --><--  branch  -->
>     namespace       path/name   remote
> Note that this doesn't mean that we must rip out .gitmodules, because
> it's needed to help splitting the previous reference name properly, and
> for bootstrapping purposes.
>

I was thinking a bit about submodules (because of the earlier
discussions about submodule update only pulling from origin, and the
associated difficulties) and started wondering if the best place for
the git repository for (say) submoduleA was really
<...>/submoduleA/.git/<> and not (say) something like
.git/submodules/submoduleA/<>. This would be nicer for people trying
to pull revisions from you because they could easily find submodule
repositories regardless or not of whether they currently exist in your
WC.

I got as far as looking at discussions around .gitlink but ran out of
avaiable time.

>
> Having that, one can probably extend most of the porcelains in _very_
> straightforward ways. For example, a local topic branch `topic` would be
> the union of the supermodule `topic` branch, and all the
> `refs/submodules/$names/topic` ones.
>
> Most importantly, it would help implementing that tries to make your
> submodules stay _on branch_. One irritating problem with submodules, is
> that when someone else commited, and that you git submodule update,
> you're on a detached head. Absolutely horrible. If you see your current
> branch (assume it's master), then when you do that, you would update
> your `refs/submodules/$name/master` references instead and keep the
> submodule HEADs `on branch`. Of course we can _probably_ hack something
> together along those lines with the current setup, but it would be _so_
> much more convenient this way...
>

For me, if I'm on heads/blah in the superproject, I probably want to
be on heads/blah in *all* submodules. But that's maybe just me.
