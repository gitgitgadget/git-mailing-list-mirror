From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 8/8] log --remerge-diff: show what the conflict resolution changed
Date: Wed, 26 Feb 2014 16:40:30 -0800
Message-ID: <xmqqbnxt1j7l.fsf@gitster.dls.corp.google.com>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<75c29215c6a61fe1dc3f088f0fcd9acfa54f24fa.1393059605.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIp1l-0001eW-4I
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaB0Akg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 19:40:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbaB0Akg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 19:40:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 262FA7085C;
	Wed, 26 Feb 2014 19:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XacbI+VRFHaUBaeSUK7GdRVOtNM=; b=Apcgg9
	GxOX1IEKtpDwwpBPXRqHrd1NHWJ+rwvxijGvf8jXyv0U1Gb0pW1Fj47kkWvpolwI
	1vzYTTVeCIyhbu2G1vUNRlfQwsEEIcylT/Siw0tmHN9AoqI4gGRvMG3j6sPyf6od
	rCTKCzFq3m7m+LA5jTL0RqndkQ+BEPPTO1DyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=al272uhIPeZrPc9F+sAiwkuMfGPvJpQe
	u747zBsG+NQELAJCijKMsHBTHrJtyVJHd6Iri8WdBOR1O9sAtWA/NuR/9w0R0yTY
	TuM4DfbUowlvcLhKlttVLjlhPEb7fVunGDCDbGM1nSIhPFH2X+RfhMqytURZyAxw
	a9UQxwt9UbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ABD87085B;
	Wed, 26 Feb 2014 19:40:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F8BF7085A;
	Wed, 26 Feb 2014 19:40:34 -0500 (EST)
In-Reply-To: <75c29215c6a61fe1dc3f088f0fcd9acfa54f24fa.1393059605.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 22 Feb 2014 10:17:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C4B1426C-9F47-11E3-A81B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242781>

Thomas Rast <tr@thomasrast.ch> writes:

> diff --git a/log-tree.c b/log-tree.c
> index 30b3063..9b831e9 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -11,6 +11,8 @@
>  #include "gpg-interface.h"
>  #include "sequencer.h"
>  #include "line-log.h"
> +#include "cache-tree.h"
> +#include "merge-recursive.h"
>  
>  struct decoration name_decoration = { "object names" };
>  
> @@ -723,6 +725,300 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
>  }
>  
>  /*
> + * Helpers for make_asymmetric_conflict_entries() below.
> + */
> +static char *load_cache_entry_blob(struct cache_entry *entry,
> +				   unsigned long *size)
> +{

I briefly wondered if this helper need to know about contents
conversions (e.g. smudge/clean or crlf), but not doing any of that
*is* the right thing to do.  IOW, I agree with what this part of the
patch does.

But it feels, at least to me, that this helper function ...

> +static void strbuf_append_cache_entry_blob(struct strbuf *sb,
> +					   struct cache_entry *entry)
> +{

... and this one are overly specific.  Why should they know about
(and limit themselves to operate on) cache-entry type?  Isn't it too
much to ask for the caller to say "entry->sha1" instead of "entry"?

I do not have an issue with a "load_blob()" helper that makes sure
what it reads is a blob, though, of course.

> +static void assemble_conflict_entry(struct strbuf *sb,
> +				    const char *branch1,
> +				    const char *branch2,
> +				    struct cache_entry *entry1,
> +				    struct cache_entry *entry2)
> +{
> +	strbuf_addf(sb, "<<<<<<< %s\n", branch1);
> +	strbuf_append_cache_entry_blob(sb, entry1);
> +	strbuf_addstr(sb, "=======\n");
> +	strbuf_append_cache_entry_blob(sb, entry2);
> +	strbuf_addf(sb, ">>>>>>> %s\n", branch2);
> +}
> +
> +/*
> + * For --remerge-diff, we need conflicted (<<<<<<< ... >>>>>>>)
> + * representations of as many conflicts as possible.  Default conflict
> + * generation only applies to files that have all three stages.
> + *
> + * This function generates conflict hunk representations for files
> + * that have only one of stage 2 or 3.  The corresponding side in the
> + * conflict hunk format will be empty.  A stage 1, if any, will be
> + * dropped in the process.
> + */
> +static void make_asymmetric_conflict_entries(const char *branch1,
> +					     const char *branch2)
> +{

I should comment on this one in a separate message after I read it
over once again.

> +}
> +
> +/*
> + * --remerge-diff doesn't currently handle entries that cannot be
> + * turned into a stage0 conflicted-file format blob.  So this routine
> + * clears the corresponding entries from the index.  This is
> + * suboptimal; we should eventually handle them _somehow_.
> +*/
> +static void drop_non_stage0()

"static void drop_non_stage0(void)"
