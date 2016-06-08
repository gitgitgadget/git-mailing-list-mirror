From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] A bit more "attributes"
Date: Wed,  8 Jun 2016 15:58:13 -0700
Message-ID: <20160608225818.726-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:58:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmQe-00059M-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 00:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423783AbcFHW6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 18:58:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933173AbcFHW6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 18:58:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 35DD520074;
	Wed,  8 Jun 2016 18:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=lFsbxQcD6VV+KOAeuHToG0GogYs
	=; b=bNv+4kVMXJH2ux49Mwu8DMNw5+BiPK5qRFY4cFFAZzFPHvdQ+ErM3QeuTkx
	jqQCl7YLMlXhcgiozHq/WvkdsT526SAcUksnO0iMjSfgRXimxQI6JsPPZuj18I/5
	RGcel6B2QjFS2aku6OYb7ggmd3/pl7ixbES6AXuqmCPZnpSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=hJfGfx/9nmtmumV5o+VWjRXjDr0Fx
	96dXIOKswNQpjw403HY4SRC5VOTYGk/8Ifs+F8JcTA8zfcov18zjtCcUKJaoVN9P
	oz50ScuMAkyc/8qVrdeJsTrJocIjfuySe45jKuPFY6f2w0z1shSgCiB+61gFlCBC
	L8uKwJlVzhuIxE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F6F820073;
	Wed,  8 Jun 2016 18:58:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFAEE20072;
	Wed,  8 Jun 2016 18:58:19 -0400 (EDT)
X-Mailer: git-send-email 2.9.0-rc2-262-g9161bbf
X-Pobox-Relay-ID: 7E52511A-2DCC-11E6-83D1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296852>

The whole jc/attr topic is now depended on Stefan's "pathspec label"
topic, both of which are in 'next' and cannot be rewound until the
next cycle.  These five patches are to continue my recent
"attributes" work while the tree is in frozen state.

A few central data structures, namely "attr_stack" that keeps track
of the attributes read from the .gitattributes files in the
directory hierarchy of interest and "check_all_attr[]" that keeps
track of the state of the attributes for the path being checked, are
implemented as file-scope global singletons that belong to the
attribute subsystem ("attr.c").  The envisioned endgame is to make
them into per "struct git_attr_check" instance, so that the entire
system can have multiple "directory hierarchy of interest" and "path
being checked", i.e. allow multiple threads to keep their own
"git_attr_check" and to use the attribute system simultaneously.

To further that plan, the first two patches pass the check[]
structure further down the callchain, and the last two patches
remove a hack that prevented check[] from being passed in one corner
case and always pass it down the callchain.

Junio C Hamano (5):
  attr.c: add push_stack() helper
  attr.c: pass struct git_attr_check down the callchain
  fixup! d5ad6c13
  attr.c: correct ugly hack for git_all_attrs()
  attr.c: always pass check[] to collect_some_attrs()

 attr.c | 143 +++++++++++++++++++++++++++++++++--------------------------------
 attr.h |   2 +-
 2 files changed, 74 insertions(+), 71 deletions(-)

-- 
2.9.0-rc2-262-g9161bbf
