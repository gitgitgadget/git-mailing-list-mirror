From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Sun, 06 Dec 2009 19:28:08 +0100
Message-ID: <vpqhbs4dkjr.fsf@bauges.imag.fr>
References: <1259784061-25143-1-git-send-email-y>
	<7vljhj4wv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 19:31:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHLtK-0007Yu-7R
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 19:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbZLFSbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 13:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757113AbZLFSbR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 13:31:17 -0500
Received: from imag.imag.fr ([129.88.30.1]:62078 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbZLFSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 13:31:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nB6IS8UY004938
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Dec 2009 19:28:08 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NHLq4-0006fe-Jt; Sun, 06 Dec 2009 19:28:08 +0100
In-Reply-To: <7vljhj4wv0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 03 Dec 2009 12\:37\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 Dec 2009 19:28:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134685>

Junio C Hamano <gitster@pobox.com> writes:

> y@imag.fr writes:

(sorry for the bad email, my fingers tried to anwser "yes" when
git-send-email asked me to confirm my address)

>> diff --git a/cache.h b/cache.h
>> index 0e69384..5c8cb5f 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -708,7 +708,11 @@ static inline unsigned int hexval(unsigned char c)
>>  #define DEFAULT_ABBREV 7
>>  
>>  extern int get_sha1(const char *str, unsigned char *sha1);
>> -extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
>> +static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
>> +{
>> +	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
>> +}
>> +extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix);
>
> Do I understand correctly that "fatal" here is the same as "!gently"
> elsewhere in the API?

It seems it is. I renamed it.

>> +	if (errno == ENOENT || errno == ENOTDIR) {
>> +		char *fullname = malloc(strlen(filename)
>> +					     + strlen(prefix) + 1);
>> +		strcpy(fullname, prefix);
>> +		strcat(fullname, filename);
>
> What if malloc fails here (and elsewhere in your patch)?

Should have been an xmalloc. Fixed.

>> +static void diagnose_invalid_index_path(int stage,
>> +					const char *prefix,
>> +					const char *filename)
>> +{
>> +	struct stat st;
>> +
>> +	if (!prefix)
>> +		prefix = "";
>> +
>> +	if (!lstat(filename, &st))
>> +		die("Path '%s' exists on disk, but not in the index.", filename);
>> +	if (errno == ENOENT || errno == ENOTDIR) {
>> +		struct cache_entry *ce;
>> +		int pos;
>> +		int namelen = strlen(filename) + strlen(prefix);
>> +		char *fullname = malloc(namelen + 1);
>> +		strcpy(fullname, prefix);
>> +		strcat(fullname, filename);
>> +		pos = cache_name_pos(fullname, namelen);
>> +		if (pos < 0)
>> +			pos = -pos - 1;
>> +		ce = active_cache[pos];
>> +		if (ce_namelen(ce) == namelen &&
>> +		    !memcmp(ce->name, fullname, namelen))
>> +			die("Path '%s' is in the index, but not '%s'.\n"
>> +			    "Did you mean ':%d:%s'?",
>> +			    fullname, filename,
>> +			    stage, fullname);
                            ^^^^^
This one should have been ce_stage(ce), otherwise, we
suggest :0:t/Makefile as you probably guessed:

> What happens if the user asked for ":2:Makefile" while in directory "t/",
> and there is ":1:t/Makefile" but not ":2:t/Makefile" in the index?
>
> What should happen if the user asked for ":2:t/Makefile" in such a
> case?

I originally didn't handle the case "it's in the index, but not at the
stage you requested" (since most users asking :N:blah will be fluent
enough in Git not to need a special case of error messages). But I
finally implemented this test.

>> @@ -862,9 +934,24 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
>>  	}
>>  	if (*cp == ':') {
>>  		unsigned char tree_sha1[20];
>> -		if (!get_sha1_1(name, cp-name, tree_sha1))
>> -			return get_tree_entry(tree_sha1, cp+1, sha1,
>> -					      mode);
>> +		char *object_name;
>> +		if (fatal) {
>> +			object_name = malloc(cp-name+1);
>
> Where is this freed?

Nowhere. In the present state, it's not serious since all codepath
going through this malloc reach a die() right after. But a free()
doesn't harm, I've added it.

> Instead of doing a leaky allocation, it may make sense to pass the tree
> object name as <const char *, size_t> pair, and print it with "%.*s" in
> the error reporting codepath.  After all, object_name is used only for
> that purpose in diagnose_invalid_sha1_path(), no?

matter of taste, but I prefer doing one "complicated" thing (copying
the string) once, and avoid having to deal with two variables instead
of one later.

>> +test_expect_success 'correct file objects' '
>> +	HASH_file=$(git rev-parse HEAD:file.txt) &&
>> +	git rev-parse HEAD:subdir/file.txt &&
>> +	git rev-parse :index-only.txt &&
>> +	cd subdir &&
>> +	git rev-parse HEAD:file.txt &&
>> +	git rev-parse HEAD:subdir/file2.txt &&
>> +	test $HASH_file = $(git rev-parse HEAD:file.txt) &&
>> +	test $HASH_file = $(git rev-parse :file.txt) &&
>> +	test $HASH_file = $(git rev-parse :0:file.txt) &&
>> +	cd ..
>> +'
>
> Please make it a habit of not doing "cd" without forcing a subprocess
> using ().

Fixed.

>> +	test_must_fail git rev-parse foobar:file.txt 2>&1 |
>> +		grep "Invalid object name '"'"'foobar'"'"'." &&
>
> It always is better to write this in separate steps, because exit status
> of the upstream of pipe is discarded by the shell.

Fixed.

I'll resubmit soon.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
