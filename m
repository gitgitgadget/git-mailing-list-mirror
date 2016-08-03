Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD0D1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbcHCVBg (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:01:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932437AbcHCVBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:01:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8604B31222;
	Wed,  3 Aug 2016 16:57:12 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CQUqCU7wv90hw07g/Sk3CNC/QE0=; b=fLGwAC
	j/WPd26qVthvPJ01SBpNTRSEemQe5xHAANn+7rTDYHEOP5aVaZNC0pgCOduayDQy
	wuh5vA7xjAHFyeC912JAbwYlj6GOkgrq6PCNCJody/oGOURecsvs8rG15rncj/Pp
	65tm7SjpMPklYax71UijrBOejiFqzcRLNxp3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRLKpOCDxK8t2CTT5iDk/5Q4s68nk6m6
	Z8f8dGXV3NbYs11BmOlmscQLSG8qccpjfNGwIbA/4Ha8Epdr6MQ+6gF4PCpEKt9s
	smQ2Qc7q8rweFhqj/Y6Qr/bQssSH5+Mqyg+BZn1Poqp9YX1OpPD31qtpHEy/xwVj
	UQTFegnb5cY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E9CE31221;
	Wed,  3 Aug 2016 16:57:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F1CF731220;
	Wed,  3 Aug 2016 16:57:11 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
References: <20160801214937.4752-1-e@80x24.org>
	<20160801214937.4752-2-e@80x24.org>
	<20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
Date:	Wed, 03 Aug 2016 13:57:09 -0700
In-Reply-To: <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 12:19:11 -0400")
Message-ID: <xmqq4m718tay.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D98D5536-59BC-11E6-8C02-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 01, 2016 at 09:49:37PM +0000, Eric Wong wrote:
>
> You'd want:
>
>   argv_array_pushf(env, "%.*s", (int)(cp - pager_env), pager_env);
>
> Also:
>
>> +		strbuf_reset(&buf);
>
> should this be strbuf_release()? If we didn't follow the conditional
> above (because getenv() told us the variable was already set), then we
> would not do do the detach/release there, and would finish the loop with
> memory still allocated by "buf".

All bugs are from my original, I think.  Here is a proposed squash.

 * This shouldn't make much difference for @@PAGER_ENV@@, but not
   quoting the default assignment, i.e.

   	: "${VAR=VAL}" && export VAR

   is bad manners.  cf. 01247e02 (sh-setup: enclose setting of
   ${VAR=default} in double-quotes, 2016-06-19)

 * Again, this shouldn't make much difference for PAGER_ENV, but
   let's follow the "reset per iteration, release at the end"
   pattern to avoid repeated allocation.

 * Let's avoid a hand-rolled "skip blanks" loop and let strspn() do
   it.


 git-sh-setup.sh |  2 +-
 pager.c         | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index b6b75e9..cda32d0 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -163,7 +163,7 @@ git_pager() {
 	for vardef in @@PAGER_ENV@@
 	do
 		var=${vardef%%=*}
-		eval ": \${$vardef} && export $var"
+		eval ": \"\${$vardef}\" && export $var"
 	done
 
 	eval "$GIT_PAGER" '"$@"'
diff --git a/pager.c b/pager.c
index cd1ac54..7199c31 100644
--- a/pager.c
+++ b/pager.c
@@ -66,25 +66,22 @@ const char *git_pager(int stdout_is_tty)
 static void setup_pager_env(struct argv_array *env)
 {
 	const char *pager_env = PAGER_ENV;
+	struct strbuf buf = STRBUF_INIT;
 
 	while (*pager_env) {
-		struct strbuf buf = STRBUF_INIT;
 		const char *cp = strchrnul(pager_env, '=');
 
 		if (!*cp)
 			die("malformed build-time PAGER_ENV");
 		strbuf_add(&buf, pager_env, cp - pager_env);
 		cp = strchrnul(pager_env, ' ');
-		if (!getenv(buf.buf)) {
-			strbuf_reset(&buf);
-			strbuf_add(&buf, pager_env, cp - pager_env);
-			argv_array_push(env, strbuf_detach(&buf, NULL));
-		}
+		if (!getenv(buf.buf))
+			argv_array_pushf(env, "%.*s",
+					 (int)(cp - pager_env), pager_env);
+		pager_env = cp + strspn(cp, " ");
 		strbuf_reset(&buf);
-		while (*cp && *cp == ' ')
-			cp++;
-		pager_env = cp;
 	}
+	strbuf_release(&buf);
 }
 
 void prepare_pager_args(struct child_process *pager_process, const char *pager)
