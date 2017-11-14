Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFF7A201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbdKNJRQ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Nov 2017 04:17:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43377 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751466AbdKNJRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 04:17:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE2A7AAB5;
        Tue, 14 Nov 2017 09:17:10 +0000 (UTC)
Subject: Re: [RFC 2/3] am: semi working --cover-at-tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <948b19c2-9f2d-de9d-1e0a-6681dc9317a9@suse.de>
 <xmqqbmk54cy3.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <325a3a6f-9916-29cb-48c0-69aa59e5913d@suse.de>
Date:   Tue, 14 Nov 2017 10:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmk54cy3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/11/2017 à 07:00, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>
>>  	if (!git_config_get_bool("commit.gpgsign", &gpgsign))
>>  		state->sign_commit = gpgsign ? "" : NULL;
>> +
>>  }
> Please give at least a cursory proof-reading before sending things
> out.
>
>> @@ -1106,14 +1131,6 @@ static void am_next(struct am_state *state)
>>  
>>  	oidclr(&state->orig_commit);
>>  	unlink(am_path(state, "original-commit"));
>> -
>> -	if (!get_oid("HEAD", &head))
>> -		write_state_text(state, "abort-safety", oid_to_hex(&head));
>> -	else
>> -		write_state_text(state, "abort-safety", "");
>> -
>> -	state->cur++;
>> -	write_state_count(state, "next", state->cur);
> Moving these lines to a later part of the source file is fine, but
> can you do so as a separate preparatory patch that does not change
> anything else?  That would unclutter the main patch that adds the
> feature, allowing better reviews from reviewers.
>
> The hunk below...

Sure. I usually do all this later in the process.
>> +/**
>> + * Increments the patch pointer, and cleans am_state for the application of the
>> + * next patch.
>> + */
>> +static void am_next(struct am_state *state)
>> +{
>> +	struct object_id head;
>> +
>> +	/* Flush the cover letter if needed */
>> +	if (state->cover_at_tip == 1 &&
>> +	    state->series_len > 0 &&
>> +	    state->series_id == state->series_len &&
>> +	    state->cover_id > 0)
>> +		do_apply_cover(state);
>> +
>> +	am_clean(state);
>> +
>> +	if (!get_oid("HEAD", &head))
>> +		write_state_text(state, "abort-safety", oid_to_hex(&head));
>> +	else
>> +		write_state_text(state, "abort-safety", "");
>> +
>> +	state->cur++;
>> +	write_state_count(state, "next", state->cur);
>> +}
> ... if you followed that "separate preparatory step" approach, would
> show clearly that you added the logic to call do_apply_cover() when
> we transition after applying the Nth patch of a series with N patches,
> as all the existing lines will show only as unchanged context lines.

Agreed. The split of am_clean should probably have its own commit too.

>
> By the way, don't we want to sanity check state->last (which we
> learn by running "git mailsplit" that splits the incoming mbox into
> pieces and counts the number of messages) against state->series_len?
> Sometimes people send [PATCH 0-6/6], a 6-patch series with a cover
> letter, and then follow-up with [PATCH 7/6].  For somebody like me,
> it would be more convenient if the above code (more-or-less) ignored
> series_len and called do_apply_cover() after applying the last patch
> (which would be [PATCH 7/6]) based on what state->last says.

I thought about that.
Is there a use case for cover after the last patch works and removes the need to touch am_next (can be done out of the loop in am_run).

If that multiple series in a mbox is something people do, your concern could be solved by flushing the cover when state->series_id goes back to a lower value.

Nicolas


