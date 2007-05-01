From: Andy Parkins <andyparkins@gmail.com>
Subject: svn:externals using git submodules
Date: Tue, 1 May 2007 11:21:14 +0100
Message-ID: <200705011121.17172.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 12:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HipUJ-0004QQ-Fk
	for gcvg-git@gmane.org; Tue, 01 May 2007 12:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161697AbXEAKV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 06:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161698AbXEAKV2
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 06:21:28 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:49467 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161697AbXEAKV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 06:21:26 -0400
Received: by mu-out-0910.google.com with SMTP id g7so225814muf
        for <git@vger.kernel.org>; Tue, 01 May 2007 03:21:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kr26+bsp7xe5weyy7umvjL00CL4WOws0z3ZoTzWcYIH8bmEmX0XqSArk1Ma7py5fT0R6XAfQJ//+W33Jjiz+DvVYD1j3Gqa/3Tt7uOJMMirYuwztvf/7ZIVaI2sBeA4Sl7TmidkyieLgy9m6JooLD6MaHP680fMRVFnSursOrFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SBJetWMp1RRueHYecvzBIJmAMZ+tPPMf3m14GZHBg0wA7KRMtgELVsgDRNMJFFkTEZn4Gh1f0TKzPgU2HPiYSHSR40iO+QGavaTdvoOcITbJ4gIl5i1ORhFl+BSnIgc9zvIUvkeQkmBQat35rvYTep0X7FhObA1/eILLmriUmQ0=
Received: by 10.82.120.14 with SMTP id s14mr13714581buc.1178014884513;
        Tue, 01 May 2007 03:21:24 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm3241268ika.2007.05.01.03.21.22;
        Tue, 01 May 2007 03:21:23 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45939>

Hello,

I've done this by hand as a proof of concept I suspect it would need loads of 
work in git-svn to do it properly.  However, I thought I'd mention as part of 
my "success with submodules" reports.

ffmpeg is managed with svn; I like to track its development with git-svn.  
Works wonderfully except for one problem: they've made use of svn:externals 
for one component, libswscale.  Previously I just regularly updated the 
libswscale subdirectory by checking out the latest copy (which is all that 
subversion does) and committing it to my own branch off upstream.

With submodule support in git, it makes it possible to do a much better job.  
What I did was have two svn-remote sections in the config:

[svn-remote "ffmpeg"]
    url = svn://svn.mplayerhq.hu/ffmpeg
    fetch = trunk:refs/remotes/ffmpeg-svn

[svn-remote "libswscale"]
    url = svn://svn.mplayerhq.hu/mplayer
    fetch = trunk/libswscale:refs/remotes/libswscale-svn

After running git-svn fetch; there are two independent branches in my 
repository:

  -- * -- * -- * -- * -- * (ffmpeg-svn)
  ---- * ----- * ------- * (libswscale-svn)  

Now, we fork from ffmpeg-svn and libswscale-svn to make non-tracking branches 
that can be committed to:

 $ git checkout -b master-ffm ffmpeg-svn
 $ git branch master-sws libswscale-svn

Next, we create a shared clone of the repository as a subdirectory in that 
repository.

 $ git clone -s . libswscale

Now we want that clone to be even more strongly linked to the parent - to the 
extent that they share the same refs, etc:

 $ cd libswscale
 $ rm -rf .git/refs .git/logs .git/info description config
 $ ln -s ../../.git/refs .git/refs
 $ ln -s ../../.git/logs .git/logs
 $ ln -s ../../.git/info .git/info
 $ ln -s ../../.git/config .git/config
 $ ln -s ../../.git/description .git/description

Only HEAD and index are independent.  Next we switch from the ffmpeg branch to 
the libswscale branch in this subdirectory:

 $ git checkout master-sws

Now, we make the subdirectory a submodule in the parent:

 $ cd ..
 $ git add libswscale
 $ git commit -m "libswscale is now a submodule"

How dangerous is this?  I've made the repository it's own submodule and it 
shares the same refs, info and logs.  LIVING ON THE EDGE MAN!

You have to run two git-svn commands to sync with upstream:

 $ git-svn fetch ffmpeg
 $ git-svn fetch libswscale

Then of course you would merge

 $ git merge ffmpeg-svn
 $ cd libswscale; git merge libswscale-svn; cd ..
 $ git commit -m "Sync with upstream"

Personally I think that's pretty cool, this is significantly better than 
svn:externals because the particular revision of libswscale in use is 
recorded.  Seriously - someone show me another VCS that can do that - I think 
git has actual magic powers :-)

I dare say that git-svn could do much better because it could reconstruct the 
submodule history based on the repository dates and create the link in the 
tracking branch rather than having to do it manually at the end as I've done 
here.  That would mean that the recorded submodule was right for all 
history - again, not the case for svn:externals, if you check out a previous 
version the external remains current.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
