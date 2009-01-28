From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-apply.c: do not set bogus mode in check_preimage()
 for deleted path
Date: Wed, 28 Jan 2009 15:27:54 -0800
Message-ID: <7vocxrj9j9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@redhat.com>,
	Alexander Potashev <aspotashev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 00:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJqq-00049C-2R
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZA1X2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZA1X2F
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:28:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbZA1X2D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:28:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2AE181D824;
	Wed, 28 Jan 2009 18:28:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4DBBB1D823; Wed,
 28 Jan 2009 18:27:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DC3A250-ED93-11DD-AEA1-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107598>

If it is deleted, it is deleted.  Do not set the current mode to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This updates 1f7903a (builtin-apply: prevent non-explicit permission
   changes, 2009-01-02).  It should not change the behaviour in the normal
   case, because we do not explicitly check the final mode of a deletion
   patch.  We do check the deletion patch creates an empty result, and we
   might want to fix that someday, and at that point the existing code
   will break.

   Also I suspect this codepath has been broken the use case 7a07841
   (git-apply: handle a patch that touches the same path more than once
   better, 2008-06-27) wanted to support, and if that is the case, this
   would fix it.

 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b415daf..1e7f917 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2453,7 +2453,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (st_mode != patch->old_mode)
 		fprintf(stderr, "warning: %s has type %o, expected %o\n",
 			old_name, st_mode, patch->old_mode);
-	if (!patch->new_mode)
+	if (!patch->new_mode && !patch->is_delete)
 		patch->new_mode = st_mode;
 	return 0;
 
-- 
1.6.1.1.278.g6a817
