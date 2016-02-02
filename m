From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/15] config: make git_config_set die on failure
Date: Tue,  2 Feb 2016 12:51:41 +0100
Message-ID: <1454413916-31984-1-git-send-email-ps@pks.im>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 12:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZVG-0005zE-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 12:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbcBBLwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 06:52:10 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48668 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754458AbcBBLwI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 06:52:08 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 25BE0211CE
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 06:52:08 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 02 Feb 2016 06:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=9KOvIBWZmTzcq/NkzI8DYQwWkG
	Q=; b=ksCVoAQr+wqEDVaHW0puFWDm+e4uSnSa72CJSeKVLTk+Fdd8l504B5OXXl
	MuprFTcucrqS1SI/niTafonitkCiE8A/ZubT0vGISVAuGBNQQZssxrJRCI22ncZG
	Nm/oB3EhTqI/cKL23X7tIa18JMWu6Lp+cp23ckhJ67UM83x8A=
X-Sasl-enc: +4PXXkWRxOxn+2+OVvHuU/Hshw8wgyI9medod8eNg7sN 1454413927
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8FEA0C00012;
	Tue,  2 Feb 2016 06:52:07 -0500 (EST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285250>

This is the fourth version of my patch series. Version three of
these patches can be found at [1]. These patches convert the
`git_config_set` family of functions such that they die by
default whenever an error is encountered in persisting configs.
This catches a lot of cases where we wrote configs without
checking the returned status code, thus leading to inconsistent
state witouth even notifying the user.

This version combines both version 2 ([2]) and version 3 of this
patch series in that we first introduce `git_config_set_or_die`
wrappers and converting most call sites to use these. After the
conversion is done, we rename `git_config_set` to
`git_config_set_gently` and adjusting remaining call sites. The
last step was to rename `git_config_set_or_die` to
`git_config_set` in order to get the desired default behavior.

This back-and-forth should hopefully help easing the transition
and review by breaking down the actual transition into small
pieces.

[1]: http://article.gmane.org/gmane.comp.version-control.git/285198
[2]: http://article.gmane.org/gmane.comp.version-control.git/285000

Patrick Steinhardt (15):
  config: introduce set_or_die wrappers
  branch: die on error in setting up tracking branch
  branch: die on config error when unsetting upstream
  branch: die on config error when editing branch description
  submodule: die on config error when linking modules
  submodule--helper: die on config error when cloning module
  remote: die on config error when setting URL
  remote: die on config error when setting/adding branches
  remote: die on config error when manipulating remotes
  clone: die on config error in cmd_clone
  init-db: die on config errors when initializing empty repo
  sequencer: die on config error when saving replay opts
  compat: die when unable to set core.precomposeunicode
  config: rename git_config_set to git_config_set_gently
  config: rename git_config_set_or_die to git_config_set

 branch.c                 | 13 +++++----
 branch.h                 |  1 +
 builtin/branch.c         |  5 ++--
 builtin/clone.c          |  2 +-
 builtin/config.c         | 28 +++++++++----------
 builtin/init-db.c        |  2 +-
 builtin/remote.c         | 70 +++++++++++++++++-------------------------------
 cache.h                  | 14 ++++++----
 compat/precompose_utf8.c |  3 ++-
 config.c                 | 52 ++++++++++++++++++++++++++---------
 submodule.c              | 10 +++----
 t/t3200-branch.sh        | 16 ++++++++++-
 t/t5505-remote.sh        |  9 +++++++
 13 files changed, 128 insertions(+), 97 deletions(-)

-- 
2.7.0
