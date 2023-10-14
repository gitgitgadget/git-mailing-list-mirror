Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8261C698
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iMuiPanx"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621AC9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:41:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3739221ABF;
	Sat, 14 Oct 2023 13:41:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hjOqbdAnsRQRjjVkaw5IhkNMpyaWNXt4JbFmN+
	T0HFM=; b=iMuiPanxSnHcXPHLaiRltT8wrqaTU30Xuli/4lGkjrq8Z6PnBjH+uW
	SbBchpHx/l+Vo/Dfs4kRhfDB1caAl+X0W5IvaZJlaIPxfmVH1sJyK65J+tjS0P2H
	C7EgEBgxDbZCAOUDbtg/hn++YtWcr/b5HATjJZ0A2fZwwTYgCIkjg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FBFB21ABE;
	Sat, 14 Oct 2023 13:41:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D81C621ABD;
	Sat, 14 Oct 2023 13:41:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Sebastian Thiel <sebastian.thiel@icloud.com>,  git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
In-Reply-To: <ZSouSI_zPusOefsv@localhost> (Josh Triplett's message of "Sat, 14
	Oct 2023 13:59:36 +0800")
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
	<xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost>
Date: Sat, 14 Oct 2023 10:41:49 -0700
Message-ID: <xmqqil79t82q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4D1C25E-6AB8-11EE-9770-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Josh Triplett <josh@joshtriplett.org> writes:

> On Tue, Oct 10, 2023 at 10:02:20AM -0700, Junio C Hamano wrote:
>> Sebastian Thiel <sebastian.thiel@icloud.com> writes:
>> 
>> > I'd like to propose adding a new standard gitattribute "precious".
>> 
>> ;-).
>> 
>> Over the years, I've seen many times scenarios that would have been
>> helped if we had not just "tracked? ignored? unignored?" but also
>> the fourth kind [*].  The word "ignored" (or "excluded") has always
>> meant "not tracked, not to be tracked, and expendable" to Git, and
>> "ignored but unexpendable" class was missing.  I even used the term
>> "precious" myself in those discussions.  At the concept level, I
>> support the effort 100%, but as always, the devil will be in the
>> details.
>
> "I've already wanted this for years" is, honestly, the best response we
> could *possibly* have hoped for.

Yeah, but that is not what I gave here.

It is something I saw people want from time to time over the years;
I am not at all talking about my desire, or lack thereof, to add it
to the system ;-)

>> In previous discussions, nobody was disturbed that "git clean" was
>> unaware of the "precious" class, but if we were to have the
>> "precious" class in addition to "ignored" aka "expendable", I would
>> not oppose to teach "git clean" about it, too.
>> 
>> There was an early and rough design draft there in
>> 
>> https://lore.kernel.org/git/7vipsnar23.fsf@alter.siamese.dyndns.org/
>> 
>> which probably is worth a read, too.

The project can say something like

    # force older git to ignore
    .config
    # older git unignores "$.config" without touching ".config"
    # but newer git applies the "last one wins" rule as usual
    # to mark ".config" as precious.
    !$.config

if our syntax were to retrofit '!' prefix, and even more simply

    #:(precious)
    .config

if we adopt Phillip's "comment abuse" idea, where older Git will
treat it as saying ".config" is not to be added but is expendable,
while newer Git will treat it as saying ".config" is not to be added
and not to be clobbered.
