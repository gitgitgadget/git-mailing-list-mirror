Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 864792082F
	for <e@80x24.org>; Tue, 18 Jul 2017 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbdGRVGl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 17:06:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56799 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbdGRVGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 17:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 020E77E94D;
        Tue, 18 Jul 2017 17:06:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ygbFZG9pO06dlBi6lIWUP3E0640=; b=dnriiK
        8TD/r8Y2oRpK5e7ZfZ2ZD4HeAr2xjsqu8n6LTF2dbP9c46l6bJX2xmh+958lnkk6
        Wv2wjvQaQFoWk9ZvFlkuQZg9VPwEW6jU9fQKoMw0rahK5Pxkux4Yjq159lpehlK3
        YsZEIHICRR/X4Pt303JZrmu7nYRFlOrx4mmFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rMyau1/R0KW2njH1z+DoFq4+FWsI1GTj
        1N3kxmUrsIkIFWESosf8RpORS+I2cWwmZTLaDXD3fTFTI38MscSh5sA9tIcKYhel
        enK1Ii+vTxtbxUeY1VC4o55BM3TNGFDaOS1bkx7wl7wtZxeEYrVjBxK4Qfl6mdCr
        L4zzsBxyn98=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDBAC7E94B;
        Tue, 18 Jul 2017 17:06:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56E0A7E949;
        Tue, 18 Jul 2017 17:06:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hielke Christian Braun <hcb@unco.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitweb bugfix - check for search permission on sub-directories while scanning project root to prevent program termination
References: <0102015d5203f2ae-c7f1daeb-a6ab-413d-9036-c8da816c4c18-000000@eu-west-1.amazonses.com>
        <xmqqd18yhl5v.fsf@gitster.mtv.corp.google.com>
        <8e4adda7-11df-8a26-71a8-2e6429b04c67@unco.de>
Date:   Tue, 18 Jul 2017 14:06:18 -0700
In-Reply-To: <8e4adda7-11df-8a26-71a8-2e6429b04c67@unco.de> (Hielke Christian
        Braun's message of "Tue, 18 Jul 2017 10:41:54 +0200")
Message-ID: <xmqq7ez5o3p1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1F93B14-6BFC-11E7-A756-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hielke Christian Braun <hcb@unco.de> writes:

> Hi,
>
> gitweb terminates and shows no project list, if it can not access a
> sub-directory in the project root directory. It should show a list of
> the projects it can access. Patch corrects this by skipping inaccessible
> directories.
>
>
> Signed-off-by: Hielke Christian Braun <hcb@unco.de>
>
>
> ---
>  gitweb/gitweb.perl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3d4a8ee27c96a..9208f42ed1753 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3071,6 +3071,8 @@ sub git_get_projects_list {
>  				return if (m!^[/.]$!);
>  				# only directories can be git repositories
>  				return unless (-d $_);
> +				# need search permission
> +				return unless (-x $_);
>  				# don't traverse too deep (Find is super slow on os x)
>  				# $project_maxdepth excludes depth of $projectroot
>  				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
>
> --
> https://github.com/git/git/pull/384

I've tweaked the title and the log message further before queuing
the patch.

Thanks.  

