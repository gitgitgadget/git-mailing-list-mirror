From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add the option to force sign annotated tags
Date: Tue, 22 Mar 2016 12:48:50 -0700
Message-ID: <xmqqshziguot.fsf@gitster.mtv.corp.google.com>
References: <20160319182310.GA23124@spk-laptop>
	<20160320042912.GD18312@sigill.intra.peff.net>
	<20160320150703.GB5139@spk-laptop>
	<xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
	<20160321192904.GC20083@spk-laptop>
	<xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
	<20160321205015.GF20083@spk-laptop>
	<xmqqa8lrldz4.fsf@gitster.mtv.corp.google.com>
	<20160322193617.GG20083@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:49:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiSIU-0003kc-9f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbcCVTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:48:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751723AbcCVTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 08BF84DC6A;
	Tue, 22 Mar 2016 15:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=44/takzKDLgKeThnLP8zadiTbow=; b=oixktv
	3rbYzt+fyAsbzlYeUULiNI8XolcLMmzIwJseHNQFELH3TNsHiwHYbrPUSWGVw4v4
	J1Tweod8lVgn/J+beFLPEaHdzEKJ2rj0SgLPnCb4eRu8BKMTVjw+Qm4Kz3kDwAUv
	DJaaNy/kFlbIeJcTZVDERjeD/TXvPe+s9j/3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YJ7A/HzZs3Sp72iH83uyOz/RVw817dWu
	b9EDqsvmtgbrVvER/nidY+obmyoUndtNyDo07DH/LgPaROYMyGb33MPbi3ViU7bf
	LVPSLf73yoYag3UpbUROBvNscrH9jIYrKVHab937HEw2LEFgQlMf2cIjfMB+v/E4
	IzRnJ113N5U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 007204DC69;
	Tue, 22 Mar 2016 15:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 718ED4DC68;
	Tue, 22 Mar 2016 15:48:51 -0400 (EDT)
In-Reply-To: <20160322193617.GG20083@spk-laptop> (Laurent Arnoud's message of
	"Tue, 22 Mar 2016 20:36:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A18D4E6-F067-11E5-96F9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289550>

Laurent Arnoud <laurent@spkdev.net> writes:

> The `tag.forcesignannotated` config option allows to sign
> annotated tags automatically.

It looks like it does a lot more than that to me, though.

> @@ -327,7 +333,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	char *cleanup_arg = NULL;
>  	int create_reflog = 0;
>  	int annotate = 0, force = 0;
> -	int cmdmode = 0;
> +	int cmdmode = 0, create_tag_object = 0;
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct ref_transaction *transaction;
> @@ -385,12 +391,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		opt.sign = 1;
>  		set_signing_key(keyid);
>  	}
> -	if (opt.sign)
> -		annotate = 1;
> +	if (opt.sign || annotate || force_sign_annotate)
> +		create_tag_object = 1;

This means that create_tag_object is always on if the configuration
is set and there is no way to override that from the command line,
doesn't it?  I cannot see how a user would create a lightweight tag
if this configuration variable is set with this change.

I think it makes sense to have this here instead of these two lines:

	create_tag_object = (opt.sign || annotate || msg.given || msgfile);

>  	if (argc == 0 && !cmdmode)
>  		cmdmode = 'l';
>  
> -	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
> +	if ((create_tag_object || msg.given || msgfile || force) && (cmdmode != 0))

and then simplify this to

	if ((create_tag_object || force) && (cmdmode != 0))

perhaps?  Then ...

>  		usage_with_options(git_tag_usage, options);
>  
>  	finalize_colopts(&colopts, -1);
> @@ -431,7 +438,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (msg.given || msgfile) {
>  		if (msg.given && msgfile)
>  			die(_("only one -F or -m option is allowed."));
> -		annotate = 1;
> +		create_tag_object = 1;

... this line can just go, as we are taking the presense of various
ways to say "I'll give this message to the resulting tag" as the
sign that the user wants to create a tag object much earlier.

>  		if (msg.given)
>  			strbuf_addbuf(&buf, &(msg.buf));
>  		else {
> @@ -474,8 +481,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	else
>  		die(_("Invalid cleanup mode %s"), cleanup_arg);
>  
> -	if (annotate)
> +	if (create_tag_object) {
> +		if (force_sign_annotate && !annotate)
> +			opt.sign = 1;
>  		create_tag(object, tag, &buf, &opt, prev, object);
> +    }

And this hunk is OK.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index cf3469b..be95318 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -775,6 +775,39 @@ test_expect_success GPG '-s implies annotated tag' '
>  	test_cmp expect actual
>  '
>  
> +get_tag_header config-implied-annotate $commit commit $time >expect
> +./fakeeditor >>expect
> +echo '-----BEGIN PGP SIGNATURE-----' >>expect
> +test_expect_success GPG \
> +	'git tag -s implied if configured with tag.forcesignannotated' \
> +	'test_config tag.forcesignannotated true &&
> +	GIT_EDITOR=./fakeeditor git tag config-implied-annotate &&

This contradicts with what you said earlier in your
<20160321192904.GC20083@spk-laptop> aka
http://thread.gmane.org/gmane.comp.version-control.git/289322/focus=289441

    > If you are forcing users to always leave a message and then further
    > forcing users to always sign with the single new configuration, i.e.
    > 
    >     $ git tag v1.0
    >     ... opens the editor to ask for a message ...
    >     ... then makes the user sign with GPG ...

    I'm not forcing this type of user to enable global
    configuration, that will be annoying for them of course.

But this test expects that this invocation of "git tag $tagname"
forces the user to give a message with editor and sign it, instead
of creating a lightweight tag.
