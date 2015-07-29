From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] clone: fix repo name when cloning a server's root
Date: Wed, 29 Jul 2015 17:51:10 +0200
Message-ID: <1438185076-28870-1-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdd-0000rQ-QW
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbbG2PvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:21 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55607 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbbG2PvU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3B0A220DF6
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:20 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 29 Jul 2015 11:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2Pdy
	I+/9Ed79Sjz8X5Oo3rMoUhY=; b=bq/uidvr5fWaeyf/UtQYKZR38MQ5FzIPBR56
	RVvrTHUMDdZ8MbuPer1M8KW6+efIPadTM2r0LAB3WOFp8E+olMMjD1/09PI/+uQV
	h+JguKA/EQJGJt9LOfPghrqc2D16kIMdmcxImugWuu9e/jqYO2ZDcX8rWijsW2g1
	mrjYxoE=
X-Sasl-enc: qK4vk3cCPIMNp14tqLD9ac2WlrEQMzzZVRPGkrfMnotB 1438185079
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id C1E9FC00014;
	Wed, 29 Jul 2015 11:51:19 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1437997708-10732-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274900>

As proposed the previous patch has been changed such that we now
utilize parse_connect_url(), which splits a connect URL by host
and path components. If the path component is empty we now try to
fall back to the host component, stripping it of its port and
authentication information.

The first two patches fix the t1509-root-worktree tests. They
currently were not working due to broken &&-chains and are
required to test cloning from /.

The next two patches expose parse_connect_url(), which is then
used in the fifth patch. The last patch provides tests for the
behavior. To keep it simple we just use file:// URIs, which have
the option of including a host in there, e.g.
file://127.0.0.1/foobar.

Patrick Steinhardt (6):
  tests: fix broken && chains in t1509-root-worktree
  tests: fix cleanup after tests in t1509-root-worktree
  connect: expose parse_connect_url()
  connect: move error check to caller of parse_connect_url
  clone: fix hostname parsing when guessing dir
  clone: add tests for cloning / without workdir name

 builtin/clone.c          | 73 +++++++++++++++++++++++++++++++++++-------------
 connect.c                | 19 +++----------
 connect.h                | 13 +++++++++
 t/t1509-root-worktree.sh | 43 +++++++++++++++++++++++++---
 4 files changed, 109 insertions(+), 39 deletions(-)

-- 
2.5.0
