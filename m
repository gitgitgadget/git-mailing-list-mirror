From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] submodule--helper module_list_compute: allow label or name arguments
Date: Tue, 10 May 2016 18:29:32 -0700
Message-ID: <xmqq8tzhl6v7.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 03:29:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Iy5-0002G3-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcEKB3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:29:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbcEKB3g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:29:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D9B51BAF4;
	Tue, 10 May 2016 21:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+NMIs6xOPK5v/1LrmxHPl5Lxpp8=; b=mAc7+M
	OBzG21wCUKULT9RAzuMG+I9QHGvCgPVqtuFc+jS6D57bFD5bDcW3fSa+nhlrQEWW
	4EfR+tjZ/dfot9ra81D0X0d4LwUqhYDDe897Ku9jkCg4EFdZEvriuObBspzjo8Vn
	WNsgS/O46SthVqIy0PhTPGLPlkjUgso1F5g7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O0xsKHksYF8mv9M0ng6po5DGzvnk0iRh
	r1IROynM14pj3teBFbtqISuxYv/+qUDxaY9eturNdPs8iKVMlGAZkLml2a8AOD6I
	aqo61RA8tucLreGG+Js47DqiYk7wYxO/hk3Gq7TmHdrsv+2uAoXTCqUrIeVEzH9l
	jMfI58pTRGg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56B4A1BAF3;
	Tue, 10 May 2016 21:29:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D20F01BAF2;
	Tue, 10 May 2016 21:29:33 -0400 (EDT)
In-Reply-To: <1462928397-1708-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D0F401F0-1717-11E6-B9BF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294222>

Stefan Beller <sbeller@google.com> writes:

> +static void split_argv_pathspec_groups(int argc, const char **argv,
> +				       const char ***pathspec_argv,
> +				       struct string_list *group)
> +{
> +	int i;
> +	struct argv_array ps = ARGV_ARRAY_INIT;
> +	for (i = 0; i < argc; i++) {
> +		if (starts_with(argv[i], "*")
> +		    || starts_with(argv[i], ":")) {
> +			string_list_insert(group, argv[i]);
> +		} else if (starts_with(argv[i], "./")) {
> +			argv_array_push(&ps, argv[i]);

I'd suggest stripping "./" when you do this.  That is, make the rule
to be "*label is a label, :name is a name, and everything else is a
path.  You can prefix ./ to an unfortunate path that begins with an
asterisk or a colon and we will strip ./ disambiguator".

> +		} else {
> +			/*
> +			* NEEDSWORK:
> +			* Improve autodetection of items with no prefixes,
> +			* roughly like
> +			* if (label_or_name_exists(argv[i]))
> +			*	string_list_insert(group, argv[i]);
> +			* else
> +			*	argv_array_push(&ps, argv[i]);
> +			*/

I do not think this is desirable.  "label" that changes its meaning
between "a path ./label" to "a label *label" would force people to
give unnecessary prefix "./" when naming their path, from fear of
colliding with a label that may or may not exist.

> +			argv_array_push(&ps, argv[i]);
> +		}
> +	}



> +		if (!group.nr) {
> +			if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +					    0, ps_matched, 1) ||
> +			    !S_ISGITLINK(ce->ce_mode))
> +				continue;
> +		} else {
> +			const struct submodule *sub;
> +			int ps = 0, gr = 0;
> +			if (!S_ISGITLINK(ce->ce_mode))
> +				continue;
> +			sub = submodule_from_path(null_sha1, ce->name);
> +
> +			ps = match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +					    0, ps_matched, 1);
> +			gr = submodule_in_group(&group, sub);
> +
> +			if (!pathspec->nr && !gr)
> +				continue;
> +			if (!ps && !gr)
> +				continue;

Hmph, so the rule is "a submodule that is in the specified group is
chosen, even if it is outside the subset of paths narrowed by the
given pathspec."  I think that is consistent with the way how the
list of arguments given to module_list (i.e. a pathspec element plus
a group specifier OR together just like two pathspec elements do not
force a path to match both, and instead they OR together).

Is that rule (i.e. specifiers are ORed together) written down
somewhere for users?
