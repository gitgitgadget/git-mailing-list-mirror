Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8790C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C04F20706
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OFXxzNPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfLMVpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:45:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60767 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:45:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B496524623;
        Fri, 13 Dec 2019 16:45:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5vKioBxj5VVVi7py7tJ3uPXDtz0=; b=OFXxzN
        Pj0cCchIglHgo2kT2oGK6hGpw5c/b9ZGY73tMplXr919/waRmisrf1R9H6Dx/LEU
        1PAfAh7iwWiC/LDTxwQMks7VIS0H3XQ/13tg/aD39nn8TffT2Mn1PXPcYzp0p2d3
        1L4w5Zrlys0hh0mn+CpuhhgheBvN037yO2+P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=puCpEPFVqnGjp+UZANHCPuI9eYDG2mz+
        HdSyjwMww71WiHSPB2/p4a3CnZgwLADVC/muMERnDpU85r0CtYLCSo+YeglLg1U3
        aNMI0rcc+OrBr2PdICYrHTXhM31+W1Brjh3pW/dnHvbVixgL1ThuOhwUoBUN0TgP
        b0bEaojJqOo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA63D24622;
        Fri, 13 Dec 2019 16:45:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2CD324621;
        Fri, 13 Dec 2019 16:45:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 10/15] bugreport: add config values from safelist
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-11-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:45:47 -0800
In-Reply-To: <20191213004312.169753-11-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:07 -0800")
Message-ID: <xmqq4ky3j3w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED14FFF8-1DF1-11EA-A8D2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach bugreport to gather the values of config options which are present
> in 'bugreport-config-safelist.h'.
>
> Many config options are sensitive, and many Git add-ons use config
> options which git-core does not know about; it is better only to gather
> config options which we know to be safe, rather than excluding options
> which we know to be unsafe.
>
> Taking the build-time generated array and putting it into a set saves us
> time - since git_config_bugreport() is called for every option the user
> has configured, performing option lookup in constant time is a useful
> optimization.

Interesting.  I actually was expecting the look-up to go the other
way around.  We know the safe keys, so iterate over them and grab
their values, if defined.  No need for hashes or anything, but just
a simple linear list of safe stuff.

But that is too simple-minded.  If we wanted to safelist foo.*.bar,
where '*' can be anything, walking on the list of safe variables
would not work.  We must have a hash table that knows "foo.*.bar" is
allowed, and while walking all the configuration keys, when we see
foo.a.bar, we consult "foo.*.bar" as well as "foo.a.bar" to see if
it is whitelisted, or something like that.

But then I am not sure if this implementation does something like
this for three-level names.  If not, I do not see much point in use
of the hash there either.

Puzzled.

>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/bugreport.c b/bugreport.c
> index 759cc0b0f8..1fca28f0b9 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -6,6 +6,9 @@
>  #include "help.h"
>  #include <gnu/libc-version.h>
>  #include "run-command.h"
> +#include "config.h"
> +#include "bugreport-config-safelist.h"
> +#include "khash.h"
>  
>  static void get_http_version_info(struct strbuf *http_info)
>  {
> @@ -18,6 +21,41 @@ static void get_http_version_info(struct strbuf *http_info)
>  	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");
>  }
>  
> +KHASH_INIT(cfg_set, const char*, int, 0, kh_str_hash_func, kh_str_hash_equal);
> +
> +struct cfgset {
> +	kh_cfg_set_t set;
> +};
> +
> +struct cfgset safelist;
> +
> +static void cfgset_init(struct cfgset *set, size_t initial_size)
> +{
> +	memset(&set->set, 0, sizeof(set->set));
> +	if (initial_size)
> +		kh_resize_cfg_set(&set->set, initial_size);
> +}
> +
> +static int cfgset_insert(struct cfgset *set, const char *cfg_key)
> +{
> +	int added;
> +	kh_put_cfg_set(&set->set, cfg_key, &added);
> +	printf("ESS: added %s\n", cfg_key);
> +	return !added;
> +}
> +
> +static int cfgset_contains(struct cfgset *set, const char *cfg_key)
> +{
> +	khiter_t pos = kh_get_cfg_set(&set->set, cfg_key);
> +	return pos != kh_end(&set->set);
> +}
> +
> +static void cfgset_clear(struct cfgset *set)
> +{
> +	kh_release_cfg_set(&set->set);
> +	cfgset_init(set, 0);
> +}
> +
>  static void get_system_info(struct strbuf *sys_info)
>  {
>  	struct strbuf version_info = STRBUF_INIT;
> @@ -53,6 +91,36 @@ static void get_system_info(struct strbuf *sys_info)
>  	strbuf_complete_line(sys_info);
>  }
>  
> +static void gather_safelist()
> +{
> +	int index;
> +	int safelist_len = sizeof(bugreport_config_safelist) / sizeof(const char *);
> +	cfgset_init(&safelist, safelist_len);
> +	for (index = 0; index < safelist_len; index++)
> +		cfgset_insert(&safelist, bugreport_config_safelist[index]);
> +
> +}
> +
> +static int git_config_bugreport(const char *var, const char *value, void *cb)
> +{
> +	struct strbuf *config_info = (struct strbuf *)cb;
> +
> +	if (cfgset_contains(&safelist, var))
> +		strbuf_addf(config_info,
> +			    "%s (%s) : %s\n",
> +			    var, config_scope_to_string(current_config_scope()),
> +			    value);
> +
> +	return 0;
> +}
> +
> +static void get_safelisted_config(struct strbuf *config_info)
> +{
> +	gather_safelist();
> +	git_config(git_config_bugreport, config_info);
> +	cfgset_clear(&safelist);
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output <file>]"),
>  	NULL
> @@ -114,10 +182,12 @@ int cmd_main(int argc, const char **argv)
>  
>  	get_bug_template(&buffer);
>  
> -	// add other contents
>  	get_header(&buffer, "System Info");
>  	get_system_info(&buffer);
>  
> +	get_header(&buffer, "Safelisted Config Info");
> +	get_safelisted_config(&buffer);
> +
>  	report = fopen_for_writing(report_path.buf);
>  	strbuf_write(&buffer, report);
>  	fclose(report);
