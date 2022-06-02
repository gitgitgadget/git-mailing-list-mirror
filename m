Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C02C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiFBVVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 17:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFBVVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 17:21:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0B36E14
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 14:21:02 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5C1D1253C9;
        Thu,  2 Jun 2022 17:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dqd2BuPc+zYF6mJMG2neVVm2zdHYY3NGoq1xI1
        y5Rj4=; b=TgQL5sZ6+DHObK5a3a6Z+P1MVdouKjg28oIhZxwznvehHVAj/iCUj0
        UAI5Vk1ocL30rqibnnPNwQJwB479nOapzKP3TwS3iXxgf9VGgWgNDjqLLYZZzD1r
        jqMiswe0iHW8S3qt76btNKqh24DI/QPuteCz+RVW+whMe3wVavgBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C92F1253C8;
        Thu,  2 Jun 2022 17:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6DFD1253C7;
        Thu,  2 Jun 2022 17:21:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4] remote: create fetch.credentialsInUrl config
References: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
        <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 14:20:59 -0700
In-Reply-To: <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Thu, 02 Jun 2022 17:20:34
        +0000")
Message-ID: <xmqq35gmkbic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6AE2808-E2B9-11EC-8320-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void validate_remote_url(struct remote *remote)
> +{
> +	int i;
> +	const char *value;
> +	struct strbuf redacted = STRBUF_INIT;
> +
> +	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
> +	    !strcmp("allow", value))
> +		return;
> +
> +	for (i = 0; i < remote->url_nr; i++) {
> +		struct url_info url_info = { NULL };

The initializer should be "= { 0 }" not "= { NULL }".  In other
words, we shouldn't have to care if the first member in the struct
happens to be of a pointer type, and we shouldn't have to change
between 0 and NULL whenever the type of the first member changes.

Even though it frowns upon assigning 0 to a pointer variable or a
pointer member in a struct, sparse knows that such an initializer is
OK.

cf. https://lore.kernel.org/git/YVJSwuqjolz28+mG@coredump.intra.peff.net/

Please have a blank line after the variable decl. 

> +		url_normalize(remote->url[i], &url_info);

url_normalize() returns "char *", and you get NULL when parsing
fails; out_info->err may also help when it happens, but I think we
will call url_normalize() again later in the existing caller, and
it will give whatever error message we need to give appropriately,
so it is OK to silently jump to the loop_cleanup label from here.

> +		if (!url_info.passwd_len)
> +			goto loop_cleanup;

I wonder what should happen to "https://username:@localhost" (i.e.
an empty string is used as a password).  I am fine if we allow it as
an obvious "this is like an anonymous ftp; anybody can connect" use
case, but I do not know how useful it would be in practice.  

I am also fine if certain authentication scheme needs username and
password, the latter of which is never used because the "real thing"
like Kerberos kicks in when the real authentication happens but
becasue something needs to be there to "trigger" the authentication,
and that is why we deliberately allow an empty string case unwarned.
But if this is a deliberate thing, we'd need to caution future
developers about it.

I do not think passwd_ofs can ever be 0 if we have an embedded
password in the URL, so checking it may be a better approach, if we
care about an empty-string case.  I can be persuaded either way.

> +
> +		strbuf_add(&redacted, url_info.url, url_info.passwd_off);
> +		strbuf_addstr(&redacted, "<redacted>");
> +		strbuf_addstr(&redacted, url_info.url + url_info.passwd_off + url_info.passwd_len);
> +
> +		if (!strcmp("warn", value))
> +			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
> +		if (!strcmp("die", value))
> +			die(_("URL '%s' uses plaintext credentials"), redacted.buf);

We obviously could introduce another local variable that is set
based on the "value" before we enter the loop to "optimize", but
this is an error codepath, so I do not mind repeated strcmp() on the
constant value in the loop.

I do have to wonder what we should do when value is none of the
three we know about.  Right now, it makes the function an expensive
noop, so upfront at the beginning of the function, we might need
something like

	int to_warn_not_die;

	if (git_config_get_string_tmp(..."))
 		return;
	if (!strcmp("warn", value))
		to_warn_not_die = 1;
	else if (!strcmp("die", value))
		to_warn_not_die = 0;
	else
		return;

anyway, in which case we would also do

	if (to_warn_not_die)
		warning(...);
	else
		die(...);

in the loop, perhaps?  I dunno.

I wonder if die_message() may want to report all the offending URL
for a given remote (with a concluding die() after the loop).  I am
OK with dying at the first offence, though.  In the worst case, the
end user experience would be:

    $ git fetch there
    die() about the first URL for the nickname
    $ edit .git/config
    $ git fetch there
    die() about the second URL for the nickname

The user will learn after getting the same error message twice and
scan through the other URLs when editing .git/config for the second
time to fix the second URL.  If I were writing this patch, I would
probably play lazy and die on the first offender.

> +test_expect_success 'fetch warns or fails when using username:password' '
> +	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
> +	test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
> +	! grep "$message" err &&
> +
> +	test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
> +	grep "warning: $message" err >warnings &&
> +	test_line_count = 3 warnings &&
> +
> +	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
> +	grep "fatal: $message" err >warnings &&
> +	test_line_count = 1 warnings

Reusing warnings file for die messages is probably OK ;-)

An extra test with an empty string as a password would have caught
the differences between using passwd_off and passwd_len to detect
the presence of a password here.

Taking all together, I'll queue the following on top as a separate
fix-up patch, but I may well be giving (some) bad pieces of advice,
so I will wait for others to comment.

Thanks.

 remote.c              | 26 ++++++++++++++++++--------
 t/t5516-fetch-push.sh |  4 ++++
 t/t5601-clone.sh      |  4 ++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git c/remote.c w/remote.c
index 59b6839445..2cdc064fa8 100644
--- c/remote.c
+++ w/remote.c
@@ -619,25 +619,35 @@ static void validate_remote_url(struct remote *remote)
 	int i;
 	const char *value;
 	struct strbuf redacted = STRBUF_INIT;
+	int warn_not_die;
 
-	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
-	    !strcmp("allow", value))
+	if (git_config_get_string_tmp("fetch.credentialsinurl", &value))
 		return;
 
+	if (!strcmp("warn", value))
+		warn_not_die = 1;
+	else if (!strcmp("die", value))
+		warn_not_die = 0;
+	else if (!strcmp("allow", value))
+		return;
+	else
+		die(_("unrecognized value fetch.credentialsInURL: '%s'"), value);
+
 	for (i = 0; i < remote->url_nr; i++) {
-		struct url_info url_info = { NULL };
-		url_normalize(remote->url[i], &url_info);
+		struct url_info url_info = { 0 };
 
-		if (!url_info.passwd_len)
+		if (!url_normalize(remote->url[i], &url_info) ||
+		    !url_info.passwd_off)
 			goto loop_cleanup;
 
 		strbuf_add(&redacted, url_info.url, url_info.passwd_off);
 		strbuf_addstr(&redacted, "<redacted>");
-		strbuf_addstr(&redacted, url_info.url + url_info.passwd_off + url_info.passwd_len);
+		strbuf_addstr(&redacted,
+			      url_info.url + url_info.passwd_off + url_info.passwd_len);
 
-		if (!strcmp("warn", value))
+		if (warn_not_die)
 			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
-		if (!strcmp("die", value))
+		else
 			die(_("URL '%s' uses plaintext credentials"), redacted.buf);
 
 loop_cleanup:
diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
index afb9236bee..a67acc3263 100755
--- c/t/t5516-fetch-push.sh
+++ w/t/t5516-fetch-push.sh
@@ -1821,6 +1821,10 @@ test_expect_success 'fetch warns or fails when using username:password' '
 
 	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings &&
+
+	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:@localhost 2>err &&
+	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
 
diff --git c/t/t5601-clone.sh w/t/t5601-clone.sh
index ddc4cc7ec2..cf0a3ef3f4 100755
--- c/t/t5601-clone.sh
+++ w/t/t5601-clone.sh
@@ -82,6 +82,10 @@ test_expect_success 'clone warns or fails when using username:password' '
 
 	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings &&
+
+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
+	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
 
