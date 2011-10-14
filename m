From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Fri, 14 Oct 2011 13:35:53 +0200
Message-ID: <1318592153.2938.21.camel@mastroc3.mobc3.local>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 13:34:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REg29-0000Ff-1y
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 13:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab1JNLec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 07:34:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33937 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab1JNLec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 07:34:32 -0400
Received: by wwf22 with SMTP id 22so3314457wwf.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 04:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :x-mailer:content-transfer-encoding:mime-version;
        bh=7F984GFak4fvXN8pDJWhCPJMEAioR3tmNZMBz17ZU/4=;
        b=OyQUbFOIazHwiIJUJX/m4P7Nrjy2y/q6vbIsFXNV+t5kYoZE5vYjyoNWE3Tptp2Xcd
         hZRSRBK146VJ9mMnQ2kEYs3XNdn2HyRkJxVjI3WSdJzbLnIIx3ggZuvuCaMH86NFQdwI
         e7x72zJcBfa464YfJoUrJEZtsgW5tFukDU3Us=
Received: by 10.227.7.155 with SMTP id d27mr2761325wbd.114.1318592070707;
        Fri, 14 Oct 2011 04:34:30 -0700 (PDT)
Received: from [192.168.1.69] (host182-72-dynamic.4-87-r.retail.telecomitalia.it. [87.4.72.182])
        by mx.google.com with ESMTPS id h39sm13711017wbo.0.2011.10.14.04.34.27
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 04:34:28 -0700 (PDT)
In-Reply-To: <1318591877.2938.20.camel@mastroc3.mobc3.local>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183564>

On Fri, 2011-10-14 at 13:31 +0200, Daniele Segato wrote:
> Hi all,
> 
> 
> following from a discussion in IRC freenode #git between me, sitaram an
> shruggar
> 
> 
> step to reproduce:
> 
> $ mkdir /tmp/gitbug
> $ cd /tmp/gitbug/
> 
> $ # create a fake remote repo
> $ git init --bare remote.git
> 
> $ # clone it with the user that will generate the bug
> $ git clone remote.git buggenerator
> $ cd buggenerator/
> $ touch whatever
> $ git add .
> $ git commit -m "first commit"
> $ git push origin master 
> 
> $ # now clone the same repo the other guy is the "victim" of this issue
> $ cd ..
> $ git clone remote.git victim
> 
> $ # time to create the remote HEAD branch
> $ cd buggenerator/
> $ git push origin HEAD:HEAD
> 
> $ # the remote refs has been created!
> $ git ls-remote
> 
> $ # another commit
> $ echo 'any change' >> whatever 
> $ git commit -a -m "some change"
> $ git push origin master 
> 
> $ # the refs/heads/HEAD is still where it was
> $ git ls-remote
> 
> $ # now from the victim perspective
> $ cd ../victim/
> 
> $ # every time executing a fetch he will get a force update
> $ # or maybe even an error, seen it my real repo, don't know how
> $ # to reproduce
> $ git fetch 
> $ git fetch 
> $ git ls-remote
> $ git fetch 
> $ git ls-remote
> $ git branch -a

This should also help understanding what happen in the "victim" local
repo at every fetch:

mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
* master                11d0a12 [behind 1] first commit
  remotes/origin/HEAD   -> origin/master
  remotes/origin/master 77852ef some change
mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
From /tmp/gitbug/remote
 + 77852ef...11d0a12 HEAD       -> origin/HEAD  (forced update)
mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
* master                11d0a12 first commit
  remotes/origin/HEAD   -> origin/master
  remotes/origin/master 11d0a12 first commit


regards,
Daniele
