From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t1200: work around a bug in some implementations of "find"
Date: Sat, 26 Dec 2009 13:53:45 -0800
Message-ID: <7vocllxuza.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 22:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOeb0-0005Qp-VM
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbZLZVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 16:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbZLZVxv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 16:53:51 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZLZVxv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 16:53:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F08C98B49D;
	Sat, 26 Dec 2009 16:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=8Di2
	cAHm5tVfMhNDFLy+Sly0jbs=; b=KcjB9HOS41+2eQC5qLeuOjVQzZ1CQTTrUpSC
	jzJfxhf9YFzE2MbATs+vpbD9k+HoeJoFWhVa343jC51n6Z1ZnpzQWOzPppV1gACo
	QRGg229IDIhMXHrvjf41A/lt+jsazaGgbRLrD3hbaY8/U94Ei01II/wU4OwPymOl
	a27uliY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FiB
	1TxoH3OJLOs7aJgrN69Syot/ABdqwyrXp6qq133ZQ8q4F88L4MDf95UCe8aViCJN
	GkA7HJGtKCfZ5IuiwQxiZB5J4v/dk4iSi/O/pBuxgiCBIAXTPLQPpZu6L2mM8+3D
	v6rg3zRD+q2LS0Sw6e7skysciClJis0ahiR+J9NY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D4D648B49C;
	Sat, 26 Dec 2009 16:53:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54ABE8B496; Sat, 26 Dec
 2009 16:53:46 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 254236E4-F269-11DE-9D81-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135693>

"find path ..." command should exit with zero status only when all path
operands were traversed successfully.  When a non-existent path is given,
however, some implementations of "find" (e.g. OpenBSD 4.6) exit with zero
status and break the last test in t1200.

Rewrite the test to check that there is no regular files in the objects
fan-out directories to work around this bug; it is closer to what we are
testing anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1200-tutorial.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 238c2f1..ab55eda 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -259,7 +259,7 @@ test_expect_success 'git repack' 'git repack'
 test_expect_success 'git prune-packed' 'git prune-packed'
 test_expect_success '-> only packed objects' '
 	git prune && # Remove conflict marked blobs
-	! find .git/objects/[0-9a-f][0-9a-f] -type f
+	test $(find .git/objects/[0-9a-f][0-9a-f] -type f -print 2>/dev/null | wc -l) = 0
 '
 
 test_done
