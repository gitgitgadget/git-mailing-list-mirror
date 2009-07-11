From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add --summary option to git-push and git-fetch
Date: Sat, 11 Jul 2009 12:05:43 -0700
Message-ID: <7viqhzm454.fsf@alter.siamese.dyndns.org>
References: <20090703044801.GA2072@cthulhu>
 <7viqiat965.fsf@alter.siamese.dyndns.org> <20090707015948.GA525@cthulhu>
 <h35bda$kgv$1@ger.gmane.org> <20090710022415.GA27274@cthulhu>
 <4A56EEBA.3070806@gmail.com> <20090711174156.GA17154@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Jul 11 21:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPhtY-0005MH-KS
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 21:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbZGKTFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZGKTFy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 15:05:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbZGKTFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 15:05:53 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B91927F40;
	Sat, 11 Jul 2009 15:05:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46FF027F3F; Sat,
 11 Jul 2009 15:05:47 -0400 (EDT)
In-Reply-To: <20090711174156.GA17154@cthulhu> (Larry D'Anna's message of
 "Sat\, 11 Jul 2009 13\:41\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9C7BDE6-6E4D-11DE-A1F0-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123116>

Larry D'Anna <larry@elder-gods.org> writes:

> --summary will cause git-push to output a one-line of each commit pushed.
> --summary=n will display at most n commits for each ref pushed.
>
> $ git push --dry-run --summary origin :
> To /home/larry/gitsandbox/a
>    80f0e50..5593a38  master -> master
>     > 5593a38 foo
>     > 81c03f8 bar
> Fetch works the same way.
>
> Signed-off-by: Larry D'Anna <larry@elder-gods.org>
> ---
>  
>  Changes sicne last version of this patch: 
>
>     * added some tests

Thanks.

> @@ -373,12 +379,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				fputc(url[i], fp);
>  		fputc('\n', fp);
>  
> -		if (ref)
> -			rc |= update_local_ref(ref, what, note);
> -		else
> +		if (ref) {
> +			*quickref = 0;
> +			rc |= update_local_ref(ref, what, note, quickref);

Makes me wonder why update_local_ref() does not put that NUL upon entry.

> +void print_summary_for_push_or_fetch(const char *quickref, int limit)
> +{
> +	struct rev_info rev;
> +	int i, max;
> +	struct object *obj;
> +	struct commit *commit;
> +
> +	max = get_max_object_index();
> +	for (i = 0; i < max; i++)  {
> +		obj = get_indexed_object(i);
> +		if (obj)
> +			obj->flags &= ~ALL_REV_FLAGS;
> +	}

Yuck; this is a horribly heavy sledgehammer.  Couldn't you at least do
clear_commit_marks() to limit the extent of the damage?

> +	init_revisions(&rev, NULL);
> +	rev.prune = 0;
> +	assert(!handle_revision_arg(quickref, &rev, 0, 1));
> +	assert(!prepare_revision_walk(&rev));
> +
> +	while ((commit = get_revision(&rev)) != NULL) {
> +		struct strbuf buf = STRBUF_INIT;
> +		if (limit == 0) {
> +			fprintf(stderr, "    ...\n");

How would you know, when you asked 20 and you showed 20 here, that there
is no more to come?

> +			break;
> +		}

> +		if (!commit->buffer) {
> +			enum object_type type;
> +			unsigned long size;
> +			commit->buffer =
> +				read_sha1_file(commit->object.sha1, &type, &size);
> +			if (!commit->buffer)
> +				die("Cannot read commit %s", sha1_to_hex(commit->object.sha1));
> +		}
> +		format_commit_message(commit, "    %m %h %s\n", &buf, 0);

Hmm, why so many spaces before %m and after %m?

> -static int do_push(const char *repo, int flags)
> +static int do_push(const char *repo, int flags, int summary)

Couldn't this be just another bit in the flag?  I didn't check but I
suspect you wouldn't have to touch the intermediate functions in the call
chain that way.

> diff --git a/builtin.h b/builtin.h
> index 20427d2..5aea3a3 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -113,4 +113,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
>  extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
>  extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
>  
> +extern void print_summary_for_push_or_fetch(const char *quickref, int limit);

Please; not at the end, but at the front where all the other command
helpers live.  I actually suspect that it might be better to migrate some
part of builtin-log.c, together with your new helper function, to a new
file log.c with accompanying header file log.h, but that could be a
separate patch.

> +test_expect_success 'fetch --summary' '
> +	mk_empty &&
> +	(
> +		cd testrepo &&
> +		git fetch --summary .. refs/heads/master:refs/remotes/origin/master 2>stderr &&
> +
> +		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
> +		test "z$r" = "z$the_commit" &&
> +
> +		test 1 = $(git for-each-ref refs/remotes/origin | wc -l) &&
> +
> +		grep -E  "^    > [a-fA-F0-9]+ second$" stderr &&
> +		grep -E  "^    > [a-fA-F0-9]+ repo$" stderr

Look at the output from

    $ git grep -n -e 'grep .*-E' -e 'egrep '

before applying your patch.  I think we support people with grep that does
not know about -E option.

> +test_expect_success 'fetch --summary forced update' '
> +	mk_empty &&
> +	(
> ...
> +	)
> +
> +'

There are at least two missing combinations. (1) "fetch --summary" to
fetch a new branch, and (2) "fetch --summary" does not try segfaulting by
accessing unavailable information after a failed fetch.

The same comment applies to the push side of the tests.

> -static void print_ok_ref_status(struct ref *ref, int porcelain)
> +static void print_ok_ref_status(struct ref *ref, int porcelain, int summary)

The same comment on "flags" applies here and the all the functions in the
call chain that adds this extra parameter.  porcelain/summary should be a
single int with two bits used.  It may be cleaner to change "porcelain" to
"a bit inside flag" in a separate patch _before_ this one, as a cleanup of
the previous "add --porcelain option to git-push" patch.
