Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0BECA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 13:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjILNgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjILNgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 09:36:37 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FB10D2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 06:36:33 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46888)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg3Z8-00BeGE-Ni; Tue, 12 Sep 2023 07:36:30 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48548 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qg3Z7-00G1WP-4d; Tue, 12 Sep 2023 07:36:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-1-ebiederm@xmission.com>
        <ZP+tTFK3Ly4sqlsq@tapette.crustytoothpaste.net>
Date:   Tue, 12 Sep 2023 08:36:22 -0500
In-Reply-To: <ZP+tTFK3Ly4sqlsq@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 12 Sep 2023 00:14:04 +0000")
Message-ID: <87zg1r1pk9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qg3Z7-00G1WP-4d;;;mid=<87zg1r1pk9.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+a/zynWj7WKKM0mhJ2X0V5CatTeY1/g5E=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 01/32] doc hash-file-transition: A map file for mapping
 between sha1 and sha256
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-09-08 at 23:10:18, Eric W. Biederman wrote:
>> The v3 pack index file as documented has a lot of complexity making it
>> difficult to implement correctly.  I worked with bryan's preliminary
>> implementation and it took several passes to get the bugs out.
>> 
>> The complexity also requires multiple table look-ups to find all of
>> the information that is needed to translate from one kind of oid to
>> another.  Which can't be good for cache locality.
>> 
>> Even worse coming up with a new index file version requires making
>> changes that have the potentialy to break anything that uses the index
>> of a pack file.
>> 
>> Instead of continuing to deal with the chance of braking things
>> besides the oid mapping functionality, the additional complexity in
>> the file format, and worry if the performance would be reasonable I
>> stripped down the problem to it's fundamental complexity and came up
>> with a file format that is exactly about mapping one kind of oid to
>> another, and only supports two kinds of oids.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  .../technical/hash-function-transition.txt    | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
>> index ed574810891c..4b937480848a 100644
>> --- a/Documentation/technical/hash-function-transition.txt
>> +++ b/Documentation/technical/hash-function-transition.txt
>> @@ -209,6 +209,46 @@ format described in linkgit:gitformat-pack[5], just like
>>  today. The content that is compressed and stored uses SHA-256 content
>>  instead of SHA-1 content.
>>  
>> +Per Pack Mapping Table
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +A pack compat map file (.compat) files have the following format:
>> +
>> +HEADER:
>> +	4-byte signature:
>> +	    The signature is: {'C', 'M', 'A', 'P'}
>> +	1-byte version number:
>> +	    Git only writes or recognizes version 1.
>> +	1-byte First Object Id Version
>> +	    We infer the length of object IDs (OIDs) from this value:
>> +		1 => SHA-1
>> +		2 => SHA-256
>
> One thing I forgot to mention here, is that we have 32-bit format IDs
> for these in the structure, so we should use them here and below.  These
> are GIT_SHA1_FORMAT_ID and GIT_SHA256_FORMAT_ID.
>
> Not that I would encourage distributing such software, but it makes it
> much easier for people to experiment with additional hash algorithms (in
> terms of performance, etc.) if we make the space a little sparser.

Unfortunately that ship has already sailed. If you look at pack reverse
indices, pack mtime files, multi-pack-index files, they all use an
oid_version field.  So to experiment with a new hash function a new
number has to be picked.

The only use I can find of your 4 byte format_id's is in the reftable
code.

Using a 4 byte magic number in this case also conflicts with basic
simplicity.  With a one byte field I can specify it easily, and read it
back with no special tools, and understand what it means at a glance.

I admit I can only understand what a oid version field means at a glance
because the variation of object id's is low, but that is fundamental.
We require global agreement on names.  Fundamentally git can not
support many object id transitions.  Names are just too expensive.

When I come to how the map file is specified a single byte has real
advantages.  A single byte never needs byte swapping.  So it won't
be misread.  Using a single byte for each format allows me to
keep the header for the file at 16 bytes.  Which guarantees good
alignment of everything in the file without having to be clever.

All of this is for a file that is strictly local and the entire function
of the bytes is a sanity check to make certain that something weird is
not going on, or to assist recover if something bad happens.

So in this case I don't see any additional agility provided by longer
names helping.

>> +	1-byte Second Object Id Version
>> +	    We infer the length of object IDs (OIDs) from this value:
>> +		1 => SHA-1
>> +		2 => SHA-256
>
> In your new patch for the next part, you consider that there might be
> multiple compatibility hash algorithms.  I had anticipated only one at
> a time in my series, but I'm not opposed to multiple if you want to
> support that.
>
> However, here you're making the assumption that there are only two.  If
> you want to support multiple values, we need to explicitly consider that
> both here (where we need a count of object ID version and multiple
> tables, one for each algorithm), and in the follow-up series.
>
> I had not considered more than two algorithms because it substantially
> complicates the code and requires us to develop n*(n-1) tables, but I'm
> not the one volunteering to do most of the work here, so I'll defer to
> your preference.  (I do intend to send a patch or two, though.)
>
> It's also possible we could be somewhat provident and define the on-disk
> formats for multiple algorithms and then punt on the code until later if
> you prefer that.

In the long term I anticipate people disabling compatObjectFormat and
switching to readCompatMap so they still have access to their old
objects by their original names, but they don't have the over head
of computing a compatibility hash.

In a world where there is a transition to futureHash I anticipate
the files associated with an old pack looking something like:
pack-abcdefg.compat12
pack-abcdefg.compat32

For a repository still using hash version sha256 for storage, with a
mapping to some sha1 names, and a mapping of everything to new
names for compatibility with futureHash.

After transitioning to the futureHash those files would look like:
pack-abcdefg.compat13
pack-abcdefg.compat23

I deeply and fundamentally care about having some way to look up
old names because I do that all of the time.

In my work on the linux-kernel I have found myself frequently digging
into old issues.  I have on my hard drive tglx's git import of the
old bitkeeper tree.  I also have an import of all of the old kernel
releases into git from before the code was stored in bitkeeper.  I find
myself actually using all of those trees when digging into issues.

So I think the idea that we will ever be able to get rid of the mapping
for old converted repositories is unlikely.  We have entirely too many
references out there.

Which means that for every hash format conversion a repository goes
through I am going to have another collection of old names.


I don't honestly anticipate ever needing to have multiple
compatObjectFormat entries specified for a single repository.  I do
agree that if we are going to worry about forward and backward
compatibility we should be robust and have a configuration file syntax
that can handle the possibility.

I do very much anticipate needing to have multiple readCompatMap
entries, and pretty much only using them in get_short_oid in
object-name.c.  It will make the loop in find_short_packed_compat_object
a little longer but that is about all that will need to be implemented
and maintained long term.


I view this compat map format a lot like the loose objects.  It is
simple and good enough to get us started.  If it turns out we need
to optimize it's simplicity means all of the interfaces in the code
to use it have already been built, and we can just concentrate on
optimizing.

Eric

