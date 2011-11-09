From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/17] Pulling signed tags
Date: Tue,  8 Nov 2011 17:01:46 -0800
Message-ID: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwYQ-0003ni-CM
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1KIBCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab1KIBCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41E715A9D
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=cvkCnxrTBSKGsyThghQosx0rc6Y
	=; b=tuavPmxZkmEFR6WBv4z3EABPesQ6PRhteDiV610Yx6uR9Ue0Xh7jeEkU6De
	CC4gXLaHS37Dfkd2CeAeaV2AQ7ytDZQEP52uPBoMx1+1ReBgmn6p5Lo1swuweTrI
	CxkoVcqmFKZ01tDiyv/IEXp90/yNE+koDXmw8hcyrp1xYwdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=nZdUTSgQ4ryAlNV51LATBrntkMGN5
	KH/NNa5fE0zw3SWyQ/0PSnxOLUo5nEDGbk8DU6ItpMvkL8jqfQZ5ZjeiiHcPYnkx
	iMeG9C+K8hNC+StofvwdjePiYIj4Hql5oc7iEp1tsnnGx5Bf7BNj2ObZ7Ia7mCnT
	J6mn7xmb7KHKss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397A75A9B
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D2245A96 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:05 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
X-Pobox-Relay-ID: 70D10576-0A6E-11E1-AE07-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185124>

The third iteration of the fourth approach to give more confidence on the
authenticity of history, but the third approach of giving GPG signature to
individual commits is independently useful and has been rebased on top.

