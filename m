Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2245220FD1
	for <e@80x24.org>; Sat,  2 Jul 2016 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcGBSrg (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 14:47:36 -0400
Received: from v-smtpout3.han.skanova.net ([81.236.60.156]:56060 "EHLO
	v-smtpout3.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658AbcGBSrf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2016 14:47:35 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jul 2016 14:47:34 EDT
Received: from [192.168.209.50] ([195.252.60.88])
	by cmsmtp with SMTP
	id JPr7b75mlbd4bJPr7bXkZx; Sat, 02 Jul 2016 20:41:30 +0200
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
 <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
 <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
Message-ID: <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
Date:	Sat, 2 Jul 2016 20:41:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAPLMUf7uluI2nnwiwu7WxlJBMvLsPCTy1ChtiQb257MsSrvvC1vnhdCq8m/9XlWfLMLUkR77jQGW/puGT+NUW0KO0IkOpfW8C24HLUx9PjwuoASrLF9
 1sOPfrmDUvf42I7B0hBnBgxllaa/WQqmPYUiCtv3Knx7xZxF2hjz4mIEUlV/tWdCRwvfr7dduwV2OMXYN/qOC2ugR18RhicVa8b9Bf0bHAHGnPaWWFzAYtf9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-02 00.11, Junio C Hamano wrote:
[snip]
> diff --git a/read-cache.c b/read-cache.c
> index a3ef967..c109b6d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -163,7 +163,9 @@ static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>
>  	if (fd >= 0) {
>  		unsigned char sha1[20];
> -		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, 0))
> +		unsigned flags = HASH_USE_SHA_NOT_PATH;
> +		memcpy(sha1, ce->sha1, sizeof(sha1));
> +		if (!index_fd(sha1, fd, st, OBJ_BLOB, ce->name, flags))
>  			match = hashcmp(sha1, ce->sha1);
>  		/* index_fd() closed the file descriptor already */
>  	}
>
> I do not quite see how "Don't use ce->sha1, but use sha1 given to
> you" flag affects this call, when sha1 and ce->sha1 are the same due
> to memcpy() just before the call?
>

Lets step back a second. and try to explain whats going on.

Do a merge (and renormalize the files).

At some point inside the merge, Git calls read-cache.c/ce_compare_data(),
   to check if the path named "file" is clean.
   According to the tree information, the path "file" has the sha1 99b633.
   #Note:
   #sha1 99b633 is "first line\nsame line\n"

ce_compare_data() starts the work:
OK, lets run index_fd(...,ce->name,...)
# index_fd will simulate a "git add"  and return the sha1 (via the sha1 pointer)
# after the hashing.

# ce_compare_data() will later compare ce->sha1 with the result stored in
# the local sha1. That's why a sha1 is in the parameter list.
# To return the resulting hash:

ce_compare_data() calls index_fd(sha1, ..., ce->name, ...)

#Down in index_fd():

sha1_file.c/index_fd() calls index_core() (after consulting the attributes)
index_core() reads the file from the working tree into memory using
read_in_full(), and after that index_mem() calls hash_sha1_file(buf)
to calculate the sha1.

Before the hashing is done, index_mem() runs
convert_to_git(path, buf, size, &nbuf, SAFE_CRLF_FALSE)
to convert  "blobs to git internal format".


Here, convert_to_git() consults the .gitattributes (again) to find out that
crlf_action is CRLF_AUTO in our case.
The "new safer autocrlf handling" says that if a blob as any CR, don't convert
CRLFs at "git add".

convert.c/crlf_to_git() starts to do it's job:
- look at buf (It has CRLF, conversion may be needed)
- consult blob_has_cr()
   # Note: Before this patch, has_cr_in_index(path)) was used

#Again, before this patch,
has_cr_in_index(path) calls read_blob_data_from_cache(path, &sz) to read the
blob into memory.

Now read_blob_data_from_cache() is a macro, and we end up in
read_blob_data_from_index(&the_index, (path), (sz))

read-cache.c/read_blob_data_from_index() starts its work:
	pos = index_name_pos(istate, path, len);
	if (pos < 0) {
		/*
		 * We might be in the middle of a merge, in which
		 * case we would read stage #2 (ours).
		 */

# And here, and this is important to notice, "ours" is sha1 ad55e2,
# which corresponds to "first line\r\nsame line\r\n"
# On our way in the callstack the information what to check had been lost:
# blob 99b633 and nothing else.
# read_blob_data_from_index() doesn't know the sha, but makes a guess,
# derived from path.
# The guess works OK for most callers: to take "ours" in a middle
# of a merge, but not here.

#Back to crlf_to_git():
The (wrong) blob has CRs in it, so crlf_to_git() decides not to convert CRLFs,
(and this is wrong).

# And now we go all the way back in the call chain:

The content in the worktree which is "first line\r\nsame line\r\n" is hashed:
hash_sha1_file(buf, size, typename(type), sha1);
#and the result is stored in the return pointer "sha1": ad55e2

#Back to ce_compare_data():
match = hashcmp(sha1, ce->sha1);

#And here sha1=ad55e2 != ce->sha199b633

The whole merge is aborted:

    error: addinfo_cache failed for path 'file'
     file: unmerged (cbd69ec7cd12dd0989e853923867d94c8519aa52)
     file: unmerged (ad55e240aeb42e0d9a0e18d6d8b02dd82ee3e527)
     file: unmerged (99b633103c15c20cebebf821133ab526b0ff90b2)
     fatal: git write-tree failed to write a tree
#Side note: cbd69ec is another file in the working tree.

#######################

With this patch,
ce_compare_data() feeds the sha1 99b633 into
blob_has_cr(const unsigned char *index_blob_sha1).

crlf_to_git() says:
"first line\r\nsame line\r\n" in the worktree needs to be converted
into
"first line\nsame line\n" as the "new" blob.

The new (converted) blob "first line\nsame line\n"
is hashed into 99b633, so ce_compare_data() says
fine, converting "first line\r\nsame line\r\n" will give sha1 99b633,
lets continue with the merge, and do the normalization.

# Note1:
# The renormalization is outside what this patch fixes.
# But I didn't manage to construct a test case, which triggered
# "fatal: git write-tree failed to write a tree" without using
# merge.renormalize

# Note2:
# ce_compare_data() has (if I understand things right)
# no knowledge that a merge is going on
# ce_compare_data() has now knowledge that a merge
# with a merge with merge.renormalize=true is going on either.

#Note3:
# I hope that this explanation makes it more clear,
# why ce->sha1 must be forwarded into blob_has_cr() (to check the right blob)
# and that ce->name must be forwarded as path into crlf_to_git()
# (to check the .gitattributes)

