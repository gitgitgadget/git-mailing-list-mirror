Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531CDC636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 00:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B64613DC
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 00:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhGPATh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 20:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhGPATg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 20:19:36 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jul 2021 17:16:43 PDT
Received: from tilde.club (unknown [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE9BC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 17:16:43 -0700 (PDT)
Received: from tilde.club (unknown [134.249.106.21])
        by tilde.club (Postfix) with ESMTPSA id 99B8122048995;
        Fri, 16 Jul 2021 00:08:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 99B8122048995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1626394094; bh=R19yDzRxP9GBvyPBAFXDC+WQ642El1VQLYJncowM0FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=looP3daI4beIJavFJ9V3C7PyMuTPcDJ6Xdiu2wBlFFwjxFTlo7Twf3I9D79Vsfioy
         nGc7P/TpMvMTKqcxb5bW0GlaFDAOC6ua+w/zKIE9raeHppfIUMCW23imnLT6nCUPEb
         c5daYX//9z3/uuwzx7AGzTlKJvnb19zYtROQp/Tk=
Date:   Fri, 16 Jul 2021 00:07:56 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 6/9] ssh signing: parse ssh-keygen output and verify
 signatures
Message-ID: <YPDN3Lkg9xm0WCSP@tilde.club>
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com>
 <381a950a6e1708b3895bb9c9cb46e974e142ae64.1626264613.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381a950a6e1708b3895bb9c9cb46e974e142ae64.1626264613.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-07-14 12:10:10+0000, Fabian Stelzer via GitGitGadget wrote:
> +		for (line = ssh_keygen_out.buf; *line; line = strchrnul(line + 1, '\n')) {
> +			while (*line == '\n')
> +				line++;
> +			if (!*line)
> +				break;
> +
> +			trust_size = strcspn(line, " \n");
> +			principal = xmemdupz(line, trust_size);

This breaks on principals with spaces in them (principals in the allowed
signers file can have spaces if surrounded by quotes). Looks like
strcspn should reject "\n" instead of " \n".

BTW, thanks for working on this feature. It seems much more convenient
than GPG in my testing.
