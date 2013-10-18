From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Fri, 18 Oct 2013 12:09:01 -0700
Message-ID: <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>
	<525FB287.7020204@gmail.com>
	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>
	<xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>
	<526083E7.6080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXFQ9-0003Uh-1e
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab3JRTJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:09:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab3JRTJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:09:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1E1C4B23F;
	Fri, 18 Oct 2013 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5LNwKiAFvT2XrRlv6hWKS2BVSgc=; b=vqpoI3
	e64J7H/1ABRdvNG7pSmzBdokGQkpzcjQNMjaVogvB1IKA9KOgeSly7ZA87mruNNN
	1StawueDvgh4aKtbfryCpJNJ1WLbDRwCklNyBMVPqW1idY0GCHhtewHaCZRnBb6m
	OSkFic89B2StxOfqfQ0Cucu+LMRmkwMkXFDvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xiJhbNRkiHf3rFDXr1CmGfZs8qhmgpAQ
	l9aIT5qAVkcPVnx3VwButFHGwisenGjLBW2PyA1UhExQTcq93qHeAUyB+CUK1obq
	P+EDHKQ5i+vBTVlLtYAnf58IcxS5+DBvNjRI8JcwoDYkwdt8sNIpAD+DsmGW/7Y4
	9IeX6Pa7Dkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D50E84B23E;
	Fri, 18 Oct 2013 19:09:03 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 260614B238;
	Fri, 18 Oct 2013 19:09:03 +0000 (UTC)
In-Reply-To: <526083E7.6080701@gmail.com> (Karsten Blees's message of "Fri, 18
	Oct 2013 02:42:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C08E6EF2-3828-11E3-8B28-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236364>

Karsten Blees <karsten.blees@gmail.com> writes:

> The coredumps are caused by my patch #10, which free()s
> cache_entries when they are removed, in combination with ...

Looking at that patch, it makes me wonder if remove_index_entry_at()
and replace_index_entry() should be the ones that frees the old
entry in the first place.  A caller may already have a ce pointing
at an old entry and use the information from old_ce to update a new
one after it installed it, e.g.

	old_ce = ...
        new_ce = make_cache_entry(... old_ce->name, ...);
        replace_index_entry(... new_ce);
	new_ce->ce_mode = old_ce->cd_mode;
	free(old_ce);

The same goes for the functions that remove the entry.

But I am probably biased saying this, because in the old days, cache
entries could never be freed (they were carved out of a contiguous
region of memory, mmapped from the index file).  These days, we
parse and run ntoh*() on the on-disk cache entries to create in-core
form, and the "cache entries should never be freed" is no longer
true, but I would not be surprised if there are still some code
leftover that relies on "use after free" being safe, leaking unused
cache entries.

Going forward, I do agree with your patch #10 that removal or
replacing that may make an existing entry unreferenced should free
entries that are no longer used, and "use after free" should be
forbidden.

> Can't we just use add_file_to_cache here (which replaces
> cache_entries by creating a copy)?
>
> diff --git a/submodule.c b/submodule.c
> index 1905d75..e388487 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
>  
>  void stage_updated_gitmodules(void)
>  {
> -       struct strbuf buf = STRBUF_INIT;
> -       struct stat st;
> -       int pos;
> -       struct cache_entry *ce;
> -       int namelen = strlen(".gitmodules");
> -
> -       pos = cache_name_pos(".gitmodules", namelen);
> -       if (pos < 0) {
> -               warning(_("could not find .gitmodules in index"));
> -               return;
> -       }

I think the remainder is (morally) equivalent between the original
and a single "add-file-to-cache" call, and the version after your
"how about this" patch in the message I am responding to looks more
correct (e.g. why does the original lstat after it has read the
file?).

But this warning may want to stay, no?

> -       ce = active_cache[pos];
> -       ce->ce_flags = namelen;
> -       if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
> -               die(_("reading updated .gitmodules failed"));
> -       if (lstat(".gitmodules", &st) < 0)
> -               die_errno(_("unable to stat updated .gitmodules"));
> -       fill_stat_cache_info(ce, &st);
> -       ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
> -       if (remove_cache_entry_at(pos) < 0)
> -               die(_("unable to remove .gitmodules from index"));
> -       if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
> -               die(_("adding updated .gitmodules failed"));
> -       if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
> +       if (add_file_to_cache(".gitmodules", 0))
>                 die(_("staging updated .gitmodules failed"));



>  }
