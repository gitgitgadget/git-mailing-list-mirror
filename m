From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Thu, 16 Jun 2011 17:24:54 -0500
Organization: Exigence
Message-ID: <20110616172454.13ff1a18@sh9>
References: <4DEB495F.9080900@kdbg.org>
	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>
	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>
	<4DF64932.1090607@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Fri Jun 17 00:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKzs-0005EU-7e
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab1FPWZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 18:25:01 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38878 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628Ab1FPWZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 18:25:00 -0400
Received: by ywe9 with SMTP id 9so1008622ywe.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=kF8q704WAuXJ0myjadsn3qELwkw/wldGc0hE2Z+evOg=;
        b=bjHIlYsqRvzcRbyKwa5s8M4Cg2XXxGB+DUmDru9VQdm0qgQmIKWShqdq8KoEOlLOij
         2oQSDTKI1+8kgJPsPHZEEQPzOIRDS+hmGM2hM1NAp29ZGnunB0zqCFff/fBOKtkpXkqE
         gK1gfQachPWpVEIdWG82twjmyUZok5FwSYof8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=TGvmLY3ZL9umws7I5RlGt0HQLocn/dwiRbjfR73b1NcfoXQ7dltEslezhX8x7xvZwg
         HLne6yVf89dV8Og7ZpACI4xZVJuVGl3sW4i9zNQqis2sj2375Ru9YfSx5PrqgHnkGfJy
         lQaLmEXM7oH1z1dakO5qhw7rcSiLvFJWbw+Zg=
Received: by 10.146.98.3 with SMTP id v3mr1649513yab.36.1308263099425;
        Thu, 16 Jun 2011 15:24:59 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net [184.187.11.226])
        by mx.google.com with ESMTPS id e24sm1276591yhk.79.2011.06.16.15.24.55
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 15:24:57 -0700 (PDT)
In-Reply-To: <4DF64932.1090607@sohovfx.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175940>

Hey,

> Ever since Jeff brought up this issue, I've been wondering what
> issue/workflow is that patch trying to fix.

I'm fairly sure the case the patch was fixing is t3411's "squash F1 into
D1".

Where, starting with a tree like:

# A1 - B1 - D1 - E1 - F1
#       \        /
#        -- C1 --

The user is on F1 and issues: "git rebase -i -p B1", the todo list
is "D1, E1, F1" (no C1), and they choose "D1 squash F1, E1",
the resulting tree should be:

# A1 - B1 - D2 - E2
#       \        /
#        -- C1 --

And, the fix was that C1 should not be in the todo list.

Perhaps that is unreasonable with whatever you guys are looking at now,
but, IIRC, the use case was that B1=some old commit, like a 2.0
release, and a bunch of work happened on the C1 branch, it was merged
in E1, but now when you want to rebase D1/E1/F1 on top of B1, you don't
want all of the noise of the C1 commit(s), since when rewriting E1 into
E2, you can just reuse the un-rewritten C1 as its 2nd parent.

Well, and not just the noise--since the todo is still flat, if C1
was listed in the todo, there's no way to recreate E2 as a merge and
maintain the C1 commit(s) as a separate branch. I think C1 would get
flattened between D2/E2, depending on where it was in the todo. You'd
lose a merge, contrary to the -p flag. That sounds like the core issue
that was being fixed.

The patch in question:

http://article.gmane.org/gmane.comp.version-control.git/98251

Did actually have a test (t3411) but it was still failing until
the following commit:

http://article.gmane.org/gmane.comp.version-control.git/98253

Where the test changed from expect failure to expect success. I
remember that looking odd at the time, but for some reason liked the
commits being separate.

- Stephen
