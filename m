From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: push <remote> :<branch> deletes remote branch
Date: Mon, 18 Feb 2008 16:55:46 +0100
Message-ID: <20080218155546.GA8934@localhost>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 16:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8M0-0000Qn-TH
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 16:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbYBRPzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 10:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbYBRPzx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 10:55:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:47085 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYBRPzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 10:55:52 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1521091fga.17
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=Dvvlx+Cz0YcPSXoV3s00O0GztJ8VLuzyJ/1/cXfGGlM=;
        b=MrRSbkGQ0/0pGs41n/+ggkLALeDPmL6sfO0P521OUInz1ayn5vWTYrDWoDktmA2Xoox9KwnpBBAZzcfW1jZMkANl9PcSquHwGfv/jLB/EdwP5EqI061pcasjs4QZnZppRzNOyt1uerE351+T2p1bOZXs3elk+YM3zXskHJ2wyzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=c35eVtuhxcHTOhl+NZia8zZ2tTMapGRCOg/dnHDl6NlBUXI+DZxsh3LXx7flTbogvn9bPDzBSfJV3MWXc4X6IKL5eyPCd6lX6N/hwMjllovq0TEENXm58D7t9Ob2qsgv6HlDFlTEE9VpN/lxQr5YvEzxFUXxo/nOT+FZq2t7Vtg=
Received: by 10.86.62.3 with SMTP id k3mr6104435fga.8.1203350150190;
        Mon, 18 Feb 2008 07:55:50 -0800 (PST)
Received: from darc.dyndns.org ( [62.47.56.178])
        by mx.google.com with ESMTPS id d4sm8603662fga.2.2008.02.18.07.55.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 07:55:50 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JR8LK-0002Lj-QD; Mon, 18 Feb 2008 16:55:46 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802181339470.30505@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74304>

This mirrors current ssh/git push syntax.
---
On Mon, Feb 18, 2008 at 01:45:08PM +0000, Johannes Schindelin wrote:
> Besides, why don't you just try to imitate the code for "-d"?

I was hesitant to implement something that will only partially mirror the
behavior of git/ssh push. For example, git/ssh push will also update the
corresponding remote-tracking branches and give a status report
(new/deleted/updated/rejected etc.) at the end.

After playing with the code a little I feel more confident that the other
issues with http-push are unrelated to this patch and the differences between
git/ssh push and http-push are acceptable for now.

> So I think something like this should work, at the same place you added 
> your code:
> 
> 		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
> 			if (delete_remote_branch(ref->peer_ref->name,
> 					force_delete || ref->force) == -1) {
> 				error("Could not remove %s",
> 					ref->peer_ref->name);
> 				rc = -4;
> 			}
> 			continue;
> 		}

Indeed. According to the rules listed in builtin-send-pack.c:442, I changed
(force_delete || ref->force) to 1.

Clemens

 http-push.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9b77d6..e98c52f 100644
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
@@ -2311,6 +2313,17 @@ int main(int argc, char **argv)
 
 		if (!ref->peer_ref)
 			continue;
+
+		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
+			if (delete_remote_branch(ref->name, 1) == -1) {
+				error("Could not remove %s",
+					ref->peer_ref->name);
+				rc = -4;
+			}
+			new_refs++;
+			continue;
+		}
+
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
@@ -2342,11 +2355,6 @@ int main(int argc, char **argv)
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
