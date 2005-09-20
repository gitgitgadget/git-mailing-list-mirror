From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: slow "stg push" on NFS
Date: Tue, 20 Sep 2005 08:24:13 +0100
Message-ID: <1127201053.7019.13.camel@localhost.localdomain>
References: <432F0AFA.3050401@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 09:26:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHcUF-0001DL-PO
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 09:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbVITHYR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 03:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVITHYR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 03:24:17 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:2466 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932754AbVITHYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 03:24:16 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050920072415.BPHD9239.mta09-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Tue, 20 Sep 2005 08:24:15 +0100
Received: from cpc4-cmbg5-3-0-cust164.cmbg.cable.ntl.com ([82.20.209.164])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050920072415.PMJB1770.aamta11-winn.ispmail.ntl.com@cpc4-cmbg5-3-0-cust164.cmbg.cable.ntl.com>;
          Tue, 20 Sep 2005 08:24:15 +0100
To: cel@citi.umich.edu
In-Reply-To: <432F0AFA.3050401@citi.umich.edu>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8986>

On Mon, 2005-09-19 at 15:01 -0400, Chuck Lever wrote:
> thanks to the several recent patches that add fast-forward support, CPU 
> utilization seems to no longer be a problem in general.

That's a good improvement but this doesn't work when the base of the
stack is changed.

> what appears to 
> be happening is that each push operation deletes and recreates 
> everything in the working directory.

The push operation only does a 'git-read-tree -u -m' which updates the
filesystem. I haven't looked at the git-read-tree code but I suspect it
only updates the files modified as a result of the merge operation. As
Blaisorblade reported, if there are big changes between the new HEAD and
the old bottom of the patch, like file removals and additions, it will
indeed take more time since git-read-tree cannot deal with them and
gitmergeonefile.py will be invoked for each file.

> for shared file systems, creating and deleting files will always be 
> synchronous.  anything we can do to eliminate the need for deleting and 
> recreating files that are not changed by a commit would be great.

I did some profiling with pushing 15 patches with 'git-read-tree
-m' (without -u for updating the working directory) over NFS and only
updating the working files after pushing all the patches. It didn't make
much difference and decided that it is not worth fully implementing it.
That's mainly because my patches were relatively small (few files
changed) and the base of the stack was already checked out, hence just
the patch files were being updated in the working directory.

> (i've also noticed that an "stg pop / stg push" sequence causes 'make' 
> to rebuild everything -- possibly due to the same reason?)

The same as 'git checkout branch'. I haven't checked whether the
modification time is preserved.

-- 
Catalin
