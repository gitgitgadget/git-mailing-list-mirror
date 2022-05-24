Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E2C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiEXSAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbiEXSAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 14:00:47 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [IPv6:2001:19f0:5:727:1e84:17da:7c52:5ab4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64B62A1D
        for <git@vger.kernel.org>; Tue, 24 May 2022 11:00:46 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-3d1b-52a1-fd46-87d2-f3d9.res6.spectrum.com [IPv6:2600:6c67:5000:3d1b:52a1:fd46:87d2:f3d9])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id E0EE32E78ABF;
        Tue, 24 May 2022 18:00:44 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id 5CA9C130012B; Tue, 24 May 2022 12:00:43 -0600 (MDT)
Date:   Tue, 24 May 2022 12:00:43 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] setup: don't die if realpath(3) fails on getcwd(3)
Message-ID: <Yo0dS550l2NCmx9O@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
 <dafc8178-d213-ffd0-9e2a-32ac88307b39@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dafc8178-d213-ffd0-9e2a-32ac88307b39@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2022-05-24 at 13:41 -0400, Derrick Stolee wrote:
> On 5/24/2022 10:51 AM, Kevin Locke wrote:> -	/* Normalize the directory */
>> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
>> -	free((char*)tmp_original_cwd);
>> -	tmp_original_cwd = NULL;
>> -	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>> +	/* Try to normalize the directory. */
>> +	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
>> +		free((char*)tmp_original_cwd);
>> +		tmp_original_cwd = NULL;
>> +		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
>> +	} else {
>> +		trace2_data_string("setup", the_repository,
>> +				   "realpath-path", tmp_original_cwd);
>> +		trace2_data_string("setup", the_repository,
>> +				   "realpath-failure", strerror(errno));
>> +		tmp_original_cwd = NULL;
> 
> I didn't catch this in v2, but should this line instead be
> 
> 		startup_info->original_cwd = NULL;
> 
> ? Especially based on this comment:

No worries.  It's a good question.  Setting startup_info->original_cwd
to NULL is handled by the no_prevention_needed label.  But I just
realized it's not actually required in this case, since original_cwd
is NULL when setup_original_cwd() is called.  I should probably return
rather than jumping to no_prevention_needed from the else block to
avoid the unnecessary free(NULL) and assignment.

Your comment made me realize that v2 and later neglect to free
tmp_original_cwd when strbuf_realpath() fails.  How embarrassing.

I'll send an update to fix both those issues shortly.

Thanks again,
Kevin
