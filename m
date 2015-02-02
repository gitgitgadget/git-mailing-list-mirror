From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] "git apply" safety
Date: Mon,  2 Feb 2015 15:27:26 -0800
Message-ID: <1422919650-13346-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 00:27:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIQP4-0002zH-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 00:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbbBBX1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 18:27:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755313AbbBBX1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 18:27:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1F7135A86;
	Mon,  2 Feb 2015 18:27:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=WlPIkKfMJ3E4i1BIWYkSFl3HJuw
	=; b=f9NP7xE8sgmRbsdhtFokPXsjGDnJNSrAj3qxEDRYGX8Adt+nw+tmkNQhPgP
	3FDmcU3JP7XdLcC+MHH9GRr2Z9wyGut4ttP4ydbfLcW6rkJyA5cNc1ESRKZvBcSa
	6lIr7BAROyCMwfoL1/qjxip+dgy01OcJeaymTYck3gngYDmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=YvBIKOH0wsGkc2Y2XzhouyT9uZc/B
	A9ZjxrlPCoTfVHO/aO6aRcIjm+SkX/fR7Y6vrgjttVxmINxjLiu3sARkTZ7Z1xeP
	yhZLuOCD4J8jrdnqSataZOCvCSD3ZFol2nu4ZgFldqwKCqdYN6nJEJ8E6M38+qW4
	gfTdshKnkkmL/c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A850C35A85;
	Mon,  2 Feb 2015 18:27:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A28B35A82;
	Mon,  2 Feb 2015 18:27:32 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc2-166-g7339d96
X-Pobox-Relay-ID: 0FA05AFE-AB33-11E4-95ED-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263291>

"git apply" have been fairly careless about letting the input follow
symbolic links, especially when used without the --index/--cached
options (which was more or less deliberate to mimic what "patch"
used to do).  When the input tells it to modify a/b/c, and lstat(2)
said that there is "a/b/c" that matches the preimage in the input,
we happily overwrote it, even when a/b is a symbolic link that
pointed somewhere, even outside the working tree.

This series tightens things a bit for safety.

 (1) By default, we reject patches to ".git/file", "../some/where",
     "./this/././that", etc., i.e. the names you cannot add to the
     index.  Those who use "git apply" (without --index/--cached) as
     a replacement for GNU patch can use --unsafe-paths option to
     override this safety.  This is what patch 1/4 does.

 (2) We do not allow a patch to depend on a location beyond a
     symbolic link (this includes "a patch to remove a path beyond a
     symbolic link").  This is patch 2/4 and 3/4.

 (3) We do not allow a patch to create result on a location beyond a
     symbolic link.  This is patch 4/4.

There is no knob to override the latter two points, as this is not a
safety but is a correctness issue.  Because Git keeps track of and
can express changes to symbolic links, a patch that expects a file
"a/b/c" to be tracked (either the patch adds it, or it modifies an
existing file tehre) implicitly expects that there is no symbolic
link "a/b", so attempting to apply such a patch to a tree with a
symbolic link at "a/b", even when the link points at some directory,
must detect that the target tree does not match what the patch's
preimage expects and fail.

The previous attempt begins at around here:

  http://thread.gmane.org/gmane.linux.kernel/1874498/focus=1878385

Junio C Hamano (4):
  apply: reject input that touches outside $cwd
  apply: do not read from the filesystem under --index
  apply: do not read from beyond a symbolic link
  apply: do not touch a file beyond a symbolic link

 Documentation/git-apply.txt     |  14 +++-
 builtin/apply.c                 | 139 +++++++++++++++++++++++++++++++++++++++-
 t/t4122-apply-symlink-inside.sh |  89 +++++++++++++++++++++++++
 t/t4139-apply-escape.sh         | 137 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 377 insertions(+), 2 deletions(-)
 create mode 100755 t/t4139-apply-escape.sh

-- 
2.3.0-rc2-164-g799cdce
