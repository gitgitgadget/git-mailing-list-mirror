Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31478C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 11:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353891AbhLDLNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 06:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbhLDLNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 06:13:20 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EBBC061751
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 03:09:54 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 4CDA058730259; Sat,  4 Dec 2021 12:09:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 4A85C60C247CB;
        Sat,  4 Dec 2021 12:09:52 +0100 (CET)
Date:   Sat, 4 Dec 2021 12:09:52 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
In-Reply-To: <xmqqee6spz9s.fsf@gitster.g>
Message-ID: <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr>
References: <xmqqee6vwj67.fsf@gitster.g> <20211202102855.23907-1-jengelh@inai.de> <xmqqee6spz9s.fsf@gitster.g>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Saturday 2021-12-04 09:09, Junio C Hamano wrote:

>Jan Engelhardt <jengelh@inai.de> writes:
>
>> When using a browser to access a URI that is served by http-backend,
>> nothing but a blank page is shown. This is not helpful.
>>
>> Emit the same "Request not handled" messages, but to the CGI stream
>
>Puzzled.  Same with what?

"Request not handled" is already sent to stderr, which means it (only)
shows up in the httpd error log.

So now we send "Request not handled" also to stdout, which is what
the browser will see.

>What is in "pathinfo" parameter?

It is getenv("PATH_INFO").

>I think the use of internal API in http-backend.c in the new code is
>wrong; I haven't seen how it is used until now, so take this with a
>grain of salt, though.
>
>Did you actually mean something different, that is:
>
>	struct strbuf body = STRBUF_INIT;
>
>	http_status(hdr, 404, "Not Found");
>	hdr_nocache(hdr);
>       
>	/* stuff pathinfo, err, and hint into "body" strbuf ... */
>	if (pathinfo)
>		strbuf_addf(&body, "%s: ", pathinfo);
>	strbuf_addf(&body, "%s.\r\n", err);
>        if (hint)
>		strbuf_addf(&body, "%s\r\n", hint);
>
>	/* ... and send it out */
>	send_strbuf(hdr, "text/plain", &body);
>	strbuf_release(&body);

Yes, that seems more like it. I was not aware of send_strbuf.

>I notice that this is still going to the standard error stream.  Is
>the intention that the remote requestor may get a lightly redacted
>error message while the log will leave detailed record to help
>debugging?

Yes.

>Why do we need the original not_found()?  It seems that there is
>only one remaining caller

I suppose it can be dissolved.

>ANd if we can get rid of the use of the original not_found(), we
>could even take its nice name over. 
