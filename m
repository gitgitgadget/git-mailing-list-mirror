Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DE15EB8
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vs0wMWns"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49698AB
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:27:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3E6B1B1913;
	Sat, 14 Oct 2023 12:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YfxaWnwTxILXvjjYx99w08q1TqIcMThVCEVM0h
	DZtwc=; b=vs0wMWnstSLjolrVT0mw6S726R2XmTJUYIEsgHIgDaQULhAeuQPYUT
	ReawCVHA46zoB0Au8W6enw7VquPy6NalJmn0eFvuFf7J4SUdD51O9G5PaEJihu/C
	N9XDcX6PK3KKmOzAoY5c3OlzF/gl409UOncx0yzkjitT6eADKDrj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D39921B1912;
	Sat, 14 Oct 2023 12:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 447D41B1911;
	Sat, 14 Oct 2023 12:27:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <20231014040101.8333-1-jacob@initialcommit.io> (Jacob Stopak's
	message of "Fri, 13 Oct 2023 21:01:01 -0700")
References: <20231014040101.8333-1-jacob@initialcommit.io>
Date: Sat, 14 Oct 2023 09:27:27 -0700
Message-ID: <xmqq4jitw4nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 90E6979C-6AAE-11EE-9CD9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jacob Stopak <jacob@initialcommit.io> writes:

> Currently, git bugreport postfixes the default bugreport filename (and
> diagnostics zip filename if --diagnose is supplied) with the current
> calendar hour and minute values, assuming the -s flag is absent.

Is "postfix" a verb that is commonly understood?  I would say
"append" would be understood by more readers.  Also, is "calendar"
hour different from other kinds of hours, perhaps stopwatch hours
and microwave-oven hours?

> If a user runs the bugreport command more than once within a calendar
> minute, a filename conflict with an existing file occurs and the program
> errors, since the new output filename was already used for the previous
> file.

This is totally expected and you made an excellent observation.

I personally do not think it is a problem, simply because a quality
bug report that would capture information necessary to diagnose any
issue concisely in a readable fashion would take at least 90 seconds
or more to produce, though.

Instead of lengthening the filename for all files by 2 digits, the
command can retry by adding say "+1", "+2", etc. after the failed
filename to find a unique suffix within the same minute.  It would
mean that after writing git-bugreport-2023-10-14-0920.txt and you
start another one without spending enough time, the new one may
become git-bugreport-2023-10-14-0920+1.txt or something unique.  It
would be really unlikely that you would run out after failing to
find a vacant single digit suffix nine times, i.e. trying "+9".  It
would also help preserve existing user's workflow, e.g. they may
have written automation that assumes the down-to-minute format and
it would keep working on their bug reports without breaking.
