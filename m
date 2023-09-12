Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C05EE3F31
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjILVT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjILVT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 17:19:28 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E210CA
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 14:19:24 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43196)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgAn4-00Dcyg-0S; Tue, 12 Sep 2023 15:19:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35428 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qgAn2-00H5ek-Dw; Tue, 12 Sep 2023 15:19:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <ZP+PKa3N1N1PXROM@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Sep 2023 22:05:29 +0000")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <xmqq8r9di5ba.fsf@gitster.g>
        <87cyyoeli0.fsf@email.froward.int.ebiederm.org>
        <ZP+PKa3N1N1PXROM@tapette.crustytoothpaste.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Tue, 12 Sep 2023 16:19:13 -0500
Message-ID: <87v8cfxf72.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qgAn2-00H5ek-Dw;;;mid=<87v8cfxf72.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX196mVAWEACw3PFb95pBW91hAscAVa11z4c=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-09-11 at 16:13:27, Eric W. Biederman wrote:
>> Junio, brian for the very warm reception of this, it is very
>> encouraging.
>> 
>> I am not worried about what it will take time to get the changes I
>> posted into the integration.  I had only envisioned them as good enough
>> to get the technical ideas across, and had never envisioned them as
>> being accepted as is.
>> 
>> What I am envisioning as my future directions are:
>> 
>> - Post non controversial cleanups, so they can be merged.
>>   (I can only see about 4 of them the most significant is:
>>    bulk-checkin: Only accept blobs)
>> 
>> - Sort out the configuration options
>> 
>> - Post the smallest patchset I can that will allow testing the code in
>>   object-file-convert.c.  Unfortunately for that I need configuration
>>   options to enable the mapping.
>> 
>>   In starting to write the tests I have already found a bug in
>>   the conversion of tags (an extra newline is added), and I haven't
>>   even gotten to testing the tricky bits with signatures.
>
> I wonder if unit tests are a possibility here now that we're starting to
> use them.  They're not obligatory, of course, but it may be more
> convenient for you if they turn out to be a suitable option.  If not, no
> big deal.

I believe you mean using test-tool and making a very narrow focused test
on just the functionality.

If the number of patches I have to go through before I can test anything
becomes a problem I might go there.  Unfortunately it would take some
refactoring to make object-file-convert independent of the object
mapping layer, and that is extra work and is likely to introduces bugs
as anything.

I have managed to get a set of tests working.  I am just going through
now and plugging the holes.

My big strategy for testing convert_object_file is to build two
repositories one sha1 and the other sha256 both with compatibility
support enabled.  I add a series of objects to those repositories and
compare them to ensure the objects are identical.

It is working well and is finding bugs not just in convert_object_file
but in code such as commit and tag that perform interesting work with
signed commits.

I discovered I had bungled the placement of hash_object_file for
the compatibility hash in commit.

I found that git tag did not yet support building tags with both
hash algorithms.

Right now I am looking at commits with mergetag lines.  It is not fun.
The mergetag instead of pointing to the tag objects they include the
body of the tag objects in the commit object.  So I have convert
the embedded tag objects from one hash function to another.
Which given the presence of preceding space on every line of
the embedded tag object makes it doubly interesting.  Perhaps
someone has already written code to extract the embedded tag.

Or in short everything is moving along steadily.

Eric
