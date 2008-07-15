From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Tue, 15 Jul 2008 15:14:38 -0700
Message-ID: <7vod4yztf5.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
 <alpine.DEB.1.00.0807101526380.18205@racer>
 <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
 <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
 <alpine.DEB.1.00.0807111635400.8950@racer>
 <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>
 <alpine.DEB.1.00.0807111647080.8950@racer>
 <7vej60jln6.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807122014y5190463j62d106a01bf31c86@mail.gmail.com>
 <7f9d599f0807150957o78d46204x280668c763fba2bf@mail.gmail.com>
 <alpine.DEB.1.00.0807152255020.2990@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsoF-0002uz-T6
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbYGOWOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756061AbYGOWOs
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:14:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbYGOWOr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:14:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4472E2DD03;
	Tue, 15 Jul 2008 18:14:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1D8562DD02; Tue, 15 Jul 2008 18:14:40 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807152255020.2990@eeepc-johanness> (Johannes
 Schindelin's message of "Tue, 15 Jul 2008 23:52:22 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6ED3A512-52BB-11DD-9583-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88610>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, it seems like I never have time to review this, so I'll just 
> take a few minutes to comment on some aspects:
>
>> @@ -1094,6 +1104,8 @@ int cmd_cherry(int argc, const char **argv,
>> const char *prefix)
>>  	const char *limit = NULL;
>>  	int verbose = 0;
>> 
>> +	git_config(git_cherry_config, NULL);
>> +
>>  	if (argc > 1 && !strcmp(argv[1], "-v")) {
>>  		verbose = 1;
>>  		argc--;
>
> Is this really purely for cherry, and not at all for "log --cherry-pick"?  
> Maybe it should be "cache.patchIds" to begin with.

What other things would we want caches for?

As a general rule, I'd prefer keeping these unproven new features opt
in (i.e. default to false unless explicitly asked for).

>> +union cached_sha1_map_header {
>> +	struct {
>> +		char signature[4]; /* CS1M */
>> +		uint32_t version;
>> +		uint32_t count;
>> +		uint32_t size;
>> +		uint32_t pad; /* pad to 20 bytes */
>> +	} u;
>> +	/* pad header out to 40 bytes.  As a consistency
>> +	 * check, pad.value stores the sha1 of pad.key. */
>> +	struct cached_sha1_entry pad;
>
> Why does it have to be a union?

Hmm.  I think you are right.

	struct cached_sha1_map_header {
        	char signature[4];
                uint32_t version;
                uint32_t count;
                uint32_t size;
                uint32_t unused;
		unsigned char csum[20];
	};

would equally be good, as long as we assume the struct is naturally
packed.  I do agree with you that it may not worth checking only the
header, though. 

>> +static const char *signature = "CS1M";
>
> Carrie Scr*ws 1 Man?

No Idea ;-)

>> +	cache->mmapped = 0;
>> +	cache->dirty = 1;
>
> Is it already dirty?  I don't think so.

This flag is more about "do we need to write it back to file", and when it
starts out without reading from an existing file, we always need to as
long as the table contains something at the end of the processing.

You could instead check (!cache->mmapped && cache->count) for that, I
guess.

>> +	cache->entries = calloc(size, sizeof(struct cached_sha1_entry));
>> +	if (!cache->entries) {
>> +		warning("failed to allocate empty map of size %"PRIu32" for %s",
>> +			size, git_path(cache->filename));
>
> xcalloc() to the rescue.

This is purely optional cache and we would want to degrade to operate
without it if any of these fails.  xcalloc() won't let you do so.

> Really, I think that these checks should be _made_ unnecessary, by 
> restricting the size of the cache.  IMO Caching more than 2^10 patch ids 
> (completely made up on the spot) is probably even detrimental, and it 
> might be better to just scratch them all and start with a new cache then.

Probably.  Or fall back on uncached operation.

>> +static int init_cached_sha1_map(struct cached_sha1_map *cache)
>> +{
>>
>> [...]
>>
>> +	SHA1_Init(&ctx);
>> +	SHA1_Update(&ctx, header.pad.key, 20);
>> +	SHA1_Final(header.pad.key, &ctx); /* reuse pad.key to store its sha1 */
>> +	if (hashcmp(header.pad.key, header.pad.value)) {
>> +		warning("%s header has invalid sha1", filename);
>> +		goto empty;
>> +	}
>
> I do not think that it is worth checking that.  If you do not trust your 
> hard disk, you might just as well jump out the window.
>
> Checking just takes too much time.

This is only checking the header, so it won't take much time, but I tend
to doubt the value of this.

>> +	/* mmap entire file so that file / memory blocks are aligned */
>> +	map_size = sizeof(struct cached_sha1_entry) * (cache->size + 1);
>> +	cache->entries = mmap(NULL, map_size,
>> +		PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>
> AFAIR there were _serious_ performance issues with mmap() on non-Linux 
> platforms.  I chose pread() in my original implementation for a reason.

That is not a reason to punish users on platforms with working mmap(2) ;-).
