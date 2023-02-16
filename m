Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FCC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 18:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjBPSDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBPSDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 13:03:50 -0500
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 10:03:46 PST
Received: from hades.entrap.de (hades.entrap.de [46.4.58.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7E4D626
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 10:03:46 -0800 (PST)
Received: from hades.entrap.de (localhost [127.0.0.1])
        by hades.entrap.de (Postfix) with ESMTP id 29D1D2AE
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 18:55:43 +0100 (CET)
Received: from www.entrap.de (kronos.cvpn [192.168.95.29])
        by hades.entrap.de (Postfix) with ESMTP id EC9DA1C3
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 18:55:42 +0100 (CET)
Received: from 213.164.93.13
        (SquirrelMail authenticated user b52@entrap.de)
        by www.entrap.de with HTTP;
        Thu, 16 Feb 2023 18:55:42 +0100
Message-ID: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
Date:   Thu, 16 Feb 2023 18:55:42 +0100
Subject: Bug: git behind proxy is broken in 2.34.1
From:   tm-uzr3z@entrap.de
To:     git@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I just realized that git cloning behind a webproxy is broken in version
2.34.1 (Ubuntu 22.04).

The environment bash variables http_proxy, https_proxy, HTTP_PROXY and
HTTPS_PROXY are all set with the value
"http://myusername:mypassword@ourwebproxy:3128/".

git gives me the following error message on cloning:
$git clone https://github.com/XXXX/YYYY
fatal: unable to access 'https://github.com/XXXX/YYYY/': Received HTTP
code 407 from proxy after CONNECT

For example wget or curl http/https requests in the same shell work
without any issues and use the same proxy settings from the environment
variables.

In pcap traces I see that git requests the URL through the proxy, receives
an http 407 authentication required, and repeats the same request again
without credentials, which gets denied a second time.

On another very old machine with git 1.9.1 it requests the URL through the
proxy, receives an http 407 authentication required, and repeats the
request with credentials, which is allowed then.

Even with git config --global and --system variables http.proxy and
https.proxy the authentication required reply is ignored.

The git configuration is all default, except the proxy variables.
Hope this helps to reproduce and fix this issue. Thank you!

Best regards
Holger

