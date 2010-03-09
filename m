From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 11:27:26 -0800
Message-ID: <20100309192726.GA12461@spearce.org>
References: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan Phillips <ryan@trolocsis.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 20:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np55c-00013H-8Q
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 20:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab0CIT1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 14:27:31 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57437 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0CIT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 14:27:30 -0500
Received: by gwb15 with SMTP id 15so3730766gwb.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 11:27:29 -0800 (PST)
Received: by 10.150.131.21 with SMTP id e21mr672049ybd.163.1268162848972;
        Tue, 09 Mar 2010 11:27:28 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm5836146iwn.8.2010.03.09.11.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 11:27:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141843>

Ryan Phillips <ryan@trolocsis.com> wrote:
> I'm trying to follow the git-http-backend man page on setting up
> authenticated pushes to my apache server. Pulls work fine, and fully
> authenticated pushes work fine. However, when I try and setup
> anonymous pulls and authenticated pushes the push fails.
> 
> I believe the culprit is this 403 error:
> 
> 192.168.1.1 - - [09/Mar/2010:09:01:43 -0800] "GET
> /git/test.git/info/refs?service=git-receive-pack HTTP/1.1" 403 - "-"
> "git/1.7.0.2.dirty"

Ugh.  Looks like I didn't design this thing right.

The backend wants you to be authenticated before it will service
the git-receive-pack advertisement.  Even though its the same
data as the git-upload-pack advertisement (but slightly different
capability strings).

Maybe we should consider doing something like this patch so that
the advertisement under info/refs?service=git-receive-pack can be
sent without needing authentication.  My only hesitation is this
makes it harder for the client to setup the authentication before
it needs to transmit the pack file, which may mean it needs to send
the pack twice.


diff --git a/http-backend.c b/http-backend.c
index 345c12b..462b07c 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -312,11 +312,6 @@ static struct rpc_service *select_service(const char *name)
 
 	if (!svc)
 		forbidden("Unsupported service: '%s'", name);
-
-	if (svc->enabled < 0) {
-		const char *user = getenv("REMOTE_USER");
-		svc->enabled = (user && *user) ? 1 : 0;
-	}
 	if (!svc->enabled)
 		forbidden("Service not enabled: '%s'", svc->name);
 	return svc;
@@ -519,6 +514,12 @@ static void service_rpc(char *service_name)
 	struct rpc_service *svc = select_service(service_name);
 	struct strbuf buf = STRBUF_INIT;
 
+	if (svc->enabled < 0) {
+		const char *user = getenv("REMOTE_USER");
+		if (!user || !*user)
+			forbidden("Service not enabled: '%s'", svc->name);
+	}
+
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
 	check_content_type(buf.buf);
 
-- 
Shawn.
