From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/7] replace_object: add mechanism to replace objects
 found in "refs/replace/"
Date: Mon, 12 Jan 2009 17:31:56 -0800
Message-ID: <7vd4esf0tv.fsf@gitster.siamese.dyndns.org>
References: <20090112184403.ebb99b75.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYAJ-0002Py-VE
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbZAMBcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758768AbZAMBcI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:32:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758417AbZAMBcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 20:32:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CE6681C59E;
	Mon, 12 Jan 2009 20:32:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3CD81C592; Mon,
 12 Jan 2009 20:31:58 -0500 (EST)
In-Reply-To: <20090112184403.ebb99b75.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 12 Jan 2009 18:44:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBE879CA-E111-11DD-B609-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105436>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/replace_object.c b/replace_object.c
> new file mode 100644
> index 0000000..25b3ef3
> --- /dev/null
> +++ b/replace_object.c
> @@ -0,0 +1,116 @@
> +#include "cache.h"
> +#include "refs.h"
> +
> +static struct replace_object {
> +	unsigned char sha1[2][20];
> +} **replace_object;
> +
> +static int replace_object_alloc, replace_object_nr;
> +
> +static int replace_object_pos(const unsigned char *sha1)
> +{
> +	int lo, hi;
> +	lo = 0;
> +	hi = replace_object_nr;
> +	while (lo < hi) {
> +		int mi = (lo + hi) / 2;
> +		struct replace_object *rep = replace_object[mi];
> +		int cmp = hashcmp(sha1, rep->sha1[0]);
> +		if (!cmp)
> +			return mi;
> +		if (cmp < 0)
> +			hi = mi;
> +		else
> +			lo = mi + 1;
> +	}
> +	return -lo - 1;
> +}

Hmm, this is a tangent of this topic, but I wonder if we can do something
more generic to factor out many binary search like this we have throughout
the code.  Also I wonder if they can be made more efficient by taking
advantage of the fact that our hash is expected to produce a good uniform
distribution, similar to the way patch-ids.c::patch_pos() does this.

I guess the performance should not matter much for this table, as we
expect there won't be massive object replacements.

Also I recall Dscho muttered something about hashmap I didn't quite
understand.

> +static int register_replace_ref(const char *refname,
> +				const unsigned char *sha1,
> +				int flag, void *cb_data)
> +{
> +	/* Get sha1 from refname */
> +	const char *slash = strrchr(refname, '/');
> +	const char *hash = slash ? slash + 1 : refname;
> +	struct replace_object * repl_obj = xmalloc(sizeof(*repl_obj));

	struct replace_object *repl_obj = ...

> +	if (strlen(hash) != 40 || get_sha1_hex(hash, repl_obj->sha1[0])) {
> +		free(repl_obj);
> +		warning("bad replace ref name: %s", refname);
> +	}
> +
> +	/* Copy sha1 from the read ref */
> +	hashcpy(repl_obj->sha1[1], sha1);

Upon an error, you free and warn and then still copy into it?

> +	/* Register new object */
> +	if (register_replace_object(repl_obj, 1))
> +		warning("duplicate replace ref: %s", refname);

I'd say this is a grave error and should be reported as a repository
corruption.

> +static void prepare_replace_object(void)
> +{
> +	static int replace_object_prepared;
> +
> +	if (replace_object_prepared)
> +		return;
> +
> +	for_each_replace_ref(register_replace_ref, NULL);
> +	replace_object_prepared = 1;
> +}
> +
> +/* We allow "recursive" replacement. Only within reason, though */
> +#define MAXREPLACEDEPTH 5
> +
> +const unsigned char *lookup_replace_object(const unsigned char *sha1)
> +{
> +	int pos, depth = MAXREPLACEDEPTH;
> +	const unsigned char *cur = sha1;
> +
> +	prepare_replace_object();
> +
> +	/* Try to recursively replace the object */
> +	do {
> +		if (--depth < 0)
> +			die("replace depth too high for object %s",
> +			    sha1_to_hex(sha1));
> +
> +		pos = replace_object_pos(cur);
> +		if (0 <= pos)
> +			cur = replace_object[pos]->sha1[1];
> +	} while (0 <= pos);
> +
> +	return cur;
> +}

Since your paradigm is prepare replacement once at the beginning, never
allowing to update it, I think you can update the table while you look it
up.  E.g. if A->B and B->C exists, and A is asked for, you find A->B (to
tentatively make cur to point at B) and then you find B->C, and before
returning you can rewrite the first mapping to A->C.  Later look-up won't
need to dereference the table twice that way.

This assumes that there will be small number of replacements, but the same
object can be asked for more than once during the process.

> diff --git a/sha1_file.c b/sha1_file.c
> index f08493f..4f2fd10 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2163,10 +2163,18 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
>  void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
>  		     unsigned long *size)
>  {
> -	void *data = read_object(sha1, type, size);
> +	const unsigned char *repl = lookup_replace_object(sha1);
> +	void *data = read_object(repl, type, size);
> +
> +	/* die if we replaced an object with one that does not exist */
> +	if (!data && repl != sha1)
> +		die("replacement %s not found for %s",
> +		    sha1_to_hex(repl), sha1_to_hex(sha1));
> +
>  	/* legacy behavior is to die on corrupted objects */
> -	if (!data && (has_loose_object(sha1) || has_packed_and_bad(sha1)))
> -		die("object %s is corrupted", sha1_to_hex(sha1));
> +	if (!data && (has_loose_object(repl) || has_packed_and_bad(repl)))
> +		die("object %s is corrupted", sha1_to_hex(repl));
> +
>  	return data;
>  }

Later we'd need a global switch to forbid the replacement for connectivity
walkers, but other than that I think this is sane.

I also looked at 1/ and 2/ which looked Ok.

Thanks.
