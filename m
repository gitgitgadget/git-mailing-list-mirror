From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/4]  "git apply" safety
Date: Tue, 10 Feb 2015 14:36:07 -0800
Message-ID: <1423607771-27157-1-git-send-email-gitster@pobox.com>
References: <1423010662-26497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 23:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJPn-0004zW-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbbBJWgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:36:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751381AbbBJWgO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:36:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE2537496;
	Tue, 10 Feb 2015 17:36:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Fe3H
	UM6xHJYV7CcaKk1Ob26t9OQ=; b=te3IUg7p4+4GRK00vQaRnDHrARZWv3Wjn4L7
	fohOpnO8fGBxEYKGj6MiqgvFnWquJS+u+cFdQiQE+wD+h7fLpyDqQYFa3b2L4Rx9
	zQ6w14xEDmtsC0n13IDD3r0gfnbRH+0h39hV9kn95/Ny6IHWSr8cVwQqwNenbui2
	7wEWCLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=w26ZZJ
	+ZphyfDMWrxVbZCE8+TzsnyL0g57zOCiaVlGnDweTq7c4jZfaraMHuO9cC7H5lZR
	4DOJ9aKOPo88POJMfBqFeEQ7jrsHop6llCpZUi2asWPfo2rFn21dGRKk/BmdBF+D
	dL7gDGpPodTCeWbdXYTFe1vWwhZUaZMy59kBY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 662E137495;
	Tue, 10 Feb 2015 17:36:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB35437491;
	Tue, 10 Feb 2015 17:36:12 -0500 (EST)
X-Mailer: git-send-email 2.3.0-185-g073f588
In-Reply-To: <1423010662-26497-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 37808844-B175-11E4-8D80-38A39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263652>

Git tracks symbolic links; e.g. you can remove files that have been
tracked in a directory "dir/file*" and then creates a symbolic link
at "dir" to point elsewhere, express such a change as a patchset and
then apply it to the original tree.  Consequently, applying a patch
to update dir/file, when you have "dir" as a symbolic link pointing
somewhere, must fail, just like a patch whose preimage does not
match what you have in tree you are trying to apply the patch to
gets rejected.  Also, we fundamentally do not like to touch a path
that contains ".git" as a path component.

This round uses cache_file_exists() in the last patch to cope with
case insensitive filesystems better.

The previous round begins here:

  http://thread.gmane.org/gmane.comp.version-control.git/263341

Junio C Hamano (4):
  apply: reject input that touches outside the working area
  apply: do not read from the filesystem under --index
  apply: do not read from beyond a symbolic link
  apply: do not touch a file beyond a symbolic link

 Documentation/git-apply.txt     |  12 +++-
 builtin/apply.c                 | 142 +++++++++++++++++++++++++++++++++++++++-
 t/t4122-apply-symlink-inside.sh | 106 ++++++++++++++++++++++++++++++
 t/t4139-apply-escape.sh         | 141 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 399 insertions(+), 2 deletions(-)
 create mode 100755 t/t4139-apply-escape.sh

-- 
2.3.0-185-g073f588
