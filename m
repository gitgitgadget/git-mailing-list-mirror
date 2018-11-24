Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894E31F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeKXXwE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 18:52:04 -0500
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:45861
        "EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbeKXXwD (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 18:52:03 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QXazgryKeGjRqQXb1gXWV5; Sat, 24 Nov 2018 06:03:40 -0700
Date:   Sat, 24 Nov 2018 15:03:37 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] t5562: do not reuse output files
Message-ID: <20181124130337.GH5348@jessie.local>
References: <20181124070428.18571-1-max@max630.net>
 <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
 <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMUtCc+OaCrza0X/5AUFwUg14ZzYlSMPkjE5LM90hSsLhPR2pCEmZsdLp27o7LMqz/LjvkPQ9KBpLJLCrAbTHVvlKz6YsBxdFhvQqFDJzLQmv6VOs7yR
 DEF/DYDFX+kxsXlBfNf8WksGxoWjuG6b/LR16M4WVc3/glglfakz2SPjb40ed/Nea3SrAMnBJ4yT3dyTt4AFSAYEYCImwXCtQXl2T5S+mhozdeQDsROLjw5v
 x7josG6woKnwGj08CO/F0WWnJX20hVFIQ61mfjA900A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 04:47:19PM +0900, Junio C Hamano wrote:
> I do agree that forcing the parent to wait, like you described in
> the comment, would be far more preferrable,

It looks like it can be done as simple as:

--- a/http-backend.c
+++ b/http-backend.c
@@ -486,6 +486,8 @@ static void run_service(const char **argv, int buffer_input)
        if (buffer_input || gzipped_request || req_len >= 0)
                cld.in = -1;
        cld.git_cmd = 1;
+       cld.clean_on_exit = 1;
+       cld.wait_after_clean = 1;
        if (start_command(&cld))
                exit(1);

at least according to strate it does what it should.
