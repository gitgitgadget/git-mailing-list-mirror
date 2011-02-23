From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] fetch/pull: recurse into submodules when necessary
Date: Wed, 23 Feb 2011 14:56:58 -0800
Message-ID: <7vipwa5phh.fsf@alter.siamese.dyndns.org>
References: <4D656F25.5090007@web.de> <4D656F4D.6080401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 23 23:57:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNe5-0005aV-2Q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 23:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab1BWW5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 17:57:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab1BWW5P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 17:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 039B7410E;
	Wed, 23 Feb 2011 17:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OPSWxLvfL8l0av6kk+2dzMCyQgs=; b=Hf2zAh
	POFEkQjQT8a+ZV0AO61l8/DSg/m2x8ftw8GrjHvYHUDIQQf2MozJ8drDOjX4aJIQ
	aofUkk1W+oScEBiakwg8c9WnlBdWmJI71KpDr48Zv/A7A3eOKypBx59EEPUbaZhl
	m6N906tXLBrNhGmOTnHfMPfxKeWqYVi9MCqC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yi0ual/mWe205xUVWffWlYiLYQ+y9imN
	JkWFTdht+Kq1eo+gBXgaqFjNV0AvONMnkMcIraMOYJUzjpecNVnITXqKfl7Fcf1h
	iRi1BE5bTELN10rXtlZlHasLTOEow6cuVaFDQbvksCRwgj10Nth+IG6PY5Sdd6SS
	GikssdBf/BM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 99EFE410D;
	Wed, 23 Feb 2011 17:58:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD4DB4109; Wed, 23 Feb 2011
 17:58:12 -0500 (EST)
In-Reply-To: <4D656F4D.6080401@web.de> (Jens Lehmann's message of "Wed\, 23
 Feb 2011 21\:34\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68C11842-3FA0-11E0-8D2B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167732>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/submodule.c b/submodule.c
> index 6f1c107..c8c3a99 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -152,6 +153,20 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
> ...
> +int parse_fetch_recurse_submodules_arg(const char *arg)
> +{
> +	switch (git_config_maybe_bool("", arg)) {

It's a bit unusual to see "" as the variable name; doesn't config-maybe-bool
barf when arg is not what it likes, with the name as part of its message?

> @@ -248,11 +263,73 @@ void set_config_fetch_recurse_submodules(int value)
> ...
> +static void submodule_collect_changed_cb(struct diff_queue_struct *q,
> +					 struct diff_options *options,
> +					 void *data)
> +{
> +	int i;
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		if (!S_ISGITLINK(p->two->mode))
> +			continue;
> +
> +		if (S_ISGITLINK(p->one->mode)) {
> +			/* NEEDSWORK: We should honor the name configured in
> +			 * the .gitmodules file of the commit we are examining
> +			 * here to be able to correctly follow submodules
> +			 * being moved around. */
> +			struct string_list_item *path;
> +			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
> +			if (!path)
> +				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));

I wondered why there is no mention of "data" in the implementation of this
function; changed_submodule_paths global is used instead here.

I do not see anywhere the global string_list is initialized, freed, nor
re-initialized for reuse.  Are you guaranteeing that the caller only calls
the check_for_new_submodule_commits() function once, and if so how?  The
function is called from update_local_ref() in builtin/fetch.c, which in
turn gets called number of times during a fetch.  IOW, does the code do
the right thing when you are fetching more than one refs?
