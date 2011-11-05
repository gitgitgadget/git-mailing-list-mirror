From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/10] Pulling signed tag
Date: Fri,  4 Nov 2011 23:01:30 -0700
Message-ID: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKK-0005a3-Rt
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab1KEGBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1KEGBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F09C3C0F
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=jpYog/MflnufOInsACp68/UHo+s
	=; b=o7ytV1m+K1K2lPfL+6d4fPRlCL3A626In1JUv9B1jkGuc/vY1+py4RltiDI
	1fFont1kZqad6+kcdqdWi2xdTtmrYjYD1w+RWbYQI3ay9vHMSTH8Yr2mM6TH4Plo
	0IJX6Z5h0WPjufvsySjJkqn2G+CFC4GiGQHIC8ortMnj4ktg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=YKd+/7UYhLKpOBF+yoOqRKYCVV3xP
	/dVt25RZtZqtRB2jwRQbo7wp2UghEcCPxgLgeIc+YMaYQ2/DLqIAii5aWURSlme9
	5y/kfmz55utt9wvlDpf6e94Rs3Mex2JCFV7luzyKpxH94ypZ1tAFTg3WYrN2Kf4g
	UyN329VA7LdNUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 558F33C0E
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A11CD3C0C for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
X-Pobox-Relay-ID: A1E67298-0773-11E1-8D48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184822>

This is my fourth iteration to solve the "how can we allow authenticity of
work by contributors to be validated by the integrator and leave enough
information for later audit by third parties" topic. What is unusual is
that this is not a fourth re-roll of one approach re-re-re-polished, but
these four are all based on different design.

This round is based on Linus's "let the integrator pull signed tag from
the contributor" design.

The first patch is the same as the one at the bottom of the third
iteration which was jc/signed-commit topic. The rest are new.

 1. Split GPG interface into its own helper library

 2. fetch: do not store peeled tag object names in FETCH_HEAD
 3. merge: notice local merging of tags and keep it unwrapped
 4. fetch: allow "git fetch $there v1.0" to fetch a tag
 5. tests: distinguish merges of tags and commits

"git fetch" used to peel tags too early when storing in FETCH_HEAD (the
input to fmt-merge-msg), and "git merge" did the same when internally
preparing the list of what are merged to feed the internal fmt-merge-msg.

The above four stops doing so, whose effect can be seen in the changes to
the test vector in the fifth patch.

 6. refs DWIMmery: use the same rule for both "git fetch" and others

You can pull a tag with "git pull $there tags/for-linus", but this allows
you to say "git pull $there for-linus".

 7. fmt-merge-msg: avoid early returns
 8. fmt-merge-msg: package options into a structure
 9. fmt-merge-msg: Add contents of merged tag in the merge message

The first two of this segment are small clean-ups to make the third one
possible. When merging signed tag(s), the merge message is prepared with
the contents of the tag object for later independent audit at the end, and
also contains the output from the GPG verification process as the comment
to help the integrator verify it.

10. merge: force edit mode when merging a tag object

And in order to _show_ that comment, we would need to show it in the
editor before the commit happens, hence this conclusion patch.

 Makefile                                           |    2 +
 builtin.h                                          |    8 +-
 builtin/fetch.c                                    |    3 +-
 builtin/fmt-merge-msg.c                            |  126 +++++++++++++++----
 builtin/merge.c                                    |   28 +++-
 builtin/tag.c                                      |   76 +----------
 builtin/verify-tag.c                               |   35 +-----
 cache.h                                            |    2 +-
 gpg-interface.c                                    |  138 ++++++++++++++++++++
 gpg-interface.h                                    |   10 ++
 refs.c                                             |    7 -
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
 t/t7600-merge.sh                                   |    6 +-
 t/t7604-merge-custom-message.sh                    |    2 +-
 t/t7608-merge-messages.sh                          |    4 +-
 tag.c                                              |    5 +
 75 files changed, 482 insertions(+), 327 deletions(-)
 create mode 100644 gpg-interface.c
 create mode 100644 gpg-interface.h

-- 
1.7.8.rc0.108.g71b5ec
