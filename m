From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: push <remote> :<branch> deletes remote branch
Date: Mon, 18 Feb 2008 17:44:23 +0100
Message-ID: <20080218164423.GA8832@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR970-0001br-Ne
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYBRQo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbYBRQo2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:44:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:63600 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYBRQo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:44:27 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1533667fga.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 08:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=CUmVzh/SRfGzBzheDvrFuHN2PBaluYMNa8JmzjXDhuY=;
        b=lvM7O+3F4IBOmPywv1dm89zJJP7iWhsQFmK6eGunMPEWi2+zX9p/21Mq8OwHj2p7f8jOyFVnoBrLn4pobe3ZHx+uaxaIMoOI4pb7acdnA0UnHrrNAuE81R0e8HFaQq/4HC6yR7GY1TAsDEAobdfs/S6fKp0+LZe12hheDvM6bGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=lV3Ird4C678mObLYaoiSRm/IWdhKL+llT7HM0Ueq3QG5wx6ajzu9t97JVHC06rMFwCOqwNygadchVMwbHIPHKunsgfmeadUhIqKmRXkuLWIhX26mlgGpH2yWhsFHtWEVtxMK7z6KK5bga5jEaabK9ltzVQUzUo70LJzJQnYNPSU=
Received: by 10.86.86.12 with SMTP id j12mr6145892fgb.33.1203353065101;
        Mon, 18 Feb 2008 08:44:25 -0800 (PST)
Received: from darc.dyndns.org ( [62.47.56.178])
        by mx.google.com with ESMTPS id l12sm8653955fgb.8.2008.02.18.08.44.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 08:44:24 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JR96N-0002ac-En; Mon, 18 Feb 2008 17:44:23 +0100
Content-Disposition: inline
In-Reply-To: <20080218155546.GA8934@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74313>

This mirrors current ssh/git push syntax.
---

The previous patch gives the wrong branch name in the failure message.

Clemens

 http-push.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9b77d6..2c928fc 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2138,6 +2138,8 @@ static int delete_remote_branch(char *pattern, int force)
 
 	/* Send delete request */
 	fprintf(stderr, "Removing remote branch '%s'\n", remote_ref->name);
+	if (dry_run)
+		return 0;
 	url = xmalloc(strlen(remote->url) + strlen(remote_ref->name) + 1);
 	sprintf(url, "%s%s", remote->url, remote_ref->name);
 	slot = get_active_slot();
@@ -2311,6 +2313,16 @@ int main(int argc, char **argv)
 
 		if (!ref->peer_ref)
 			continue;
+
+		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
+			if (delete_remote_branch(ref->name, 1) == -1) {
+				error("Could not remove %s", ref->name);
+				rc = -4;
+			}
+			new_refs++;
+			continue;
+		}
+
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
@@ -2342,11 +2354,6 @@ int main(int argc, char **argv)
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (is_zero_sha1(ref->new_sha1)) {
-			error("cannot happen anymore");
-			rc = -3;
-			continue;
-		}
 		new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
-- 
1.5.4.2.183.g69d3
