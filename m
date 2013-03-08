From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Enumerating reflog entries in a wrong order
Date: Fri,  8 Mar 2013 13:53:41 -0800
Message-ID: <1362779624-15513-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 22:54:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE5F7-0000MP-TL
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3CHVxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:53:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3CHVxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:53:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6064B4B8
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Zy/4qPBIiiaLSdL351SIrk18SZU
	=; b=eOnDbvXUpLcCbpSWJofiis3czP4yzgD8Bi2CoAvPlTvnTUz46fiXjEfXQCX
	97h2BXwuZcezbr9PiLB3e5i0jatyXZzfHnphXx3rGUZq2mNE3st9Ir4zIAp3hqXd
	NdVBsrTwAVf8y8ybUBRbt/Pvt4hZ+2iq1G2b4F3oW7q7i3b8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=xABuYElISAC+m6nbR7TmG2mHLDesv
	/GxwkFNLwDWrM+aP5m2wEfMyEmeWO3OmyoGckIlub/3lXtz2t3d7jrsLVe/jOx0P
	6rpCZptF1kpoxoZps8B34AP30fsm3EbVif6/XPqrMx3CwO3XuG0bMRQ2eLK+qOg8
	FZwOnbEklPkivY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1ECB4B7
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BEFDB4B4 for
 <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:46 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-189-g94c4d42
X-Pobox-Relay-ID: A6CDD186-883A-11E2-B7EB-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217687>

The for_each_reflog_ent() function yields reflog entries from the
oldest to newer, and is inefficient when we know what we are looking
for are near the newest end (e.g. "find the nth newest reflog entry
that matches 'checkout: moving from X to Y'").  To optimize for the
common case, we introduced for_each_recent_reflog_ent() to scan only
the newest part (i.e. tail) of the reflog file, but it is difficult
to use this function correctly.

Just bite the bullet and stop working around the API that reads the
file in a wrong order.  The new for_each_reflog_ent_reverse()
function gives us reflog entries from the newest to older.

Junio C Hamano (3):
  for_each_reflog_ent(): extract a helper to process a single entry
  for_each_recent_reflog_ent(): simplify opening of a reflog file
  reflog: add for_each_reflog_ent_reverse() API

 refs.c      | 161 +++++++++++++++++++++++++++++++++++++++++++-----------------
 refs.h      |   2 +-
 sha1_name.c |  48 +++++++-----------
 3 files changed, 134 insertions(+), 77 deletions(-)

-- 
1.8.2-rc3-189-g94c4d42
