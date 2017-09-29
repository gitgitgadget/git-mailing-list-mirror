Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2B4B20A2A
	for <e@80x24.org>; Fri, 29 Sep 2017 06:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdI2GGX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 02:06:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53473 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751070AbdI2GGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 02:06:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51FA2B0A33;
        Fri, 29 Sep 2017 02:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fwp9E9lpGV6k2NgaXvRiHwqImW8=; b=SgyTT6
        KgmXZpHzpPlpTaK0pPGmxMGBw2x9YsjHNktVHgpneq0hURdnSa0FYbsoYOejjJlA
        EKm1pGE5Lr2LZgRcH8xhnfk2qUURvlshcOWDxoZqWkm2FN2Rtgv0QINlbdMZ9z1T
        uiVrBa/9C1URgvIKV2xJbeWSDo7coqOYqTM04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oiUR2a2cZ1PEc2ppG/J0bGynD4Tw/n3w
        ZAGc68eDws/0FOoXvaTrOUShu71VEh0FF1X24oXjTQURBNMi+UVWXbZzWF/f5RVi
        CILa1ZRRfYBhVuV/zMQOIktWfENmjrZFV+q4TJ/oPS3LejGTc9AK4LTDoJ4RO+Au
        y2aH7co5FOk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 455B4B0A32;
        Fri, 29 Sep 2017 02:06:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85DF2B0A31;
        Fri, 29 Sep 2017 02:06:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function transition
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
        <20170928044320.GA84719@aiede.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 15:06:19 +0900
In-Reply-To: <20170928044320.GA84719@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 27 Sep 2017 21:43:21 -0700")
Message-ID: <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 505F825E-A4DC-11E7-912F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> This document describes what a transition to a new hash function for
> Git would look like.  Add it to Documentation/technical/ as the plan
> of record so that future changes can be recorded as patches.
>
> Also-by: Brandon Williams <bmwill@google.com>
> Also-by: Jonathan Tan <jonathantanmy@google.com>
> Also-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Shoudln't these all be s-o-b: (with a note immediately before that
to say all four contributed equally or something)?

> +Background
> +----------
> +At its core, the Git version control system is a content addressable
> +filesystem. It uses the SHA-1 hash function to name content. For
> +example, files, directories, and revisions are referred to by hash
> +values unlike in other traditional version control systems where files
> +or versions are referred to via sequential numbers. The use of a hash

Traditional systems refer to files via numbers???  Perhaps "where
versions of files are referred to via sequential numbers" or
something?

> +function to address its content delivers a few advantages:
> +
> +* Integrity checking is easy. Bit flips, for example, are easily
> +  detected, as the hash of corrupted content does not match its name.
> +* Lookup of objects is fast.

* There is no ambiguity what the object's name should be, given its
  content.

* Deduping the same content copied across versions and paths is
  automatic.

> +SHA-1 still possesses the other properties such as fast object lookup
> +and safe error checking, but other hash functions are equally suitable
> +that are believed to be cryptographically secure.

s/secure/more &/, perhaps?

> +Goals
> +-----
> +...
> +   c. Users can use SHA-1 and NewHash identifiers for objects
> +      interchangeably (see "Object names on the command line", below).

Mental note.  This needs to extend to the "index X..Y" lines in the
patch output, which is used by "apply -3" and "am -3".

> +2. Allow a complete transition away from SHA-1.
> +   a. Local metadata for SHA-1 compatibility can be removed from a
> +      repository if compatibility with SHA-1 is no longer needed.

I like the emphasis on "Local" here.  Metadata for compatiblity that
is embedded in the objects obviously cannot be removed.

From that point of view, one of the goals ought to be "make sure
that as much SHA-1 compatibility metadata as possible is local and
outside the object".  This goal may not be able to say more than "as
much as possible", as signed objects that came from SHA-1 world
needs to carry the compatibility metadata somewhere somehow.  

Or perhaps we could.  There is nothing that says a signed tag
created in the SHA-1 world must have the PGP/SHA-1 signature in the
NewHash payload---it could be split off of the object data and
stored in a local metadata cache, to be used only when we need to
convert it back to the SHA-1 world.

But I am getting ahead of myself before reading the proposal
through.

> +Non-Goals
> +---------
> ...
> +6. Skip fetching some submodules of a project into a NewHash
> +   repository. (This also depends on NewHash support in Git
> +   protocol.)

It is unclear what this means.  Around submodule support, one thing
I can think of is that a NewHash tree in a superproject would record
a gitlink that is a NewHash commit object name in it, therefore it
cannot refer to an unconverted SHA-1 submodule repository.  But it
is unclear if the above description refers to the same issue, or
something else.

