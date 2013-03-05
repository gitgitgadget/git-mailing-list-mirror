From: Pete Wyckoff <pw@padd.com>
Subject: Re: [BUG] Incorrect/misleading error when `git rev-list --objects
 --all` hits the max open files limit
Date: Tue, 5 Mar 2013 10:26:25 -0500
Message-ID: <20130305152625.GA20562@padd.com>
References: <20130303232927.GA16606@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Rabbitson <rabbit@rabbit.us>
X-From: git-owner@vger.kernel.org Tue Mar 05 16:24:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCtjC-00028m-MC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 16:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881Ab3CEPYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 10:24:05 -0500
Received: from honk.padd.com ([74.3.171.149]:42821 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755580Ab3CEPYD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 10:24:03 -0500
Received: from tic.padd.com (unknown [216.240.30.5])
	by honk.padd.com (Postfix) with ESMTPSA id 666E7322B;
	Tue,  5 Mar 2013 07:24:02 -0800 (PST)
Received: by tic.padd.com (Postfix, from userid 1000)
	id E0FA0100F04; Tue,  5 Mar 2013 10:26:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130303232927.GA16606@rabbit.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217450>

rabbit@rabbit.us wrote on Mon, 04 Mar 2013 10:29 +1100:
> I was tinkering with a massive git repository (actually a bup 
> repository, but it is a standard valid git repo underneath). While 
> validating that a repack ran succesfully I executed the command:
> 
>  git rev-list --objects --all > rev.list
> 
> And got back this:
> 
> error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
> fatal: missing blob object '27a8cf44da85b958aef2b5074931e7913e08ae95'
> 
> Several hours later after successful fsck, and after chasing down trees 
> blobs etc, I realized that the problem is too many open files. The hint 
> came from ls-tree which lists the correct error (among a lot of spurious 
> junk):
> 
>  git ls-tree -r c636a5f51d4e > /dev/null
> 
>  error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
>  error: packfile ./objects/pack/pack-841e375f5e6c793a52fd1a3a2aea0b76219c4cdd.pack cannot be accessed
>  error: packfile ./objects/pack/pack-e67d9bf75e0840fc6113170b314d2d5a32cbb45a.pack cannot be accessed
>  error: packfile ./objects/pack/pack-b8fd8f083461c391fe6ec396840c328620d912e2.pack cannot be accessed
>  error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
>  error: packfile ./objects/pack/pack-804e0fadf56e2a165c157ef257620369adeea595.pack cannot be accessed
>  error: unable to open object pack directory: ./objects/pack: Too many open files
>  error: packfile ./objects/pack/pack-804e0fadf56e2a165c157ef257620369adeea595.pack cannot be accessed
>  error: Could not read 32a050cb7e54a1e817d135d25ab251480e8d9e3c
> 
> Failure to report the correct message verified with git 1.7.2.5 and 
> 1.8.2 (debian testing and experimental).
> 
> I hope this is sufficient description to address the underlying issue. I 
> will keep the un-repacked "many files" repo around just in case you need 
> more info/testing (though lowering the ulimit works equally well on 
> normal-size repos).

I've run into this twice:

    1.  user with restrictive ulimit on #files.
    2.  forgot to do "git gc" after regular fast-imports

Here's one thread:

    http://thread.gmane.org/gmane.comp.version-control.git/179231/focus=179292

I've got a patch in cold storage.  It's not beautiful because
there are too many paths that can end up hitting EMFILE.  I'll
dust it off and see if it is worth considering.

		-- Pete
