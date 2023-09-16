Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B18C46CA1
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjIPVvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjIPVvV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 17:51:21 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3DE13E
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 14:51:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58BA835B4E;
        Sat, 16 Sep 2023 17:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=IIIIrAjVL3Yc7bzTtlKAIGFvfXOQuB85M4oO20
        mnO3k=; b=yWAFi6lF9vGZ7QrMaVQ+HBz39L9rhmMf4L6DdF6IG2O3RY3cuad0Vb
        03heHwvW6ms2tJPQukOQAlUS5UtUXq4ns7lLHiBZVaiabH3EOnG+ug/VGoEB16Yq
        RVY73+boydd1OStIkB0WNuEy3kyCG2cupJgZZx8EKBhXJXGZpkYW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5167C35B4D;
        Sat, 16 Sep 2023 17:51:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D374435B4C;
        Sat, 16 Sep 2023 17:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     johannes.schindelin@gmx.de, me@yadavpratyush.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2] git-gui - re-enable use of hook scripts
In-Reply-To: <20230916210131.78593-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Sat, 16 Sep 2023 17:01:31 -0400")
References: <xmqqy1h6auy7.fsf@gitster.g>
        <20230916210131.78593-1-mlevedahl@gmail.com>
Date:   Sat, 16 Sep 2023 14:51:11 -0700
Message-ID: <xmqqy1h5aisw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 274A3CA0-54DB-11EE-A97F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> uses tcl's "file split" command. Experiments on Linux and Windows, using
> tclsh, show that command names with relative and absolute paths always
> give at least two components, while a bare command gives only one.
>
> 	  Linux:   puts [file split {foo}]       ==>  foo
> 	  Linux:   puts [file split {/foo}]      ==>  / foo
> 	  Linux:   puts [file split {.git/foo}]  ==> .git foo
> 	  Windows: puts [file split {foo}]       ==>  foo
> 	  Windows: puts [file split {c:\foo}]    ==>  c:/ foo
> 	  Windows: puts [file split {.git\foo}]  ==> .git foo

;-)  Nice documentation of what you found out.

> diff --git a/git-gui.sh b/git-gui.sh
> index 8bc8892..8603437 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -118,7 +118,7 @@ proc sanitize_command_line {command_line from_index} {
>  	set i $from_index
>  	while {$i < [llength $command_line]} {
>  		set cmd [lindex $command_line $i]
> -		if {[file pathtype $cmd] ne "absolute"} {
> +		if {[llength [file split $cmd]] < 2} {
>  			set fullpath [_which $cmd]
>  			if {$fullpath eq ""} {
>  				throw {NOT-FOUND} "$cmd not found in PATH"

Nice.  Now we need to find a replacement maintainer for Git-gui ;-)
In the meantime, I can queue this patch on top of what I updated
git-gui part the last time with and merge it in.

Thanks.
