From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] remote-ext: do not segfault for blank lines
Date: Sat, 15 Jan 2011 21:49:40 -0600
Message-ID: <20110116034940.GA29072@burratino>
References: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286901583-30088-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 16 04:50:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeJdk-0006Vd-Ny
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 04:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1APDtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 22:49:55 -0500
Received: from mail-yi0-f67.google.com ([209.85.218.67]:58038 "EHLO
	mail-yi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab1APDty (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 22:49:54 -0500
Received: by yib18 with SMTP id 18so1672434yib.2
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 19:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7KZvVcHaw1fyDy9ue6bLHuNIgLl7AAQvJ2YBi77TXZE=;
        b=DlxqoIHpaqX0iHDj4UfaX0+Bk180/Y84HaIgW5LOGUj/avHhEsINp0DLw/DEuOsZeK
         iJjKIuoMuowuvhi4OIs24k63FN8xXVZiYGTHiVB4SahS1eTy7rPa1Q00uP95nFfddpTL
         PZGX9gSmmcp0po3447xtujElEeAnEm+ay6EPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xVjVq0y581qmlvREho0HYQiLJScFwlZ6Y3nOZ/db+Pa9dZVPedyOAj4yWEJRFRoUZy
         +uElsd41wLZ2iXkocFNnobI+KVX9WxD5ByZMQd3uw3GhIkpQZaSn1BHjpzv4pC45qqCo
         +/VCJTLNao74KgKaMJHimhHmfopwsxfjFafPw=
Received: by 10.150.54.18 with SMTP id c18mr2859222yba.357.1295149794079;
        Sat, 15 Jan 2011 19:49:54 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id m49sm1878120yha.2.2011.01.15.19.49.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 19:49:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1286901583-30088-4-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165159>

Instead of stripping space characters past the beginning of the
line and overflowing a buffer, stop at the beginning of the line
(mimicking the corresponding fix in remote-fd).

The argument to isspace does not need to be cast explicitly because
git isspace takes care of that already.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/remote-ext.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 1f77317..ea71977 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -212,16 +212,16 @@ static int command_loop(const char *child)
 	char buffer[MAXCOMMAND];
 
 	while (1) {
-		size_t length;
+		size_t i;
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
 				die("Comammand input error");
 			exit(0);
 		}
 		/* Strip end of line characters. */
-		length = strlen(buffer);
-		while (isspace((unsigned char)buffer[length - 1]))
-			buffer[--length] = 0;
+		i = strlen(buffer);
+		while (i > 0 && isspace(buffer[i - 1]))
+			buffer[--i] = 0;
 
 		if (!strcmp(buffer, "capabilities")) {
 			printf("*connect\n\n");
-- 
1.7.4.rc2
