From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/8] git submodule update: have a dedicated helper for cloning
Date: Thu, 29 Oct 2015 15:34:33 -0700
Message-ID: <xmqqfv0tqp6u.fsf@gitster.mtv.corp.google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 23:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrvmt-0005Er-2H
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 23:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757560AbbJ2WfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 18:35:06 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757559AbbJ2Wel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 18:34:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F64526B01;
	Thu, 29 Oct 2015 18:34:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qNyTKj7zj15BrA/MrANENZ34H44=; b=FwolqD
	Xp6qK/w/pMxE72pSA7wHsOT5t5FSzyv10PIpyaQRUoqsu/1zq/+YhrM89CA4kJ4h
	Bp1WVjoG5SG7a+9WYw23f6yubnQyTnp+rAbRRwFlzkAeaXG5bJOohNAbkWSJJild
	HxnO/ElHURNzU3EFTi/RTDU5ZIlxCpJMnJCgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GTWbzFo4vh/FBSNo9pV25QxamH69yD4O
	nMjVm/BXh0xu4x9vfgCjIYKd4yG1txNzAQZiYSHitQC94JHl8I2MM1koqrV9aOW9
	m3ht0f3Y4ECU6zkexaZxakI8hwkVIdyczGe0Y5f4J6xrDgxnEb286SlKOm5rw5/X
	dvUpABsVeV8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 246A926B00;
	Thu, 29 Oct 2015 18:34:35 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64DB826AFF;
	Thu, 29 Oct 2015 18:34:34 -0400 (EDT)
In-Reply-To: <1446074504-6014-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 28 Oct 2015 16:21:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3AB4AB0E-7E8D-11E5-94CA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280461>

Stefan Beller <sbeller@google.com> writes:

> +struct submodule_update_clone {
> +	int count;
> +	int quiet;
> +	int print_unmatched;
> +	char *reference;
> +	char *depth;
> +	char *update;
> +	const char *recursive_prefix;
> +	const char *prefix;
> +	struct module_list list;
> +	struct string_list projectlines;
> +	struct pathspec pathspec;
> +};

These fields should be split into at least two classes, the ones
that are primarily the "configuration", and the others that are
"states".  I am guessing 'quiet' is what the caller prepares and
tells the pp callbacks that they must work with reduced verbosity,
and 'print_unmatched' is also in the same boat.  From the above
structure definition, nobody can guess what 'count' represents.  Is
that the number of modules you have in the top-level superproject?
Is that the number of modules updated so far?  Some other number?

We can guess "list" is probably the list of modules to be cloned or
updated, but we have no idea what "projectlines" mean and what it
will be used for.  The only word with 'project' we would use in the
context of discussing submodules is the "top level superproject",
but then that will not need a "list", so that is not it.  Perhaps
this refers to a list of projects bound to our tree as submodules,
and perhaps each such submodule gives some kind of "lines", but it
is totally unclear what kind of lines they use.

