From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Performance optimization for detection of modified
 submodules
Date: Mon, 18 Jan 2010 17:44:14 -0800
Message-ID: <7v1vhmg975.fsf@alter.siamese.dyndns.org>
References: <4B54C3EA.9090200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 02:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX38y-0005bL-Dk
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 02:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0ASBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135Ab0ASBo1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 20:44:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0ASBo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 20:44:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 808E092486;
	Mon, 18 Jan 2010 20:44:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kqhc4LX8n59snsXxpInau+uNbjw=; b=Rhi4zU
	OTWDU0PW+HL7Xy/GKVzEWpSAC0s99oIUa+01zIWXhCac3N4cUmHJgBiksBzQ1lL6
	5HkyE7QG5y/3wrSc/IT5muk4Aoea/ekYDM0YB+VYWBJTzUCeyFuutKVUQ01hf1LC
	qClhpP1pjzxx1sPwb5rA+HnUwCWFda1fkQ/nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wk6t1+jqXT/OXXK69Ur/txtKY789VipW
	RTpoXHiBheODlJVsuZtB4sZZM9nw5xaYKg0YDt4cwhemc1MfQlsTYAAGbBoD9pUp
	RsmDuCKf+7RtMyMe3+muG2aWhyV0cYrarKO9juKXbRPcPcssZuoGJKa/8FfRP6f4
	s2rJ1sep5Rc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5572B92481;
	Mon, 18 Jan 2010 20:44:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F82D9246C; Mon, 18 Jan
 2010 20:44:16 -0500 (EST)
In-Reply-To: <4B54C3EA.9090200@web.de> (Jens Lehmann's message of "Mon\, 18
 Jan 2010 21\:26\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28F756C6-049C-11DF-8853-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137415>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> - Changed the type of the new dirty_submodule flags to unsigned.

Why?  An unsigned used in place of a bool raises an eyebrow as it is more
common to use "int" (the most natural type on the platform).  Going
against tradition makes readers waste time wondering if there were some
other reason why the code couldn't use "int" and had to use "unsigned"
(e.g. "Hmmpphh, it looked like a mere boolean but the use of 'unsigned'
suggests there might be something deeper going on.  Is this used as a
bitfield?  Does this count and cannot go negative?").

> @@ -173,12 +174,16 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			if (silent_on_removed)
>  				continue;
>  			diff_addremove(&revs->diffopt, '-', ce->ce_mode,
> -				       ce->sha1, ce->name);
> +				       ce->sha1, ce->name, 0);

Removed from work tree; cannot be dirty---good.

> +		if (S_ISGITLINK(ce->ce_mode)
> +		    && (!changed || (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
> +		    && is_submodule_modified(ce->name)) {
> +			changed = 1;
> +			dirty_submodule = 1;
> +		}

If the index records a submodule commit, and the commit checked out in the
submodule is different from that commit, ce_compare_gitlink() called from
ce_match_stat() would have already said "changed".  If we want "-dirty",
we need to call is_submodule_modified(), but otherwise we don't.  Looks
good.

Does DIFF_FORMAT_PATCH cover all cases where we may want a reliable value
in "dirty_submodule" here?  Should use of "--submodule=log" affect this
decision?

> @@ -188,7 +193,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		newmode = ce_mode_from_stat(ce, st.st_mode);
>  		diff_change(&revs->diffopt, oldmode, newmode,
>  			    ce->sha1, (changed ? null_sha1 : ce->sha1),
> -			    ce->name);
> +			    ce->name, 0, dirty_submodule);

LHS is always index and RHS is work tree whose dirtiness is in
dirty_submodule; good.

> @@ -204,16 +209,18 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  static void diff_index_show_file(struct rev_info *revs,
>  				 const char *prefix,
>  				 struct cache_entry *ce,
> -				 const unsigned char *sha1, unsigned int mode)
> +				 const unsigned char *sha1, unsigned int mode,
> +				 unsigned dirty_submodule)
>  {
>  	diff_addremove(&revs->diffopt, prefix[0], mode,
> -		       sha1, ce->name);
> +		       sha1, ce->name, dirty_submodule);

Mental note to myself.  prefix[0] is either '-' (removed from the work
tree) or '+' (added to the work tree).  Added submodule could be
immediately dirty.

> @@ -251,15 +263,17 @@ static void show_new_file(struct rev_info *revs,
>  {
> ...
> -	diff_index_show_file(revs, "+", new, sha1, mode);
> +	diff_index_show_file(revs, "+", new, sha1, mode, dirty_submodule);

And this caller handles that case correctly; good.

> @@ -270,11 +284,13 @@ static int show_modified(struct rev_info *revs,
>  {
>  	unsigned int mode, oldmode;
>  	const unsigned char *sha1;
> +	unsigned dirty_submodule = 0;
>
> -	if (get_stat_data(new, &sha1, &mode, cached, match_missing) < 0) {
> +	if (get_stat_data(new, &sha1, &mode, cached, match_missing,
> +			  &dirty_submodule, revs->diffopt.output_format) < 0) {
>  		if (report_missing)
>  			diff_index_show_file(revs, "-", old,
> -					     old->sha1, old->ce_mode);
> +					     old->sha1, old->ce_mode, 0);

Again, removed from work tree cannot be dirty; good.

> @@ -309,7 +325,7 @@ static int show_modified(struct rev_info *revs,
>  		return 0;
>
>  	diff_change(&revs->diffopt, oldmode, mode,
> -		    old->sha1, sha1, old->name);
> +		    old->sha1, sha1, old->name, 0, dirty_submodule);
>  	return 0;
>  }

Comparing between a tree entry and either an index entry or a file in the
work tree.  When cached (i.e. not looking at work tree), get_stat_data()
doesn't touch dirty_submodule, so this won't make noises about submodule
dirtyness, which is good.

> @@ -356,7 +372,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	 * Something removed from the tree?
>  	 */
>  	if (!idx) {
> -		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode);
> +		diff_index_show_file(revs, "-", tree, tree->sha1, tree->ce_mode, 0);

Removed from the work tree and canont be dirty; good.

> diff --git a/diff.c b/diff.c
> index 012b3d3..f130a36 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3736,7 +3736,7 @@ int diff_result_code(struct diff_options *opt, int status)
>  void diff_addremove(struct diff_options *options,
>  		    int addremove, unsigned mode,
>  		    const unsigned char *sha1,
> -		    const char *concatpath)
> +		    const char *concatpath, unsigned dirty_submodule)

A removed submodule cannot be dirty, so we can get away with only one
dirty_submodule that always refers to the RHS (i.e. "two"); I see.

> diff --git a/diffcore.h b/diffcore.h
> index 5b63458..66687c3 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -42,6 +42,7 @@ struct diff_filespec {
>  #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
>  	unsigned should_free : 1; /* data should be free()'ed */
>  	unsigned should_munmap : 1; /* data should be munmap()'ed */
> +	unsigned dirty_submodule : 1;  /* For submodules: its work tree is dirty */

By the way, we might want to consolidate these bitfields into a single 

	unsigned should_free:1,
        	 should_munmap:1,
                 dirty_submodule:1;

in a separate clean-up patch, after all the dust settles.
