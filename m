X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] Handle errors when setting configs
Date: Thu, 28 Jan 2016 10:00:28 +0100
Message-ID: <1453971637-22273-1-git-send-email-ps@pks.im>
NNTP-Posting-Date: Thu, 28 Jan 2016 09:01:33 +0000 (UTC)
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=emDaVPvgtz7XejGKqWL+ZqD2oI
	w=; b=M2ic5gvNEfNaDcOIT/MkMNJHwpwG7lxhP4PsPwqOBCOCwpfCxrw+OLDdRy
	QK0XjdmLfCrJIxukiugOQePexaI8zaM0inWVHLPo1WtShTbcpqCQFTmeOgTUf9T1
	ihN75UusHF46s5UyuEkFEVSKc1ALMoOUMTj0iLYe1FEu+7obs=
X-Sasl-enc: SFc94WK8/kN3JiZbX4kYhPC6Ke2kEdTWbIlBPoSsjMy1 1453971639
X-Mailer: git-send-email 2.7.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1aOiS6-0007A6-3N for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 10:01:18
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755216AbcA1JAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016
 04:00:47 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41977 "EHLO
 out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S1755173AbcA1JAl (ORCPT <rfc822;git@vger.kernel.org>); Thu, 28
 Jan 2016 04:00:41 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46]) by
 mailout.nyi.internal (Postfix) with ESMTP id 656B521EE4 for
 <git@vger.kernel.org>; Thu, 28 Jan 2016 04:00:40 -0500 (EST)
Received: from frontend2 ([10.202.2.161]) by compute6.internal (MEProxy);
 Thu, 28 Jan 2016 04:00:40 -0500
Received: from localhost (f052174253.adsl.alicedsl.de [78.52.174.253]) by
 mail.messagingengine.com (Postfix) with ESMTPA id E93C96800D1; Thu, 28 Jan
 2016 04:00:39 -0500 (EST)
Sender: git-owner@vger.kernel.org

I've finally got around to producing version two of my previous
patch to handle errors when setting configs. Back in September
I've posted a single patch to handle errors when
`install_branch_config` fails due to configuration failures [1].

Failure to write the configuration file may be caused by multiple
conditions, but the most common one will surely be the case where
the configuration is locked because of a leftover lock file or
because another process is currently writing to it. We used to
ignore those errors in many cases, possibly leading to
inconsistently configured repositories. More often than not git
even pretended that everything was fine and that the settings
have been applied when indeed they were not.

Version two of this patch is somewhat more involved in that I
tried to track down all relevant places where we set configs
without checking for error conditions. My current approach to
most of those cases is to just die with an error message, this
remains up to discussion though for the individual cases.

[1]: $gmane/278544

Patrick Steinhardt (9):
  config: introduce set_or_die wrappers
  branch: return error code for install_branch_config
  remote: handle config errors in set_url
  clone: handle config errors in cmd_clone
  branch: handle config errors when unsetting upstream
  init-db: handle config errors
  sequencer: handle config errors when saving opts
  submodule--helper: handle config errors
  compat: die when unable to set core.precomposeunicode

 branch.c                    | 31 +++++++++++++++++++++----------
 branch.h                    |  3 ++-
 builtin/branch.c            |  4 ++--
 builtin/clone.c             | 17 ++++++++++-------
 builtin/init-db.c           | 20 ++++++++++----------
 builtin/remote.c            | 11 ++++++-----
 builtin/submodule--helper.c |  4 ++--
 cache.h                     |  4 ++++
 compat/precompose_utf8.c    |  3 ++-
 config.c                    | 27 +++++++++++++++++++++++++++
 sequencer.c                 | 22 +++++++++++-----------
 t/t3200-branch.sh           | 16 +++++++++++++++-
 t/t5505-remote.sh           |  9 +++++++++
 transport.c                 | 11 ++++++-----
 14 files changed, 127 insertions(+), 55 deletions(-)

-- 
2.7.0
