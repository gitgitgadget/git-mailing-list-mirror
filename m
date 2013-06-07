From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 7 Jun 2013 22:21:41 +0530
Message-ID: <CALkWK0m0QDGVUmHkmzC7G6it9fJafQCh8+423-NOyMwq9yts1Q@mail.gmail.com>
References: <20130607124146.GF28668@sociomantic.com> <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
 <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Leandro Lucarella <leandro.lucarella@sociomantic.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 18:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukztr-0001hg-D8
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 18:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab3FGQwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 12:52:23 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34505 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab3FGQwW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 12:52:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so11017317iec.19
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N65OxrErwds3p95J8wAtDxLrgzG2Tc81AEDxtYFEk7s=;
        b=ReUDR3pWcaAetP4S6Bay2aqG/K7BdscMHcJQWxVYPWesyGIPdXCDi7YYkzLWd3idW6
         VTlV+kTlGHL0/GAp8kkyatwelofBis62NLkZjdgwfqtjVHSnc6G2kc5+0AFm6MOPnbS0
         /FufhVU1Bi4xL1tMM43oTQwdznaRCq2tyvTe6R8tfrrD1QwUS8b1WDBuJDO1WzgE//i4
         2big7ER8AA4ca5o2FQp7y1DUiGeITnMOeieOy5L5S82KcR/ERCG6mYOzmyGSCuJLEI+f
         +Ckh1gzciKCtASliSZhsTKZtHxBg2UrsBcmEFeP5TMU12xeSVxR4fyamxND8osK7R0rP
         4CaA==
X-Received: by 10.50.107.6 with SMTP id gy6mr1814632igb.57.1370623942074; Fri,
 07 Jun 2013 09:52:22 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 09:51:41 -0700 (PDT)
In-Reply-To: <7v8v2lvs5s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226647>

Junio C Hamano wrote:
> This shows the "triangular" support in 1.8.3 is only half-finished;
> the other half was discussed a few weeks ago ($gmane/224604)

I intentionally omitted that detail, because it is not directly
related to this bug.  We have to fix the existing simple and upstream,
whether or not we introduce branch.<name>.push.  I've personally
stopped working on branch.<name>.push, and am focusing on getting @{p}
first (you've already seen a dirty wip).  The transport code
underlying the push is dirty enough, and I'd first like to understand
it before bolting on more features.

> I think the
> natural extension of the current end-user configuration would be to
> redefine "upstream" mode to push to update the branch with the same
> name

Right, so does this work?

diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..b253a64 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -137,11 +137,6 @@ static void setup_push_upstream(struct remote
 	if (branch->merge_nr != 1)
 		die(_("The current branch %s has multiple upstream branches, "
 		    "refusing to push."), branch->name);
-	if (strcmp(branch->remote_name, remote->name))
-		die(_("You are pushing to remote '%s', which is not the upstream of\n"
-		      "your current branch '%s', without telling me what to push\n"
-		      "to update which remote branch."),
-		    remote->name, branch->name);
 	if (simple && strcmp(branch->refname, branch->merge[0]->src))
 		die_push_simple(branch, remote);
