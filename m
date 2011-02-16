From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Tue, 15 Feb 2011 22:03:23 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102152040370.14950@debian>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vzkpxm45e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, santi@agolina.net,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 04:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXg0-0007FD-Nf
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 04:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab1BPDDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 22:03:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54870 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397Ab1BPDDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 22:03:30 -0500
Received: by qwa26 with SMTP id 26so780890qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 19:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=/EbrYbibKwjYgNyIvTWOY7UszAdp0xTWDdpFUoHN9NI=;
        b=jPzskNDEr3R7znVMkEZ6gjqy6GDkuJ+8cEaXv+ILAPjgLamoAwbUpk09RNbDc0CKa4
         9yLMwAGqdY5YjBoUibDY6H62wP9kDQ6QtKTSIS0EWYJqaRsFMIItgpBnp90gu2Oimai9
         H2gbwieAnZqXD1mvQNNgESAmVYscbHT0AwHFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Kaenv0wpxrRahgWqOB5Ijiq9Gzhi7d80/ot+R8xEfqG9QOurPhmgbofefAeTrNB2Yr
         IrF4XUWxX6Scv7m6/RQMB69YQKKHKIl319QJepECVd3ctuHfM7hacwWeyjpU7wz5Yhmt
         kq4Xkb7y3Qj9HGlBJuZ7awT8ozqD/kzdyZfeg=
Received: by 10.224.28.129 with SMTP id m1mr62634qac.87.1297825409215;
        Tue, 15 Feb 2011 19:03:29 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id k39sm1607705vcr.26.2011.02.15.19.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 19:03:28 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7vzkpxm45e.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166918>

On Tue, 15 Feb 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 5abfeac..1bc0c29 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -466,6 +466,19 @@ esac
> >  
> >  require_clean_work_tree "rebase" "Please commit or stash them."
> >  
> > +test -n "$upstream_name" && for reflog in \
> > +	$(git rev-list -g $upstream_name 2>/dev/null)
> 
> Ugly.

Very. Fixed. Thanks.

> 	test -n "$upstream_name" &&
>         for reflog in $(git rev-list ...)
>         do
>         	...
> 	done
> 
> Don't you need to make sure $upstream_name is a branch (or a ref in
> general that can have a reflog), or does it not matter because the
> "rev-list -g" will die without producing anything and you are discarding
> the error message?

Exactly as you suspect. Is it too ugly?

> Now, a handful of random questions, none of them rhetorical, as I don't
> know the answers to any of them.
> 
> Would it help if the code is made just as clever as the patch attempts to
> be, when the user says
> 
> 	git rebase origin/next~4
> 
> IOW, use the reflog of origin/next even in such a case?

Not sure. I think it seems too rare to worry about. In those cases,
one could still use the good old '--onto' option manually. Also, if we
don't handle the ref~4 case, the "cleverness" can be disabled by using
ref~0.

> > +do
> > +	if test $reflog = $(git merge-base $reflog $orig_head)
> > +	then
> > +		if test $reflog != $(git merge-base $onto $reflog)
> > +		then
> > +			upstream=$reflog
> > +		fi
> > +		break
> > +	fi
> 
> Do we always traverse down to the beginning of the reflog in the worst
> case?

Yes.

> Would bisection help to avoid the cost?

I don't think the straight-forward use of bisection would work. If the
history looks something like below, where 'b' is the branch to rebase
and 'u' is the upstream, we have to go through each entry in the
reflog to find u@{3}.


        .-u@{0}
       /
      .---u@{1}
     /
x---y-----u@{2}
     \
      .---u@{3}---b
       \
        .-u@{4}


I have an idea inspired by bisection, Thomas's exponential stride, and
what someone (you?) mentioned the other day about virtual merge
commits. I haven't tried it out, but let me know what you think. I'll
try to explain it using an example only:

Exponential stride phase:
1. candidates={ u@{0} }
   merge-base b $candidates -> y, _not_ in $candidates
2. candidates={ u@{1} u@{2} }
   merge-base b $candidates -> y, _not_ in $candidates
3. candidates={ u@{3} u@{4} u@{5} u@{6} }
   merge-base b $candidates -> u@{3}, in $candidates
Bisection phase:
1. candidates={ u@{3} u@{4} }
   merge-base b $candidates -> u@{3}, in $candidates
2. candidates={ u@{3} }
   merge-base b $candidates -> u@{3}, in $candidates, done


It works for the few cases I have thought of, but it may break in
other other cases. I just read about the virtual merge commits, so I'm
not sure I understand correctly how that works eiter.

Would it even perform better than searching linearly? I tried stepping
through it manually a few times and it seems faster.

Maybe something based on timestamps would be better?


/Martin
