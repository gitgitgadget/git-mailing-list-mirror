From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 16:44:57 +0100
Message-ID: <20141113154457.GA31624@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 16:45:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xowa3-0002YI-VA
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 16:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbaKMPpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 10:45:01 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:9700 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbaKMPpA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 10:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415893498; l=2155;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:To:From:Date;
	bh=ZTwk4FeqjxCS/xayOhJpyIeTZe4=;
	b=vWIzUJ9/9WenZlTfERUKVHPrTFMvOc1v3LcfFUOoLlacHF46x2N95MnCEPuzKPR2EPv
	MJ98pTClBKooghQ4Et/Gp8QheWtqEUjnZaWOJglRKsKPCNcJZtRn+KNRKt5qRRBdl/myZ
	ZXdLklTKw2p/4a9Jz3D/RVw4VjGzzhrZHUw=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id 6037d0qADFiwold
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Thu, 13 Nov 2014 16:44:58 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 1816A50172; Thu, 13 Nov 2014 16:44:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141113111444.GA15503@aepfle.de>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, Olaf Hering wrote:

> So how can I reduce the disk usage needed for the four .git dirs above?
> I looked around in the docs that came with my git-2.1.3 package, but
> found nothing that answers my question. Maybe we can workout something
> and add it to one of the existing docs.


While playing around with this I made some notes, this is the result:


Manage multiple branches as separate copies


To preserve disk space for each clone, use a master copy of the reop and do
local clones from such copy of a remote repository.

First clone the remote repository as usual. Then create a local branch for
each remote branch that is supposed to be worked on:
# git clone git://host/repo.git repo-master                                                                                                                                                                                                                            
# cd repo-master                                                                                                                                                                                                                                                       
# git checkout -b branchA origin/branchA                                                                                                                                                                                                                               
# git checkout -b branchB origin/branchB                                                                                                                                                                                                                               
# cd -                                                                                                                                                                                                                                                                 

Now clone each work branch into its own directory. The work dir references the
master repo. All changes come from and go into this repo, instead of the
remote repo.
# git clone -l -b branchA repo-master repo-branchA                                                                                                                                                                                                                     
# git clone -l -b branchB repo-master repo-branchB                                                                                                                                                                                                                     

To make changs in a work dir, commit as usual. The changes will be pushed from
the work copy into the local master repo. Its required to have some other
branch than branchA active in repo-master, or push from work copy to
repo-master will fail.
# cd repo-master
# git checkout master
# cd -
# cd repo-branchA
# git commit -avs
# git push origin branchA
# cd -

To publish the outstanding changes its required to do this from the master
repo. First checkout the work branch, then pull the local changes and finally
push them to the remote repo.
# cd repo-master
# git checkout branchA
# git pull
# git push origin branchA
# cd -

To receive changes from the remote repo its required to do this from the
master repo. First checkout the work branch, then pull the outstanding remote
changes into the local branch. And finally pull them into the work dir.
# cd repo-master
# git fetch --all (optional)
# git checkout branchB
# git pull
# cd -
# cd repo-branchB
# git pull
# cd -


# vim: set tw=72 et
