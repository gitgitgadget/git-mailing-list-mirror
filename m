From: Amos King <amos.l.king@gmail.com>
Subject: [PATCH 2/2] Created a faux remote to pass to http_init. This allows 
	http_push to authenticate http through a prompt.
Date: Wed, 18 Mar 2009 18:46:41 -0500
Message-ID: <d8c371a80903181646o6caf5948o25d2037486629c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 00:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk5UY-0005mD-Hi
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 00:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbZCRXqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755555AbZCRXqo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 19:46:44 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:54258 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbZCRXqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 19:46:43 -0400
Received: by qyk16 with SMTP id 16so402926qyk.33
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=TzWI9YdZw2AQUuPw28h1/idy0lxE/JeZQfT60BQJKlw=;
        b=N5hmpXOEGRAOAZ6WfZiQxQdryYN5Z0Ke89b0oJSXo6S8XxRKdbwPp5Ece3VxfvMjVd
         rLHFRSmEjs9C662vdUpEO2KxD1ncmFamV3rT4lFhakUuXA0GumNShN7efOvsgtkUvPtx
         jpvlDHbxa0F6eeuOPM1WWVaG/f2IpNfMV0oZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=r2vVFlRfXajoglkdFX+CNChvA9DDE9LDQTVJ/4/+Tx6iEN+8qcG5nLv9+qRA+Z+XfV
         j8hJ8/TXVv/FS0POw9tQRD0678xM5a5489psVuNSItkpRtllAZq0F7v1GR/xd6iVQ9di
         OBdGJZ2zoXvMl2w7qc8IFbrHcO1C8xOFESXxY=
Received: by 10.229.74.71 with SMTP id t7mr1233284qcj.47.1237420001538; Wed, 
	18 Mar 2009 16:46:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113706>

This patch allows http_push to use http authentication via prompts.
You may notice that there is a remote struct that only contains the
url from the repo struct.  This struct is a temporary fix for a larger
issue, but gets http authentication via prompts out the door, and
keeps users from having to store passwords in plain text files.

Signed-off-by: Amos King <amos.l.king@gmail.com>
---
 http-push.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9ac2664..885378b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2195,7 +2195,14 @@ int main(int argc, char **argv)

 	memset(remote_dir_exists, -1, 256);

-	http_init(NULL);
+	//This is a faked remote so that http_init can get the correct data for
+	//builidng out athorization.
+	struct remote *remote;
+	remote = xcalloc(sizeof(*remote), 1);
+	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
+	remote->url[remote->url_nr++] = repo->url;
+
+	http_init(remote);

 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");

-- 
1.6.2.GIT
