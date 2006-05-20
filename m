From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Remove possible segfault in http-fetch.
Date: Sat, 20 May 2006 18:46:33 -0400
Message-ID: <BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE>
References: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 00:52:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhaJS-0006IK-EP
	for gcvg-git@gmane.org; Sun, 21 May 2006 00:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWETWwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWETWwY
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 18:52:24 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:33892 "EHLO
	BAYC1-PASMTP08.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932219AbWETWwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 18:52:23 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP08.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 20 May 2006 15:57:12 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6DCAE644C28;
	Sat, 20 May 2006 18:52:21 -0400 (EDT)
To: Florian Weimer <fw@deneb.enyo.de>
Message-Id: <20060520184633.76b438cc.seanlkml@sympatico.ca>
In-Reply-To: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 20 May 2006 22:57:12.0515 (UTC) FILETIME=[BB25A930:01C67C60]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Free the curl string lists after running http_cleanup to
avoid an occasional segfault in the curl library.  Seems
to only occur if the website returns a 405 error.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---

On Sat, 20 May 2006 20:47:54 +0200
Florian Weimer <fw@deneb.enyo.de> wrote:

> Is anybody else seeing segfaults on dumb HTTP pull with
> USE_CURL_MULTI?  For example, this crashes for me:
> 
> $ git clone http://git.enyo.de/fw/debian/debfoster.git upstream
> 
> GDB shows that this happens inside the call to curl_multi_perform.
> 

Florian, could you please test this patch.

It comes with a big disclaimer because I don't really know the
code in here all that well.  However gdb reports the segfault
happens in a strncasecmp call, and seeing as we've released a
bunch of strings prior to the call....

Testing seems to confirm that the segfault is removed by this patch.

As to why the website returns a 405 error in the first place is still
a mystery to me.

Sean


 http-fetch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-fetch.c b/http-fetch.c
index 861644b..178f1ee 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1269,10 +1269,10 @@ int main(int argc, char **argv)
 	if (pull(commit_id))
 		rc = 1;
 
-	curl_slist_free_all(no_pragma_header);
-
 	http_cleanup();
 
+	curl_slist_free_all(no_pragma_header);
+
 	if (corrupt_object_found) {
 		fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
-- 
1.3.GIT
