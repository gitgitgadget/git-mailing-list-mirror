From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Mon, 03 Aug 2015 15:49:56 -0400
Organization: Twitter
Message-ID: <1438631396.7348.33.camel@twopensource.com>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
	 <55BC4438.8060709@alum.mit.edu>
	 <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
	 <55BC6C5C.1070707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMLkO-000179-10
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 21:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbbHCTuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 15:50:01 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33782 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbbHCTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 15:50:00 -0400
Received: by qged69 with SMTP id d69so96503239qge.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 12:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=itXR48Ak0NILi6L9mmOu2tPCd3PDpxWp9+nsckzxFO4=;
        b=HKT+BGQhpuFzQbaAaStrsoee+yN3slzEiKEwouYVZ9szl0ApsaSCGS8nCe7CTXX6ql
         PW+YsngMH2E1MKjo7Bj0mfOo/YSuoD/KD7azRSK7K753rmDSqd7rBXzMr6wfBRV7JgM4
         uaBYsE1GItDm4LGt5vaR28RP49w/H93SjwC7ueMYFWYSP8DATNBy8Q427kzS/Ig7O3CL
         FzlUqV8x7UQGBb76K7vWow57fm0eR0YsqTsWOepcMhhHW1Nwzkw3ZMog+whGYBVhlM5x
         gRurGZRi6JanqZObPuLIZqiFt+gU5HGmxdHnZuclh0UJDOLQYI77DVKjkHMujk3MTlhZ
         +7ww==
X-Gm-Message-State: ALoCoQmQGS9lztsT3GEWsNKRiAG9d0N3oN6NDraNp7j4LqobPlT46fN3tpALWawAEIJ9lZzcZbLe
X-Received: by 10.140.34.33 with SMTP id k30mr26865110qgk.56.1438631399367;
        Mon, 03 Aug 2015 12:49:59 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 78sm7323986qhh.42.2015.08.03.12.49.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 12:49:58 -0700 (PDT)
In-Reply-To: <55BC6C5C.1070707@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275191>

On Sat, 2015-08-01 at 08:51 +0200, Michael Haggerty wrote:
> On 08/01/2015 07:12 AM, Junio C Hamano wrote:
> > On Fri, Jul 31, 2015 at 8:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >>
> >> It seems to me that adding a new top-level "worktree-refs" directory is
> >> pretty traumatic. Lots of people and tools will have made the assumption
> >> that all "normal" references live under "refs/".
> >> ...
> >> It's all a bit frightening, frankly.
> > 
> > I actually feel the prospect of pluggable ref backend more frightening,
> > frankly ;-). These bisect refs are just like FETCH_HEAD and MERGE_HEAD,
> > not about the primary purpose of the "repository" to grow the history of refs
> > (branches), but about ephemeral pointers into the history used to help keep
> > track of what is being done in the worktree upstairs. There is no need for
> > these to be visible across worktrees. If we use the real refs that are grobal
> > in the repository (as opposed to per-worktree ones), we would hit the backend
> > databas with transactions to update these ephemeral things, which somehow
> > makes me feel stupid.
> 
> Hmm, ok, so you are thinking of a remote database with high latency. I
> was thinking more of something like LMDB, with latency comparable to
> filesystem storage.
> 
> These worktree-specific references might be ephemeral, but they also
> imply reachability, which means that they need to be visible at least
> during object pruning. Moreover, if the references don't live in the
> same database with the rest of the references, then we have to deal with
> races due to updating references in different places without atomicity.
> 
> The refs+object store is the most important thing for maintaining the
> integrity of a repo and avoiding races. To me it seems easier to do so
> if there is a single refs+objects store than if we have some references
> over here on the file system, some over there in a LMDB, etc. So my gut
> feeling is for the primary reference storage to be in a single reference
> namespace that (at least in principle) can be stored in a single ACID
> database.
>
> For each worktree, we could then create a different view of the
> references by splicing parts of the full reference namespace together.
> This could even be based on config settings so that we don't have to
> hardcode information like "refs/bisect/* is worktree-specific" deep in
> the references module. Suppose we could write
> 
> [worktree.refs]
> 	map = refs/worktrees/*:
> 	map = refs/bisect/*:refs/worktrees/[worktree]/refs/bisect/*
> 
> which would mean (a) hide the references under refs/worktrees", and (b)
> make it look as if the references under
> refs/worktrees/[worktree]/refs/bisect actually appear under refs/bisect
> (where "[worktree]" is replaced with the current worktree's name). By
> making these settings configurable, we allow other projects to define
> their own worktree-specific reference namespaces too.
> 
> The corresponding main repo might hide "refs/worktrees/*" but leave its
> refs/bisect namespace exposed in the usual place.
> 
> "git prune" would see the whole namespace as it really is so that it can
> compute reachability correctly.

I think making this configurable is (a) overkill and (b) dangerous.
It's dangerous because the semantics of which refs are per-worktree is
important to the correct operation of git, and allowing users to mess
with it seems like a big mistake.  Instead, we should figure out a
simple scheme and define it globally.

I think refs/worktree -> refs/worktrees/[worktree]/ would do fine as a
fixed scheme, if we go that route.

We would need two separate views of the refs hierarchy, though: one used
by prune (and pack-refs) that is non-mapped (that is, includes
per-worktree refs for each worktree), and one for general use that is
mapped.   Maybe this is just a flag to the ref traversal functions.

But I'm not sure that this is really the right way to go.

As I understand it, we don't presently do many transactions that include
both pseudorefs or per-worktree refs and other refs.  And we definitely
don't want to move pseudorefs into the database since there's so much
code that assumes they're files.  Also, the vast majority of refs are
common, rather than per-worktree.  In fact, the only per-worktree refs
I've seen mentioned so far are the bisect refs and NOTES_MERGE_REF and
HEAD.  Of these, only HEAD is needed for pruning. Are there more that I
haven't thought of?

So I'm not sure the gain from moving per-worktree refs into the database
is that great.

There are some downsides of moving per-worktree refs into the database:

1. More operations in one worktree can now contend with operations in
another worktree for the database.  LMDB only allows a single write
transaction at a time.  

2. The refs API would be more complicated: it would need to deal with
remapped vs raw ref paths.  Refs backends would need to have functions
to prune per-worktree data when a worktree is destroyed. 

4. We would still need to deal with pseudorefs, so there's still some
missing transactional safety, and still the complication of dealing with
files on the filesystem.

Simply treating refs/worktree as per-worktree, while the rest of refs/
is not, would be a few dozen lines of code.  The full remapping approach
is likely to be a lot more. I've already got the lmdb backend working
with something like this approach.  If we decide on a complicated
approach, I am likely to run out of time to work on pluggable backends.
