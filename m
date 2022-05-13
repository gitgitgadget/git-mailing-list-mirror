Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C7C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 07:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377734AbiEMHNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 03:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377725AbiEMHMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 03:12:48 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 00:12:46 PDT
Received: from psionic.psi5.com (psionic.psi5.com [IPv6:2a02:c206:3008:6895::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9C2701BB
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:12:45 -0700 (PDT)
Received: by psionic.psi5.com (Postfix, from userid 1002)
        id 7F9233F1E9; Fri, 13 May 2022 09:04:42 +0200 (CEST)
From:   Simon.Richter@hogyros.de
To:     git@vger.kernel.org
Cc:     Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 0/3] Allow configuration of HTTP authentication method
Date:   Fri, 13 May 2022 09:04:13 +0200
Message-Id: <20220513070416.37235-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Simon Richter <Simon.Richter@hogyros.de>

Hi,

this adds a configuration option to set the authentication method curl uses
when authenticating to a server.

The method is always configured, not just when a username is set, to allow
failing early if the server does not support the selected method;
otherwise, this mechanism is orthogonal to the proxy authentication method
handling, and I've liberally copied code from there.

This introduces http.authmethod and remote.<name>.authmethod configuration
options and an environment variable GIT_HTTP_AUTHMETHOD, with ascending
precedence.

There are three patches in this series, one that just renames a constant
list of options as it is used outside the proxy configuration scope now,
one that contains the main patch, and one I'm unsure about (hence no
Signed-Off-By yet) that allows empty user names during authentication.

The latter avoids surprises when people half-follow Microsoft's
documentation, which suggests that users configure a custom header
containing a hand-crafted Basic authentication string with an empty user
name. This is not strictly required by the "DevOps" server, any string will
do here, but simply pressing return on the username prompt will otherwise
fail to present the credentials at all, and give an error message
indicating that the given token is invalid.

I haven't investigated fully whether this is of any use outside the
interactive case, so the third patch is more of a request for comments.

With these changes, I can successfully authenticate to MS DevOps server
over HTTP using a Personal Access Token, without using the custom header
workaround[1], which allows me to use git-lfs (which in turn doesn't work
over ssh) from Jenkins with a limited token that is stored in the Jenkins
credential store, solving a problem for approximately tens of users[2].

   Simon

[1] https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows#use-a-pat

[2] https://stackoverflow.com/q/64800010

Simon Richter (3):
  Rename proxy_authmethods -> authmethods
  Add config option/env var to limit HTTP auth methods
  Allow empty user name in HTTP authentication

 Documentation/config/http.txt   | 19 ++++++++++++++
 Documentation/config/remote.txt |  4 +++
 http.c                          | 45 ++++++++++++++++++++++++++++-----
 remote.c                        |  4 +++
 remote.h                        |  3 +++
 5 files changed, 68 insertions(+), 7 deletions(-)

-- 
2.30.2

