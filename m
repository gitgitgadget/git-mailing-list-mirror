Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5050BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEA8207DE
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="fTljxiIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgIGRDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:03:15 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:47116 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbgIGRDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 13:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1599498175; bh=czfHeRlz4v+vPiHEG0NCPNVZ/gP+s6I9+VZ8kZ0SrLg=;
        h=Subject:From:To:Date;
        b=fTljxiICBGNuCyEfiqGF7tARGi6UlOiuDAQYE6tIttPrhk8OGbM9iVY9jW9PtxDEI
         lmwS2d77HCMFqcEQhHrORDa3PjBy3nyodEQTaUFXEUsCKBXS60IBFUMsJ6WtfNebmj
         mmY4cLpbbvGzfc+KNINg94+Lev/hlT96DFOH7yfc=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Proposal: server-advertised config options
From:   "Drew DeVault" <sir@cmpwn.com>
To:     <git@vger.kernel.org>
Date:   Mon, 07 Sep 2020 12:52:12 -0400
Message-Id: <C5HAJYI9RDPU.1CPN4E1JCQCAQ@homura>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The basic idea is that the server could advertise some config options
which it recommends the client sets for a given repo after a fetch. Some
possible use-cases for this feature include setting:

- format.subjectPrefix to 'PATCH my-project'
- sendemail.to to the mailing list address
- push.pushOption to recommended push options

Upon cloning, each recommended config option would be displayed to the
user, and they would be prompted ([Y/n]) to agree to set that value in
the config file for that repository. Additionally, there would be a
config option which white-lists a list of config options which are
automatically agreed to without prompting, and each config option would
have one of the following states:

- accept-silent: set the option without printing a message
- accept-verbose: set the option and display a message
- prompt: prompt the user to set this config option
- reject-silent: silently refuse to set this config option
- reject-verbose: refuse to set this config option and display a message

We would default to reject-verbose for all unknown config options and
include a set of defaults which specifies the appropriate trust level
for various useful benign options (such as the examples above).

The implementation would involve advertising config-advertisement in the
fetch protocol. Both the client and server would have to agree to use
it. If the server supports it but the client does not (in the case of an
old client), it could fall back to printing the list of recommended
options to stderr.

To choose which config options to advertise, a new option would be
introduced (uploadpack.advertiseOptions) for example, which has a list
of .git/config options from the remote repository to forward to the
client.

This would be a lot of work so I'd like to float it for discussion
before getting started. What do you guys think?
