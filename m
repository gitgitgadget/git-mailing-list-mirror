From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 15:21:34 -0800
Message-ID: <7vmzfmm35t.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	<4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	<e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	<7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550603191340u466d3551t8a95c3808eb977c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 00:21:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL7DS-00008w-Ir
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 00:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWCSXVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 18:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCSXVi
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 18:21:38 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:30669 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751223AbWCSXVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 18:21:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060319231954.CLBN20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 18:19:54 -0500
To: Marco Costalba <mcostalba@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17735>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Finally accessing the missing object with a browser
>
> http://digilander.libero.it/mcostalba/
> scm/qgit.git/objects/8d/ea03519e75f47da91108330dde3043defddd60
>
> gives a pre-canned (in italian) 'Sorry page not found' stuff.
>
> So I really think the site "HTTP/1.0 200 OK" response it's a fake.
> Perhaps security related to avoid sniffing (just a guess because I have
> absolutely zero competence in security related things).

I think you are just rephrasing what I said.  From the HTTP
protocol perspective, you _do_ have that 8d/3a0351 thing on that
server, because you do not correctly say "No we donot have it"
using 404 response.

Your inability to produce 404 is a different matter -- often the
hosting server is not under your control.  But that does not
change the fact that the repository observed by your clients is
"broken".  That is why a workaround flag like I suggested may be
needed for such a setup.

This is totally untested, but maybe something like this?

---
diff --git a/http-fetch.c b/http-fetch.c
index 7de818b..d523798 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -8,6 +8,7 @@
 #define RANGE_HEADER_SIZE 30
 
 static int got_alternates = -1;
+static int unreliable_404 = 0;
 
 static struct curl_slist *no_pragma_header;
 
@@ -822,12 +823,18 @@ static int fetch_object(struct alt_base 
 		close(obj_req->local); obj_req->local = -1;
 	}
 
+	
+
 	if (obj_req->state == ABORTED) {
 		ret = error("Request for %s aborted", hex);
-	} else if (obj_req->curl_result != CURLE_OK &&
-		   obj_req->http_code != 416) {
+	} else if ((obj_req->curl_result != CURLE_OK &&
+		    obj_req->http_code != 416)  ||
+		   (unreliable_404 &&
+		    obj_req->curl_result == CURLE_OK &&
+		    obj_req->zret != Z_STREAM_END)) {
 		if (obj_req->http_code == 404 ||
-		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE)
+		    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
+		    unreliable_404)
 			ret = -1; /* Be silent, it is probably in a pack. */
 		else
 			ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
@@ -966,6 +973,8 @@ int main(int argc, char **argv)
 			arg++;
 		} else if (!strcmp(argv[arg], "--recover")) {
 			get_recover = 1;
+		} else if (!strcmp(argv[arg], "--unreliable-404")) {
+			unreliable_404 = 1;
 		}
 		arg++;
 	}
