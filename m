From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make git svn --version work again
Date: Fri, 5 Mar 2010 03:13:17 -0800
Message-ID: <20100305111317.GB14650@dcvr.yhbt.net>
References: <fb196463677f8560aa490eaa137990ab2d5d6b86.1267698128.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Josh Robb <josh_robb@fastmail.fm>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 05 12:13:25 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnVTB-00040o-2b
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 12:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab0CELNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 06:13:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755258Ab0CELNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 06:13:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20861F4F1;
	Fri,  5 Mar 2010 11:13:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fb196463677f8560aa490eaa137990ab2d5d6b86.1267698128.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141576>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> by requesting SVN::Core which is needed for the svn version.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks Michael, pushed out to git://git.bogomips.org/git-svn along with the
crlf fixes by Erik.

> ---
> In fact, there are a few more places where seemingly a req_svn() is missing.
> But the call chains are very confusing. The one seemingly missing in prop_walk()
> would be covered by the recursive props test which succeeds, so the caller
> must have requested SVN::Core also. I believe this applies to the other places
> as well (but not to version()).
> 
> Is there any harm done by inserting a superfluous req_svn() in these cases for
> good measure?

There should be no harm anywhere SVN::* is needed, Perl won't attempt to
re-require something that's already required.

The primary benefactor of having an explicit req_svn() function is the
no-op case of rebase on certain setups:

commit d32fad2b89c81ca29128722e0e2f5985426e5e7a
Author: josh robb <josh_robb@fastmail.fm>
Date:   Wed Feb 24 16:13:50 2010 +1300

    git svn: delay importing SVN::Base until it is needed
    
    Importing functions from a .dll into Git for Windows' perl is pretty slow,
    so let's avoid importing if it is not necessary.
    
    This seems particularly slow in virtualized enviroments. Before this
    change (on my machine):
    
    $ time perl /libexec/git-core/git-svn rebase
    Current branch master is up to date.
    
    real 2m56.750s
    user 0m3.129s
    sys 2m39.232s
    
    Afterwards:
    
    $ time perl /libexec/git-core/git-svn rebase
    Current branch master is up to date.
    
    real 0m33.407s
    user 0m1.409s
    sys 0m23.054s
    
    git svn rebase -n goes from 3m7.046s to 0m10.312s.
    
    Signed-off-by: Josh Robb <josh_robb@fastmail.fm>
    Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
