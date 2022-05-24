Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B8C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiEXToJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbiEXToI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:44:08 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C63674D4
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:44:06 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24OJi5rX096145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 May 2022 15:44:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>,
        <derrickstolee@github.com>, <gitster@pobox.com>,
        <larsxschneider@gmail.com>, <tytso@mit.edu>
References: <cover.1638224692.git.me@ttaylorr.com> <cover.1653088640.git.me@ttaylorr.com> <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com> <Yo0ysWZKFJoiCSqv@google.com>
In-Reply-To: <Yo0ysWZKFJoiCSqv@google.com>
Subject: RE: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Date:   Tue, 24 May 2022 15:44:00 -0400
Organization: Nexbridge Inc.
Message-ID: <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHb/488bX7VmyGm7lOI8s5Sc6VeLQKg6TD0AnqYOkcA3Oyauaz3ifng
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 24, 2022 3:32 PM, Taylor Blau wrote:
>Taylor Blau wrote:
>
>> This patch prepares for cruft packs by defining the `.mtimes` format,
>> and introducing a basic API that callers can use to read out
>> individual mtimes.
>
>Makes sense.  Does this intend to produce any functional change?  I'm
guessing
>not (and the lack of tests agrees), but the commit message doesn't say so.
>
>By the way, is this something we could cover in tests, e.g. using a test
helper that
>exercises the new code?
>
>[...]
>> --- a/Documentation/technical/pack-format.txt
>> +++ b/Documentation/technical/pack-format.txt
>> @@ -294,6 +294,25 @@ Pack file entry: <+
>>
>>  All 4-byte numbers are in network order.
>>
>> +== pack-*.mtimes files have the format:
>> +
>> +All 4-byte numbers are in network byte order.
>> +
>> +  - A 4-byte magic number '0x4d544d45' ('MTME').
>> +
>> +  - A 4-byte version identifier (= 1).
>> +
>> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
>> +
>> +  - A table of 4-byte unsigned integers. The ith value is the
>> +    modification time (mtime) of the ith object in the corresponding
>> +    pack by lexicographic (index) order. The mtimes count standard
>> +    epoch seconds.
>> +
>> +  - A trailer, containing a checksum of the corresponding packfile,
>> +    and a checksum of all of the above (each having length according
>> +    to the specified hash function).
>> +
>
>This describes the "syntax" but not the "semantics" of the file.
>Should I look to a separate piece of documentation for the semantics?
>If so, can this one include a mention of that piece of documentation to
make it
>easier to find?
>
>[...]
>> --- a/object-store.h
>> +++ b/object-store.h
>> @@ -115,12 +115,15 @@ struct packed_git {
>>  		 freshened:1,
>>  		 do_not_close:1,
>>  		 pack_promisor:1,
>> -		 multi_pack_index:1;
>> +		 multi_pack_index:1,
>> +		 is_cruft:1;
>>  	unsigned char hash[GIT_MAX_RAWSZ];
>>  	struct revindex_entry *revindex;
>>  	const uint32_t *revindex_data;
>>  	const uint32_t *revindex_map;
>>  	size_t revindex_size;
>> +	const uint32_t *mtimes_map;
>> +	size_t mtimes_size;
>
>What does mtimes_map contain?  A comment would help.
>
>
>> --- /dev/null
>> +++ b/pack-mtimes.c
>> @@ -0,0 +1,126 @@
>> +#include "pack-mtimes.h"
>> +#include "object-store.h"
>> +#include "packfile.h"
>
>Missing #include of git-compat-util.h.
>
>> +
>> +static char *pack_mtimes_filename(struct packed_git *p) {
>> +	size_t len;
>> +	if (!strip_suffix(p->pack_name, ".pack", &len))
>> +		BUG("pack_name does not end in .pack");
>> +	/* NEEDSWORK: this could reuse code from pack-revindex.c. */
>> +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name); }
>
>This seems simple enough that it's not obvious we need more code sharing.
Do
>you agree?  If so, I'd suggest just removing the NEEDSWORK comment.
>
>> +
>> +#define MTIMES_HEADER_SIZE (12)
>> +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 *
>> +the_hash_algo->rawsz))
>
>Hm, the all-caps name makes this feel like a compile-time constant but it
contains
>a reference to the_hash_algo.  Could it be an inline function instead?
>
>> +
>> +struct mtimes_header {
>> +	uint32_t signature;
>> +	uint32_t version;
>> +	uint32_t hash_id;
>> +};
>> +
>> +static int load_pack_mtimes_file(char *mtimes_file,
>> +				 uint32_t num_objects,
>> +				 const uint32_t **data_p, size_t *len_p)
>
>What does this function do?  A comment would help.
>
>> +{
>> +	int fd, ret = 0;
>> +	struct stat st;
>> +	void *data = NULL;
>> +	size_t mtimes_size;
>> +	struct mtimes_header header;
>> +	uint32_t *hdr;
>> +
>> +	fd = git_open(mtimes_file);
>> +
>> +	if (fd < 0) {
>
>nit: this would be more readable without the blank line between setting and
>checking fd (likewise for the other examples below).
>> +		ret = -1;
>> +		goto cleanup;
>> +	}
>
>[...]
>> +	if (mtimes_size - MTIMES_MIN_SIZE != st_mult(sizeof(uint32_t),
>> +num_objects)) {
>
>This presupposes that the hash_id matches the_hash_algo.  Maybe worth a
>NEEDSWORK comment.
>
>[...]
>> +cleanup:
>> +	if (ret) {
>> +		if (data)
>> +			munmap(data, mtimes_size);
>> +	} else {
>> +		*len_p = mtimes_size;
>> +		*data_p = (const uint32_t *)data;
>
>Do we know that 'data' is uint32_t aligned?  Casting earlier in the
function could
>make that more obvious.
>
>[...]
>> +int load_pack_mtimes(struct packed_git *p)
>
>This could use a doc comment in the header file.  For example, what
requirements
>do we have on what the caller passes as 'p'?
>
>[...]
>> +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos)
>
>Likewise.
>
>[...]
>> --- a/packfile.c
>> +++ b/packfile.c
>[...]
>> @@ -363,7 +373,7 @@ void close_object_store(struct raw_object_store
>> *o)
>>
>>  void unlink_pack_path(const char *pack_name, int force_delete)  {
>> -	static const char *exts[] = {".pack", ".idx", ".rev", ".keep",
".bitmap",
>".promisor"};
>> +	static const char *exts[] = {".pack", ".idx", ".rev", ".keep",
>> +".bitmap", ".promisor", ".mtimes"};
>
>Are these in any particular order?  Should they be?
>
>[...]
>> @@ -718,6 +728,10 @@ struct packed_git *add_packed_git(const char *path,
>size_t path_len, int local)
>>  	if (!access(p->pack_name, F_OK))
>>  		p->pack_promisor = 1;
>>
>> +	xsnprintf(p->pack_name + path_len, alloc - path_len, ".mtimes");
>> +	if (!access(p->pack_name, F_OK))
>> +		p->is_cruft = 1;
>> +
>>  	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
>>  	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
>>  		free(p);
>> @@ -869,7 +883,8 @@ static void prepare_pack(const char *full_name,
size_t
>full_name_len,
>>  	    ends_with(file_name, ".pack") ||
>>  	    ends_with(file_name, ".bitmap") ||
>>  	    ends_with(file_name, ".keep") ||
>> -	    ends_with(file_name, ".promisor"))
>> +	    ends_with(file_name, ".promisor") ||
>> +	    ends_with(file_name, ".mtimes"))
>
>likewise

I am again concerned about 32-bit time_t assumptions. time_t is 32-bit on
some platforms, signed/unsigned, and sometimes 64-bit. We are talking about
potentially long-persistent files, as I understand this series, so we should
not be limiting times to end at 2038. That's only 16 years off and I would
wager that many clones that exist today will exist then.
--Randall

