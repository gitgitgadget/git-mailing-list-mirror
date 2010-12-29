From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 02/31] rebase: refactor reading of state
Date: Wed, 29 Dec 2010 09:09:37 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012290550080.29381@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-3-git-send-email-martin.von.zweigbergk@gmail.com> <7v1v51v6l2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 15:08:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXwhv-00019V-CA
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 15:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0L2OIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 09:08:46 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:65074 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab0L2OIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 09:08:45 -0500
Received: by qyk4 with SMTP id 4so3035667qyk.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 06:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=L0kaHhoS9/fRAI+oRB+bfqMZjJrYaELeGkUhzBRjmKQ=;
        b=bPs+X9sx7l0Ixc4hOnbQtASD5WV6NIZCn6GYU4QnF96k5VGKv4jWfLST9LlkEcEadM
         6R4JluZgwB8WeMgUOGsUnV8OuEiKvHVvCwA49BGjAtfqqVRhbM/gPnBTLbbVcCo+Pi5e
         6xNVPrf4XNoJ7PRMZRl0LUUBtU1M99+nvKLaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=S/0eh66uXpRxta+lmJ3DvostIGGm4JRQXTtuK9QOjASmaa6NaFZmUG4YvZ5TFZLjpA
         IcCh0iE7LqcLztEp2ylaa2LbIra9bg2AjdSC6EwEiXq6iVvqPm328LeFa/QuKK9HBzWq
         56h27pqG+FIMMOIBMDZtL6zE8+tb1XNA+VyZ4=
Received: by 10.229.220.134 with SMTP id hy6mr13065760qcb.287.1293631724781;
        Wed, 29 Dec 2010 06:08:44 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm8426698qck.22.2010.12.29.06.08.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 06:08:43 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v1v51v6l2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164312>

