Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9B92018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbcGASBM (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:01:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752472AbcGASBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 14:01:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC99929A4B;
	Fri,  1 Jul 2016 14:01:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kpx7uo1e/oUi
	v1MBsWyBgyWTQYc=; b=LCY5UXEqGB4Rx+q3OGiTR/NFahciR6acAiiXVAPh6o1Z
	m77jVkxJnUka2/FXiO4c9+tKRKdCSO0M2q77u0kdam7G8rBmojhw4atGGJuij3R7
	iXDyCOC9WUF2OTAxd7svtnT65+CvR5qgUA/pDUbJvDIt3v372ae2gYjDx4lz2Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B1vW0U
	PWLPFHeivg6iDCNY+UkvJnXNwFk8VFPShYqEZ+UmyHYSyzb4sUgFFXo9zy9snGuw
	nfLADTLA9fKct0c2s6UtHygr4NK2woeABn+yz0kAT7u2QbzA/zwyoP57yMZrOVAc
	iwXllo7/i0y1HXHv9iDFv4vZXlM1uMgKHuJCM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A057F29A49;
	Fri,  1 Jul 2016 14:01:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 191BB29A47;
	Fri,  1 Jul 2016 14:01:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring blank lines
References: <20160616174620.1011-1-sbeller@google.com>
	<20160617153637.GA9314@sigill.intra.peff.net>
	<CAGZ79kZgdbqnWW9uqeBHNDbyGVfc0x5gTJbyD0Nyi1i3SNvENQ@mail.gmail.com>
	<576C1803.5050905@alum.mit.edu> <57752478.1000302@alum.mit.edu>
Date:	Fri, 01 Jul 2016 11:01:01 -0700
In-Reply-To: <57752478.1000302@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 30 Jun 2016 15:54:00 +0200")
Message-ID: <xmqq8txlz19e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C65FA93A-3FB5-11E6-9743-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I put quite of work into tooling to evaluate diff heuristics, and just
> published it on GitHub:
>
>     https://github.com/mhagger/diff-slider-tools
>
> The README there is hopefully enough to let people get started using it
> to test their own favorite heuristics.

Intereting.  A fair TL;DR of this would be that what we write and
want to diff have the structure where things often are ordered in an
inherent hierarchy, and things at the higher level are highlighted
by being less indented, and the indent-based heuristics exploit that
well to choose a slide that breaks at the higher-level boundary, e.g.

> The algorithm does pretty well with XML and HTML:
>
>> fef3ea39f8bd474add292bb6437df6cbd22e1ba7:contributors.xml a394a0bdf8e6240dc09023a8260059c57c158a00:contributors.xml + 1624
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>                >    <last>Toni</last>
>>                >  </name>
>>                >  <name>
>>                >    <first>Vincent</first>
>>                >    <last>Legoll</last>
>>       -2 |     >  </name>
>>       -1 |   i >  <name>
>>        0 || ci >    <first>Vincent</first>
>>          || ci >    <last>Privat</last>
>>           | ci >  </name>
>>           | c  >  <name>

And that trait is shared among common programming languages (Java,
Perl, Go, C, etc.).

The only case I can think of offhand that does not follow "higher
level heading is less indented" pattern is an already typeset book,
where chapter headers are often centered on the page while section
headers may be at the left edge.  But we are not likely to be
interested to get that case right anyway, so it is OK.

> gettext source:
>
>> aef18cc6063106075afeb3a78ec72656b19c8bde:po/de.po b0e098ce46ce7f8ecd975720ccec8d0eb7787e50:po/de.po - 12954
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>                >#~ msgid "unmerged:   %s"
>>                >#~ msgstr "nicht zusammengeführt:   %s"
>>                >
>>                >#~ msgid "input paths are terminated by a null character"
>>                >#~ msgstr "Eingabepfade sind durch ein NUL Zeichen abgeschlossen"
>>       -2 |     >
>>       -1 |  ci >#~ msgid ""
>>        0 || ci >#~ "The following untracked files would NOT be saved but need to be removed "
>>          || ci >#~ "by stash save:"
>>          || ci >#~ msgstr ""
>>          || ci >#~ "Die folgenden unbeobachteten Dateien würden NICHT gespeichert werden,\n"
>>          || ci >#~ "müssen aber durch \"stash save\" entfernt werden:"
>>           | ci >

This is an interesting example of "have only a single level
hierarchy.  A line is either in one block or a blank between
blocks".

> It often fails to get C preprocessor directives right:
>
>> a08595f76159b09d57553e37a5123f1091bb13e7:http.c aeff8a61216bf6e0d663c08c583bc8552fa3c344:http.c + 429
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>                >		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
>>                >#endif
>>                >#if LIBCURL_VERSION_NUM >= 0x070908
>>                >	if (ssl_capath != NULL)
>>                >		curl_easy_setopt(result, CURLOPT_CAPATH, ssl_capath);
>>       -1 |   i >#endif
>>        0 || ci >#if LIBCURL_VERSION_NUM >= 0x072c00
>>          || ci >	if (ssl_pinnedkey != NULL)
>>          || ci >		curl_easy_setopt(result, CURLOPT_PINNEDPUBLICKEY, ssl_pinnedkey);
>>           | c  >#endif

Yes, this is "non-human do not know 'end' is likely to be at the end
of a logical block".

> And it gets confused by unusual blank line placement:
>
>> ed55169834a3ce16a271def9630c858626ded34d:tools/eslint/node_modules/doctrine/lib/doctrine.js 2d441493a4a46a511ba1bdf93e442c3288fbe92d:tools/eslint/node_modules/doctrine/lib/doctrine.js + 330
>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>>                >                        name === 'external' ||
>>                >                        name === 'event')) {
>>                >                    name += advance();
>>                >                    name += scanIdentifier(last);
>>                >
>>       -1 |   i >                }
>>        0 || ci >                if(source.charCodeAt(index) === 0x5B  /* '[' */ && source.charCodeAt(index + 1) === 0x5D  /* ']' */){
>>          || ci >                    name += advance();
>>          || ci >                    name += advance();
>>           | c  >                }

Likewise, this is showing that a "non-human not knowing } is a closing
and { is an opening token".

By the way, I no longer remember what indent level your
"indent-only" heuristics gives to a blank line.  Does the closing
brace we see above (marked with -1) count as increasing the
indentation level from the previous empty-line at indent 0, or does it
count as dedenting from the previous empty-line that has virtually
at the same indent level as "name += scanIdentifier(last);" line?

