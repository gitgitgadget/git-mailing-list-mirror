Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC611C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA262073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tF0GZlCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgC2QGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:06:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54115 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC2QGa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 12:06:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED934CAFDD;
        Sun, 29 Mar 2020 12:06:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EZMpesZMMjTo/yStUJJzLNPDyxs=; b=tF0GZl
        CNXxH7JOKWPGl1K1G5fUOjq6W2bgaTYWVvKo36otjU/NoV8095+lfQBuOGc0sjv6
        OuFPX/vSo9CLX3FsdRhLjFzPe/CuHqqHEWq49OH1QXs4IC9sLoMh5FufYeFXzQDa
        7vh11WQq8r3lsXqHyhrP9SMrPNWqV2d6ayEd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vzXHz/5l3yIvyepRa6WVy1CmpX4ZPvWa
        dkO+9gxD66n9pFR2HJa6OFxEvLr1TOwZqBBkVzyAdRwZwoJ5C27euKH2FceUVHcY
        f6nDIHGt9S1uZ+lxCkeeg8mo3mkAYP6ncwLNQJCUXk/Ox00vfX6ysQTWMX5WVgXr
        jbfpKFE8+l4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6503CAFDC;
        Sun, 29 Mar 2020 12:06:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25E21CAFDB;
        Sun, 29 Mar 2020 12:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien Moutinho <julm+git@sourcephile.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitweb: fix UTF-8 encoding when using CGI::Fast
References: <20200329002028.26080-1-julm+git@sourcephile.fr>
Date:   Sun, 29 Mar 2020 09:06:24 -0700
In-Reply-To: <20200329002028.26080-1-julm+git@sourcephile.fr> (Julien
        Moutinho's message of "Sun, 29 Mar 2020 01:20:28 +0100")
Message-ID: <xmqqr1xbb0xr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E153628-71D7-11EA-B627-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien Moutinho <julm+git@sourcephile.fr> writes:

>  	require CGI::Fast;
>  	our $CGI = 'CGI::Fast';
> +	# FCGI is not Unicode aware hence the UTF-8 encoding must be done manually.
> +	# However no encoding must be done within git_blob_plain() and git_snapshot()
> +	# which must still output in raw binary mode.

I guess this comment would be sufficient to help future developers
when they find that newer version of CGI::Fast has become Unicode
aware later can make this part conditional to the version of the
module, perhaps?

Would "use CGI::Fast (-utf8)" instead of the whole thing help, by
the way?

> +	no warnings 'redefine';
> +	my $enc = Encode::find_encoding('UTF-8');
> +	*FCGI::Stream::PRINT = sub {
> +		my @OUTPUT = @_;
> +		for (my $i = 1; $i < @_; $i++) {
> +			$OUTPUT[$i] = $enc->encode($_[$i], Encode::FB_CROAK|Encode::LEAVE_SRC);
> +		}
> +		@_ = @OUTPUT;
> +		goto $FCGI_Stream_PRINT_raw;
> +	};



>  	my $request_number = 0;
>  	# let each child service 100 requests
> @@ -7079,6 +7093,7 @@ sub git_blob_plain {
>  			($sandbox ? 'attachment' : 'inline')
>  			. '; filename="' . $save_as . '"');
>  	local $/ = undef;
> +	local *FCGI::Stream::PRINT = $FCGI_Stream_PRINT_raw;
>  	binmode STDOUT, ':raw';
>  	print <$fd>;
>  	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> @@ -7417,6 +7432,7 @@ sub git_snapshot {
>  
>  	open my $fd, "-|", $cmd
>  		or die_error(500, "Execute git-archive failed");
> +	local *FCGI::Stream::PRINT = $FCGI_Stream_PRINT_raw;
>  	binmode STDOUT, ':raw';
>  	print <$fd>;
>  	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
