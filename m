From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 09:28:55 +0100
Message-ID: <81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HROrC-0008Qa-1C
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 09:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbXCNI26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 04:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbXCNI26
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 04:28:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3285 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933884AbXCNI25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 04:28:57 -0400
Received: by nf-out-0910.google.com with SMTP id o25so121174nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 01:28:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iYmNv6VamPBRmuxil4Uwi38wi5+zZrHVoE34IOdS534tqzRj8+7tRw7RLuUOR9C3Zirl4gISeCZgL0/1NGmQGjDODxXktYYBSRlO3Ip697KVwxpNoVfs3d/bC5KhcbGioDKubfRfJjjXAlCjq/kcrEf/C7mktHt7FKXrVlQKD5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0mX5mOJhyFMqyK0jLRFq3XQmOSvjzBBVKOL91D9n+0ukDGYxlJn8thmfmqhrGsqQxWv7c7Tap0uPnv5Bn4WZrMCigcbh8LgopG50pIFsHvAJ326HIE1K40+e6Gk7mRYzD4yA/plM0Ow1oMyL3DkXS5xghKLZqD3VmzXSqT/itk=
Received: by 10.78.181.13 with SMTP id d13mr998015huf.1173860935071;
        Wed, 14 Mar 2007 01:28:55 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 01:28:55 -0700 (PDT)
In-Reply-To: <7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42184>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > diff --git a/builtin-diff.c b/builtin-diff.c
> > index 4efbb82..5e6265f 100644
> > --- a/builtin-diff.c
> > +++ b/builtin-diff.c
> > @@ -130,6 +130,7 @@ static int builtin_diff_tree(struct rev_info *revs,
> >  {
> >       const unsigned char *(sha1[2]);
> >       int swap = 0;
> > +     int result = 0;
> >
> >       if (argc > 1)
> >               usage(builtin_diff_usage);
> > @@ -141,9 +142,9 @@ static int builtin_diff_tree(struct rev_info *revs,
> >               swap = 1;
> >       sha1[swap] = ent[0].item->sha1;
> >       sha1[1-swap] = ent[1].item->sha1;
> > -     diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
> > +     result = diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
> >       log_tree_diff_flush(revs);
> > -     return 0;
> > +     return result;
> >  }
> >
> >  static int builtin_diff_combined(struct rev_info *revs,
>
> The change to diff-tree side is completely borked.  (1) You did
> not notice compare_tree_entry() in tree-diff.c returns 0 only to
> signal that it has dealt with an entry from both sides (so the
> caller can do update_tree_entry() on both), and the return value
> does not mean they are the same.  (2) You are checking if there
> are differences at wrong level, before letting diffcore_std() to
> process the queue.  Because of the bug (1) I cannot test that
> but after you fix (1) you would notice that it would not work if
> you say "-Spickaxe"; your changes to diff-files and diff-index
> are correct on this regard.

Challenging... Now, if someone just told me where to look for
differences in diff-tree case...

> A slight tangent, but what Linus recalled he thought he did but
> he didn't is related to the parts you touched in diff-tree
> above.  Because of the interaction with diffcore, these changes
> should not be used for the purpose of -exit-code, but catching
> the tree level change in the above places and leaving early
> would be the right thing to do for comparing the whole tree for
> the purpose of simplifying the parents.  Tomorrow will be my git
> day so I might whip up a patch to speed that up.

Can it eventually be wired to "-s" (DIFF_FORMAT_NO_OUTPUT)?

> >       diffcore_std(&revs->diffopt);
> > +     ret = revs->diffopt.diff_exit_code && diff_queued_diff.nr ? 1: 0;
> >       diff_flush(&revs->diffopt);
> >       return ret;
> >  }
>
> This side looks correct, as you are counting queued_diff.nr after
> letting diffcore_std() to filter the results.
>

And it will continue to work if the diffing is left early because of
no output needed. Err, will it?

> > +test_expect_failure 'git diff-index --cached HEAD' '
> > +     git update-index c &&
> > +     git diff-index --exit-code --cached HEAD
> > +'
>
> In general, expect_failure should not be used for complex cases
> like this.  The first one I quoted is fine, but the latter one
> is not.  update-index may fail (perhaps somebody screwed up
> while updating read-cache.c or sha1_file.c) and the whole test
> would say "happy that the command chain as a whole failed".

Right. Fixed.
