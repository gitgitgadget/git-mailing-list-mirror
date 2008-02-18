From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: Fix error message for push <remote> :<branch>
Date: Mon, 18 Feb 2008 14:07:26 +0100
Message-ID: <20080218130726.GA26854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 14:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5jF-00079w-D3
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759601AbYBRNHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758869AbYBRNHa
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:07:30 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:36656 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758838AbYBRNH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:07:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1811330fkz.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        bh=qfgLSg7SThfk4cgReYlanhrYWFXpJeuJsj9u8YgKd9A=;
        b=N8Sr/O9VDDRFjCEiI9Jd55ryOgQFiOArXWw+X6JqdLfMsZbasiU/onmVvm87bkPaKpfkuxBEm0DMWwtxVIuLsTyGEb580ipkt/rIQ6y1P2IDnmsIivv8Pd+BIA9+58qVrCFVfFjKO8jybQS/jD/0e3gYh6T8fQt/eGVsW1xdJaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=be2VOmdub6gqb9W+KGkKnnWEVmGmG8djCYpYt6+zWh7MUInZ330Z8lJDJCCjZvSDnw1D5R3tuCexixJD1010/Q+JjoUx47p+zpt2XlwMUT6MnovFxBuZuFbFJTsNQlRkKOIfui+TKU5+r5NRGGB7Q4cdtPJUarlMyS1gJokjRlE=
Received: by 10.82.166.9 with SMTP id o9mr10072087bue.34.1203340047185;
        Mon, 18 Feb 2008 05:07:27 -0800 (PST)
Received: from darc.dyndns.org ( [62.47.56.178])
        by mx.google.com with ESMTPS id 4sm8398591fge.3.2008.02.18.05.07.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 05:07:24 -0800 (PST)
Received: from drizzd by darc.dyndns.org with local (Exim 4.68)
	(envelope-from <drizzd@aon.at>)
	id 1JR5iQ-00070c-S6
	for git@vger.kernel.org; Mon, 18 Feb 2008 14:07:26 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74279>

git http-push <remote> :<branch> currently fails with the error message
"cannot happen anymore". Print a more useful error message instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

We should actually support this feature, of course. Unfortunately, a lot has
changed since the version of send-pack which http-push is based on
(v1.2.4-398-gaa1dbc9). I think http-push should be updated to reflect these
changes at a larger scope. Is there any work going on in this direction?

 http-push.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index f9b77d6..8de091f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2311,6 +2311,15 @@ int main(int argc, char **argv)
 
 		if (!ref->peer_ref)
 			continue;
+
+		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
+			error("Deleting remote branches via :<branch> is not "
+				"currently supported by http-push. Use git "
+				"http-push -d <remote-url> <branch> instead.");
+			rc = -2;
+			continue;
+		}
+
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
-- 
1.5.4.2.183.g1ae81
