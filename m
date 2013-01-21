From: John Keeping <john@keeping.me.uk>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Mon, 21 Jan 2013 09:36:58 +0000
Message-ID: <20130121093658.GD7498@serenity.lan>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 10:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxDop-0004Ox-My
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 10:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab3AUJhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 04:37:07 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:52138 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab3AUJhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 04:37:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 40C20198025;
	Mon, 21 Jan 2013 09:37:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hY0lXC7+XomW; Mon, 21 Jan 2013 09:37:03 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id BB12A198023;
	Mon, 21 Jan 2013 09:37:03 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B8446161E551;
	Mon, 21 Jan 2013 09:37:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-4CXR2N-bIP; Mon, 21 Jan 2013 09:37:03 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C6985161E3EC;
	Mon, 21 Jan 2013 09:37:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130120232008.GA25001@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214108>

On Sun, Jan 20, 2013 at 06:20:08PM -0500, Eric S. Raymond wrote:
> John Keeping <john@keeping.me.uk>:
>> I don't think there is any way to solve this without giving cvsps more
>> information, probably the last commit time for all git branches, but
>> perhaps I'm missing a fast-import feature that can help solve this
>> problem.
> 
> Yes, you are.  The magic incantation is
> 
>     from refs/heads/<branch>^0
> 
> I've just pushed a cvsps-3.9 with an -i option that generates these at
> each branch root.  Combine it with -d and you get incremental
> fast-export.

I don't think this is enough.  I made a very similar change here for
testing (conditional on relative_date_start instead of a new flag) and I
needed this as well in order to prevent empty duplicate commits being
added:

-- >8 --

diff --git a/cvsps.c b/cvsps.c
index fb6a3ad..5771462 100644
--- a/cvsps.c
+++ b/cvsps.c
@@ -1560,7 +1560,7 @@ static bool visible(PatchSet * ps)
  ok:
     //fprintf(stderr, "Time check: %zd %zd %zd\n", restrict_date_start, restrict_date_end, ps->date);
     if (restrict_date_start > 0 &&
-	(ps->date < restrict_date_start ||
+	(ps->date <= restrict_date_start ||
 	 (restrict_date_end > 0 && ps->date > restrict_date_end)))
 	return false;
 
-- 8< --


But this is nothing more than a sticking plaster that happens to do
enough in this particular case - if the Git repository happened to be on
a different branch, the start date would be wrong and too many or too
few commits could be output.  Git doesn't detect that they commits are
identical to some that we already have because we're explicitly telling
it to make a new commit with the specified parent.

You can easily see the breakage by running the tests in the Git tree,
where the CVS revision map tests fail because they end up with duplicate
versions.

You'll need my cvsimport-3 branch to see these failures as it adds the
"git config" support that the tests rely on:

    git://github.com/johnkeeping/git.git cvsimport-3


John
