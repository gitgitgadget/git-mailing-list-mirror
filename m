From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Tue, 26 Mar 2013 19:20:11 +0000
Message-ID: <5151F4EB.80909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 20:22:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKZS6-0005Zs-Cy
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 20:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757525Ab3CZTWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 15:22:03 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:45344 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754105Ab3CZTWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 15:22:01 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 4E829384080;
	Tue, 26 Mar 2013 19:22:00 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 812F338407C;
	Tue, 26 Mar 2013 19:21:59 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 26 Mar 2013 19:21:58 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219189>


After commit cbfd5e1c ("drop some obsolete "x = x" compiler warning
hacks", 21-03-2013) removed a gcc specific hack, older versions of
gcc now issue an "'contents' might be used uninitialized" warning.
In order to suppress the warning, we simply initialize the variable
to NULL in it's declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

An alternative solution may look like this (note: *untested*):

    diff --git a/builtin/cat-file.c b/builtin/cat-file.c
    index ad29000..e50b20f 100644
    --- a/builtin/cat-file.c
    +++ b/builtin/cat-file.c
    @@ -193,7 +193,6 @@ static int batch_one_object(const char *obj_name, int print_contents)
     	unsigned char sha1[20];
     	enum object_type type = 0;
     	unsigned long size;
    -	void *contents;
     
     	if (!obj_name)
     	   return 1;
    @@ -204,16 +203,11 @@ static int batch_one_object(const char *obj_name, int print_contents)
     		return 0;
     	}
     
    -	if (print_contents == BATCH)
    -		contents = read_sha1_file(sha1, &type, &size);
    -	else
    -		type = sha1_object_info(sha1, &size);
    +	type = sha1_object_info(sha1, &size);
     
     	if (type <= 0) {
     		printf("%s missing\n", obj_name);
     		fflush(stdout);
    -		if (print_contents == BATCH)
    -			free(contents);
     		return 0;
     	}
     
    @@ -221,6 +215,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
     	fflush(stdout);
     
     	if (print_contents == BATCH) {
    +		void *contents = read_sha1_file(sha1, &type, &size);
     		write_or_die(1, contents, size);
     		printf("\n");
     		fflush(stdout);
    -- 

However, this would add an additional call to sha1_object_info() to
the "--batch" code path, with potential performance consequences
(again untested). Also, if you are paranoid, I guess you should
check that the (type,size) returned by sha1_object_info() was the
same as that returned by read_sha1_file(). ;-)

ATB,
Ramsay Jones

 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ad29000..40f87b4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,7 +193,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents;
+	void *contents = NULL;
 
 	if (!obj_name)
 	   return 1;
-- 
1.8.2