> +Overview
> +--------
> +We introduce a new repository format extension. Repositories with this
> +extension enabled use NewHash instead of SHA-1 to name their objects.
> +This affects both object names and object content --- both the names
> +of objects and all references to other objects within an object are
> +switched to the new hash function.
> +
> +NewHash repositories cannot be read by older versions of Git.
> +
> +Alongside the packfile, a NewHash repository stores a bidirectional
> +mapping between NewHash and SHA-1 object names. The mapping is generated
> +locally and can be verified using "git fsck". Object lookups use this
> +mapping to allow naming objects using either their SHA-1 and NewHash names
> +interchangeably.
> +
> +"git cat-file" and "git hash-object" gain options to display an object
> +in its sha1 form and write an object given its sha1 form.

Both of these are somewhat unclear.  I am guessing that "git
cat-file --convert-to=sha1 <type> <NewHashName>" would emit the
object contents converted from their NewHash payload to SHA-1
payload (blobs are unchanged, trees, commits and tags get their
outgoing references converted from NewHash to their SHA-1
counterparts), and that is what you mean by "options to display an
object in its sha1 form".  

I am not sure how "git hash-object" with the option would work,
though.  Do you give an option "--hash=sha1 --stdout --stdin -t
<type>" to feed a NewHash contents (file, tree, commit or tag) to
the command, convert it to the SHA-1 content (hmm, how's that
different from the cat-file's new option???) and then write out its
loose object representation suitable to be used in the SHA-1 workd?
Where do you write it to?  It won't be in the repository, as we
rejected mixed repository in our Non-Goals section.

> +Object names
> +~~~~~~~~~~~~
> +Objects can be named by their 40 hexadecimal digit sha1-name or 64
> +hexadecimal digit newhash-name, plus names derived from those (see
> +gitrevisions(7)).
> +
> +The sha1-name of an object is the SHA-1 of the concatenation of its
> +type, length, a nul byte, and the object's sha1-content. This is the
> +traditional <sha1> used in Git to name objects.
> +
> +The newhash-name of an object is the NewHash of the concatenation of its
> +type, length, a nul byte, and the object's newhash-content.

It makes me wonder if we want to add the hashname in this object
header.  "length" would be different for non-blob objects anyway,
and it is not "compat metadata" we want to avoid baked in, yet it
would help diagnose a mistake of attempting to use a "mixed" objects
in a single repository.  Not a big issue, though.

> +The format allows round-trip conversion between newhash-content and
> +sha1-content.

If it is a goal to eventually be able to lose SHA-1 compatibility
metadata from the objects, then we might want to remove SHA-1 based
signature bits (e.g. PGP trailer in signed tag, gpgsig header in the
commit object) from NewHash contents, and instead have them stored
in a side "metadata" table, only to be used while converting back.
I dunno if that is desirable.

> +Pack index
> +~~~~~~~~~~
> +Pack index (.idx) files use a new v3 format that supports multiple
> +hash functions. They have the following format (all integers are in
> +network byte order):
> +
> +- A header appears at the beginning and consists of the following:
> +  - The 4-byte pack index signature: '\377t0c'
> +  - 4-byte version number: 3
> +  - 4-byte length of the header section, including the signature and
> +    version number
> +  - 4-byte number of objects contained in the pack
> +  - 4-byte number of object formats in this pack index: 2
> +  - For each object format:
> +    - 4-byte format identifier (e.g., 'sha1' for SHA-1)
> +    - 4-byte length in bytes of shortened object names. This is the
> +      shortest possible length needed to make names in the shortened
> +      object name table unambiguous.
> +    - 4-byte integer, recording where tables relating to this format
> +      are stored in this index file, as an offset from the beginning.
> +  - 4-byte offset to the trailer from the beginning of this file.
> +  - Zero or more additional key/value pairs (4-byte key, 4-byte
> +    value). Only one key is supported: 'PSRC'. See the "Loose objects
> +    and unreachable objects" section for supported values and how this
> +    is used.  All other keys are reserved. Readers must ignore
> +    unrecognized keys.
> +- Zero or more NUL bytes. This can optionally be used to improve the
> +  alignment of the full object name table below.
> +- Tables for the first object format:
> +  - A sorted table of shortened object names.  These are prefixes of
> +    the names of all objects in this pack file, packed together
> +    without offset values to reduce the cache footprint of the binary
> +    search for a specific object name.

I take it to mean that the stride is defined in the "length in bytes
of shortened object names" in the file header.  If so, I can see how
this would work.  This "sorted table", unlike the next one, does not
say how it is sorted, but I assume this is just the object name
order (as opposed to the pack location order the next table uses)?

> +  - A table of full object names in pack order. This allows resolving
> +    a reference to "the nth object in the pack file" (from a
> +    reachability bitmap or from the next table of another object
> +    format) to its object name.
> +
> +  - A table of 4-byte values mapping object name order to pack order.
> +    For an object in the table of sorted shortened object names, the
> +    value at the corresponding index in this table is the index in the
> +    previous table for that same object.
> +
> +    This can be used to look up the object in reachability bitmaps or
> +    to look up its name in another object format.

And this is a separate table because the short-name table wants to
be as compact as possible for binary search?  Otherwise an entry in
the short-name table could be <pack order number, n-bytes that is
short unique prefix>.

> +  - A table of 4-byte CRC32 values of the packed object data, in the
> +    order that the objects appear in the pack file. This is to allow
> +    compressed data to be copied directly from pack to pack during
> +    repacking without undetected data corruption.

An obvious alternative would be to have the CRC32 checksum near
(e.g. immediately before) the object data in the packfile (as
opposed to the .idx file like this document specifies).  I am not
sure what the pros and cons are between the two, though, and that is
why I mention the possiblity here.

Hmm, as the corresponding packfile stores object data only in
NewHash content format, it is somewhat curious that this table that
stores CRC32 of the data appears in the "Tables for each object
format" section, as they would be identical, no?  Unless I am
grossly misleading the spec, the checksum should either go outside
the "Tables for each object format" section but still in .idx, or
should be eliminated and become part of the packdata stream instead,
perhaps?

> +  - A table of 4-byte offset values. For an object in the table of
> +    sorted shortened object names, the value at the corresponding
> +    index in this table indicates where that object can be found in
> +    the pack file. These are usually 31-bit pack file offsets, but
> +    large offsets are encoded as an index into the next table with the
> +    most significant bit set.

Oy.  So we can go from a short prefix to the pack location by first
finding it via binsearch in the short-name table, realize that it is
nth object in the object name order, and consulting this table.
When we know the pack-order of an object, there is no direct way to
go to its location (short of reversing the name-order-to-pack-order
table)?

> +  - A table of 8-byte offset entries (empty for pack files less than
> +    2 GiB). Pack files are organized with heavily used objects toward
> +    the front, so most object references should not need to refer to
> +    this table.

> +- Zero or more NUL bytes.

... for padding/aligning.

> +- Tables for the second object format, with the same layout as above,
> +  up to and not including the table of CRC32 values.
> +- Zero or more NUL bytes.
> +- The trailer consists of the following:
> +  - A copy of the 20-byte NewHash checksum at the end of the
> +    corresponding packfile.
> +
> +  - 20-byte NewHash checksum of all of the above.

When did NewHash shrink to 20-byte suddenly?  I think the above two
are both "32-byte"?

> +Loose object index
> +~~~~~~~~~~~~~~~~~~
> +A new file $GIT_OBJECT_DIR/loose-object-idx contains information about
> +all loose objects. Its format is
> +
> +  # loose-object-idx
> +  (newhash-name SP sha1-name LF)*
> +
> +where the object names are in hexadecimal format. The file is not
> +sorted.

Shouldn't the file somehow say what hashes are involved to allow us
match it with extension.{objectFormat,compatObjectFormat}, perhaps
at the end of the "# loose-object-idx" line?

> +The loose object index is protected against concurrent writes by a
> +lock file $GIT_OBJECT_DIR/loose-object-idx.lock. To add a new loose
> +object:
> +
> +1. Write the loose object to a temporary file, like today.
> +2. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the lock.
> +3. Rename the loose object into place.
> +4. Open loose-object-idx with O_APPEND and write the new object

"write the new entry, fsync and close"?

> +Translation table
> +~~~~~~~~~~~~~~~~~
> +The index files support a bidirectional mapping between sha1-names
> +and newhash-names. The lookup proceeds similarly to ordinary object
> +lookups. For example, to convert a sha1-name to a newhash-name:
> +
> + 1. Look for the object in idx files. If a match is present in the
> +    idx's sorted list of truncated sha1-names, then:
> +    a. Read the corresponding entry in the sha1-name order to pack
> +       name order mapping.
> +    b. Read the corresponding entry in the full sha1-name table to
> +       verify we found the right object. If it is, then
> +    c. Read the corresponding entry in the full newhash-name table.
> +       That is the object's newhash-name.

c. is possible because b. and c. are sorted the same way, i.e. the
index used to consult the full sha1-name table, which is the pack
order number, can be used to find its full newhash in the "full
newhash sorted by pack order" table?

> +Reading an object's sha1-content
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I'd stop here and continue in a separate message.  Thanks for a
detailed write-up.
