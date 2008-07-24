From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH]
Date: Wed, 23 Jul 2008 17:22:58 -0700
Message-ID: <7vej5k8719.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLodC-0002Av-LS
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584AbYGXAXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbYGXAXI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:23:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbYGXAXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:23:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ACA2A38EC4;
	Wed, 23 Jul 2008 20:23:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7C41238EC2; Wed, 23 Jul 2008 20:23:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF570992-5916-11DD-A7E1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89820>

f2eba66 (Enable HEAD@{...} and make it independent from the current
branch, 2007-02-03) introduced dwim_log() to handle <refname>@{...}
syntax, and as part of its processing, it checks if the ref exists by
calling refsolve_ref().  It should call it as a reader to make sure the
call returns NULL for a nonexistent ref (not as a potential writer in
which case it does not return NULL).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I found this purely by accident.  "echo >.git/logs/refs/heads/HEAD"
   would make your "git rev-parse HEAD@{1}" complain about a refname
   'HEAD' being ambiguous without this patch.

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b0b2167..4fb77f8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -273,7 +273,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		const char *ref, *it;
 
 		strcpy(path, mkpath(*p, len, str));
-		ref = resolve_ref(path, hash, 0, NULL);
+		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)
 			continue;
 		if (!stat(git_path("logs/%s", path), &st) &&
