Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F101F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936352AbdGTTmo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:42:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53860 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935971AbdGTTmn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:42:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC7548C684;
        Thu, 20 Jul 2017 15:42:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zi92my/52aT6QiCHObdeR0+IrAE=; b=U7cTyM
        nbJu0RvYiBitmPvuh9pBWwMzTp6BCIhXvP5LZPSLuhBLK5mcgrKsuPFLBnAPYF51
        4xG/vZr054O0XPwdN9RQdzAAQEwP3kbhTVVBDZtJeIRt8PdcSxqumDGLmwt+rPcj
        HwwFAi6cVBBPlZ5JsAfpmi+KNdf5mikn1I+Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EXoHXeq8/sO4K6dnTlShIsqkja3WfWjs
        vWdiw28+M4+4wLSyrl0whoN8It3a6/yz/FMncDSsI1p0cx6cg0bvNZxXVYYwWdXk
        5R1RKrrTS1Q/1drm6+daR8zpg6msiRK7RVqUUeuEfOFw52mVDb1PmNZ2v0xkDGsZ
        NYPFVWaHet0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5B208C682;
        Thu, 20 Jul 2017 15:42:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37C3B8C680;
        Thu, 20 Jul 2017 15:42:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victor Toni <victor.toni@gmail.com>
Cc:     git@vger.kernel.org, Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>
Subject: Re: Handling of paths
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
Date:   Thu, 20 Jul 2017 12:42:40 -0700
In-Reply-To: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
        (Victor Toni's message of "Wed, 19 Jul 2017 18:48:41 +0200")
Message-ID: <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 985C2CE6-6D83-11E7-BCC0-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victor Toni <victor.toni@gmail.com> writes:

> What's unexpected is that paths used for sslKey or sslCert are treated
> differently insofar as they are expected to be absolute.
> Relative paths (whether with or without "~") don't work.

Looking at http.c::http_options(), I see that "sslcapath" and
"sslcainfo" do use git_config_pathname() when grabbing their values,
but "sslcert" and "sslkey" treat the value as a plain vanilla string
without expecting "~[username]/" at all.

The modern http.c codestructure was introduced at 29508e1e ("Isolate
shared HTTP request functionality", 2005-11-18) and was corrected
for interation between the multiple configuration files in 7059cd99
("http_init(): Fix config file parsing", 2009-03-09), but back in
these versions, all of them including "sslcapath" and "sslcainfo"
were all treated as plain vanilla strings.

It appears that only two of these among four were made aware of the
"~[username]/" prefix in bf9acba2 ("http: treat config options
sslCAPath and sslCAInfo as paths", 2015-11-23), but "sslkey" and
"sslcert" were still left as plain vanilla strings.  I do not know
if that was an elaborate omission, or a mere oversight, as it seems
that it happened while I was away, so...

