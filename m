From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] blame: honor core.abbrev
Date: Fri, 01 Apr 2011 15:44:44 -0700
Message-ID: <7vbp0pegmb.fsf@alter.siamese.dyndns.org>
References: <1301622896-5836-1-git-send-email-namhyung@gmail.com>
 <1301622896-5836-2-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 00:45:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5n5Q-0000Z5-Qd
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 00:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab1DAWoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 18:44:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316Ab1DAWoy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 18:44:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD6544AC2;
	Fri,  1 Apr 2011 18:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7sM7iPo+dJCyuc57X56fdVdOAWQ=; b=XhXGfY
	0lkOaaw1YDp9p9hFgY4Yw3XK6NLAr3OEX7IjOZOGi8sdJuSBIWdzc/1SbptSzC86
	wljX7sShSOfSB1S4TXa6r6uLvZOqDn3LchBC+x+yiBqHSG4+ZXuv2TODD9g1L2FT
	xYRGIp/VtXHhgJOAMKZwYBIOfnrm5cF3iWPJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0+HjrYB+QOX29Pvhhs/wVg6fEeFmYnn
	s1wYAD0ikktHFrkxVz2BljKYK2usdiS3xBVe6K9NDb/1PNdOMMfzwCghkWgbgfCG
	ipLpHd+hxNndvgR632zMfu0ErazNfTUB+fzrbe7g0wOmKZwL04DOlqu6f4HBHErO
	QiubukDhlrE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A90FF4AC0;
	Fri,  1 Apr 2011 18:46:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE79B4AB4; Fri,  1 Apr 2011
 18:46:36 -0400 (EDT)
In-Reply-To: <1301622896-5836-2-git-send-email-namhyung@gmail.com> (Namhyung
 Kim's message of "Fri, 1 Apr 2011 10:54:56 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8338DF2-5CB1-11E0-8233-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170633>

Namhyung Kim <namhyung@gmail.com> writes:

> If user sets config.abbrev option, use it as if --abbrev was given.
> We can't set abbrev to default_abbrev unconditionally IMHO, because
> historically default abbrev length of the blame command is 8 and
> DEFAULT_ABBREV is 7.

Isn't the one-letter difference because we sometimes need to show the
boundary commit with a caret at the beginning?

I think the way this patch initializes orig_abbrev using DEFAULT_ABBREV is
wrong (at that point, I don't think you have called git_config() to get
the user config for DEFAULT_ABBREV).

See the patch to describe.c in dce9648 (Make the default abbrev length
configurable, 2010-10-28) for the right way to do this.

 - initialize the variable to -1;
 - call git_config() to get correct value in DEFAULT_ABBREV;
 - call parse_options() to potentially update the variable; then
 - if variable is still -1, assign DEFAULT_ABBREV to it.

After all that, add 1 to it to account for the possible boundary caret.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 253b480..93693d2 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2317,12 +2317,16 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	struct parse_opt_ctx_t ctx;
>  	int cmd_is_annotate = !strcmp(argv[0], "annotate");
> +	int orig_abbrev = DEFAULT_ABBREV;
>  
>  	git_config(git_blame_config, NULL);
>  	init_revisions(&revs, NULL);
>  	revs.date_mode = blame_date_mode;
>  	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
>  
> +	/* if user sets config.abbrev, honor it */
> +	if (orig_abbrev != default_abbrev)
> +		abbrev = default_abbrev;
>  	save_commit_buffer = 0;
>  	dashdash_pos = 0;
