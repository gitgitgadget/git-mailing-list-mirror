From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/18] git notes merge: Initial implementation handling
 trivial merges only
Date: Thu, 7 Oct 2010 01:24:33 -0500
Message-ID: <20101007062433.GF2285@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 08:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3jxE-0003qy-Ed
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 08:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab0JGG1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 02:27:42 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62404 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab0JGG1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 02:27:41 -0400
Received: by ywh1 with SMTP id 1so156336ywh.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 23:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wNBD4QcMyulmuAAb0MbK+1PzpfZ+OII2SME4IiFSHUk=;
        b=MPF3IPqVNBsHP5acN64SAHTyoFs426qUs+0f/NlBdazcMNhTNMfnZAcDeNCBOoYYPa
         1LFqvcgM9/YGiVxm9W3lvmN+9p+IxXKmjdo7R9BYCdDqkYwDUvIW4F90GgeahaeIAERh
         tPUod9Yraus5PkCaE1AjVqkOkbmdRP0EFfofQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xQ5U3Lt5hw+6mXMyX6u4twnBbjSoAwOgwk2OGCe63Uss+VMTNFDeNbELP81rJEItqC
         qcnKn9LyP0hBwCAQtiBj801genaUP0uFD4DAgdUMGoozumC1PzvIk6I5y15NXNTtcg8e
         c4tQ8J1bzi+uomWVdROFc/5Wtgewe3S/QzvZ0=
Received: by 10.236.95.47 with SMTP id o35mr643092yhf.99.1286432860806;
        Wed, 06 Oct 2010 23:27:40 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z62sm962132yhc.41.2010.10.06.23.27.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 23:27:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-9-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158376>

Johan Herland wrote:

> This initial implementation of 'git notes merge' only handles the trivial
> merge cases (i.e. where the merge is either a no-op, or a fast-forward).

This alone should already be a nice UI improvement: in the
fast-forward case, with this patch applied, in place of

	git fetch . refs/notes/x:refs/notes/commits

one could write

	git notes merge x

This reminds me: it would be nice if non-builtin scripts could use

	git notes --get-notes-ref $refarg

to learn the configured notes ref.  In other words, shouldn't the
default_notes_ref() exposed in patch 2 also be exposed to scripted
callers?  If someone else doesn't get around to it, I can mock
something up in the next few days.

[...]
> +++ b/notes-merge.h
> @@ -0,0 +1,30 @@
> +#ifndef NOTES_MERGE_H
> +#define NOTES_MERGE_H
> +
> +struct notes_merge_options {
> +	const char *local_ref;
> +	const char *remote_ref;
> +	int verbosity;
> +};
> +
> +void init_notes_merge_options(struct notes_merge_options *o);
[...]
> +int notes_merge(struct notes_merge_options *o,
> +		unsigned char *result_sha1);

So the command is usable as-is from other builtins.  Nice.

> +++ b/notes-merge.c
> @@ -0,0 +1,103 @@
[...]
> +#include "cache.h"
> +#include "commit.h"
> +#include "notes-merge.h"
> +
> +void init_notes_merge_options(struct notes_merge_options *o)
> +{
> +	memset(o, 0, sizeof(struct notes_merge_options));
> +	o->verbosity = 2;
> +}
> +
> +static int show(struct notes_merge_options *o, int v)
> +{
> +	return (o->verbosity >= v) || o->verbosity >= 5;
> +}

Should the verbosities be of enum type?

	enum notes_merge_verbosity {
		DEFAULT_VERBOSITY = 2,
		MAX_VERBOSITY = 5,
		etc
	};

> +
> +#define OUTPUT(o, v, ...) \
> +	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (0)

I would find it easier to read

	if (o->verbosity >= DEFAULT_VERBOSITY)
		fprintf(stderr, ...)

unless there are going to be a huge number of messages.

> +
> +int notes_merge(struct notes_merge_options *o,
> +		unsigned char *result_sha1)
> +{
> +	unsigned char local_sha1[20], remote_sha1[20];
> +	struct commit *local, *remote;
> +	struct commit_list *bases = NULL;
> +	const unsigned char *base_sha1;
> +	int result = 0;
> +
> +	hashclr(result_sha1);
> +
> +	OUTPUT(o, 5, "notes_merge(o->local_ref = %s, o->remote_ref = %s)",
> +	       o->local_ref, o->remote_ref);

Would trace_printf be a good fit for messages like this one?  If not,
any idea about how it could be made to fit some day?

(It is especially nice to be able to direct the trace somewhere other
than stdout and stderr when running tests.)

> +
> +	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
> +		/* empty notes ref => assume empty notes tree */

Can an empty ref be distinguished from a missing ref?  It would be
nice to error out when breakage is detected.

[...]
> +	/* Find merge bases */
> +	bases = get_merge_bases(local, remote, 1);
> +	if (!bases) {
> +		base_sha1 = null_sha1;
> +		OUTPUT(o, 4, "No merge base found; doing history-less merge");
> +	} else if (!bases->next) {
> +		base_sha1 = bases->item->object.sha1;
> +		OUTPUT(o, 4, "One merge base found (%.7s)",
> +		       sha1_to_hex(base_sha1));
> +	} else {
> +		/* TODO: How to handle multiple merge-bases? */

With a recursive merge of the ancestors, of course. :)

The difficult part is what to do when a merge of ancestors results in
conflicts.

[...]
> +++ b/builtin/notes.c
> @@ -772,6 +779,50 @@ static int show(int argc, const char **argv, const char *prefix)
>  	return retval;
>  }
>  
> +static int merge(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
> +	unsigned char result_sha1[20];
> +	struct notes_merge_options o;
> +	int verbosity = 0, result;
> +	struct option options[] = {
> +		OPT__VERBOSITY(&verbosity),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_notes_merge_usage, 0);
> +
> +	if (argc != 1) {
> +		error("Must specify a notes ref to merge");
> +		usage_with_options(git_notes_merge_usage, options);
> +	}
> +
> +	init_notes_merge_options(&o);
> +	o.verbosity = verbosity + 2; // default verbosity level is 2

Maybe

	o.verbosity += verbosity;

or

	o.verbosity = DEFAULT_NOTES_MERGE_VERBOSITY + verbosity;

to allow the default verbosity to be set in one place?

> +	o.local_ref = default_notes_ref();
> +	strbuf_addstr(&remote_ref, argv[0]);
> +	expand_notes_ref(&remote_ref);
> +	o.remote_ref = remote_ref.buf;
> +
> +	result = notes_merge(&o, result_sha1);
> +
> +	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
> +		    remote_ref.buf, default_notes_ref());
> +	if (result == 0) { /* Merge resulted (trivially) in result_sha1 */
> +		/* Update default notes ref with new commit */
> +		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
> +			   0, DIE_ON_ERR);
> +	} else {
> +		/* TODO: */
> +		die("'git notes merge' cannot yet handle non-trivial merges!");

Mm.  In the long run, will (result != 0) mean "merge conflict"?

> @@ -865,6 +916,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
>  		result = append_edit(argc, argv, prefix);
>  	else if (!strcmp(argv[0], "show"))
>  		result = show(argc, argv, prefix);
> +	else if (!strcmp(argv[0], "merge"))
> +		result = merge(argc, argv, prefix);

Thanks for a pleasant read.
