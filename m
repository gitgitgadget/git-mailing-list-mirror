Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40909C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiCJWMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiCJWMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:12:00 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A41959FA
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:10:57 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEBD7107E27;
        Thu, 10 Mar 2022 17:10:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pSUpoUuF4hcaY51U5b4hMYqcyNNvGMVKWkrKuS
        B22t0=; b=EF+PB/lmc0GD3Ofm+ZPGOPs+tPqSwhSD6yp0eO+LHZyumlbViIPhsO
        +s5gaMmk2+womfwFkZPmFpKuA5QxlTZDucO/42Igh29o0zGh/kCUJGcqx53ftehS
        oXlVYmR52nQTWJJ6A/yEaCUj8teuccoR/0kfaWrrmqiDO0S99DGyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9D40107E26;
        Thu, 10 Mar 2022 17:10:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33800107E25;
        Thu, 10 Mar 2022 17:10:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
References: <20220310004423.2627181-1-emilyshaffer@google.com>
        <20220310004423.2627181-3-emilyshaffer@google.com>
        <xmqqtuc6h83m.fsf@gitster.g>
        <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 10 Mar 2022 14:10:55 -0800
In-Reply-To: <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 10 Mar 2022 13:40:02 -0800")
Message-ID: <xmqqwnh1bgr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F55B07FA-A0BE-11EC-A486-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>>
>>> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>>>  
>>>  	free(prefixed_path);
>>>  
>>> +	/*
>>> +	 * This entry point is always called from a submodule, so this is a
>>> +	 * good place to set a hint that this repo is a submodule.
>>> +	 */
>>> +	git_config_set("submodule.hasSuperproject", "true");
>>> +
>>>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
>>>  		return do_run_update_procedure(&update_data);
>>
>> In Glen's update to rewrite "submodule update" in C, this part is
>> replaced with a call to update_submodule2().  I am not sure what the
>> current repository is at this point of the code with and without
>> Glen's topic, but are we sure we are in a submodule we discovered?
>
> Rereading this, I realize you probably meant that this conflicts with
> part1, not part2...
>
> At the end of part1, update_submodule2() is called from inside the
> submodule (specifically from run_update_procedure()). So a good merge
> conflict resolution would be to set the config _before_ calling
> update_submodule2(). e.g.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index bef9ab22d4..f53808d995 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>                                             &update_data.update_strategy);
>
>         free(prefixed_path);
> +       /*
> +        * This entry point is always called from a submodule, so this is a
> +        * good place to set a hint that this repo is a submodule.
> +        */
> +       git_config_set("submodule.hasSuperproject", "true");
>         return update_submodule2(&update_data);
>  }

That matched my tentative resolution I made last night, but what do
you think about this part of the test added by the patch?

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..ec2397fc69 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
+	(cd super &&
+	 test_unconfig submodule.hasSuperproject &&
+	 git submodule update &&
+	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
+	)
+'
+
 test_done

We go to "super", make sure that superproject does not have
submodule.hasSuperproject set, run "git submodule update", and see
if the configuration file in "submodule" subdirectory has the
variable set.  It does not clear the variable from the submodule
before starting, so the variable given to the submodule when it was
cloned would be there, even if "git submodule update" failed to set
it.

I am wondering if it should do something like the attached instead.

We

 * clear the variable from "super" and "super/submodule"
   repositories;

 * run "git submodule update";

 * ensure that "git submodule update" did not touch "super/.git/config";

 * ensure that "git submodule update" added the variable to
   "super/submodule/.git/config".

Clearing the variable from "super" is technically wrong because the
repository is set up as a submodule of "recursivesuper" and if we
had further tests, we should restore it in "super", but the point is
that we are makng sure "git submodule update" sets the variable in
the configuration file of the submodule, and not in the superproject's. 

With the conflict resolution above, this "corrected" test fails and
shows that superproject's configuration file is updated after "git
submodule update".

This series alone, without your topic, this "corrected" test fails,
and that is where my "are we sure we are mucking with the
configuration file in the submodule"? comes from.

diff --git c/t/t7406-submodule-update.sh w/t/t7406-submodule-update.sh
index 000e055811..c9912bb242 100755
--- c/t/t7406-submodule-update.sh
+++ w/t/t7406-submodule-update.sh
@@ -1083,4 +1083,16 @@ test_expect_success 'submodule update --filter sets partial clone settings' '
 	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
 '
 
+test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
+	(cd super &&
+	 test_unconfig submodule.hasSuperproject &&
+	 test_unconfig -C submodule submodule.hasSuperproject &&
+	 git submodule update &&
+	 echo in super &&
+	 test_cmp_config false --type=bool submodule.hasSuperproject &&
+	 echo in submodule &&
+	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject
+	)
+'
+
 test_done
