Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40910C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1456720679
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbhAZWFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:05:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65493 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbhAZVjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:39:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC146113872;
        Tue, 26 Jan 2021 16:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zKWws3qNO8YywCs8f2UclaXyrak=; b=GfwgZe
        Wm8ifqIUEisopr5e62kh74mKiXiZwTBB8oUFtHjv8a+EcG1ldI6yF/KUPwNSIMYg
        4p/45LQY6crNGLT09zlZFC5nwusocZA0mL301b+DvarkiqvJ5qLRHurnYnTq7Yae
        DFuWVTmihZCTJXzLs7f75XA+zJLdWrMzciMrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Su9H1f9YgLu+oRUQ1NCIhp3cMMc50+/y
        aAX/zdQQK0l4EK9Vau1meEpW2q2XfEo6SwLiz+rB2OucDlCzlz1++f7R6IHRdzut
        dCtSzGLUTiTw//vSvIWFRGRrCS6zRi3JvVkh/vlFvntCG/zvlL7ud+4yrbTwRXF7
        dA4tph0gnlA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4B93113871;
        Tue, 26 Jan 2021 16:38:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F41211386E;
        Tue, 26 Jan 2021 16:38:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
Date:   Tue, 26 Jan 2021 13:38:49 -0800
In-Reply-To: <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 26 Jan 2021 10:55:55 -0800")
Message-ID: <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E156CFE6-601E-11EB-8167-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning, we choose the default branch based on the remote HEAD.
> But if there is no remote HEAD reported (which could happen if the
> target of the remote HEAD is unborn), we'll fall back to using our local
> init.defaultBranch. Traditionally this hasn't been a big deal, because
> most repos used "master" as the default. But these days it is likely to
> cause confusion if the server and client implementations choose
> different values (e.g., if the remote started with "main", we may choose
> "master" locally, create commits there, and then the user is surprised
> when they push to "master" and not "main").
>
> To solve this, the remote needs to communicate the target of the HEAD
> symref, even if it is unborn, and "git clone" needs to use this
> information.
>
> Currently, symrefs that have unborn targets (such as in this case) are
> not communicated by the protocol. Teach Git to advertise and support the
> "unborn" feature in "ls-refs" (by default, this is advertised, but
> server administrators may turn this off through the lsrefs.allowunborn
> config). This feature indicates that "ls-refs" supports the "unborn"
> argument; when it is specified, "ls-refs" will send the HEAD symref with
> the name of its unborn target.
>
> This change is only for protocol v2. A similar change for protocol v0
> would require independent protocol design (there being no analogous
> position to signal support for "unborn") and client-side plumbing of the
> data required, so the scope of this patch set is limited to protocol v2.
>
> The client side will be updated to use this in a subsequent commit.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt                |  2 +
>  Documentation/config/lsrefs.txt         |  3 ++
>  Documentation/technical/protocol-v2.txt | 10 ++++-
>  ls-refs.c                               | 53 +++++++++++++++++++++++--
>  ls-refs.h                               |  1 +
>  serve.c                                 |  2 +-
>  t/t5701-git-serve.sh                    |  2 +-
>  7 files changed, 66 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/config/lsrefs.txt
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6ba50b1104..d08e83a148 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -398,6 +398,8 @@ include::config/interactive.txt[]
>  
>  include::config/log.txt[]
>  
> +include::config/lsrefs.txt[]
> +
>  include::config/mailinfo.txt[]
>  
>  include::config/mailmap.txt[]
> diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.txt
> new file mode 100644
> index 0000000000..dcbec11aaa
> --- /dev/null
> +++ b/Documentation/config/lsrefs.txt
> @@ -0,0 +1,3 @@
> +lsrefs.allowUnborn::
> +	Allow the server to send information about unborn symrefs during the
> +	protocol v2 ref advertisement.
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 85daeb5d9e..4707511c10 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
>  	When specified, only references having a prefix matching one of
>  	the provided prefixes are displayed.
>  
> +If the 'unborn' feature is advertised the following argument can be
> +included in the client's request.
> +
> +    unborn
> +	The server may send symrefs pointing to unborn branches in the form
> +	"unborn <refname> symref-target:<target>".
> +
>  The output of ls-refs is as follows:
>  
>      output = *ref
>  	     flush-pkt
> -    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
> +    obj-id-or-unborn = (obj-id | "unborn")
> +    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
>      ref-attribute = (symref | peeled)
>      symref = "symref-target:" symref-target
>      peeled = "peeled:" obj-id
> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..4077adeb6a 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -32,6 +32,8 @@ struct ls_refs_data {
>  	unsigned peel;
>  	unsigned symrefs;
>  	struct strvec prefixes;
> +	unsigned allow_unborn : 1;
> +	unsigned unborn : 1;
>  };
>  
>  static int send_ref(const char *refname, const struct object_id *oid,
> @@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	if (!ref_match(&data->prefixes, refname_nons))
>  		return 0;
>  
> -	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	if (oid)
> +		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +	else
> +		strbuf_addf(&refline, "unborn %s", refname_nons);

When a call is made to this helper with NULL "oid", it unconditionally
sends the "refname" out as an 'unborn' thing.  If data->symrefs is not
true, or flag does not have REF_ISSYMREF set, then we'd end up
sending

    "unborn" SP refname LF

without any ref-attribute.  The caller is responsible for ensuring
that it passes sensible data->symrefs and flag when it passes
oid==NULL to this function, but it is OK because this is a private
helper.

OK.

>  	if (data->symrefs && flag & REF_ISSYMREF) {
>  		struct object_id unused;
>  		const char *symref_target = resolve_ref_unsafe(refname, 0,
> @@ -74,8 +79,30 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int ls_refs_config(const char *var, const char *value, void *data)
> +static void send_possibly_unborn_head(struct ls_refs_data *data)
>  {
> +	struct strbuf namespaced = STRBUF_INIT;
> +	struct object_id oid;
> +	int flag;
> +	int oid_is_null;
> +
> +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> +	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
> +		return; /* bad ref */
> +	oid_is_null = is_null_oid(&oid);
> +	if (!oid_is_null ||
> +	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
> +		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);

And this caller makes sure that send_ref()'s expectation holds.

> +	strbuf_release(&namespaced);
> +}
> +
> +static int ls_refs_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct ls_refs_data *data = cb_data;
> +
> +	if (!strcmp("lsrefs.allowunborn", var))
> +		data->allow_unborn = git_config_bool(var, value);
> +
>  	/*
>  	 * We only serve fetches over v2 for now, so respect only "uploadpack"
>  	 * config. This may need to eventually be expanded to "receive", but we
> @@ -91,7 +118,8 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  
>  	memset(&data, 0, sizeof(data));
>  
> -	git_config(ls_refs_config, NULL);
> +	data.allow_unborn = 1;
> +	git_config(ls_refs_config, &data);

The above is a usual sequence of "an unspecified allow-unborn
defaults to true, but the configuration can turn it off".  OK
>  
>  	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
>  		const char *arg = request->line;
> @@ -103,14 +131,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  			data.symrefs = 1;
>  		else if (skip_prefix(arg, "ref-prefix ", &out))
>  			strvec_push(&data.prefixes, out);
> +		else if (data.allow_unborn && !strcmp("unborn", arg))
> +			data.unborn = 1;

I think the use of &&-cascade is iffy here.  Even when we are *not*
accepting request for unborn, we should still parse it as such.
This does not matter in today's code, but it is a basic courtesy for
future developers who may add more "else if" after it.

IOW

		else if (!strcmp("unborn", arg)) {
			if (!data.allow_unborn)
				; /* we are not accepting the request */
			else
				data.unborn = 1;
		}

I wrote the above in longhand only for documentation purposes; in
practice, 

		else if (!strcmp("unborn", arg))
                	data.unborn = data.allow_unborn;

may suffice.

>  	}
>  
>  	if (request->status != PACKET_READ_FLUSH)
>  		die(_("expected flush after ls-refs arguments"));
>  
> -	head_ref_namespaced(send_ref, &data);
> +	send_possibly_unborn_head(&data);
>  	for_each_namespaced_ref(send_ref, &data);

And here is another caller of send_ref().  Are we sure that
send_ref()'s expectation is satisfied by this caller when the
iteration encounters a broken ref (e.g. refs/heads/broken not a
symref but names an object that does not exist and get_sha1()
yielding 0{40}), or a dangling symref (e.g. refs/remotes/origin/HEAD
pointing at something that does not exist)?

>  	packet_flush(1);
>  	strvec_clear(&data.prefixes);
>  	return 0;
>  }
> +
> +int ls_refs_advertise(struct repository *r, struct strbuf *value)
> +{
> +	if (value) {
> +		int allow_unborn_value;
> +
> +		if (repo_config_get_bool(the_repository,
> +					 "lsrefs.allowunborn",
> +					 &allow_unborn_value) ||
> +		    allow_unborn_value)
> +			strbuf_addstr(value, "unborn");
> +	}

This reads "when not explicitly disabled, stuff "unborn" in there".

It feels somewhat brittle that we have to read the same variable and
apply the same "default to true" logic in two places and have to
keep them in sync.  Is this because the decision to advertize or not
has to be made way before the code that is specific to the
implementation of ls-refs is run?

If ls_refs_advertise() is always called first before ls_refs(), I
wonder if it makes sense to reuse what we found out about the
configured (or left unconfigured) state here and use it when
ls_refs() gets called?  I know that the way serve.c infrastructure
calls "do we advertise?" helper from each protocol-element handler
is too narrow and does not allow us to pass such a necessary piece
of information but I view it as a misdesign that can be corrected
(and until that happens, we could use file-local static limited to
ls-refs.c).

> +	return 1;
> +}
> diff --git a/ls-refs.h b/ls-refs.h
> index 7b33a7c6b8..a99e4be0bd 100644
> --- a/ls-refs.h
> +++ b/ls-refs.h
> @@ -6,5 +6,6 @@ struct strvec;
>  struct packet_reader;
>  int ls_refs(struct repository *r, struct strvec *keys,
>  	    struct packet_reader *request);
> +int ls_refs_advertise(struct repository *r, struct strbuf *value);
>  
>  #endif /* LS_REFS_H */
> diff --git a/serve.c b/serve.c
> index eec2fe6f29..ac20c72763 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -73,7 +73,7 @@ struct protocol_capability {
>  
>  static struct protocol_capability capabilities[] = {
>  	{ "agent", agent_advertise, NULL },
> -	{ "ls-refs", always_advertise, ls_refs },
> +	{ "ls-refs", ls_refs_advertise, ls_refs },
>  	{ "fetch", upload_pack_advertise, upload_pack_v2 },
>  	{ "server-option", always_advertise, NULL },
>  	{ "object-format", object_format_advertise, NULL },
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index a1f5fdc9fd..df29504161 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -12,7 +12,7 @@ test_expect_success 'test capability advertisement' '
>  	cat >expect <<-EOF &&
>  	version 2
>  	agent=git/$(git version | cut -d" " -f3)
> -	ls-refs
> +	ls-refs=unborn
>  	fetch=shallow
>  	server-option
>  	object-format=$(test_oid algo)
