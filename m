From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 18 Mar 2012 09:36:24 -0700 (PDT)
Message-ID: <m3fwd550j3.fsf@localhost.localdomain>
References: <loom.20120318T083216-96@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 17:36:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9J5s-0008EY-GG
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 17:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab2CRQg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 12:36:27 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36946 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab2CRQg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 12:36:26 -0400
Received: by wibhj6 with SMTP id hj6so2875707wib.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        bh=yIkmxY+NNfBYjKV2C5EpDAAS2J8xcbspWTn5IZeU950=;
        b=M+Frr9KLbCNoTNrzAfk1USFf70IVfCiZa4+u61YjrzcCliFRTBRbFUJ93NRHQ1rgGR
         9TRDWy8UzvvnqJBkUaLOG5bzLI5BlBtSn2AiAvNuO2m+HdOihwk54pEfsxKRf9f6y52Z
         wTD6Tpkypo0rmuXLibdLmSdIlpNrMrJ5PyvV/DcyLAbj4/ZJ1MY1zHg6tzQeDvgjSrWI
         UpMEEcQQZGFOvb2NBgsTATiQNFl3zzCheohtwJGlvc52mt2UJEdJN2A10AtcggrTxH0K
         BKGsfWK6ccELfnkPU0F6zr+s1+6gujVZ7heVhbKFDukN/1bFY2wT6U3bD6LpWND5X6Ft
         stiw==
Received: by 10.180.95.1 with SMTP id dg1mr13292476wib.21.1332088585218;
        Sun, 18 Mar 2012 09:36:25 -0700 (PDT)
Received: from localhost.localdomain (abvx54.neoplus.adsl.tpnet.pl. [83.8.221.54])
        by mx.google.com with ESMTPS id gg2sm29004222wib.7.2012.03.18.09.36.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 09:36:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2IGaXUv021674;
	Sun, 18 Mar 2012 17:36:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2IGaWuO021670;
	Sun, 18 Mar 2012 17:36:32 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193385>

Ivan Todoroski <grnch_lists@gmx.net> writes:

> I recently tried cloning a fresh copy of a large repo (converted from CVS, 
> nearly 10 years of history) and to my surprise "git clone" failed with the 
> following message:
> 
>     error: cannot spawn git: No such file or directory
> 
> The problem is only reproduced using the Smart HTTP transport.

[...]
> I tracked down the problem to remote-curl.c:fetch_git(). That's where the 
> "fetch-pack" command line is being constructed with all the refs on one line:
> 
> git fetch-pack --stateless-rpc --lock-pack ...<all the refs>...
> 
> The solution is conceptually simple: if the list of refs results in a too long 
> command line, split the refs in batches and call fetch-pack multiple times such 
> that each call is under the cmdline limit:
> 
> git fetch-pack --stateless-rpc --lock-pack ...<first batch of refs>...
> git fetch-pack --stateless-rpc --lock-pack ...<second batch of refs>...
> ...
> git fetch-pack --stateless-rpc --lock-pack ...<last batch of refs>...

That, or implement --stdin / --revs in git-fetch-pach (perhaps
following git-pack-objects that implements --revs).

-- 
Jakub Narebski
