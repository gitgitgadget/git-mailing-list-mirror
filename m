From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 00:44:43 -0800
Message-ID: <7v8xr5ld38.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	<4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	<e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	<7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550603191340u466d3551t8a95c3808eb977c1@mail.gmail.com>
	<7vmzfmm35t.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550603192231k7843a741xbf14394bc5e4c57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 09:44:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLG0R-0002KN-SD
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 09:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWCTIoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 03:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCTIoq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 03:44:46 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21690 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932214AbWCTIop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 03:44:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320084144.MQNN17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 03:41:44 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603192231k7843a741xbf14394bc5e4c57@mail.gmail.com>
	(Marco Costalba's message of "Mon, 20 Mar 2006 07:31:03 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17743>

"Marco Costalba" <mcostalba@gmail.com> writes:

>> This is totally untested, but maybe something like this?
>
> It works for me. Just some trailing white space warning when applying.

The change only removes the error message without changing any
other logic, so if that works for you, I wonder if leaving
things as they are is a better option than doing anything short
of implementing an AI that tries to pattern-match the "allegedly
corrupt file" with "sorry no such page found" in many natural
languages.

My test patch makes it impossible to track down the real
breakage when an HTTP-reachable repository _does_ have a corrupt
object.

So how about doing this instead?

-- >8 --
diff --git a/http-fetch.c b/http-fetch.c
index 8fd9de0..1405c1f 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -8,6 +8,7 @@
 #define RANGE_HEADER_SIZE 30
 
 static int got_alternates = -1;
+static int corrupt_object_found = 0;
 
 static struct curl_slist *no_pragma_header;
 
@@ -830,6 +831,7 @@ static int fetch_object(struct alt_base 
 				    obj_req->errorstr, obj_req->curl_result,
 				    obj_req->http_code, hex);
 	} else if (obj_req->zret != Z_STREAM_END) {
+		corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, obj_req->url);
 	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
 		ret = error("File %s has bad hash", hex);
@@ -989,5 +991,11 @@ int main(int argc, char **argv)
 
 	http_cleanup();
 
+	if (corrupt_object_found) {
+		fprintf(stderr,
+"Some loose object were found to be corrupt, but they might be just\n"
+"a false '404 Not Found' error message sent with incorrect HTTP\n"
+"status code.  Suggest running git fsck-objects.\n");
+	}
 	return rc;
 }