On Tue, 28 Dec 2010, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > +read_state () {
> > +	if test -d "$merge_dir"
> > +	then
> > +		state_dir="$merge_dir"
> > +		prev_head=$(cat "$merge_dir"/prev_head) &&
> > +		end=$(cat "$merge_dir"/end) &&
> > +		msgnum=$(cat "$merge_dir"/msgnum)
> > +	else
> > +		state_dir="$apply_dir"
> > +	fi &&
> > +	head_name=$(cat "$state_dir"/head-name) &&
> > +	onto=$(cat "$state_dir"/onto) &&
> > +	orig_head=$(cat "$state_dir"/orig-head) &&
> > +	GIT_QUIET=$(cat "$state_dir"/quiet)
> > +}
> > +
> >  continue_merge () {
> >  	test -n "$prev_head" || die "prev_head must be defined"
> >  	test -d "$merge_dir" || die "$merge_dir directory does not exist"
> > @@ -138,10 +154,6 @@ call_merge () {
> >  }
> >  
> >  move_to_original_branch () {
> > -	test -z "$head_name" &&
> > -		head_name="$(cat "$merge_dir"/head-name)" &&
> > -		onto="$(cat "$merge_dir"/onto)" &&
> > -		orig_head="$(cat "$merge_dir"/orig-head)"
> 
> It used to be safe to call this without head_name and friends set, because
> the function took care of reading these itself.  Nobody calls this without
> head_name set anymore?
> 
> I am not complaining nor suggesting to add an unnecessary "read_state"
> here only to slow things down---I am making sure that you removed this
> because you know it is unnecessary.

Correct. It used to be called without head_name set from
finish_rb_merge, which would in turn be called from the --continue and
--skip arms. onto would already have been set in these cases, but
would then be re-read.

> > @@ -220,13 +232,9 @@ do
> >  			echo "mark them as resolved using git add"
> >  			exit 1
> >  		}
> > +		read_state
> >  		if test -d "$merge_dir"
> >  		then
> > -			prev_head=$(cat "$merge_dir/prev_head")
> > -			end=$(cat "$merge_dir/end")
> > -			msgnum=$(cat "$merge_dir/msgnum")
> > -			onto=$(cat "$merge_dir/onto")
> > -			GIT_QUIET=$(cat "$merge_dir/quiet")
> 
> Even though this patch may make the code shorter, it starts to read
> head_name and orig_head that we previously did not open and change the
> values of variables with what are read from them.  Does this change affect
> the behaviour in any way (either in performance or in correctness)?

True. Previously, head_name and orig_head were lazily read only when
the rebase had been finished (in the finish_rb_merge, as I mentioned
above). Now these values are read unnecessarily when the rebase is
resumed, but a later patch fails. The am-based rebase is not affacted
by this patch as it already read head_name and orig_head eagerly.

Good point about the correctness. I looked into the correctness issue
arising if a file could not be found and I think I concluded that all
of the files would always be written (do we need to care about the
case where a user deletes e.g. .git/rebase-apply/onto?). However, I
did not think about the possibility of overwriting variables. It seems
fine, though, as neither continue_merge nor call_merge uses either of
these variables.

Regarding performance, I would say there is definitely a cost
associated with this patch. How big this cost is, though, I don't dare
to speculate. I will leave that up to the rest of you.

It should be noted that read_state is only called when a rebase is
resumed with --continue or --skip, or when it is aborted. There are no
changes to the code in the call_merge-continue_merge loop.

The performance hit is probably biggest in the --abort case, which
previously only read head_name and orig_head. It now ends up reading
_at least_ two more values.

> 
> > @@ -236,10 +244,6 @@ do
> >  			finish_rb_merge
> >  			exit
> >  		fi
> > -		head_name=$(cat "$apply_dir"/head-name) &&
> > -		onto=$(cat "$apply_dir"/onto) &&
> > -		orig_head=$(cat "$apply_dir"/orig-head) &&
> > -		GIT_QUIET=$(cat "$apply_dir"/quiet)
> >  		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
> >  		move_to_original_branch
> 
> Earlier move-to-original-branch was Ok to be called without head_name, and
> the old code here read from the file anyway, so it didn't matter, but now
> it seems that the first check and assignment you removed from the function
> may matter because this caller does not even read from head_name.  Are you
> sure about this change?

If I understand your question correctly, then yes, it is ok, because
of the previous hunk that calls read_state. That call is made
before/outside the if block for merge-based rebase, so the variables
are already set when this code is reached.
 
> > @@ -279,18 +275,15 @@ do
> >  			die "No rebase in progress?"
> >  
> >  		git rerere clear
> > -
> > -		test -d "$merge_dir" || merge_dir="$apply_dir"
> 
> My heartbeat skipped when I first saw this.  Thanks to the previous
> commit, it was exposed that somebody reused $dotest that was only to be
> used when using merge machinery because the things left to be done in this
> codepath are common between the merge and apply, which is kind of sloppy,
> but that sloppiness is now gone ;-).
> 
> Are there places that read from individual files for states left after
> this patch, or read_state is the only interface to get to the states?  If
> the latter that would be a great news, and also would suggest that we may
> want to have a corresponding write_state function (and we may even want to
> make the state into a single file to reduce I/O---but that is a separate
> issue that can be done at the very end of the series if it turns out to be
> beneficial).

There are still a few other places where state is read, mainly in
call_merge. It reads things that vary from iteration to iteration,
such as a counter. I forgot to say in the commit message, but I tried
to extract only the code that reads the initial state.

The write_state function actually is there, but it comes pretty late,
in patch 24. I don't remember why I added it so much later. I could
possibly move it closer to the beginning of this series.
 
> Of course it is fine if introduction of read_state is an attempt to catch
> most common cases, but it would reduce chances of mistake if the coverage
> were 100% (as opposed to 99.9%) hence this question.

Do you mean if all the state was read in the read_state function? I
should say that the pieces of state that are read in read_state are
not read anywhere else. But overall, the coverage is more like 60% or
so.


Thanks for a thorough review. Many of these things should have been in
the commit message. I need to get better at writing those...


Thanks,
Martin
