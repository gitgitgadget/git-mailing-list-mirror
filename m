Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31721F404
	for <e@80x24.org>; Sat,  8 Sep 2018 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIHXBp convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 8 Sep 2018 19:01:45 -0400
Received: from chomsky.autogeree.net ([91.216.110.36]:42993 "EHLO
        chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeIHXBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 19:01:45 -0400
Received: by localhost.localdomain (localhost.localdomain, from userid 1000)
        id 24F54E08A7; Sat,  8 Sep 2018 20:14:39 +0200 (CEST)
Date:   Sat, 8 Sep 2018 20:14:39 +0200
From:   Julien Moutinho <julm+git@autogeree.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb: HTML output is not always encoded in UTF-8 when using
 --fastcgi.
Message-ID: <20180908181439.jdbvdrzndvdy7gkc@localhost>
References: <20180908171532.uyz7i5oy6w6otp2r@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180908171532.uyz7i5oy6w6otp2r@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le sam. 08 sept. 2018 à 19:15:32 +0200, Julien Moutinho a écrit :
> As a quick workaround this hotpatch can even be put in $GITWEB_CONFIG
> by removing the `local` before `*FCGI::Stream::PRINT`.

Turns out to require more care than that,
due to $per_request_config reloading $GITWEB_CONFIG at each request,
overwriting FCGI::Stream::PRINT multiple times, messing the encoding.
This seems to work(around):
| if ($first_request) {
|         my $enc = Encode::find_encoding('UTF-8');
|         my $org = \&FCGI::Stream::PRINT;
|         no warnings 'redefine';
|         *FCGI::Stream::PRINT = sub {
|             my @OUTPUT = @_;
|             for (my $i = 1; $i < @_; $i++) {
|                 $OUTPUT[$i] = $enc->encode($_[$i], Encode::FB_CROAK|Encode::LEAVE_SRC);
|             }
|             @_ = @OUTPUT;
|             goto $org;
|         };
| }
