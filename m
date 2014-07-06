From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Sat, 05 Jul 2014 21:04:27 -0700
Organization: Twitter
Message-ID: <1404619467.3109.38.camel@stross>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	 <xmqq8uocx2c5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 06:05:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3dhR-0002yo-JW
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 06:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaGFEEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 00:04:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34106 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbaGFEEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 00:04:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3684075pab.30
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 21:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=CtFrH30rln6KhbCmvz364YsuYWXuO92cW5heB64at6E=;
        b=O7r+DhMUdAn3SeFrNmIwmzRBuk4xpCtA+wXA2fNBLI/053Em0RkyYxKCrd+xKMAi7+
         k94ofOaoRIfoWCeX8Ho3g+jddnP+o5C3wMiXPtvleLvgPGOP1NbHRPh7ZstGW2jT/hQ/
         Jc7F7AkUoyvmrmiufX0mR4iTJ2YK+IEq3AENmeQs+RLJU6hUXizMJFrqd2GPRJ+L3fHs
         /1lzGgza/fUmpmJB2QzgKxYoVhSeZeg/icItwFw3f4Ccyrkui13zCH58lNukKMOVSBKy
         nhTNodqWX3aLVeSbxc96vPfPDxi6wz7PEUqFU4a1qUDbbk6ky5K1EOQudX0vbWtzrMOR
         VI6w==
X-Gm-Message-State: ALoCoQlQswVeQY36yj83wLhhhwGmu/QMbn+K0zWScF83Og8/zYjPfh3mUetIAaBZB/XA64r8ORKW
X-Received: by 10.66.227.196 with SMTP id sc4mr1359615pac.15.1404619487272;
        Sat, 05 Jul 2014 21:04:47 -0700 (PDT)
Received: from [192.168.1.56] (c-67-169-40-58.hsd1.ca.comcast.net. [67.169.40.58])
        by mx.google.com with ESMTPSA id kp5sm14837236pdb.72.2014.07.05.21.04.44
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 05 Jul 2014 21:04:45 -0700 (PDT)
In-Reply-To: <xmqq8uocx2c5.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252923>

On Tue, 2014-07-01 at 13:15 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > When git checkout checks out a branch, create or update the
> > cache-tree so that subsequent operations are faster.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> >  builtin/checkout.c    |  8 ++++++++
> >  cache-tree.c          |  5 +++--
> >  t/t0090-cache-tree.sh | 15 ++++++++++++++-
> >  3 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 07cf555..a023a86 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -553,6 +553,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
> >  		}
> >  	}
> >  
> > +	if (!active_cache_tree)
> > +		active_cache_tree = cache_tree();
> > +
> > +	if (!cache_tree_fully_valid(active_cache_tree))
> > +		cache_tree_update(active_cache_tree,
> > +				  (const struct cache_entry * const *)active_cache,
> > +				  active_nr, 0);
> > +
> 
> This looks much better than the previous round, but it still does
> allow verify_cache() to throw noises against unmerged entries in the
> cache, as WRITE_TREE_SILENT flag is not passed down, no?
> 
> 	$ git checkout master^0
>         $ git am $this_message
>         $ make
>         $ edit builtin/checkout.c ;# make changes to the above lines
>         $ ./git checkout -m master^0
> x       builtin/checkout.c: unmerged (972c8a7b28f16f88475268f9a714048c228e69db)
> x       builtin/checkout.c: unmerged (f1dc56e55f7b2200412142b10517458ccfda2952)
> x       builtin/checkout.c: unmerged (3b9753ba8c19e7dfe6e922f30eb85c83a92a4596)
>         M       builtin/checkout.c
>         Warning: you are leaving 1 commit behind, not connected to
>         any of your branches:
> 
>           25fab54 cache-tree: Create/update cache-tree on checkout
> 
>         Switched to branch 'master'
> 
> Passing WRITE_TREE_SILENT in the flags parameter will get rid of the
> conflict notice output from the above.
> 
> The user is not interested in writing a brand new tree object at all
> in this case, so it feels wrong to actually let the call chain go
> down to update_one() and create new tree objects.
> 
> 	Side note.  And passing WRITE_TREE_DRY_RUN is not a good
> 	solution either, because a later write_cache_as_tree() will
> 	not create the necessary tree object once you stuff a tree
> 	object name in the cache-tree.
> 
> What we want in this code path is a way to repair a sub cache_tree
> if it can be repaired without creating a new tree object and
> otherwise leave that part invalid.  The existing cache-tree
> framework is not prepared to do that kind of thing.  It wants to
> start from the bottom and percolate things up, computing levels
> nearer to the top-level only after it fully created the trees for
> deeper levels, because it is meant to be used only when we really
> want to write out trees.  We may want to reuse update_one() but
> 
> I am not convinced that doing an equivalent of write-tree when you
> switch branches is the right approach in the first place.  You will
> eventually write it out as a tree, and having a relatively undamaged
> cache-tree will help you when you do so, but spending the cycles
> necessary to compute a fully populated cache-tree, only to let it
> degrade over time until you are ready to write it out as a tree,
> somehow sounds like asking for a duplicated work upfront.

As I understand it, the cache-tree extension was originally designed to
speed up writing the tree later.  However, as Karsten Blees's work (and
my own tests) have shown, it also speeds up git status.  I use git
status a lot while working, and I've talked to a few others who do the
same.  So I think it's worth spending extra time when switching branches
to have a good working experience within that branch.

In the new version of the patchset (which I'll post shortly), I've added
an option WRITE_TREE_REPAIR, which does all of the work to compute a new
tree object, but only adds it to the cache-tree if it already exists
on-disk.  This is a little wasteful for the reason that you note.  So if
you would like, I could add a config option to skip it.  But I think it
is a good default.

Does this seem OK to you, assuming the implementation is good? 
