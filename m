Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3E7C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 17:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiEXRQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiEXRQH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 13:16:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF910C7
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:16:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AA88E17F857;
        Tue, 24 May 2022 13:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ia+Oj4n2rLA1E7tlm5feFYOJdzsOtOgbq8598d
        DSJI4=; b=s/Km/JKA0l+0QWhnhlf1PPfxdWF5pPQI0ZC2a9fT+U1L7CoMfkUxZX
        JmjPBlbRNxIZAROzoFO3Ounh7BZEuvZufI/a2zQYGzhT4Tq/9GYS2R1Iut7ppfr+
        QkR7NquR4adGmhzD15aKBZEBWHu2B/dTMWnN/dxCchFLNRXDy20P4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2FB417F856;
        Tue, 24 May 2022 13:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4201C17F854;
        Tue, 24 May 2022 13:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
Date:   Tue, 24 May 2022 10:15:57 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 May 2022 13:03:41 +0200 (CEST)")
Message-ID: <xmqqleuqj1gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D8B0A2A-DB85-11EC-959A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Not really.  An outer run_active_slot() and an inner
>> run_active_slot() have a pointer to the same slot object.
>
> How is that possible? One of the first things that function does is to
> assign `slot->finished = &finished`, and then run that `while (!finished)`
> loop.
>
> How would the outer `run_active_slot()` ever get signaled via `finished`
> when the inner `run_active_slot()` would overwrite `slot->finished`? I am
> puzzled why we do not see infinite loops in such outer calls all the time,
> then.

The idea in http subsystem goes like this.

 * Generally, we have multiple curl requests in flight.  A curlm
   passed to curl_multi_perform() call knows about them and attempts
   to make as much progress without blocking.

 * After calling curl_multi_perform(), we call process_curl_messages()
   to collect the response that corresponds to the request.  This is
   done using the slot data structure.  Once we read the response,
   we may process it further by making a callback.

 * A slot, when finished, can be reused.  THe reuse is controlled by
   its in_use member.

So, let's trace a code flow, http-walker.c::fetch_object() is used
as a sample starting point.

 * http-walker.c::fetch_object()
   - pushes the object name to object_request queue.
   - calls step_active_slots() to make progress.  This function in turn
     - calls curl_multi_perform() repeatedly to make progress
     - calls process_curl_messages() to possibly complete some active slots
     - calls fill_active_slots() to fill more requests.  This function
       calls the "fill" function repeatedly to make more requests,
       which is http-walker.c::fill_active_slot() in this code path.  It
       - repeatedly calls start_object_request()
         * start_object_request() does these:
           - calls new_http_object_request(), which prepares object-request
             structure, in which there is a slot member that was
	     obtained by calling get_active_slot().
	     * get_active_slot() does many things, but all we need to know	
	       here is that it does "in_use = 1".
           - sets callback for the slot to process_object_response()
           - calls start_active_slot(),
             which adds the slot to curlm and calls curl_multi_perform()
             to make progress on the active slots.
     - calls run_active_slots() repeatedly.

Now run_active_slots() we know about.  Before baa7b67d (HTTP slot
reuse fixes, 2006-03-10), we used to loop on slot->in_use but to fix
a bug we updated it to use slot->finished.

 * run_active_slot()
   - takes a slot
   - clears finished on its stack
   - makes slot->finished point at &finished on its stack
   - loops until "finished" is set
     - calls step_active_slots(); what it does can be seen above,
       but here, we need to know what process_curl_messages() it
       calls does, in order to complete some requests.
       * process_curl_messages() 
         - reads the response from curl
         - finds the slot with request that resulted in the response
         - sets its result member
         - calls finish_active_slot() on it, which in turn does these:
	   - calls closedown_active_slot(), slot->in_use becomes 0
           - sets (*slot->finished) = 1
	   - calls slot->callback_func

The callback_func was set to process_object_response() earlier in
this code flow.

 * http-walker.c::process_object_response()
   - calls process_http_object_request(), which dissociates the slot
     from the http_object_request object.
   - may call fetch_alternates() when the object is not found,
     otherwise calls finish_object_request().

Let's see what happens when fetch_alternates() gets called here.

 * http-walker.c::fetch_alternates()
   - calls step_active_slots() to make progress
   - calls get_active_slot() 
   - calls start_active_slot()
   - calls run_active_slot()

Now we can see how the "slot" we used in the "outer" run_active_slot()
can be reused for a different request.  We received response to the
request, and in process_curl_messages(), we called finish_active_slot()
on the slot, which did three things: (1) slot is now not-in-use, (2) the
"finished" on the stack of the outer run_active_slot() is set to 1, and
(3) called the process_object_response() callback.

The callback then asked for an unused slot, and got the slot we just
used, because we no longer need it (the necessary information in the
response have been copied away to http_object_request object before
the slot was dissociated from it, and the only one bit of
information the outer run_active_slot() needs has already been sent
there on its on-stack "finished" variable).  The reused slot goes
through the usual start_active_slot() call to add it to curlm, and
then the "inner" run_active_slot() is started on it.  Until the
inner run_active_slot() returns, fetch_alternates() would not
return, but once it does, the control goes back to the outer
run_active_slot(), where it finds that its "finished" is now set to
1.

This incidentally is a good illustration why the thread-starter
patch that did

	if (&finished == slot->finished)
		slot->finished = NULL;

would be sufficient, and the "clear only ours" guard is not
necessary, I think.  If the inner run_active_slot() did not trigger
a callback that adds more reuse of the slot, it will clear
slot->finished to NULL itself, with or without the guard.  And the
outer run_active_slot() may fail to clear if the guard is there, but
slot->finished is NULL in that case, so there is no point in clearing
it again.

And if the inner run_active_slot() did trigger a callback that ended
up reusing the slot, then eventually the innermost one would have
cleared slot->finished to NULL, with or without the guard, before it
returned the control to inner run_active_slot().  The inference goes
the same way to show that the guard is not necessary but is not
hurting.

I _think_ we can even get away by not doing anything to
slot->finished at the end of run_active_slot(), as we are not
multi-threaded and the callee only returns to the caller, but if it
helps pleasing the warning compiler, I'd prefer the simplest
workaround, perhaps with an unconditional clearing there?

What did I miss?  I must be missing something, as I can explain how
the current "(*slot->finished) = 1" with "while (finished)"
correctly works, but I cannot quite explain why the original "while
(slot->in_use)" would not, which is annoying.

In other words, why we needed baa7b67d (HTTP slot reuse fixes,
2006-03-10) in the first place?  It is possible that we had some
code paths that forgot to drop in_use before the inner run_active
returned that have been fixed in the 16 years and this fix was
hiding that bug, but I dunno.
