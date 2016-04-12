From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Tue, 12 Apr 2016 19:33:50 +0300
Message-ID: <20160412190904-mutt-send-email-mst@redhat.com>
References: <alpine.DEB.2.20.1604111736060.2967@virtualbox>
 <20160411184535-mutt-send-email-mst@redhat.com>
 <xmqqlh4krkop.fsf@gitster.mtv.corp.google.com>
 <20160411225222-mutt-send-email-mst@redhat.com>
 <vpqr3ebnc9w.fsf@anie.imag.fr>
 <xmqqd1pustdp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:34:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq1GJ-0004ya-IW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbcDLQdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:33:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53430 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932552AbcDLQdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:33:54 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EC3880F73;
	Tue, 12 Apr 2016 16:33:54 +0000 (UTC)
Received: from redhat.com (vpn1-6-52.ams2.redhat.com [10.36.6.52])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3CGXper021888;
	Tue, 12 Apr 2016 12:33:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd1pustdp.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291277>

On Tue, Apr 12, 2016 at 09:07:30AM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> >
> >> Interesting. An empty commit would be rather easy to create on any
> >> branch, not just the current one, using git-commit-tree.
> >
> > This "modify a branch without checking-it out" makes me think of "git
> > notes". It may make sense to teach "git rebase -i" to look for notes in
> > rebased commits and append them to the commit message when applying.
> > Just an idea, not necessarily a good one ;-).
> 
> Yeah that may actually fly well, as a note is designed to attach to
> an exact commit, not to a branch, so that feels more natural.

We'd have to invent a way to show that in the rebase -i output though.


> As to the "use commit-tree", well, personally I am not interested in
> a solution that can work well in my workflow ONLY if I further script
> it.  That's half-solution and unless that half is done very well,
> I'd rather do a full solution better.

Absolutely. But that's not what I meant. I will add a flag to git-ack to
select a branch and use commit-tree to put the ack commit there
*internally*. Would this do everything you need? How do you select
a branch? Automatically or do you remember the mapping from topic
to branch name?

> 	Note: this is a continuation of "I personally would not use
> 	it, even though other people might" discussion.
> 
> I was also wondering if I should just script around filter-branch,
> if all I am futzing with is the data in the trailer block, doing the
> munging of the trailer block with interpret-trailers, naturally.
> 
> In any case, a recent occasion that I had to do something related to
> this topic may illustrate the boundary of requirements:
> 
>     Two developers, Michael and David, are involved.  David sends a
>     24-patch series, some of which were written by Michael and
>     others by David.  The in-body "From:" lines are set right and
>     the resulting patches record authorship correctly.
> 
>     Michael reminds David that patches authored by Michael still
>     need to be signed-off by David.  David sends a single message
>     "those by Michael in this series are signed off by me".
> 
>     Michael also says that he reviewed all patches authored by
>     David, i.e. "Add Acked-by Michael to all patches in this series
>     authored by David".
> 
> Now this is an extreme case where a simple "OK I received an
> e-mailed Ack, so I can rely on the subject line matching to mark it
> to be squashed" approach will never work (i.e. if we were automating
> it I'd expect that the script in DSL to the automation machinery to
> take at last as many (conceptual) bits as the above problem
> description).

So here's how I solve the second part for now - that
is very common: I expect Michael to write something like
For series:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

then I run git ack -s to put the signature in a file .git/ACKS.

(git ack -s is just writing acks into .git/ACKS so
if the email format is wrong I just edit it manually).

And then I tag the series in email and run git ack -r to
add the ack tag.

For first part, that is less common but also happens
(for example I get "for patches 1,7 and 23 in series: ACK") -
I would do git ack -s
to store David's signoff, then tag just messages by David
(probably just using limit ~b From:\ David in mutt)
and pipe them to git ack -r.

Does this sound user-friendly enough? What would you do
differently?

-- 
MST
