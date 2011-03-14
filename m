From: Jakob Pfender <jpfender@elegosoft.com>
Subject: [PATCH] revision.c: Clarify error message for missing objects
Date: Mon, 14 Mar 2011 16:11:54 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D7E303A.5090605@elegosoft.com>
References: <7vzkp1y0jr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 16:21:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz9a1-0000VW-Ue
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 16:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab1CNPVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 11:21:01 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:43339 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab1CNPVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 11:21:00 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 11:21:00 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id AF3A51B4B97
	for <git@vger.kernel.org>; Mon, 14 Mar 2011 16:12:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJSjXLALXmxQ for <git@vger.kernel.org>;
	Mon, 14 Mar 2011 16:12:01 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 93C8E1B4B82
	for <git@vger.kernel.org>; Mon, 14 Mar 2011 16:11:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vzkp1y0jr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168992>

[Sorry Junio, accidentally sent this to just you the first time around]

If "git show" is invoked on a hash for a file that doesn't exist, the
produced error message was "fatal: bad object <hash>". This is
misleading as the object isn't bad, but missing. As a matter of fact, if
an object is bad, this error message is never produced, because
parse_object() terminates with its own error message if the object is
corrupt.

This patch introduces a check to see whether an object exists (with the
appropriate error message if it doesn't) and removes the unnecessary and
misleading original error message if parse_object() fails.

Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
---
  revision.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 86d2470..085aac2 100644
--- a/revision.c
+++ b/revision.c
@@ -173,9 +173,9 @@ static struct object *get_reference(struct rev_info 
*revs, const char *name, con
  {
      struct object *object;

+    if (sha1_object_info(sha1, NULL) < 0)
+        die("Not a valid object name %s", name);
      object = parse_object(sha1);
-    if (!object)
-        die("bad object %s", name);
      object->flags |= flags;
      return object;
  }
-- 
1.7.0.4
