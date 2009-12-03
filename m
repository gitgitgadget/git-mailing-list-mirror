From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Detailed diagnosis when parsing an object name fails.
Date: Thu, 03 Dec 2009 12:37:55 -0800
Message-ID: <7vljhj4wv0.fsf@alter.siamese.dyndns.org>
References: <1259784061-25143-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: y@imag.fr
X-From: git-owner@vger.kernel.org Thu Dec 03 21:38:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGIRI-0002Yg-KS
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbZLCUiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754321AbZLCUiA
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:38:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbZLCUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:37:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C68DA30C0;
	Thu,  3 Dec 2009 15:38:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yK07G5ZYPo80rXDyjMhdE42VCK4=; b=QrhiO5
	9R+82tPoyvxl1b6ldhJ0S2xFpxiMZXZrJuPNZY+lowtukVmpRhWSowRKJ1hZylQr
	qHcXBYvGt3oRuiAK7EUmt9GBoRBrg9pee5HoSo4Y5LlaXhEhCyA/9LzqCw4CoQv/
	VJNR6o2Ynm3fOCFIj7yM2xiuqErfCh1CKl4g8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YpscYDRhVkdmxEFesXypl9GKJ/cmjGr+
	FM3csLPwb0ZkA/FEsT3lT5grzsdsCX1JQ6X7avnYai3FioZ74iPr1znrwXGTg6ki
	oZ5BF9jGvt7Utnmi4ZVuo+uB4N1k6Wsu8YgkPOAGLzNKB95+5GWJRmljiss819Bc
	Y1DMgxDOwuM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C598A30BE;
	Thu,  3 Dec 2009 15:38:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CEBCA30B6; Thu,  3 Dec 2009
 15:37:57 -0500 (EST)
In-Reply-To: <1259784061-25143-1-git-send-email-y> (y.'s message of "Wed\,  2
 Dec 2009 21\:01\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C06EFE3E-E04B-11DE-B34F-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134475>

y@imag.fr writes:

> diff --git a/cache.h b/cache.h
> index 0e69384..5c8cb5f 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -708,7 +708,11 @@ static inline unsigned int hexval(unsigned char c)
>  #define DEFAULT_ABBREV 7
>  
>  extern int get_sha1(const char *str, unsigned char *sha1);
> -extern int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode);
> +static inline get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
> +{
> +	return get_sha1_with_mode_1(str, sha1, mode, 0, NULL);
> +}
> +extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int fatal, const char *prefix);

Do I understand correctly that "fatal" here is the same as "!gently"
elsewhere in the API?

