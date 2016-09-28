Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97911F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbcI1Rch (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:32:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61571 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932977AbcI1Rcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF831405C2;
        Wed, 28 Sep 2016 13:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/BC4jo20cmw3aQFP8JvrXU8eHfk=; b=H9pp0h
        A0RcfKf2NkUz1qLMhDIqDAvNi+UAeLGKpVSNA2+lgE2+W2mBtmpkw5NkocCqbdHn
        CFC8mtx71e5EbBZ7D1YP5YuDiEkZUh4JUbNUQpk8FKOLOKABx0CzPRcQURgirS0T
        6j0jlYHile2ArnDnyT2yqZevociXkDOmybmrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s77AmPAH5cJ6O/2HsfApzeDAvfTN/t/7
        X/h7mkXOlmhVT3diEe8KnWF6xW1JnwpYGenbWidPHlLZGw66bmUHpPVbbYe83A4b
        bAHOm+cVi81EuEsBY+RzPKfrIx2nJi7dRTk6l173KGFcBGEwf6N8F/MJF7TnTYcv
        wkEk/ia0wsk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B248C405C1;
        Wed, 28 Sep 2016 13:32:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15B96405C0;
        Wed, 28 Sep 2016 13:32:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <20160927215143.GA32622@starla>
        <xmqqshslkndk.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 28 Sep 2016 10:32:30 -0700
In-Reply-To: <xmqqshslkndk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Sep 2016 15:07:35 -0700")
Message-ID: <xmqqy42cj5g1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89E44952-85A1-11E6-8B63-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> git clone --resume <resumable_work_or_git_dir>
>>
>> I think calling "git fetch" should resume, actually.
>> It would reduce the learning curve and seems natural to me:
>> "fetch" is jabout grabbing whatever else appeared since the
>> last clone/fetch happened.
>
> I hate say this but it sounds to me like a terrible idea.  At that
> point when you need to resume, there is not even ref for "fetch" to
> base its incremental work off of.  It is better to keep the knowledge
> of this "priming" dance inside "clone".  Hopefully the original "clone"
> whose connection was disconnected in the middle would automatically
> attempt resuming and "clone --resume" would not be as often as needed.

After sleeping on this, I want to take the above back.

I think teaching "git fetch" about the "resume" part makes tons of
sense.

What "git clone" should have been was:

    * Parse command line arguments;

    * Create a new repository and go into it; this step would
      require us to have parsed the command line for --template,
      <directory>, --separate-git-dir, etc.

    * Talk to the remote and do get_remote_heads() aka ls-remote
      output;

    * Decide what fetch refspec to use, which alternate object store
      to borrow from; this step would require us to have parsed the
      command line for --reference, --mirror, --origin, etc;

    --- we'll insert something new here ---

    * Issue "git fetch" with the refspec determined above; this step
      would require us to have parsed the command line for --depth, etc.

    * Run "git checkout -b" to create an initial checkout; this step
      would require us to have parsed the command line for --branch,
      etc.

Even though the current code conceptually does the above, these
steps are not cleanly separated as such.  I think our update to gain
"resumable clone" feature on the client side need to start by
refactoring the current code, before learning "resumable clone", to
look like the above.

Once we do that, we can insert an extra step before the step that
runs "git fetch" to optionally [*1*] grab the extra piece of
information Kevin's "prime-clone" service produces [*2*], and store
it in the "new repository" somewhere [*3*].

And then, as you suggested, an updated "git fetch" can be taught to
notice the priming information left by the previous step, and use it
to attempt to download the pack until success, and to index that
pack to learn the tips that can be used as ".have" entries in the
request.  From the original server's point of view, this fetch
request would "want" the same set of objects, but would appear as
an incremental update.

Of course, the final step that happens in "git clone", i.e. the
initial checkout, needs to be done somehow, if your user decides to
resume with "git fetch", as "git fetch" _never_ touches the working
tree.  So for that purpose, the primary end-user facing interface
may still have to be "git clone --resume <dir>".  That would
probably skip all four steps in the above sequence, the new
"download priming information" step and go directly to the step that
runs "git fetch".

I do agree that is a much better design, and the crucial design
decision that makes it a better design is your making "git fetch"
aware of this "ah, we have the instruction left in this repository
how to prime its object store" information.

Thanks.


[Footnotes]

*1* It is debatable if it would be an overall win to use the "first
    prime by grabbing a large packfile" clone if we are doing
    shallow or single-branch clone, hence "optionally".  It is
    important to notice that we already have enough information to
    base the decision at this point in the above sequence.

*2* As I said, I do not think it needs to be a separate new service,
    and I suspect it may be a better design to carry it over the
    protocol extension.  At this point in the above sequence, we
    have done an equivalent of ls-remote and if we designed a
    protocol extension to carry the information we should already
    have it.  If we use a separate new service, we can of course
    make a separate connection to ask about "prime-clone"
    information.  The way this piece of information is transmitted
    is of secondary importance.

*3* In addition to the "prime-clone" information, we may need to
    store some information that is only known to "clone" (perhaps
    because it was given from the command line) to help the final
    "checkout -b" step to know what to checkout around here, in case
    the next "fetch" step is interrupted and killed.