Notable differences from the previous round are:

 - The way to handle multi-line header lines in a commit object is
   officially defined --- the second and subsequent lines begin with a
   single SP to indent them. The "mergetag" header and "gpgsig" header are
   now expressed using it;

 - commit_tree() figures out what "mergetag" extra headers to generate by
   inspecting the annotation added to the util field of parent commits as
   before; it uses a new lower level commit_tree_extended() API to record
   the extra headers.

 - "commit --amend" propagates "mergetag" extra header from the original
   (but not "gpgsig" for obvious reasons).


 . Split GPG interface into its own helper library
 . fetch: do not store peeled tag object names in FETCH_HEAD
 . merge: notice local merging of tags and keep it unwrapped
 . fetch: allow "git fetch $there v1.0" to fetch a tag
 . refs DWIMmery: use the same rule for both "git fetch" and others
 . fmt-merge-msg: avoid early returns
 . fmt-merge-msg: package options into a structure
 . fmt-merge-msg: Add contents of merged tag in the merge message
 . merge: make usage of commit->util more extensible
 . merge: record tag objects without peeling in MERGE_HEAD

   Unchanged from the previous round.

 . commit: copy merged signed tags to headers of merge commit

   The way commit_tree() notices that some parents are signed tags and
   copies them to "mergetag" extra header has been reimplemented by using
   the new commit_tree_extended() API.

 . merge: force edit mode when merging a tag object

   Unchanged.

 . commit: teach --amend to carry forward extra headers

   New. This is the reason commit_tree_extended() was introduced. The
   plumbing "git commit-tree" should learn to read list of extra headers
   and record them to its product to help scripts (e.g. "rebase -i"), but
   it is outside the scope of this series for now.

 . commit: teach --gpg-sign option
 . log: --show-signature

   These two use the new multi-line header format, but otherwise
   unchanged.

 . test "commit -S" and "log --show-signature"
 . pretty: %G[?GS] placeholders

   Unchanged.

 Makefile                                           |    2 +
 builtin.h                                          |    8 +-
 builtin/commit-tree.c                              |   24 ++-
 builtin/commit.c                                   |   28 ++-
 builtin/fetch.c                                    |    3 +-
 builtin/fmt-merge-msg.c                            |  113 +++++++--
 builtin/merge.c                                    |  109 +++++----
 builtin/tag.c                                      |   76 +------
 builtin/verify-tag.c                               |   35 +---
 cache.h                                            |    2 +-
 commit.c                                           |  260 +++++++++++++++++++-
 commit.h                                           |   39 +++-
 gpg-interface.c                                    |  138 +++++++++++
 gpg-interface.h                                    |   10 +
 log-tree.c                                         |   39 +++
 merge-recursive.c                                  |   13 +-
 notes-cache.c                                      |    2 +-
 notes-merge.c                                      |    2 +-
 pretty.c                                           |   86 +++++++
 refs.c                                             |    7 -
 revision.c                                         |    2 +
 revision.h                                         |    1 +
 strbuf.c                                           |   14 +
 strbuf.h                                           |    8 +
 t/t4202-log.sh                                     |    4 +-
 t/t5510-fetch.sh                                   |    5 +-
 t/t5515/fetch.br-branches-default                  |    6 +-
 t/t5515/fetch.br-branches-default-merge            |    6 +-
 ...etch.br-branches-default-merge_branches-default |    6 +-
 t/t5515/fetch.br-branches-default-octopus          |    6 +-
 ...ch.br-branches-default-octopus_branches-default |    6 +-
 t/t5515/fetch.br-branches-default_branches-default |    6 +-
 t/t5515/fetch.br-branches-one                      |    6 +-
 t/t5515/fetch.br-branches-one-merge                |    6 +-
 t/t5515/fetch.br-branches-one-merge_branches-one   |    6 +-
 t/t5515/fetch.br-branches-one-octopus              |    6 +-
 t/t5515/fetch.br-branches-one-octopus_branches-one |    6 +-
 t/t5515/fetch.br-branches-one_branches-one         |    6 +-
 t/t5515/fetch.br-config-explicit                   |    6 +-
 t/t5515/fetch.br-config-explicit-merge             |    6 +-
 .../fetch.br-config-explicit-merge_config-explicit |    6 +-
 t/t5515/fetch.br-config-explicit-octopus           |    6 +-
 ...etch.br-config-explicit-octopus_config-explicit |    6 +-
 t/t5515/fetch.br-config-explicit_config-explicit   |    6 +-
 t/t5515/fetch.br-config-glob                       |    6 +-
 t/t5515/fetch.br-config-glob-merge                 |    6 +-
 t/t5515/fetch.br-config-glob-merge_config-glob     |    6 +-
 t/t5515/fetch.br-config-glob-octopus               |    6 +-
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    6 +-
 t/t5515/fetch.br-config-glob_config-glob           |    6 +-
 t/t5515/fetch.br-remote-explicit                   |    6 +-
 t/t5515/fetch.br-remote-explicit-merge             |    6 +-
 .../fetch.br-remote-explicit-merge_remote-explicit |    6 +-
 t/t5515/fetch.br-remote-explicit-octopus           |    6 +-
 ...etch.br-remote-explicit-octopus_remote-explicit |    6 +-
 t/t5515/fetch.br-remote-explicit_remote-explicit   |    6 +-
 t/t5515/fetch.br-remote-glob                       |    6 +-
 t/t5515/fetch.br-remote-glob-merge                 |    6 +-
 t/t5515/fetch.br-remote-glob-merge_remote-glob     |    6 +-
 t/t5515/fetch.br-remote-glob-octopus               |    6 +-
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    6 +-
 t/t5515/fetch.br-remote-glob_remote-glob           |    6 +-
 t/t5515/fetch.br-unconfig                          |    6 +-
 t/t5515/fetch.br-unconfig_--tags_.._.git           |    6 +-
 ...nfig_.._.git_one_tag_tag-one_tag_tag-three-file |    6 +-
 ...fig_.._.git_tag_tag-one-tree_tag_tag-three-file |    6 +-
 ...h.br-unconfig_.._.git_tag_tag-one_tag_tag-three |    6 +-
 t/t5515/fetch.br-unconfig_branches-default         |    6 +-
 t/t5515/fetch.br-unconfig_branches-one             |    6 +-
 t/t5515/fetch.br-unconfig_config-explicit          |    6 +-
 t/t5515/fetch.br-unconfig_config-glob              |    6 +-
 t/t5515/fetch.br-unconfig_remote-explicit          |    6 +-
 t/t5515/fetch.br-unconfig_remote-glob              |    6 +-
 t/t5515/fetch.master                               |    6 +-
 t/t5515/fetch.master_--tags_.._.git                |    6 +-
 ...ster_.._.git_one_tag_tag-one_tag_tag-three-file |    6 +-
 ...ter_.._.git_tag_tag-one-tree_tag_tag-three-file |    6 +-
 .../fetch.master_.._.git_tag_tag-one_tag_tag-three |    6 +-
 t/t5515/fetch.master_branches-default              |    6 +-
 t/t5515/fetch.master_branches-one                  |    6 +-
 t/t5515/fetch.master_config-explicit               |    6 +-
 t/t5515/fetch.master_config-glob                   |    6 +-
 t/t5515/fetch.master_remote-explicit               |    6 +-
 t/t5515/fetch.master_remote-glob                   |    6 +-
 t/t7510-signed-commit.sh                           |   71 ++++++
 t/t7600-merge.sh                                   |   12 +-
 t/t7604-merge-custom-message.sh                    |    2 +-
 t/t7608-merge-messages.sh                          |    4 +-
 tag.c                                              |    5 +
 89 files changed, 1080 insertions(+), 392 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h
 create mode 100755 t/t7510-signed-commit.sh

-- 
1.7.8.rc1.82.g90e080
