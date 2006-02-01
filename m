From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 2/9] http-fetch: Fix object list corruption in fill_active_slots().
Date: Wed, 01 Feb 2006 11:44:28 +0000
Message-ID: <20060201114428.5042.53434.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:44:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPj-00055O-38
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWBALob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBALob
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:31 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:5360 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932423AbWBALoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:30 -0500
Received: (qmail 6514 invoked from network); 1 Feb 2006 11:44:28 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?7ziqtQ878TCs6ygn0hYi4KfigHxwZktD?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:28 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15406>

From: Mark Wooding <mdw@distorted.org.uk>

In fill_active_slots() -- if we find an object which has already arrived,
say as part of a pack, /don't/ remove it from the list.  It's already been
prefetched and someone will ask for it later.  Just label it as done and
carry blithely on.  (As it was, the code would dereference a freed object
to continue through the list anyway.)

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http-fetch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 4b1b62d..b1ee836 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -312,7 +312,7 @@ void fill_active_slots(void)
 	while (active_requests < max_requests && obj_req != NULL) {
 		if (obj_req->state == WAITING) {
 			if (has_sha1_file(obj_req->sha1))
-				release_object_request(obj_req);
+				obj_req->state = COMPLETE;
 			else
 				start_object_request(obj_req);
 			curl_multi_perform(curlm, &num_transfers);
