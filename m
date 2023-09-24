Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAABCE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 14:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjIXOsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIXOsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 10:48:06 -0400
X-Greylist: delayed 92984 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 07:47:59 PDT
Received: from thor.hardeman.nu (thor.hardeman.nu [94.130.186.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3F6FD
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 07:47:59 -0700 (PDT)
Received: from webmail.hardeman.nu (thor.hardeman.nu [IPv6:2a01:4f8:c0c:bb23::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: david@hardeman.nu)
        by thor.hardeman.nu (Postfix) with ESMTPSA id 4RtplJ5K2dzFpgx;
        Sun, 24 Sep 2023 16:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardeman.nu;
        s=202308-ed25519; t=1695566876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C7XNuJIQPCVUa/PHyxiSxVUYUFrdTUX4A8whxRpZ7c=;
        b=Gz0nzswoqVC9rs3ffB7nh08BmCXAP8hBXk8M0FXlL7GFgJa45UQhQD5IMlbhNGg+dKXA/i
        xNNpz3uDQpdhlxDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardeman.nu; s=202308-rsa;
        t=1695566876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3C7XNuJIQPCVUa/PHyxiSxVUYUFrdTUX4A8whxRpZ7c=;
        b=pG19gi/TEC5Z75QrDheiRAPdigU8cnyzuhS94JFrp24UJE0o6ZsLDXEIEwqeX3Awopqmkm
        Pfa2EhdtqiLXjfv6uXwpnAPMmmZx9gU5iM/J6vRfOCQ2qStQZeMRt2eQta/Y/1KqeHYtT9
        O/R4l+hy8QVnPchsDRm5kVfW48ckZ4PACY0F+Sn/6AzBhQV/GqED9ulLNWKaUKdJNXLq3R
        nKFBhFGwSP+1R4S6MQxA8zpeMGHaXgF1Vn0rGgdbQCml5AMcf72qleswYxWJ/lgWF8IYSo
        e6L8eTEEDwNxID+kD9ZRovVXcARA7UHBILtHfWO6iOebCi+DzPqI+iP3L1xa7A==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=david@hardeman.nu smtp.mailfrom=david@hardeman.nu
MIME-Version: 1.0
Date:   Sun, 24 Sep 2023 14:47:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "=?utf-8?B?RGF2aWQgSMOkcmRlbWFu?=" <david@hardeman.nu>
Message-ID: <4454d8e1dab565118a316409d653844bbbfacfc7@hardeman.nu>
TLS-Required: No
Subject: Re: Issues with git clone over HTTP/2 and closed connections
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20230924035022.GA1503477@coredump.intra.peff.net>
References: <20230924035022.GA1503477@coredump.intra.peff.net>
 <bb757ebd66b5ac4c81d62b01d5cff2f75250090d@hardeman.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

September 24, 2023 at 5:50 AM, "Jeff King" <peff@peff.net> wrote:
> On Sat, Sep 23, 2023 at 12:58:09PM +0000, David H=C3=A4rdeman wrote:
>> From what I understand, git should close the connection, try to open a
>>  new one and resume the clone operation before erroring out (because
>>  the GOAWAY message could mean anything).
>>=20=20
>>=20 Is this a known bug and is it something that would need to be fixed=
 in
>>  libcurl or in git?
>>=20
>=20
> I don't think we've heard of such a problem before with Git. I don't
> know enough about GOAWAY to comment on the correct behavior, but this i=
s
> almost certainly a curl issue, not a Git one. All of the connection
> handling, reuse, etc, is happening invisibly at the curl layer.
>=20
>=20It's probably worth poking around libcurl's issue tracker. This seems
> like it might be related:
>=20
>=20 https://github.com/curl/curl/issues/11859

Yeah, looks very relevant. I'll keep an eye on that issue instead.

Thanks for the prompt feedback.

> And one final comment: 2000 is a lot of requests for one clone. That
> plus the error you are seeing from Git makes me think you're using the
> "dumb" http protocol (i.e., your webserver is not set up to run the
> server side of Git's smart protocol, so it is just serving files
> blindly).

Yeah, thanks for the advice...I've already sorted this out so that I'm no=
t
affected, but I wanted to make sure that I posted the bug report before I
forgot all the details.

Cheers,
David
