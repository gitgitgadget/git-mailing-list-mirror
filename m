From: Jakub Suder <jakub.suder@gmail.com>
Subject: Re: git-subtree.sh - regression introduced by da949cc55
Date: Sat, 13 Feb 2010 20:41:08 +0100
Message-ID: <508e1531002131141o32fdc555keb31a3d8b05d7109@mail.gmail.com>
References: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com>
	 <508e1531002110526u623bffbdi119d009a7af460b8@mail.gmail.com>
	 <32541b131002120952gcb5116as730fff8bdcf005c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Fournier <marc.fournier@camptocamp.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 20:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgNrh-0006Qc-SM
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 20:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789Ab0BMTlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 14:41:12 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:37195 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab0BMTlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 14:41:11 -0500
Received: by fxm27 with SMTP id 27so1282fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Wn+0yi48pK84MhQcMrrq95FyoQTynT1PoExaOZ8J64s=;
        b=x/sXW90wa1nuN/RJfBac+QqrljgFPwYaE3jsa460iiz+EMJsY48l9Ws+QLee2O8eMB
         nhox8JKm4Il47APYbTpSERPIb0Dl4X6jnj/zt2XbU9PwPzqeTn8Nj0EVChPH3G9dCvY+
         SyECZasLNpNDVQv7vrpgVArjAOMY0RqyB0O2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=D0srw6GuPESS0flpCrIDHh6XJdafMhzIK+ncSoR17rXX62u69McEopBzVNDwhFShiJ
         gG8wR/BtAbkQQNesHLyETjtp2hRXRcU8NaoyDFDLGwOhqtXlUJz4I11Xk85jhl2QtbTv
         lhdalpPWhFLbAbavjcWDi2MR+OKkTdiR+8VcE=
Received: by 10.103.84.32 with SMTP id m32mr2213317mul.69.1266090068920; Sat, 
	13 Feb 2010 11:41:08 -0800 (PST)
In-Reply-To: <32541b131002120952gcb5116as730fff8bdcf005c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139824>

On Fri, Feb 12, 2010 at 18:52, Avery Pennarun <apenwarr@gmail.com> wrote:
> Did you have a chance to look at this?

It's true, when you try to extract a subproject from an ordinary
directory of a project, using git subtree split, it builds the new
branch on top of some past commit, instead of as a completely separate
timeline, and it's exactly because of my change. The problem lies in
what you wrote in the comment above that fragment: "ugly.  is there no
better way to tell if this is a subtree vs. a mainline commit?  Does
it matter?" - well, apparently it does matter :) That line fixed my
problem, because commits in the subproject's timeline should have
cache set to themselves, but it the case when you start from the other
side (first subtree split, not first subtree add), in this fragment
the first commits from the mainline (which are unrelated to the
subdirectory) are regarded as subtree commits, because $tree is empty
(but not because the root directory is different, only because it just
didn't exist yet at this point).

We just need some different way of determining if this is a commit
from subtree timeline or the main timeline - I'll see if I can come up
with something...

JS
