From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin/clone: support submodule groups
Date: Wed, 20 Jan 2016 13:43:28 -0800
Message-ID: <xmqqlh7k3p1b.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:43:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0XP-0004Ey-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbcATVnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:43:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754388AbcATVna (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:43:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5E8AB3C4D0;
	Wed, 20 Jan 2016 16:43:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TBylZy3MYdwhHkQuJ+mIqJ9M6Jc=; b=uRBOKT
	/sPl7DQK29MGpVWvjQtULIRmPr32UerFMqhPyPsOgMqaB4ZhOtXwI1ny92BDe0mn
	mQ8/CePV22eyhPgF46gzTq+uUmbe2PyH5wpcEP4QqajUHfShZypsprFdtSbfZ73V
	5AG2RukLKKCImmUyb3pULxgAjDE5YBu5uQZz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vSRil91uujoQQdcB7lHV2cKNvgJ6zJIR
	qAx37L5FOvn8+BMqe+ss7IaAedM//Y6SpQMYo7hfwRdnrMD6e0Lfm+0LV62pp9FH
	t9svankZk1ehj8gFh243FOV4YMzODu0XUi0Cxwg7yEpT8WUSFW3a9Qlwwx652lRB
	VQEaC9YcUS8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54BAD3C4CF;
	Wed, 20 Jan 2016 16:43:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C37483C4CE;
	Wed, 20 Jan 2016 16:43:29 -0500 (EST)
In-Reply-To: <1453260880-628-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Jan 2016 19:34:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D84AA482-BFBE-11E5-86A6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284472>

Stefan Beller <sbeller@google.com> writes:

> When invocing clone with the groups option,
> the repository will be configured to the specified groups.
> This has implications for the submodule commands, such as
> update.
>
> Having groups configured will imply init for all uninitialized
> submodules belonging to at least one of the configured groups,
> such that new submodules in the group are initialized
> automatically.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-clone.txt | 13 +++++++++++
>  builtin/clone.c             | 46 +++++++++++++++++++++++++++++++++++---
>  t/t7400-submodule-basic.sh  | 54 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 6db7b6d..685fb7c 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -214,6 +214,19 @@ objects from the source repository into a pack in the cloned repository.
>  	repository does not have a worktree/checkout (i.e. if any of
>  	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
>  
> +--group::

This is misnamed but in an opposite way as the variables and fields
in previous patches.  "Clone" is not primarily about submodules, so
a plain "group" in the context of "clone" does not hint that this
option is about submodules.  It also does not tell the user anything
about what the parameter is for (i.e. there are submodules that are
and are not in the group that is specified with this option.  What
special things happens to the ones in the group?)

I am guessing that it is about the auto-vivifying behaviour like 3/4
did, and if that is the case, perhaps "--init-submodule=<group>" or
something like that?

Oh by the way, I think you meant this option to take an argument by
reading the description (you say "part of the given groups").  Follow
the example of existing option you see below in the context and make
sure that the reader knows they have to give an argument to it.

    A tangent. I think it would be handy to have a way to name a
    single submodule and have the code treat as if there were a
    group that contains that single submodule already defined and
    the user specified that group.  Then this option (and any other
    option that takes a submodule group name) can instead take a
    submodule name and the user can expect a natural thing to happen.

> +	After the clone is created, all submodules which are part of the
> +	given groups are cloned. To specify multiple groups, you can either
> +	give the group argument multiple times or comma separate the groups.
> +	This option will be recorded in the `submodule.groups` config,
> +	which will affect the behavior of other submodule related commands,
> +	such as `git submodule update`.
> +	This option implies recursive submodule checkout. If you don't
> +	want to recurse into nested submodules, you need to specify
> +	`--no-recursive`. The group selection will be passed on recursively,
> +	i.e. if a submodule is cloned because of group membership, its
> +	submodules will be cloned according to group membership, too.
> +

>  --separate-git-dir=<git dir>::
>  	Instead of placing the cloned repository where it is supposed
>  	to be, place the cloned repository at the specified directory,
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b004fb4..72aea3a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -51,6 +51,22 @@ static struct string_list option_config;
>  static struct string_list option_reference;
>  static int option_dissociate;
>  static int max_jobs = -1;
> +static struct string_list submodule_groups;
> +
> +static int groups_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	struct string_list_item *item;
> +	struct string_list sl = STRING_LIST_INIT_DUP;
> +
> +	if (unset)
> +		return -1;
> +
> +	string_list_split(&sl, arg, ',', -1);

Why not just do "--group A --group B" without "--group A,B"?  I do
not think you accept "git submodule add --group A,B" anyway [*1*],
so doing "nice" things like this is just being inconsistent and does
not help the users.  And I do personally do not think we should make
things consistent by accepting "--group A,B" everywhere.

[Footnote]

*1* Technically, your 'add --group' accepts A;B, I think, but then
this ',' is still inconsistent with it ;-)
