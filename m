From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] builtin-remote: make rm operation safer in mirrored repository
Date: Sun,  1 Feb 2009 10:48:29 -0500
Message-ID: <1233503309-40144-1-git-send-email-jaysoffian@gmail.com>
References: <76718490902010652w7a332550w5e0658a390c7dea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 16:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTea8-0005pC-Qk
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 16:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbZBAPsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 10:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZBAPsf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 10:48:35 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:26492 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbZBAPse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 10:48:34 -0500
Received: by yw-out-2324.google.com with SMTP id 9so419045ywe.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0q+YVJe+Xq0z+lDY9/qRgGUptdxhJV266Z1f8/mDaEY=;
        b=ROwDiww8QeF6PXnLzhRcRUC8suD+y4pWPKK0KkaIecWHTV3cKbUYXDp369LzSyBM4I
         P0Am43xBcXyD3ubExc0z/InV3gISEHxkwf25yuhbbbqFlp4knwqMg6yVRBfZ56TLKO0O
         n1XNcKJSPtEBy3Wt5F50/yDv53qED1i0W2NkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CEWxZNCgEgo7H4uIC0PQ1WpNHe0JnjfufaQUvirvkEK668zII22nvqggZtGJLK03mE
         B3/plgLynLyhp9h/65vmGgRacR2SkTUET6wbQlSt45F6uADdihQakp6q0C0d8dq8ygKj
         Livg/5FSViLSAAB9PfZcnaqHAVs8BwYJNOhPI=
Received: by 10.150.12.10 with SMTP id 10mr3465936ybl.233.1233503312978;
        Sun, 01 Feb 2009 07:48:32 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id i27sm6097598elf.14.2009.02.01.07.48.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 07:48:32 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
In-Reply-To: <76718490902010652w7a332550w5e0658a390c7dea9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107983>

"git remote rm <repo>" is happy to remove non-remote branches (and their
reflogs). This may be okay if the repository truely is a mirror, but if the
user had done "git remote add --mirror <repo>" by accident and was just
undoing their mistake, then they are left in a situation that is difficult to
recover from.

After this commit, "git remote rm" skips over non-remote branches and instead
advises the user on how to remove such branches using "git branch -d", which
itself has nice safety checks wrt to branch removal lacking from "git remote
rm".

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
On Sun, Feb 1, 2009 at 9:52 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Anyway, it would seem to me it should be harder to remove local refs.
> This one was somewhat painful to recover from. Not sure what better
> behavior would be: should it be harder to do "remote add --mirror" on
> a repository with content, should "remote rm" on mirrored repository
> require a --force switch with a stern warning first, or...?

Perhaps something like this?

 builtin-remote.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index abc8dd8..2629bc5 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -310,6 +310,13 @@ static int add_branch_for_removal(const char *refname,
 	struct string_list_item *item;
 	struct known_remote *kr;
 
+	/* don't delete non-remote branches */
+	if (prefixcmp(refname, "refs/remotes")) {
+		warning("not removing non-remote branch; use git branch -d %s to remove",
+			abbrev_branch(refname));
+		return 0;
+	}
+
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (remote_find_tracking(branches->remote, &refspec))
-- 
1.6.1.224.gb56c
