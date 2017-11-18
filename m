Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9032202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 01:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161266AbdKRBkt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 20:40:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751953AbdKRBkr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 20:40:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B17A2AD300;
        Fri, 17 Nov 2017 20:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nZ4sucYMa10KVwxF+9NFw+tA934=; b=mY/azo
        BgonEByT5ryra3NCuHHKe614/mhlksdeKpSnDLLE2oUoazq7y37Ze1UTAESOxcV9
        tZitVbIxDjCYNQKZDJ/dC5o+lwtfgOJPwU/p1l2SDZiw17L26hVyPdF05nlu09mf
        bxUHkiltVi2fngMp+fleqMAHoZLVNiacafQvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c2TyrNkkKp6pu3HeZECzCR6FTvyBrsWh
        yEDulG8WAGYjv6j/+tZfizvmR8QFpp2TQ9ApOUgM9p/Yyebc+sfXs6VGejnxVQOV
        gXl8KcKFk6Ug/SC+5LmJ63/jmBB8bzNI0Mq4MF6+thNJD/VQEU0spzOUSERzDWEH
        8AXvdQdkpao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8E6DAD2FE;
        Fri, 17 Nov 2017 20:40:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23D0CAD2FC;
        Fri, 17 Nov 2017 20:40:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
        <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
Date:   Sat, 18 Nov 2017 10:40:44 +0900
In-Reply-To: <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 17 Nov 2017 14:41:18 -0500")
Message-ID: <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F5842D4-CC01-11E7-BCE7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -40,6 +40,32 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>> +               static const char *close_notice = NULL;
>> +
>> +               if (isatty(2) && !close_notice) {
>
> If you reverse this condition to say (!close_notice && isatty(2)),
> then you save an isatty() invocation each time if close_notice is
> already assigned.
>
> However, it's not clear how much benefit you gain from stashing this
> away in a static variable. Premature optimization?

The variable being "static" could be (but it was done primarily
because it allowed me not to worry about freeing), but during a
single invocation, it primarily is used as a flag "are we showing
the editor invocation notice?" two places in the function can use
without having to do the same checks twice.

If we want this as an optimization "we've already checked the
condition in our previous call, so let's use the result without
checking again", then this has to become tristate:

 - We haven't checked, and needs checking (probably NULL);

 - We have checked, and we know we want to show the notice---here is
   a string to use when we clear the notice (what we have here);

 - We have checked, and we know we do not want to show the notice
   (there is no provision for this in the posted code---that makes
   this not an optimization yet).

Perhaps an empty string can be used for the last one, but if/when it
is done, the above needs to go in a comment near the definition of
the variable.

> Should printing of close_notice be done before the error()? Otherwise,
> you get this:
>
> --- 8< ---
> Launched your editor (...) ...There was a problem...
> --- 8< ---

In my version with a far shorter message, I deliberately chose not
to clear the notice.  We ran the editor, and we saw a problem.  That
is what happened and that is what will be left on the terminal.

I agree that the verbose message Lars substituted makes it harder to
read.
