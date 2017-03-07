Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE87B1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756506AbdCGX33 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:29:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53302 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751093AbdCGX32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:29:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DDC57F8CE;
        Tue,  7 Mar 2017 18:24:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WQU54wSaE7FDmcb6YlohSJOxgsw=; b=EyK+9C
        TvdlkCOcbw/iphzwz2dzK/eVlalAVx6jECS3OVt0VIwPdBK0izV+m6lHG/W1n7KX
        y4zX0H8OtAkRr6XB0z7F2lePXnAk9AXwlL5AGj2pkdSsFNor20gcvxD7oDWAZB/L
        kYosHjZor/rB9CRF0oS9Z9L3w72VpnTOU6SHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WQvyRfCGv74jjX4yCaz8DEITN5zcuRXC
        smk/dDZLAoy2XCZMSKt1T4zKbLRCgoH8Q+/hAaaxPCDAMAo5URQcOdNm4tCt/Bpu
        77mBvulRIpiWAnEouHGQuKc+tKgFyZ064jqnpNXhr1y2QcJ8d8RmjK9e6EG1hIff
        5teKbC8/XCY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 073557F8CC;
        Tue,  7 Mar 2017 18:24:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F3AA7F8CB;
        Tue,  7 Mar 2017 18:24:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 04/10] setup_git_directory_1(): avoid changing global state
References: <cover.1488562287.git.johannes.schindelin@gmx.de>
        <cover.1488897111.git.johannes.schindelin@gmx.de>
        <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
Date:   Tue, 07 Mar 2017 15:24:33 -0800
In-Reply-To: <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 7 Mar 2017 15:32:56 +0100
        (CET)")
Message-ID: <xmqqtw744qmm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39431BB2-038D-11E7-9B31-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
> +	case GIT_DIR_NONE:
> +		prefix = NULL;
> +		break;
> +	case GIT_DIR_EXPLICIT:
> +		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, nongit_ok);
> +		break;
> +	case GIT_DIR_DISCOVERED:
> +		if (dir.len < cwd.len && chdir(dir.buf))
> +			die(_("Cannot change to '%s'"), dir.buf);
> +		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
> +						  nongit_ok);
> +		break;
> +	case GIT_DIR_BARE:
> +		if (dir.len < cwd.len && chdir(dir.buf))
> +			die(_("Cannot change to '%s'"), dir.buf);
> +		prefix = setup_bare_git_dir(&cwd, dir.len, nongit_ok);
> +		break;
> +	case GIT_DIR_HIT_CEILING:
> +		prefix = setup_nongit(cwd.buf, nongit_ok);
> +		break;
> +	case GIT_DIR_HIT_MOUNT_POINT:
> +		if (nongit_ok) {
> +			*nongit_ok = 1;
> +			return NULL;
> +		}
> +		die(_("Not a git repository (or any parent up to mount point %s)\n"
> +		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> +		    dir.buf);
> +	default:
> +		die("BUG: unhandled setup_git_directory_1() result");
> +	}


I _might_ find niggles in other patches (and other parts of this
patch) that enables the above clean implementation, but this
switch() statement speaks of the value of this entire series ;-)

Very nicely done.
