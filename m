Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833AE1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 15:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754463AbeDYPS3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 11:18:29 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:40836 "EHLO
        smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753508AbeDYPS2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Apr 2018 11:18:28 -0400
Received: from smtp25.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp25.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id BF75A20675;
        Wed, 25 Apr 2018 11:18:27 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp25.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 464BB2042A;
        Wed, 25 Apr 2018 11:18:27 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [192.168.222.13] (cable-192.222.220.61.electronicbox.net [192.222.220.61])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 25 Apr 2018 11:18:27 -0400
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
Date:   Wed, 25 Apr 2018 11:18:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-25 04:48 AM, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> 
>> In the thread from 6 years ago, you asked about tar's behavior for
>> mtimes. 'tar xf' restores mtimes from the tar archive, so relative
>> ordering after restore would be the same, and would only rebuild if the
>> original source happened to be dirty.
>>
>> This behavior is already non-deterministic in Git, and would be improved
>> by the patch.
> 
> But Git is not an archiver (tar), but is a source code control
> system, so I do not think we should spend any extra cycles to
> "improve" its behaviour wrt the relative ordering, at least for the
> default case.  Only those who rely on having build artifact *and*
> source should pay the runtime (and preferrably also the
> maintainance) cost.

Anyone who uses "make" or some other mtime-based tool is affected by 
this.  I agree that it's not "Everyone" but it sure is a lot of people.

Are we all that sure that the performance hit is that drastic?  After 
all, we've just done write_entry().  Calling utime() at that point 
should just hit the filesystem cache.

> The best approach to do so is to have those people do the "touch"
> thing in their own post-checkout hook.  People who use Git as the
> source control system won't have to pay runtime cost of doing the
> touch thing, and we do not have to maintain such a hook script.
> Only those who use the "feature" would.

The post-checkout hook approach is not exactly straightforward.

Naively, it's simply

	for F in `git diff --name-only $1 $2`; do touch "$F"; done

But consider:

* Symlinks can cause the wrong file to be touched.  (Granted, Michał's 
proposed patch also doesn't deal with symlinks.)  Let's assume that a 
hook can be crafted will all possible sophistication.  There are still 
some fundamental problems:

* In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are 
identical so the above loop does nothing.  Offhand I'm not even sure how 
a hook might get the right files in this case.

* The hook has to be set up in every repo and submodule (at least until 
something like Ævar's experiments come to fruition).

* A fresh clone can't run the hook.  This is especially important when 
dealing with submodules.  (In one case where we were bit by this, make 
though that half of a fresh submodule clone's files were stale, and 
decided to re-autoconf the entire thing.)


I just don't think the hook approach can completely solve the problem.

I appreciate Ævar's concern that there are more than just two mtime 
requests floating around.  But I think git's users are best served by a 
built-in approach, with a config setting to control the desired mtime 
handling (defaulting to the current behaviour).  People who want a 
different mtime solution will at least have a clear place in the code to 
propose a patch.

		M.

