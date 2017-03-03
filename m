Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA9A20133
	for <e@80x24.org>; Fri,  3 Mar 2017 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdCCVGo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 16:06:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751212AbdCCVGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 16:06:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E18766004;
        Fri,  3 Mar 2017 16:05:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsXWQPqRTiTKJv5ILlIiaSv/U9k=; b=UvtZwA
        MXpOVCyaOeagzMuYykb5itNkjTDy0D3zC54Os1P6btPQXOX9dwaUQ3ThV9zV3nRD
        4KNtLdAZN5Z+tLJZiUO5cPaCrU8ZKjqBgzqsIAPAcOhQn6YPmR2hJ5QCoiaWWP2u
        s598kVSNXl7Ll4tEBO7t+/jo4/Fa0cHwDdSB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ftHCxrR27ZdTKvfWoygyN0CX0N66lmZD
        S2pFHO7BZpjEVmu8TKG8ThnmEWfwgesMeyUs6rq2jxH+JR4DJTKu4TGzCWhEqQx0
        WuOHCVMoQTELNMvCMIo4ktJjhQeWxfET0z6etmtQUMHdIfxQcF2z87OJw7/Qh/pr
        JiguhylfqLE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 464DA66003;
        Fri,  3 Mar 2017 16:05:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 847A366000;
        Fri,  3 Mar 2017 16:05:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] config: check if config path is a file before parsing it
References: <20170303094252.11706-1-pclouds@gmail.com>
        <20170303094252.11706-2-pclouds@gmail.com>
        <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 13:05:47 -0800
In-Reply-To: <20170303095351.rgifjpfuvafx33jy@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 04:53:51 -0500")
Message-ID: <xmqq4lza840k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D04507C-0055-11E7-844F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>        a. actually check ferror() after getting EOF and report the read
>           error. That catches EISDIR, along with any other unexpected
> 	  errors.

That is the most sensible, I would think (assuming that we really
get EISDIR instead of silent EOF).

>        b. use an fopen wrapper that checks fstat(fileno(fh)) after the
>           open, and turns fopen(some_dir) into an error.

That's already an option with FREAD_READS_DIRECTORIES, I think.

>   2. It doesn't address the root problem for git_config_from_file(),
>      which is that it is quiet when fopen fails, even if the reason is
>      something interesting besides ENOENT. The caller can't check errno
>      because it doesn't know if fopen() failed, or if the config
>      callback returned an error.

Perhaps like this one as a starting point, with FREAD_READS_DIRECTORIES?

 config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.c b/config.c
index 0dac0f4cb2..af8c01c8a3 100644
--- a/config.c
+++ b/config.c
@@ -1305,6 +1305,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	FILE *f;
 
 	f = fopen(filename, "r");
+	if (!f && errno != ENOENT)
+		die_errno("fopen('%s') failed", filename);
+
 	if (f) {
 		flockfile(f);
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
