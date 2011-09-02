From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rev-list --cherry-pick and context lines
Date: Fri, 02 Sep 2011 17:32:23 +0200
Message-ID: <4E60F707.40708@drmicha.warpmail.net>
References: <1k6yux4.x1kexb19bkrqpM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Fri Sep 02 17:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzVjM-0008D6-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 17:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab1IBPc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 11:32:26 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:38641 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752925Ab1IBPcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2011 11:32:25 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3CBD320992;
	Fri,  2 Sep 2011 11:32:25 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 02 Sep 2011 11:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Nx6D667UNYXTJ/TfKofMIn
	YTStg=; b=t5rMit56qC5/k6+gk2gJbEV7iFhfp23yT6c91IoCN/3yi2rF99jmBh
	KWalfj4kW8dGULAKyblkChgSTlx6WFmn/OZSf2w0ZhWO12BpYx6VHRLzEo7puWsF
	Bi8v6JUCOuAqou/V50KuSF8iLonLRHblZ2M/EYeHgaxvhTiPAdfXU=
X-Sasl-enc: vpzIY4rW2x3VqcOky90sq2ZDJDL71M+o7N2vstcCsmYO 1314977544
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B8A10AE14E4;
	Fri,  2 Sep 2011 11:32:24 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1k6yux4.x1kexb19bkrqpM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180615>

Stefan Haller venit, vidit, dixit 02.09.2011 12:35:
> Consider two commits on different branches, one with this patch:
> 
>     diff --git a/file.txt b/file.txt
>     index 704fa27..2f7e74c 100644
>     --- a/file.txt
>     +++ b/file.txt
>     @@ -1,3 +1,3 @@
>      old_context
>      
>     -foo
>     +bar
> 
> and the other with this patch:
> 
>     diff --git a/file.txt b/file.txt
>     index f35051b..8c7de32 100644
>     --- a/file.txt
>     +++ b/file.txt
>     @@ -1,3 +1,3 @@
>      new_context
>      
>     -foo
>     +bar
> 
> If I run "git rev-list --cherry-pick --left-right branch1...branch2", it
> reports both commits as being genuine commits on their respective
> branch, even though I consider their patches to be the same.
> 
> I guess for my purpose I would like to have patch-ids that ignore
> context (or that use only one line of context, I'm not sure which).
> 
> In fact, if I do "git show <commit> -U1 | git patch-id", both commits
> show the same id.
> 
> So, would it make sense to have a parameter for git-rev-list (and
> git-cherry) that lets you specify how much context to be used for the
> patch ids?

It would be a bit like the patch below. "git log" accepts diff options already.
But:

- Do we want the patch id generation and the patch display (-p) to use the
  same options?

- -U1 implies -p/--patch and there is no --no-patch.

- Which other diff options do we want to pass to the patch id
  generation: --histogram, --patience, ...?

Cheers,
Michael

----

diff --git i/diff.c w/diff.c
index fcc0078..4e82912 100644
--- i/diff.c
+++ w/diff.c
@@ -4103,7 +4103,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		}
 
 		xpp.flags = 0;
-		xecfg.ctxlen = 3;
+		xecfg.ctxlen = options->context;
 		xecfg.flags = 0;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
 			      &xpp, &xecfg);
diff --git i/revision.c w/revision.c
index 072ddac..5a98ed9 100644
--- i/revision.c
+++ w/revision.c
@@ -601,6 +601,7 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	left_first = left_count < right_count;
 	init_patch_ids(&ids);
 	ids.diffopts.pathspec = revs->diffopt.pathspec;
+	ids.diffopts.context = revs->diffopt.context;
 
 	/* Compute patch-ids for one side */
 	for (p = list; p; p = p->next) {
