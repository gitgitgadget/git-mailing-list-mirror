From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] parse-options: detect attempt to add a duplicate short option name
Date: Wed, 03 Sep 2014 12:42:37 -0700
Message-ID: <xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPGSC-0001Z6-NE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbaICTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:42:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51273 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297AbaICTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:42:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C377537B10;
	Wed,  3 Sep 2014 15:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ju6PwTwKpzZXy3Cslcc0Mcf21Ow=; b=r9hDnk
	KQ/pcFxLC8HgUQV/dlCqVcXc1sWF6trf9PcF7iAY1r70cU4/uPL2nvulaZjFXn7w
	9CDIiC78pAi/Y/dwZQUtt3WEqqd9wLL5yT9U4E1f0cAHIp62G7iHGIl6G3mdDu4B
	0SAF4mjPh/nzcZYHHbONxjm3j6GPG+d6dRYSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vq3Z8Hxlpk+AE1+MmAw5FqK76DkRlk4K
	SvZXptSt8IXMyrawhfEmXucxauZMY/NAZpMxA1MHGZdOnFWMLkUBVXM109U+4V/l
	aMusSrw3h0WJsYfsSUcC5a5EKWUvYz2huApRwLwsvz85nDWT2EJ/UXTQj+t5TFWc
	TGGKCnuryR0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA53637B0E;
	Wed,  3 Sep 2014 15:42:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 40DC437B0C;
	Wed,  3 Sep 2014 15:42:39 -0400 (EDT)
In-Reply-To: <xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Sep 2014 12:32:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76708168-33A2-11E4-9316-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256408>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index f9ed5bd..831c2cd 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -91,6 +91,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>>  			N_("option for merge strategy"), option_parse_x),
>>  		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>> +		OPT_BOOL('n', "no-verify", &opts->no_verify, N_("bypass pre-commit hook")),
>
> I doubt we want this option to squat on '-n'; besides, it is already
> taken by a more often used "--no-commit".
>
> I thought that we added sanity checker for the options[] array to parse-options
> API.  I wonder why it did not kick in...

... because we didn't, not quite.

Perhaps like this?

-- >8 --
It is easy to overlook an already assigned single-letter option name
and try to use it for a new one.  Help the developer to catch it
before such a mistake escapes the lab.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/parse-options.c b/parse-options.c
index e7dafa8..b7925c5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -347,12 +347,17 @@ static void check_typos(const char *arg, const struct option *options)
 static void parse_options_check(const struct option *opts)
 {
 	int err = 0;
+	char short_opts[128];
+
+	memset(short_opts, '\0', sizeof(short_opts));
 
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
 		    (opts->flags & PARSE_OPT_OPTARG))
 			err |= optbug(opts, "uses incompatible flags "
 					"LASTARG_DEFAULT and OPTARG");
+		if (opts->short_name && short_opts[opts->short_name]++)
+			err |= optbug(opts, "short name already used");
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
