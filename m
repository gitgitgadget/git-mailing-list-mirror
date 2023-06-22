Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA78EB64DD
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFVTvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFVTvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 15:51:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB171FEF
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 12:51:31 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4A8435A1A8;
        Thu, 22 Jun 2023 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687463490;
        bh=EaIrc0lXC6HQHVADnGeo6vPv4akskq/rTS6jiHnCaq8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BnlEx41FiBG9UtDOLIzQ4U+DY97rm/hQcceFZxA4JtxqdkYSLHfIOiYVZlQr7yfbU
         mhd1Cs0GOmYO8IwuGUUfsSFe52pVGJ8b3L5W85NHWH6S19he0/pl60vLI5w8uLyxlo
         gHeVVT9w+zCoxzKn9gQ5++tZLNKmUEqA2LU6BrMC8n3ZoTKrsvXG5TIzmIF1jOYDuz
         mSrhCYfHytv3Z7VGl5u2LKaNpn1IqVmq2BxtaJ/uxflKRzn0MRBtdL3RNGyZTN7EnX
         8slJT+kU3PbvvNsEwfYWKBZs4kdZB68gDmY0hRZFp4KiZcDGNT73knIwD481o4sOdq
         VRH9ooF9RTTA9arf6HsYkzvh/aeTPD7NlLravhRxW1vy8QejXrdT3X0lla2rGkkLHb
         NCfo/YxC8IT/5dVsVFq/Vm4AT1WmAjZT8ixTMdszz8yykbZXJI3ZVsItB+R+gcS84p
         vtSfsdcV6mq/yUOcTZsTpkAeyrl4UAgdhk4IKnJx6vtT7IzZFmW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: [PATCH 0/3] Additional variables for git var
Date:   Thu, 22 Jun 2023 19:50:56 +0000
Message-ID: <20230622195059.320593-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On many Unix systems, we have a good idea where Git's configuration
files and the shell it uses are located.  However, there are some
systems where that's not the case, such as Windows and with Homebrew,
where the expected files might be found in another location.

Right now, programs who would like to access things like the system
gitattributes or config file have to guess where the distributor of Git
placed these files, and with runtime relocation, it's not even
guaranteed that these will be in a fixed place from invocation to
invocation.  As a result, we need a way to query Git about the location
of these files.

This series introduces five new configuration variables that refer to
the shell path, the system and global gitattributes files, and the
system and global config files.  The global values are not technically
needed, since they should be computable from the environment alone, but
they are added to make life easier for users.

The shell path is especially useful on Windows, where Git usually
provides the POSIX shell, and is designed to make using programs that
interact with Git or Unix-like environment variables (e.g., `EDITOR` and
`VISUAL`) easier.

The gitattributes files are primarily for the benefit of Git LFS, but of
course the goal is to be generally useful.

The curious reviewer may ask, "Why are these in `git var` and not `git
rev-parse`?"  The answer is that these refer to configuration (albeit
partially at compile time), and thus are like the existing GIT_EDITOR,
and unlike what `git rev-parse` produces, which is almost completely
limited to paths and metadata related specifically to a given
repository.

This should be a relatively straightforward series, but of course any
feedback is welcome.

brian m. carlson (3):
  var: add support for listing the shell
  var: add attributes files locations
  var: add config file locations

 Documentation/git-var.txt | 23 +++++++++
 attr.c                    |  6 +--
 attr.h                    |  4 ++
 builtin/var.c             | 99 +++++++++++++++++++++++++++++++++++----
 t/t0007-git-var.sh        | 98 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 219 insertions(+), 11 deletions(-)

