Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03B91F859
	for <e@80x24.org>; Wed, 31 Aug 2016 17:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161473AbcHaRyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 13:54:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56897 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1161069AbcHaRyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 13:54:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36F2439866;
        Wed, 31 Aug 2016 13:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fnwiwNyGEo/sja0wdQ3WBkviaiE=; b=jfx52M
        XpndqJjITO+0HxZo3Rw+CcAeacROrnQNjVo3lVZnHz+jodNPZ4v6CkFR7TPx5RQK
        t8UVDXvVHGzf98rXoPajyOH3bGo1Rgx5/lgjZSxB7wlbQf0ou5geT29ch50jlYR9
        Mn/pVJlzgDtkJLLogRupCYXSHF0MSg032fqQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KMAQhSD9upAaigPPNAxP1xAGg9a9KTev
        e7BcUn9iQUyOaqgqNY+8KExyec7zjsukBd8cDIEg8nO5ZlqxuFAeGFvCj8E7Zhas
        e66ERNh4W6Gn/y0tOxWXH88sqXehZ35YVayBw7TYPLjzziE6eLqZsvmJfY30jc/q
        l22uL4UVx4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FD8A39865;
        Wed, 31 Aug 2016 13:54:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A250D39864;
        Wed, 31 Aug 2016 13:54:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] git-send-email: Add ability to cc: any "trailers" from commit message
References: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
Date:   Wed, 31 Aug 2016 10:54:39 -0700
In-Reply-To: <b2aa91d59a6cdd468bcbe85b45807cc1b82b23ed.1472588158.git.joe@perches.com>
        (Joe Perches's message of "Tue, 30 Aug 2016 13:18:29 -0700")
Message-ID: <xmqqpooo259c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FED01296-6FA3-11E6-8D8B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> Many commits have various forms of trailers similar to
>      "Acked-by: Name <address>" and "Reported-by: Name <address>"
>
> Add the ability to cc these trailers when using git send-email.

I thought you were asking what we call these "<token> followed by
<colon>" at the end of the log message, and "footers or trailers"
was the answer.

I do not have a strong objection against limiting to "-by:" lines;
for one thing, it would automatically avoid having to worry about
"Bug-ID:" and other trailers that won't have e-mail address at all.

But if you are _only_ picking up "-by:" lines, then calling this
option "trailers" is way too wide and confusing.  I do not think
there is any specific name for "-by:" lines, though.  Perhaps you
would need to invent some name that has "-by" as a substring.

"any-by"?  or just "by"?  I dunno.

>  if ($suppress_cc{'all'}) {
> -	foreach my $entry (qw (cccmd cc author self sob body bodycc)) {
> +	foreach my $entry (qw (cccmd cc author self sob body bodycc trailers)) {
>  		$suppress_cc{$entry} = 1;
>  	}

OK.

> @@ -448,7 +448,7 @@ $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
>  $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
>  
>  if ($suppress_cc{'body'}) {
> -	foreach my $entry (qw (sob bodycc)) {
> +	foreach my $entry (qw (sob bodycc trailers)) {
>  		$suppress_cc{$entry} = 1;
>  	}
>  	delete $suppress_cc{'body'};

OK.

> @@ -1545,7 +1545,7 @@ foreach my $t (@files) {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
> +		if (/^(Signed-off-by|Cc|[^\s]+[_-]by): (.*)$/i) {

Micronits:

 (1) do you really want to grab a run of any non-blanks?  Don't
     you want to exclude at least a colon?
 (2) allowing an underscore looks a bit unusual.  

> @@ -1555,6 +1555,12 @@ foreach my $t (@files) {
>  			} else {
>  				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
>  				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> +				next if $suppress_cc{'trailers'} and $what !~ /Signed-off-by/i && $what =~ /by$/i;
> +			}

It is a bit unfortunate that S-o-b is a subset of any-by that forces
you to do this.

> +			if ($c !~ /.+@.+/) {
> +				printf("(body) Ignoring %s from line '%s'\n",
> +				       $what, $_) unless $quiet;
> +				next;
>  			}

This check is new and applies to sob/cc, too.

I am aware of the fact that people sometimes write only a name with
no e-mail address when giving credit to a third-party and we want to
avoid upsetting the underlying MTA by feeding it a non-address.

Looking at existing helper subs like extract_valid_address and
sanitize_address that all addresses we pass to the MTA go through,
it appears to me that we try to support an addr-spec with only
local-part without @domain, so this new check might turn out to be
too strict from that point of view, but on the other hand I suspect
it won't be a huge issue because the addresses in the footers are
for public consumption and it may not make much sense to have a
local-only address there.  I dunno.

>  			push @cc, $c;
>  			printf("(body) Adding cc: %s from line '%s'\n",
