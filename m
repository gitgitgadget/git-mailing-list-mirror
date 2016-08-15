Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183641F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbcHOS3L (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:29:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbcHOS3K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3A86340ED;
	Mon, 15 Aug 2016 14:29:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nglKBZrhlbMsxm2HIAQeF/9QkoE=; b=D4TTdq
	GjfOWKu0MPN+l7Ch09/VcVStQkqPVXACyTkfDtokw1cmBQeDCezGuO3Nx1S9TH4l
	RS3iOI8uhbar/wOYjE+73TCY2iTp/DcCoatg5PwB2ITyHwUnPGr5GCRPyMAitxAm
	1XQZXB34+uKXcxTPXnm80o5grPeHFF+HIrQjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yd1NzISalLln6EheyRK+EmK43TJ5FEVG
	lbug0B3a/VpriKj391zCwSwNNxN29gH02ueBoj2Il65D31O2nl8hSYYb6aCvaoVN
	voMOMgPQsc3yoQ+Jh2KMuyS1aXwU86Pz7dJqi/NolOLGYQy9bhmiZbUCy10p3iAS
	X7Pu2bU//c8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBB32340EC;
	Mon, 15 Aug 2016 14:29:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D252340E9;
	Mon, 15 Aug 2016 14:29:08 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
	<20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
	<8737m63phh.fsf@linux-m68k.org>
	<20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
Date:	Mon, 15 Aug 2016 11:28:20 -0700
In-Reply-To: <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 14:09:05 -0400")
Message-ID: <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2781247C-6316-11E6-911A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 15, 2016 at 07:34:50PM +0200, Andreas Schwab wrote:
>
>> On Aug 15 2016, Jeff King <peff@peff.net> wrote:
>> 
>> > And implicit in your test is the other bug, which is that deleting the
>> > last key in a section leaves the empty header. I think it's related to
>> > the same issue.
>> 
>> Indiscriminately removing empty section headers may break comments that
>> have been put there on purpose.
>
> I know, but we do not even do so discriminately.

I notice that we have thought about all the issues when we last
discussed it in 2013.  Refining a message from the earlier thread,
as it illustrates tricky cases in which we have to be careful.

If we were to remove the section header at this point, we should
be removing the comment two out of three cases.

 - if it is about section.key, it should go when section.key goes.
 - if it is about section, it should go when section goes.
 - if it is a more generic comment about this configuration file,
   it should stay.

A configuration file may have something like this:

        # Now, let's list all the remotes I interact with.

        # This is where I push all the separate topics.
        [remote "github"]
                # fetch like everybody else without auth
                url = git://github.com/user/git
                # push with auth
                pushURL = github.com:user/git
                # publish my working area as-is
                mirror

        # Traditional "canonical" one
        [remote "korg"]
                url = k.org:/pub/scm/user/git

If I were to retire the "github" account, removing the entire
[remote "github"] section while keeping the comments before that
section would be confusing, which would end up with:

        # Now, let's list all the remotes I interact with.

        # This is where I push all the separate topics.

        # Traditional "canonical" one
        [remote "korg"]
                url = k.org:/pub/scm/user/git

because I do not push all the separate topics to korg.

Removing the section while removing the comments that pertain to the
section is impossible; "Now, let's list all the remotes" should
stay, "This is where I push" should go.

So a comment outside [section "name"] is tricky; it needs some
mechanism (or convention) to tell us if it is about the particular
section, or it is about the location in the configuration file.

Removing only the keys and keeping the skelton around would give us:

        # Now, let's list all the remotes I interact with.
        # This is where I push all the separate topics.
        [remote "github"]
                # fetch like everybody else without auth
                # push with auth
                # publish my working area as-is

        # Traditional "canonical" one
        [remote "korg"]
                url = k.org:/pub/scm/user/git

which is still confusing, but at least the confusion is not spread
to adjacent sections.  What we could do easily without understanding
natural languages is to remove comments inside [section "name"], but
it still depends on a convention that such a per-key comment comes
before the key, not after, i.e.

        # This is where I push all the separate topics.
        [remote "github"]
                # fetch like everybody else without auth
                ...
                # publish my working area as-is
                mirror
		# note that mirror may push out outside tags/ and heads/

	# Traditional "canonical" one
	[remote "korg"]

We could also take hints from the indentation level, but now we are
deep into the "convention" territory once we start doing that.
