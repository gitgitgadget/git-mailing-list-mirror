Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8422C206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 23:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbcLLXcQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 18:32:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62190 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751427AbcLLXcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 18:32:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBE7958DD8;
        Mon, 12 Dec 2016 18:32:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KHZ2qWybXCNNCvDWpkQ/qRTGoIs=; b=AD7U87
        sg7Cndy9sIYKm/SiE90Anp8ap1E5GA0gLIgdc965EF56GPKgOc5tS+Vlq+bxo0AI
        aaq6gE64nxDAhTjb6i2RHKbN6Mh1wNPlrqrn9LIyDsM92U0VMac81ax5EuhhR7tg
        yX6bEpC52gUMif4rp9jA73MjLt3ktFemuOmWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cbgKh6xTAfSe/y3AAzgcaf0+yzDqRWsU
        Q9P25mJDv3fcQ/1xNTlHvNHWyGtP6n1SWdAuBDmspMqZNpHmeVZOXtx8hadJ27SQ
        7x/UA3bKO7bquLD2nmgodMGnrp95RQzKmUNLN6KP/Q2tkF6qNYvRR6ipzBClt2ZV
        76J4lY0eYMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B238158DD7;
        Mon, 12 Dec 2016 18:32:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27A9558DD6;
        Mon, 12 Dec 2016 18:32:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 1/4] real_path: resolve symlinks by hand
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-2-git-send-email-bmwill@google.com>
        <xmqqd1gw94f1.fsf@gitster.mtv.corp.google.com>
        <20161212225006.GB193413@google.com>
Date:   Mon, 12 Dec 2016 15:32:12 -0800
In-Reply-To: <20161212225006.GB193413@google.com> (Brandon Williams's message
        of "Mon, 12 Dec 2016 14:50:06 -0800")
Message-ID: <xmqqk2b47mgz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35A2F084-C0C3-11E6-BDCA-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 12/12, Junio C Hamano wrote:
> ...
>> E.g. for input path "foo/bar/", the above loop runs zero times and
>> then ...
>> 
>> > +	/* Skip sequences of multiple path-separators */
>> > +	while (offset < len && is_dir_sep(path->buf[len - 1]))
>> > +		len--;
>> 
>> ... the slash at the end is removed, leaving "foo/bar" in path.
>
> The way this is currently used I don't believe this scenario can happen
> (since input to this shouldn't have trailing slashes), but if others
> begin to use this function then yes, that is an implicit assumption.

OK.

>> > +	/* Iterate over the remaining path components */
>> > +	while (remaining.len > 0) {
>> > +		get_next_component(&next, &remaining);
>> > +
>> > +		if (next.len == 0) {
>> > +			continue; /* empty component */
>> > +		} else if (next.len == 1 && !strcmp(next.buf, ".")) {
>> > +			continue; /* '.' component */
>> > +		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
>> > +			/* '..' component; strip the last path component */
>> > +			strip_last_component(&resolved);
>> 
>> Wouldn't this let "resolved" eventually run out of the path
>> components to strip for a malformed input e.g. "/a/../../b"?
>
> As I understand it, that path is correct and would resolve to "/b".

That is OK on the traditional UNIX end.  

I am not sure if we want to handle the "//host/share/$remaining" in
this codepath, though.  If we do, then this is still an issue (IIRC,
somebody explained that we do not want to step into //host/share/
part when seeing ".."---we'd at least need to leave a NEEDSWORK
comment so that interested parties can later take a look into it.
