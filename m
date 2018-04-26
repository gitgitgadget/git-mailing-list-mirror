Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BE11F424
	for <e@80x24.org>; Thu, 26 Apr 2018 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756262AbeDZOMN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 10:12:13 -0400
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:48761 "EHLO
        smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754727AbeDZOMM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Apr 2018 10:12:12 -0400
Received: from smtp2.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp2.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 4039CC02C0;
        Thu, 26 Apr 2018 10:12:12 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp2.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CA047C0287;
        Thu, 26 Apr 2018 10:12:11 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 26 Apr 2018 10:12:12 -0400
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Junio C Hamano <gitster@pobox.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
 <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <8a7e0d0c-a821-b289-b390-ca9818f6770b@xiplink.com>
Date:   Thu, 26 Apr 2018 10:12:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqefj24v3c.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-25 09:25 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>>> But Git is not an archiver (tar), but is a source code control
>>> system, so I do not think we should spend any extra cycles to
>>> "improve" its behaviour wrt the relative ordering, at least for the
>>> default case.  Only those who rely on having build artifact *and*
>>> source should pay the runtime (and preferrably also the
>>> maintainance) cost.
>>
>> Anyone who uses "make" or some other mtime-based tool is affected by
>> this.  I agree that it's not "Everyone" but it sure is a lot of
>> people.
> 
> That's an exaggerated misrepresentation.  Only those who put build
> artifacts as well as source to SCM *AND* depend on mtime are
> affected.
> 
> A shipped tarball often contain configure.in as well as generated
> configure, so that consumers can just say ./configure without having
> the whole autoconf toolchain to regenerate it (I also heard horror
> stories that this is done to control the exact version of autoconf
> to avoid compatibility issues), but do people arrange configure to
> be regenerated from configure.in in their Makefile of such a project
> automatically when building the default target?

Yes.  I've seen many automake-generated Makefiles with "recheck" 
machinery that'll conveniently rerun autoconf if "necessary".

(And those horror stories are true, BTW.)

> In any case, that is
> a tarball usecase, not a SCM one.

No, it's an SCM case when you need to have the project's code as part of 
your own.  I can't make everyone do things the Right Way, so I'm stuck 
using projects that are not 100% pure-source, because they "helpfully" 
release their code after the autoconf step for some reason.

>> Are we all that sure that the performance hit is that drastic?  After
>> all, we've just done write_entry().  Calling utime() at that point
>> should just hit the filesystem cache.
> 
> I do not know about others, but I personally am more disburbed by
> the conceptual ugliness that comes from having to have such a piece
> of code in the codebase.

The ugliness arises from the problem being solved.  It's not git's fault 
that the world is so stupid.

That git might be willing to suffer a bit of self-mutilation for the 
benefit of its users should be seen as a point of pride.

		M.

