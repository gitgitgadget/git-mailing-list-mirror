From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Return CURL error message when object transfer fails
Date: Mon, 26 Sep 2005 23:13:14 -0700
Message-ID: <7vpsqv2g3p.fsf@assigned-by-dhcp.cox.net>
References: <20050926175211.GD9410@reactrix.com>
	<7v4q87ed73.fsf@assigned-by-dhcp.cox.net>
	<20050927001241.GB15615@reactrix.com>
	<7v3bnr3vo5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 08:14:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK8iP-0001Bh-Oi
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 08:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVI0GNT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 02:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVI0GNT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 02:13:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8577 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964828AbVI0GNR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 02:13:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927061315.VFKI19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 02:13:15 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <7v3bnr3vo5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 26 Sep 2005 22:51:38 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9373>

Junio C Hamano <junkio@cox.net> writes:

> If that is the case, I'll take your patch verbatim.  Thanks.

Oops.  I spoke too fast.  That "sounds like a good idea" of mine
was a response to your:

> It might be better to extend this to all places that curl_easy_perform
> is called, rather than just in fetch_object.

... so the patch still needed some fixups.  It had minor
dependencies on the previous patches in the series as well, so I
tried to fix them up myself.

Could you take a look at it and see if the following is good
enough, please?

------------
Subject: [PATCH] Return CURL error message when object transfer fails
From: Nick Hengeveld <nickh@reactrix.com>
Date: 1127757131 -0700

Return CURL error message when object transfer fails

[jc: added similar curl_errorstr errors to places where we
 use curl_easy_perform() to run fetch that _must_ succeed.]

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 http-fetch.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

4f1da6322aa5d11091005b23716bcc3c65151a32
diff --git a/http-fetch.c b/http-fetch.c
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -15,6 +15,7 @@
 
 static CURL *curl;
 static struct curl_slist *no_pragma_header;
+static char curl_errorstr[CURL_ERROR_SIZE];
 
 static char *initial_base;
 
@@ -112,10 +113,12 @@ static int fetch_index(struct alt_base *
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	
 	if (curl_easy_perform(curl)) {
 		fclose(indexfile);
-		return error("Unable to get pack index %s", url);
+		return error("Unable to get pack index %s\n%s", url,
+			     curl_errorstr);
 	}
 
 	fclose(indexfile);
@@ -264,10 +267,10 @@ static int fetch_indices(struct alt_base
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	
-	if (curl_easy_perform(curl)) {
-		return -1;
-	}
+	if (curl_easy_perform(curl))
+		return error("%s", curl_errorstr);
 
 	while (i < buffer.posn) {
 		switch (data[i]) {
@@ -327,10 +330,12 @@ static int fetch_pack(struct alt_base *r
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
-	
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
+
 	if (curl_easy_perform(curl)) {
 		fclose(packfile);
-		return error("Unable to get pack file %s", url);
+		return error("Unable to get pack file %s\n%s", url,
+			     curl_errorstr);
 	}
 
 	fclose(packfile);
@@ -373,6 +378,7 @@ int fetch_object(struct alt_base *repo, 
 	curl_easy_setopt(curl, CURLOPT_FILE, NULL);
 	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, no_pragma_header);
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 
 	url = xmalloc(strlen(repo->base) + 50);
 	strcpy(url, repo->base);
@@ -388,7 +394,7 @@ int fetch_object(struct alt_base *repo, 
 
 	if (curl_easy_perform(curl)) {
 		unlink(filename);
-		return -1;
+		return error("%s", curl_errorstr);
 	}
 
 	fchmod(local, 0444);
@@ -453,6 +459,7 @@ int fetch_ref(char *ref, unsigned char *
         curl_easy_setopt(curl, CURLOPT_FILE, &buffer);
         curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, NULL);
+	curl_easy_setopt(curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 
         url = xmalloc(strlen(base) + 6 + strlen(ref));
         strcpy(url, base);
@@ -464,7 +471,8 @@ int fetch_ref(char *ref, unsigned char *
         curl_easy_setopt(curl, CURLOPT_URL, url);
 
         if (curl_easy_perform(curl))
-                return error("Couldn't get %s for %s\n", url, ref);
+                return error("Couldn't get %s for %s\n%s",
+			     url, ref, curl_errorstr);
 
         hex[40] = '\0';
         get_sha1_hex(hex, sha1);
