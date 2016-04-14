From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Port `submodule init` to C
Date: Thu, 14 Apr 2016 11:26:31 -0700
Message-ID: <xmqqwpo0f3mw.fsf@gitster.mtv.corp.google.com>
References: <1460657909-1329-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:26:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlyQ-000734-Id
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269AbcDNS0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:26:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186AbcDNS0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:26:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57FB713699;
	Thu, 14 Apr 2016 14:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9EOfVho54SRv1xNxqfzzhWJwwck=; b=PDoKMS
	RZWiiPUJ78ygA6K9zvJi3Jk0l8iDE1WpWHAoZly8BVNYAXGkliiYpAXi6WZ20T0x
	/RX2bJl97JEC4AZ7CTRgJhX7fir4jp8ZS+u1wyvb04oBWjT3KCGbLIvJg1UytoHs
	dAHM6PsisdNAYC9xycwepQrme8qbT7VAu0t6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uDGVxnPfRnLLBE0wDl6VMF4itj/rKEmm
	eXETuKnPlUGj2KC2adysrqbd+xU3ibydfTvwQyhontbc4GOjPadlruSif3capdAi
	zEUCtlsqc+GeyKbX6AWrx16qNlaMc2FCSedZWX3NJAMEcPRsuEgnPhoB7vGThezd
	pZtRQXjiFxo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ED5B13698;
	Thu, 14 Apr 2016 14:26:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B511413696;
	Thu, 14 Apr 2016 14:26:32 -0400 (EDT)
In-Reply-To: <1460657909-1329-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 14 Apr 2016 11:18:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 69E33E08-026E-11E6-BF12-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291552>

Stefan Beller <sbeller@google.com> writes:

> * This applies on another base commit, such that we make use of the tests
>   written in origin/sb/submodule-path-misc-bugs. (I am not sure if I have too
>   many series in flight stomping on each other here)

I actually am quite sure that is the case ;-)

> * This time I actually fix what Ramsay was hinting at:
>   strbuf_detach(&sb, NULL) instead of strbuf_detach(&sb, 0);

Thanks, will take a look.

> Where do these patches apply?
> =============================
>
> I ran the following commands for a new starting point of this series:
>
>     git checkout --detach origin/sb/submodule-parallel-update
>     git merge origin/sb/submodule-helper-clone-regression-fix
>     git merge origin/sb/submodule-path-misc-bugs
>
> The second merge produces 2 conflicts, which can be resolved like this:
> (I am unsure about the second comment in strbuf.h though)
> diff --cc builtin/fetch.c
> index 5aa1c2d,e4639d8..0000000
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@@ -37,7 -37,8 +37,8 @@@ static int prune = -1; /* unspecified *
>   static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
>   static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>   static int tags = TAGS_DEFAULT, unshallow, update_shallow;
>  -static int max_children = 1;
>  +static int max_children = -1;
> + static enum transport_family family;
>   static const char *depth;
>   static const char *upload_pack;
>   static struct strbuf default_rla = STRBUF_INIT;
> diff --cc strbuf.h
> index d4f2aa1,f72fd14..0000000
> --- a/strbuf.h
> +++ b/strbuf.h
> @@@ -387,15 -387,10 +387,16 @@@ extern ssize_t strbuf_read_file(struct 
>   extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>   
>   /**
>  + * Write the whole content of the strbuf to the stream not stopping at
>  + * NUL bytes.
>  + */
>  +extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
>  +
>  +/**
> -  * Read a line from a FILE *, overwriting the existing contents
> -  * of the strbuf. The second argument specifies the line
> -  * terminator character, typically `'\n'`.
> +  * Read a line from a FILE *, overwriting the existing contents of
> +  * the strbuf.  The strbuf_getline*() family of functions share
> +  * this signature, but have different line termination conventions.
> +  *
>    * Reading stops after the terminator or at EOF.  The terminator
>    * is removed from the buffer before returning.  Returns 0 unless
>    * there was nothing left before EOF, in which case it returns `EOF`.
>
> As sb/submodule-parallel-update and sb/submodule-helper-clone-regression-fix
> both touch builtin/submodule--helper.c, so we need those.
>
> We need origin/sb/submodule-path-misc-bugs as it tests `submodule add`
> output.
>
> Thanks,
> Stefan
>
> Stefan Beller (2):
>   submodule: port resolve_relative_url from shell to C
>   submodule: port init from shell to C
>
>  builtin/submodule--helper.c | 322 +++++++++++++++++++++++++++++++++++++++++++-
>  git-submodule.sh            | 127 +----------------
>  submodule.c                 |  21 +++
>  submodule.h                 |   1 +
>  t/t0060-path-utils.sh       |  43 ++++++
>  5 files changed, 392 insertions(+), 122 deletions(-)
