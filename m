Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B61CA80
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h7wcQ+d0"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C0DC
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 10:15:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5690D1B1A46;
	Sat, 14 Oct 2023 13:15:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OZE5MiSlnSd5
	1YGfjB+uogcvhi7losaYdStwzYrBYPE=; b=h7wcQ+d0/M/gN6/jPj+og8fTE6Sa
	2eR4KfzMPYE9eHLWCQtHSDXJaetxHTBYAUHpH/BCZSzJ11EsfQtowVdWHu3K3ew0
	qT526ggcxygWZGu7+uslKRRTmsbHgQfqBJhT9EY5YBdjEsyRUSAox1L8IY93zuIw
	N7ODBMFmjtTe9QY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE5C1B1A45;
	Sat, 14 Oct 2023 13:15:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B97C41B1A44;
	Sat, 14 Oct 2023 13:15:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: ks1322 ks1322 <ks1322@gmail.com>,  git@vger.kernel.org,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH] diagnose: require repository
In-Reply-To: <20231014135302.13095-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
	message of "Sat, 14 Oct 2023 15:53:01 +0200")
References: <CAKFQ_Q9WjF9i-Rx2jdCw-adPVQrWNfNKrDY-em8Rpa5RNLXz4A@mail.gmail.com>
	<20231014135302.13095-1-martin.agren@gmail.com>
Date: Sat, 14 Oct 2023 10:15:19 -0700
Message-ID: <xmqq5y39unvc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 41087AFE-6AB5-11EE-BCC6-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Martin =C3=85gren <martin.agren@gmail.com> writes:

> When `git diagnose` is run from outside a repo, it begins collecting
> various information before eventually hitting a segmentation fault,
> leaving an incomplete zip file behind.
>
> Switch from the gentle setup to requiring a git directory. Without a gi=
t
> repo, there isn't really much to diagnose.
>
> We could possibly do a best-effort collection of information about the
> machine and then give up. That would roughly be today's behavior but
> with a controlled exit rather than a segfault. However, the purpose of
> this tool is largely to create a zip archive. Rather than creating an
> empty zip file or no zip file at all, and having to explain that
> behavior, it seems more helpful to bail out clearly and early with a
> succinct error message.

Without having thought things through, offhand I agree with your "no
repository?  there is nothing worth tarring up then" assessment.

Because "git bugreport --diag" unconditionally spawns "git
diagnose", the former may also want to be extra careful, perhaps
like the attached patch.

 builtin/bugreport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git c/builtin/bugreport.c w/builtin/bugreport.c
index d2ae5c305d..ac9e05fcf7 100644
--- c/builtin/bugreport.c
+++ w/builtin/bugreport.c
@@ -146,6 +146,11 @@ int cmd_bugreport(int argc, const char **argv, const=
 char *prefix)
 		    report_path.buf);
 	}
=20
+	if (!startup_info->have_repository && diagnose !=3D DIAGNOSE_NONE) {
+		warning(_("no repository--diagnostic output disabled"));
+		diagnose =3D DIAGNOSE_NONE;
+	}
+
 	/* Prepare diagnostics, if requested */
 	if (diagnose !=3D DIAGNOSE_NONE) {
 		struct strbuf zip_path =3D STRBUF_INIT;