> diff --git a/sha1_name.c b/sha1_name.c
> index 44bb62d..030e2ac 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -804,7 +804,77 @@ int get_sha1(const char *name, unsigned char *sha1)
>  	return get_sha1_with_mode(name, sha1, &unused);
>  }
>  
> -int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
> +static void diagnose_invalid_sha1_path(const char *prefix,
> +				       const char *filename,
> +				       const char *tree_sha1,
> +				       const char *object_name)
> +{
> +	struct stat st;
> +	unsigned char sha1[20];
> +	unsigned mode;
> +
> +	if (!prefix)
> +		prefix = "";
> +
> +	if (!lstat(filename, &st))
> +		die("Path '%s' exists on disk, but not in '%s'.",
> +		    filename, object_name);
> +	if (errno == ENOENT || errno == ENOTDIR) {
> +		char *fullname = malloc(strlen(filename)
> +					     + strlen(prefix) + 1);
> +		strcpy(fullname, prefix);
> +		strcat(fullname, filename);

What if malloc fails here (and elsewhere in your patch)?

> +		if (!get_tree_entry(tree_sha1, fullname,
> +				    sha1, &mode)) {
> +			die("Path '%s' exists, but not '%s'.\n"
> +			    "Did you mean '%s:%s'?",
> +			    fullname,
> +			    filename,
> +			    object_name,
> +			    fullname);
> +		}
> +		die("Path '%s' does not exist in '%s'",
> +		    filename, object_name);
> +	}
> +}
> +
> +static void diagnose_invalid_index_path(int stage,
> +					const char *prefix,
> +					const char *filename)
> +{
> +	struct stat st;
> +
> +	if (!prefix)
> +		prefix = "";
> +
> +	if (!lstat(filename, &st))
> +		die("Path '%s' exists on disk, but not in the index.", filename);
> +	if (errno == ENOENT || errno == ENOTDIR) {
> +		struct cache_entry *ce;
> +		int pos;
> +		int namelen = strlen(filename) + strlen(prefix);
> +		char *fullname = malloc(namelen + 1);
> +		strcpy(fullname, prefix);
> +		strcat(fullname, filename);
> +		pos = cache_name_pos(fullname, namelen);
> +		if (pos < 0)
> +			pos = -pos - 1;
> +		ce = active_cache[pos];
> +		if (ce_namelen(ce) == namelen &&
> +		    !memcmp(ce->name, fullname, namelen))
> +			die("Path '%s' is in the index, but not '%s'.\n"
> +			    "Did you mean ':%d:%s'?",
> +			    fullname, filename,
> +			    stage, fullname);

What happens if the user asked for ":2:Makefile" while in directory "t/",
and there is ":1:t/Makefile" but not ":2:t/Makefile" in the index?

What should happen if the user asked for ":2:t/Makefile" in such a case?

> @@ -850,6 +920,8 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
>  			}
>  			pos++;
>  		}
> +		if (fatal)
> +			diagnose_invalid_index_path(stage, prefix, cp);
>  		return -1;
>  	}
>  	for (cp = name, bracket_depth = 0; *cp; cp++) {
> @@ -862,9 +934,24 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
>  	}
>  	if (*cp == ':') {
>  		unsigned char tree_sha1[20];
> -		if (!get_sha1_1(name, cp-name, tree_sha1))
> -			return get_tree_entry(tree_sha1, cp+1, sha1,
> -					      mode);
> +		char *object_name;
> +		if (fatal) {
> +			object_name = malloc(cp-name+1);

Where is this freed?

Instead of doing a leaky allocation, it may make sense to pass the tree
object name as <const char *, size_t> pair, and print it with "%.*s" in
the error reporting codepath.  After all, object_name is used only for
that purpose in diagnose_invalid_sha1_path(), no?

> +			strncpy(object_name, name, cp-name);
> +			object_name[cp-name] = '\0';
> +		}
> +		if (!get_sha1_1(name, cp-name, tree_sha1)) {
> +			const char *filename = cp+1;
> +			ret = get_tree_entry(tree_sha1, filename, sha1, mode);
> +			if (fatal)
> +				diagnose_invalid_sha1_path(prefix, filename,
> +							   tree_sha1, object_name);
> +
> +			return ret;
> +		} else {
> +			if (fatal)
> +				die("Invalid object name '%s'.", object_name);
> +		}
>  	}
>  	return ret;
>  }
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> new file mode 100755
> index 0000000..8112d56
> --- /dev/null
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description='test git rev-parse diagnosis for invalid argument'
> +
> +exec </dev/null
> +
> +. ./test-lib.sh
> +
> +HASH_file=
> +
> +test_expect_success 'set up basic repo' '
> +	echo one > file.txt &&
> +	mkdir subdir &&
> +	echo two > subdir/file.txt &&
> +	echo three > subdir/file2.txt &&
> +	git add . &&
> +	git commit -m init &&
> +	echo four > index-only.txt &&
> +	git add index-only.txt &&
> +	echo five > disk-only.txt
> +'
> +
> +test_expect_success 'correct file objects' '
> +	HASH_file=$(git rev-parse HEAD:file.txt) &&
> +	git rev-parse HEAD:subdir/file.txt &&
> +	git rev-parse :index-only.txt &&
> +	cd subdir &&
> +	git rev-parse HEAD:file.txt &&
> +	git rev-parse HEAD:subdir/file2.txt &&
> +	test $HASH_file = $(git rev-parse HEAD:file.txt) &&
> +	test $HASH_file = $(git rev-parse :file.txt) &&
> +	test $HASH_file = $(git rev-parse :0:file.txt) &&
> +	cd ..
> +'

Please make it a habit of not doing "cd" without forcing a subprocess
using ().  If 'rev-parse HEAD:file.txt' fails after "cd subdir", the next
test will start running from that directory.

> +test_expect_success 'incorrect revision id' '
> +	test_must_fail git rev-parse foobar:file.txt 2>&1 |
> +		grep "Invalid object name '"'"'foobar'"'"'." &&

It always is better to write this in separate steps, because exit status
of the upstream of pipe is discarded by the shell.

If you expect an error exit and want to make sure a particular error
message is given, do this:

	test_must_fail git rev-parse foobar:file.txt 2>error &&
        grep "Invalid ..." error 

If you expect an error exit and want to make sure an incorrect error
message is not produced, do this:

	test_must_fail git rev-parse foobar:file.txt 2>error &&
        ! grep "Invalid ..." error 
