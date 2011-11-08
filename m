From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Mon,  7 Nov 2011 19:00:33 -0800
Message-ID: <1320721245-13223-1-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbvh-0001GM-0w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab1KHDAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:00:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab1KHDAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:00:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F68964F9;
	Mon,  7 Nov 2011 22:00:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OUwV
	dEazqIIql1cQzJEtr8Enhfs=; b=HsVuGpTbiA5p/uYj0PByYPMkuRbJ/pNMzno9
	kMuvd8TMcsIymCOj5D2hO+rxh2NEO7IEd6r8pX8wjVHcH7aB45bSSqTQjNdrGOEL
	eoHf5p5M8gVezqCM6W8kpER1hBV/U5x7tLydeGYEk/U+wLOZIxSNoZO8dWNEBHEj
	OJna5to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	g8DUZG4iXKV8YOY6xjDnqkWdhdtnr2gNfOFzvNjJvvn1ryuyz52WE+4JYjx+/Ud+
	Kir4UBF/+2q1/nDLzymmx/Ix70TuuK/ADSIcaOL+54UcgWNlyn/3GqLC/v54iMnY
	TZNB/iIm+6uZ63KbAebBfGNyM0G86wXekuE/pWIkZLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16B8E64F8;
	Mon,  7 Nov 2011 22:00:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66FCF64F5; Mon,  7 Nov 2011
 22:00:46 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DAE9D370-09B5-11E1-B681-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185051>

This is a re-roll of the fourth iteration.

  Split GPG interface into its own helper library
  fetch: do not store peeled tag object names in FETCH_HEAD
  merge: notice local merging of tags and keep it unwrapped
  fetch: allow "git fetch $there v1.0" to fetch a tag
  refs DWIMmery: use the same rule for both "git fetch" and others
  fmt-merge-msg: avoid early returns
  fmt-merge-msg: package options into a structure

The above are unchanged from v1, except for the test patch that is
gone. It has been merged into the patch that changes the behaviour to
require the adjustment to the test.

  fmt-merge-msg: Add contents of merged tag in the merge message

This is updated to not show the ugly tag contents with "tag:" prefix in
the merge log editor. Instead, the body of the tag (excluding the
signature if it is a signed tag) is given without any prefix to help the
integrator write a better log message. This happens even when merging an
annotated (not signed) tag.

  merge: make usage of commit->util more extensible
  merge: record tag objects without peeling in MERGE_HEAD
  commit: copy merged signed tags to headers of merge commit

These three are new and are necessary to copy "cat-file tag" of a signed
tag to the header of resulting merge commit.

  merge: force edit mode when merging a tag object

The implementation of this one has changed, but the spirit hasn't.

 Makefile                                           |    2 +
 builtin.h                                          |    8 +-
 builtin/commit.c                                   |   10 +-
 builtin/fetch.c                                    |    3 +-
 builtin/fmt-merge-msg.c                            |  113 +++++++++++++----
 builtin/merge.c                                    |   93 +++++++-------
 builtin/tag.c                                      |   76 +----------
 builtin/verify-tag.c                               |   35 +-----
 cache.h                                            |    2 +-
 commit.c                                           |   65 +++++++++-
 commit.h                                           |   13 ++
 gpg-interface.c                                    |  138 ++++++++++++++++++++
 gpg-interface.h                                    |   10 ++
 merge-recursive.c                                  |   13 +-
 refs.c                                             |    7 -
 strbuf.c                                           |   15 ++
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
 t/t7600-merge.sh                                   |   12 +-
 t/t7604-merge-custom-message.sh                    |    2 +-
 t/t7608-merge-messages.sh                          |    4 +-
 tag.c                                              |    5 +
 81 files changed, 613 insertions(+), 378 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

-- 
1.7.8.rc0.128.g31aa4