> +static void fill_clone_command(struct child_process *cp, int quiet,
> +			       const char *prefix, const char *path,
> +			       const char *name, const char *url,
> +			       const char *reference, const char *depth)
> +{
> +	cp->git_cmd = 1;
> +	cp->no_stdin = 1;
> +	cp->stdout_to_stderr = 1;
> +	cp->err = -1;
> +	argv_array_push(&cp->args, "submodule--helper");
> +	argv_array_push(&cp->args, "clone");
> +	if (quiet)
> +		argv_array_push(&cp->args, "--quiet");
> +
> +	if (prefix) {
> +		argv_array_push(&cp->args, "--prefix");
> +		argv_array_push(&cp->args, prefix);
> +	}
> +	argv_array_push(&cp->args, "--path");
> +	argv_array_push(&cp->args, path);

The pattern makes readers wish if there were a way to make these
pair of pushes easier to read.  The best I can come up with is

    argv_array_pushl(&cp->args, "--path", path, NULL);

While that would be already a vast improvement, when we know there
are many "I want to push two", it makes me wonder if I am entitled
to find the repeated ", NULL" irritating.

    argv_array_push2(&cp->args, "--path", path);

on the hand feels slightly too specific.  I dunno.

> +static int update_clone_get_next_task(void **pp_task_cb,
> +				      struct child_process *cp,
> +				      struct strbuf *err,
> +				      void *pp_cb)
> +{
> +	struct submodule_update_clone *pp = pp_cb;
> +
> +	for (; pp->count < pp->list.nr; pp->count++) {
> +		const struct submodule *sub = NULL;
> +		const char *displaypath = NULL;
> +		const struct cache_entry *ce = pp->list.entries[pp->count];
> +		struct strbuf sb = STRBUF_INIT;
> +		const char *update_module = NULL;
> +		char *url = NULL;
> +		int just_cloned = 0;
> +
> +		if (ce_stage(ce)) {
> +			if (pp->recursive_prefix)
> +				strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
> +					pp->recursive_prefix, ce->name);
> +			else
> +				strbuf_addf(err, "Skipping unmerged submodule %s\n",
> +					ce->name);
> +			continue;
> +		}
> +
> +		sub = submodule_from_path(null_sha1, ce->name);
> +		if (!sub) {
> +			strbuf_addf(err, "BUG: internal error managing submodules. "
> +				    "The cache could not locate '%s'", ce->name);
> +			pp->print_unmatched = 1;
> +			return 0;

This feels a bit inconsistent.  When the pp->count'th submodule is
set not to update (i.e. "none" below), you let this loop to ignore
that submodule and continue on to process pp->count+1'th one without
returning to the caller.  Is there a reason why this case should be
processed differently?  If the rest of the code treats this
condition as a "grave error" that tells the caller to never call
get-next again (i.e. the "emergency abort" condition), that sort of
makes sense, but I cannot offhand see if that is being done in this
patch.

> +		}
> +
> +		if (pp->recursive_prefix)
> +			displaypath = relative_path(pp->recursive_prefix, ce->name, &sb);
> +		else
> +			displaypath = ce->name;
> +
> +		if (pp->update)
> +			update_module = pp->update;
> +		if (!update_module)
> +			update_module = sub->update;
> +		if (!update_module)
> +			update_module = "checkout";
> +		if (!strcmp(update_module, "none")) {
> +			strbuf_addf(err, "Skipping submodule '%s'\n", displaypath);
> +			continue;
> +		}
> +
> +		/*
> +		 * Looking up the url in .git/config.
> +		 * We cannot fall back to .gitmodules as we only want to process

s/cannot/must not/, right?

> +		 * configured submodules. This renders the submodule lookup API
> +		 * useless, as it cannot lookup without fallback.
> +		 */

I doubt the value of the last sentence, especially the "useless"
part.

Either "We do not want to read .gitmodules and that is why we do not
use submodule config API, period" (which does not make it "useless",
it is just not meant to be used here at all), or "We do not want to
read .gitmodules in this codepath, and submodule config API cannot
be used here before we teach it an option to only check the config
without falling back" (which does not make it "useless", it is just
that you haven't made it ready to be used here yet).

> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +		git_config_get_string(sb.buf, &url);
> +		if (!url) {
> +			/*
> +			 * Only mention uninitialized submodules when its
> +			 * path have been specified
> +			 */
> +			if (pp->pathspec.nr)
> +				strbuf_addf(err, _("Submodule path '%s' not initialized\n"
> +					"Maybe you want to use 'update --init'?"), displaypath);
> +			continue;
> +		}
> +
> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%s/.git", ce->name);
> +		just_cloned = !file_exists(sb.buf);

That name was misleading and had me scratch my head for a while.
This module is in the "needs cloning" state, and you haven't even
started cloning it yet.

> +		strbuf_reset(&sb);
> +		strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
> +				sha1_to_hex(ce->sha1), ce_stage(ce),
> +				just_cloned, ce->name);
> +		string_list_append(&pp->projectlines, sb.buf);
> +
> +		if (just_cloned) {
> +			fill_clone_command(cp, pp->quiet, pp->prefix, ce->name,
> +					   sub->name, url, pp->reference, pp->depth);
> +			pp->count++;
> +			free(url);
> +			return 1;
> +		} else
> +			free(url);
> +	}
> +	return 0;
> +}

That's it for today.  I'll take a look at the remainder another day.

Thanks.
