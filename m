Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D77FC0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 20:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C9C206C0
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 20:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgCPUBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:01:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:38148 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732436AbgCPUBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 16:01:18 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jDvvJ-0000Lk-6K; Mon, 16 Mar 2020 20:01:18 +0000
Subject: Re: [TOPIC 3/17] Obliterate
To:     Damien Robert <damien.olivier.robert@gmail.com>,
        James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au>
 <20200315221940.bdgi5mluxuetq2lz@doriath>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5cab1530-f8b6-cef3-7b93-48fad410a160@iee.email>
Date:   Mon, 16 Mar 2020 20:01:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200315221940.bdgi5mluxuetq2lz@doriath>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien, James, (and 4 other who voted for the topic)

I had been thinking about 'missing' blobs for a long while as a earlier
'partial clone' concept (unpublished)

On 15/03/2020 22:19, Damien Robert wrote:
> From James Ramsay, Thu 12 Mar 2020 at 14:57:24 (+1100) :
>> 6. Elijah: replace refs helps, but not supported by hosts like GitHub etc
>>     a. Stolee: breaks commit graph because of generation numbers.
>>     b. Replace refs for blobs, then special packfile, there were edge cases.
> I am interested in more details on how to handle this using replace.
>
> My situation: coworkers push big files by mistake, I don't want to rewrite
> history because they are not too well versed with git, but I want to keep
> *my* repo clean.
>
> Partial solution:
> - identify the large blobs (easy)
> - write a replace ref (easy):
>   $ git replace b5f74037bb91 $(git hash-object -w -t blob /dev/null)
>   and replace the file (if it is still in the repo) by an empty file.

Here, my idea was to create a deliberately malformed blob object that
would allow self reference to say "this blob is deliberately missing".
(i.e. the same content would exist under two oids, one valid, one
invalid) The change would require extra code (more below).

Managing the verification of the replacement is a bigger problem,
especially if already pushed to a server.
> Now the pain points start:
> - first the index does not handle replace (I think), so the replaced file
>   appear as changed in git status, even through eg git diff shows nothing.
>
> => Solution: configure .git/info/sparse-checkout
>
> - secondly, I want to remove the large blob from my repo.
>
> Ideally I'd like to repack everything but filter this blob, except that
> repack does not understand --filter. So I need to use `git pack-objects`
> directly and then do the naming and clean up that repack usually does
> manually, which is error prone.
>
> Furthermore, while `git pack-objects` accepts --filter, I can only filter on
> blob size, not blob oid. (there is filter=sparse:oid where I could reuse my
> sparse checkout file, but I would need to make a blob of it first). And if I
> have one large file I want to keep, I cannot filter by blob size.
>
> Another solution would be to use `git unpack-objects` to unpack all objects
> (except I would need to do that in an empty git dir), remove the blob, and
> then repack everything.
>
> Am I missing a simpler solution?
>
> - finally, checkouting to a ref including the replaced (now missing) blob
>   gives error messages of the form:
> error: invalid object 100644 b5f74037bb91c45606b233b0ad6aad86f8e3875e for 'Silverman-Height-NonTorsion.pdf'
>
> On the one hand it is reassuring that git checks that the real object
> (rather than only the replaced object) is still there, on the other hand it
> would be nice to ask git to completely forget about the original object
> (except fsck of course).
>
> Thanks,
> Damien
My notes on the "13. Obliterate" ideas.

1. If the object is in the wild & is dangerous : Stop: Failed: Damage
limitation.
2. If the object is external, but still tame : Seek and recapture;
either treat as internal, or treat as wild [1].
3. The object is in captivity, even if distributed around an enclosure.
Proceed to vaccination [4].
4. Create new blob object with exact content "Git revoke: <oid>" (or
similar) This object includes the embedded object type coding as part of
the object format. This object is/becomes part of the git signature/oid
commit hierarchy. This should (ultimately) be on 'master' branch as it
is the verifier for the obliteration.
5. In the old revoked object <oid>, replace the object content (after
zlib etc) with the same content as created in step 4. This deliberately
_malformed_ object would normally cause fsck to barf. see [6]
6. However here we/fsck would detect the length and prefix of the
(barfed) object contents and so determine its oid (the oid of the
content). This results in an oid equal to that found in 4. which can be
looked up and determined to be a self referral to this obliterated oid,
so an fsck 'pass:obliterated' result is returned. This content could be
actually be stored in any removed file if checked out!

Consequences:
Packs and other served object contents no longer contain the  revoked oid.
Hygiene/vaccination needs applied to other distributed recipients of the
former defective object.

Possible attacks: Attacker removes other important commits/blobs/trees
by adding a 'revoke' which propagates to other users: Separate the
hygiene cycle from the initial server revocation.

For trees(?) and commits the message is "revoke <oid> <use-oid>". But
where to 'hold' the commit & tree (maybe require that tree revoke is
treated as a commit revoke, so the the new tree is got for free). We
still need the new commit to be walked by fsck/gc, and the old oid
contents to be gc'd.
For a 'commit' revocation it (the new msg/trees/revision) could maybe be
a 2nd (or third parent after {0}) so a 'normal walk finds it, but
probably that's just a recipe for disaster.
Maybe a revocation reflog that doesn't expire? or can be rebuilt (fsck
would extend it's lost/found to include a revoked list).

The new (XY) problem is now one of tying in the new revoked blob to the
'old' commit/tree hierarchy which only handles tracked files! Maybe its
a .revoked file (like a .gitignore) which has a list of the old oids and
has actual blobs attached under a .revoked tree.

Also need to make sure that re-packing is done if the blob/tree/commit
was a delta-base at the point of obliteration. Also need to prompt the
local user, just in case it's a spoof!. Plus need a way of 'sending' the
revocation. (and flag for what to do about a fetch pack containing a
revocation for which we have the original, esp if we have it as a pack
that will take a long time to recreate. Need a way of writing the
'defective' object (more code).

Newhash transition. When histories are rewritten, then the obliterated
artefacts are truly removed. For new repos using the newhash then the
revocation mechanism is essentially the same other than extending the
nominal size of the revocation objects.

Perhaps use the 'submodule' commit object type (i.e 'stuff held
elsewhere')  for the holder of the revoked ID (for commits & trees).
This could be locked into the history (details not fully thought
through..).

If there is a design error within Git, its the lack of an 'after the
fact' redaction mechanism (and how it is spread across branches and
distributed users/servers) - not easy.

Philip
