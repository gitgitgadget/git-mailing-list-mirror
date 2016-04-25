From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5b 00/17] port branch.c to use ref-filter's printing options
Date: Mon, 25 Apr 2016 14:47:29 -0700
Message-ID: <xmqq4mapjr7y.fsf@gitster.mtv.corp.google.com>
References: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:47:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoM3-0003ws-DI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbcDYVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:47:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965232AbcDYVri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:47:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D26AB152B7;
	Mon, 25 Apr 2016 17:47:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sF9ATO9lngZv47DLHuXN2dQIVAM=; b=LkLH4Q
	JVW6NmLwkNqk63RFbRTpbNSDmD9X7WNLNZdalkAUPXiU+aFUdAMN166ebadzgLrZ
	5kdcOxMq4Ztm+reD6w7as6dQCb4t4ouFV4mMuFO2FwjzGymVCfzqQKQkbRuqf7mX
	0g+HvDMN9CXyNoDgV3xTg6OPziFwtkeSNwiRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vOiTivq+MDlgMNxm53guNXQEHdQA68bR
	vxnY4wfgXZoqmE7OVqnxiu0/oiEi6rNrymhDPg2LlxZWV378mYE0R8eDEkLyIQfc
	LIMPAVf41eQM3pVIUll90MjnmoMgH9wYK8xKs7gAPZVrDXhkjqjWVgKnPbxBrQgB
	kH/wMq1q+cI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8931152B4;
	Mon, 25 Apr 2016 17:47:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F07E152B3;
	Mon, 25 Apr 2016 17:47:31 -0400 (EDT)
In-Reply-To: <1461581558-32348-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Mon, 25 Apr 2016 16:22:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FCAA49C-0B2F-11E6-8BBB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292570>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is part of unification of the commands 'git tag -l, git branch -l
> and git for-each-ref'. This ports over branch.c to use ref-filter's
> printing options.
>
> Initially posted here: $(gmane/279226). It was decided that this series
> would follow up after refactoring ref-filter parsing mechanism, which
> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>
> v1 can be found here: $(gmane/288342)
> v2 can be found here: $(gmane/288863)
> v3 can be found here: $(gmane/290299)
> v4 can be found here: $(gmane/291106)
>
> Changes in this version (v5b):
> 1. Added the first patch of the series which was missing in v5.

2. Rebased on top of 'master', which includes
   jk/branch-shortening-funny-symrefs.

> Interdiff:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c9a2e5b..6847ac3 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -288,9 +288,11 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>
>                 skip_prefix(it->refname, "refs/heads/", &desc);
>                 skip_prefix(it->refname, "refs/remotes/", &desc);
> -               if (it->kind == FILTER_REFS_DETACHED_HEAD)
> -                       w = strlen(get_head_description());
> -               else
> +               if (it->kind == FILTER_REFS_DETACHED_HEAD) {
> +                       char *head_desc = get_head_description();
> +                       w = strlen(head_desc);
> +                       free(head_desc);
> +               } else
>                         w = utf8_strwidth(desc);

Presumably w is computed here to be used later for some kind of
alignment?  It is curious why we can assume that head_desc does not
need utf8_strwidth() here.
