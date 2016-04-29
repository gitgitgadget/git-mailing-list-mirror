From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Fri, 29 Apr 2016 11:37:49 -0700
Message-ID: <xmqqlh3wxnuq.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-12-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:37:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awDIb-0008Iu-Cr
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbcD2Shx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:37:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750714AbcD2Shw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:37:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3F5B170FE;
	Fri, 29 Apr 2016 14:37:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XXNHRtIlapFrupSXS33YMwtRSgk=; b=UVLuWn
	6BUaUkrN4lFebP1cLC2E2sz7Mr74EkYe5IbXfzp71Ue4vnKjm4XRFocChHSO4MSz
	9l91Ouh0m6f781A2bDCgdfk9L2YHYxp9JqS0eXr7tZ2R3atjxnM4vhDmh1JmrBSJ
	+oRYa1osj9p+CwUpTrS7xuIPj7ucf9sExGWEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Orkfa8EqhuFaNXbjG1vYvFtEdw9tRNwb
	RkBu0DQxH56ISaTKQS5qT/ADJuljHnOFcvuFzSvTBFtl9H/6JU8iDp7A4mjg40ID
	RE7W3ajLC3wmSKJFfoKGpG3kGVL1ws8aDY8EV+opRhrqbNSeDHFbdmoyGbEXCWe+
	U6RkWEOvRjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBFB9170FD;
	Fri, 29 Apr 2016 14:37:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18933170FC;
	Fri, 29 Apr 2016 14:37:51 -0400 (EDT)
In-Reply-To: <1461703833-10350-12-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A6AEEF2-0E39-11E6-BCF1-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293043>

Stefan Beller <sbeller@google.com> writes:

> We do not need to do anything special to initialize the `submodule_groups`
> pointer as the diff options setup will fill in 0 by default.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 3 +++
>  diff.h | 1 +
>  2 files changed, 4 insertions(+)

Isn't this going in the opposite way from what you described in 0/15
with analogy to how "ignore" mechanism works?  Just like a path is
tracked once it is tracked, whether it matches an ignore pattern,
shouldn't we be getting a summary for a submodule for any submodule
once submodule/.git/HEAD is there (i.e. we can give a comparison),
whether it is specified by a separate mechanism that acts from
sideways (e.g. the "default group").

> diff --git a/diff.c b/diff.c
> index 059123c..5808d8a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4921,10 +4921,13 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
>  {
>  	int ignored = 0;
>  	unsigned orig_flags = options->flags;
> +	const struct submodule *sub = submodule_from_path(null_sha1, path);
>  	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
>  		set_diffopt_flags_from_submodule_config(options, path);
>  	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
>  		ignored = 1;
> +	if (!submodule_in_group(options->submodule_groups, sub))
> +		ignored = 1;
>  	options->flags = orig_flags;
>  	return ignored;
>  }
> diff --git a/diff.h b/diff.h
> index e7d68ed..7d499fb 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -178,6 +178,7 @@ struct diff_options {
>  	void *output_prefix_data;
>  
>  	int diff_path_counter;
> +	struct string_list *submodule_groups;
>  };
>  
>  enum color_diff {
