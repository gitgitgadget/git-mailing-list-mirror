Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E8EE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjIJSUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjIJSUl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:20:41 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F0CC5
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:20:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53236)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfP2w-000ATz-Um; Sun, 10 Sep 2023 12:20:35 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35748 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfP2v-003PLu-Ov; Sun, 10 Sep 2023 12:20:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <ZP3i9WdpDKlsWuNP@tapette.crustytoothpaste.net>
Date:   Sun, 10 Sep 2023 13:20:26 -0500
In-Reply-To: <ZP3i9WdpDKlsWuNP@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Sep 2023 15:38:29 +0000")
Message-ID: <878r9dgaad.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfP2v-003PLu-Ov;;;mid=<878r9dgaad.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18+s83MWArlFyNojCcYMzlBH2QyGmVHjIU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-09-08 at 23:05:52, Eric W. Biederman wrote:
>> 
>> I would like to see the SHA256 transition happen so I started playing
>> with the k2204-transition-interop branch of brian m. carlson's tree.
>> 
>> Before I go farther I need to some other folks to look at this and see
>> if this is a general direction that the git project can stand.
>
> I'm really excited to see this and I think it's a great way forward.
> I've taken a brief look at each patch, and I don't see anything that
> should be a dealbreaker.  I left a few comments, although I think your
> mailserver is blocking mine at the moment, so you may not have received
> them (hopefully you can read them on the list in the interim).

I can.  I will see if I can figure out what is happening with direct
reception tomorrow.

> You may also feel free to simply adjust the commit message for the
> patches of mine you've modified without needing to document that you've
> changed them.  I expect that you will have changed them when you submit
> them, if only to resolve conflicts.  After all, Junio does so all the
> time.

Thanks.  I was doing my best at striking a balance between giving credit
where is credit is due, and pointing out the bugs are probably mine.

>> This patchset is not complete it does not implement converting a
>> received pack of the compatibility hash into the hash function of the
>> repository, nor have I written any automated tests.  Both need to happen
>> before this is finalized.
>
> Speaking of tests, one set of tests I had intended to write and think
> should be written, but had not yet implemented, is tests for
> round-tripping objects.  That is, the SHA-1 value we get for a revision
> in a pure SHA-1 repository should obviously be the same as the SHA-1
> value we get in a SHA-256 repository in interop mode, and we should be
> able to use the `test_oid_cache` functionality to hard-code the desired
> objects.  I think it would be also helpful to do this for fixed objects
> that are doubly-signed (with both algorithms) as well, since that's a
> tricky edge case that we'll want to avoid breaking.  Other edge cases
> will include things like merge commits, including octopus merges.

Yes.  I think we can use cat-file to do that.  Have two repositories one
in each format.  Verify that when cat-file prints out an object given
the native oid cat-file prints out what was put in.  Similarly verify
that when cat-file prints out an object given the compatibility oid
cat-file prints out the expected conversion.  That logic performed in
both repositories should work.

> But overall, I think this is a great improvement, and I'm very excited
> to see someone picking up some of this work and moving it forward.
> Thanks for doing so.

Thanks.

Then next goal is to get enough merged that I can test the round-trip
conversions.  More than anything else we need to know the conversion
functionality is solid.

Plus I expect that while 32 patches were important to show the scope of
the work, but a bit much to fully review and merge all at once.

Eric
