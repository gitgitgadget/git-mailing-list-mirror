Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A569CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 13:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjIWNGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 09:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjIWNGS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 09:06:18 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Sep 2023 06:06:12 PDT
Received: from thor.hardeman.nu (thor.hardeman.nu [IPv6:2a01:4f8:c0c:bb23::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048FB11D
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 06:06:11 -0700 (PDT)
Received: from webmail.hardeman.nu (thor.hardeman.nu [IPv6:2a01:4f8:c0c:bb23::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: david@hardeman.nu)
        by thor.hardeman.nu (Postfix) with ESMTPSA id 4Rt8M553gyzFpvL
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 14:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardeman.nu;
        s=202308-ed25519; t=1695473889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jDw1xRYpYVGDvNFp01KLJIWvLnGtc1L9IH+EUpkPggQ=;
        b=84uOrLCRMRWHuA34ZhCVKv7hB2L5//tKWcv1htnOYiv95jC8b3C8glMRkCYSrI8murDDw+
        dQabXsVHHyQ51MCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hardeman.nu; s=202308-rsa;
        t=1695473889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jDw1xRYpYVGDvNFp01KLJIWvLnGtc1L9IH+EUpkPggQ=;
        b=Hyre/3lUNy0VbskhQyUeYfZzGF7m7M4bcf0NxDKy6NxbMwEamMheNAgbItsdkn79XzOhe+
        1yzLOEsf+UWBN1eMiGsr6tihJUJuyF8szALXQ98xl/cFlajijuouz0mHKquux8hVlF6yAl
        ZL8zTNhaUx4AleEEIGVa6GE4gYdJEPigK6EnMY4DnwfKWqwZsaA2ciIaNCir219pvRMONL
        NwtP3IhCu8sZ/ZU/SNRjWAca9Czan2pEznnZ3GE7fsN9rtunyk+nY1Ux1jJSgXQZ0vJRJP
        AAV4RG9lqp4lfr0cedYqVIlXEZruFNU97pyaE8LwofSRVvMGYBdAgNcWA3NqjQ==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=david@hardeman.nu smtp.mailfrom=david@hardeman.nu
MIME-Version: 1.0
Date:   Sat, 23 Sep 2023 12:58:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "=?utf-8?B?RGF2aWQgSMOkcmRlbWFu?=" <david@hardeman.nu>
Message-ID: <bb757ebd66b5ac4c81d62b01d5cff2f75250090d@hardeman.nu>
TLS-Required: No
Subject: Issues with git clone over HTTP/2 and closed connections
To:     git@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just tried to clone a repo from a server over HTTPS, which failed with =
a message like this:

  error:  (curl_result =3D 55, http_code =3D 0, sha1 =3D <XYZ>
  error: Unable to find <XYZ> under https://example.com/myrepo.git
  Fetching objects: 20790, done.
  Cannot obtain needed tree <XYZ>
  while processing commit <ABC>
  error: fetch failed.

Every time I retried cloning, <XYZ> and <ABC> changed, but the error mess=
age was the same.

By running "GIT_CURL_VERBOSE=3D1 git clone https://example.com/myrepo.git=
", I noticed that:

  a) HTTP/2 was being used; and
  b) just before the error the server returned a GOAWAY [1]:
     "=3D=3D Info: received GOAWAY, error=3D0, last_stream=3D1999"

On the client side I'm using Debian Unstable (libcurl 8.3.0, git 2.40.1),=
 and the server is running Debian Stable (nginx 1.22.1-9).

nginx will, by default, close HTTP/2 connections after "http2_max_request=
s", (default: 1000, i.e. 1999 streams, note that the error message above =
says last_stream=3D1999) and it seems that it is using GOAWAY to do so, w=
hich seems to confuse git/libcurl.

And sure enough, after running "git config --global http.version HTTP/1.1=
" on the client and trying again, the "git clone" was successful (I'm gue=
ssing I could/should also bump http2_max_requests on the server).

From what I understand, git should close the connection, try to open a ne=
w one and resume the clone operation before erroring out (because the GOA=
WAY message could mean anything).

Is this a known bug and is it something that would need to be fixed in li=
bcurl or in git?

Cheers,
David

PS. Not subscribed, please CC: me on any replies.

[1] https://www.rfc-editor.org/rfc/rfc7540#section-6.8
[2] http://nginx.org/en/docs/http/ngx_http_v2_module.html#http2_max_reque=
sts
