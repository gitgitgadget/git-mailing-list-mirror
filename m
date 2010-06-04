From: Simo Melenius <simo.melenius@iki.fi>
Subject: [PATCH 2/2] branch: don't fail listing branches if one of the commits wasn't found
Date: Fri,  4 Jun 2010 12:50:11 +0300
Message-ID: <1275645011-28795-2-git-send-email-simo.melenius@iki.fi>
References: <AANLkTilGOtScr7AyF_Dsm5ItTm2QBv_aPdBXRUDH29Ad@mail.gmail.com>
Cc: git@vger.kernel.org, Simo Melenius <simo.melenius@iki.fi>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 04 11:51:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKTYg-0001EJ-6k
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 11:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab0FDJvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 05:51:17 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59811 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0FDJvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 05:51:17 -0400
Received: by pwi3 with SMTP id 3so74096pwi.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=sFcuOq0MCy15nhAZCHjySDqWj0lTEkmwETKkIHmnodI=;
        b=oJDA2Ht1TCmz1hjgipRjF7fbMw+OLL39s6ReEgyxrT4ifTzvURHyYLGUu+khVBG+gj
         IUXJ2fz1580VVldFcyHktdCUfz1RHyik/02TdJgmL8+TwhQUEU45/xt2fMEkq27IYXSy
         GyHe5GfavBrnEv2XnKpEnPauoZslxsUkJ6r5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Cw0YEmv+2vL0ZFRkkIVxfuUHmiM43SD7CV9852llhfHmWKrTzcrStB7oLG+XH5CVGf
         T9uEykjamzvfiLXCQfYZwAcMZq8vnCm4aWC6FwMIdO998T/W4Ou1lyjeIP+i2qKIq0dN
         SXtRPGmDpJh9OEqEkNCG46UcYJ8RIenn7IOnM=
Received: by 10.115.65.14 with SMTP id s14mr8264055wak.209.1275645039662;
        Fri, 04 Jun 2010 02:50:39 -0700 (PDT)
Received: from localhost.localdomain (xdsl-83-150-84-41.nebulazone.fi [83.150.84.41])
        by mx.google.com with ESMTPS id b6sm7290819wam.9.2010.06.04.02.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 02:50:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <AANLkTilGOtScr7AyF_Dsm5ItTm2QBv_aPdBXRUDH29Ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148395>

When listing branches with ref lookups, if one of the known raw refs
doesn't point to a commit then "git branch" would return error(),
terminating the whole for_each_rawref() iteration and possibly hiding
any remaining refs.

Signed-off-by: Simo Melenius <simo.melenius@iki.fi>
---
 builtin/branch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 72a486c..2371ca0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -301,7 +301,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		commit = lookup_commit_reference_gently(sha1, 1);
 		if (!commit) {
 			cb->ret = error("branch '%s' does not point at a commit", refname);
-			return cb->ret;
+			return 0;
 		}
 
 		/* Filter with with_commit if specified */
@@ -539,6 +539,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 
 	free_ref_list(&ref_list);
 
+	if (cb.ret)
+		error("some refs could not be read");
+
 	return cb.ret;
 }
 
-- 
1.7.0.4
