From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Mon, 14 Nov 2011 10:07:42 +0100
Message-ID: <1321261662.2941.13.camel@mastroc3.mobc3.local>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>
	 <1318592153.2938.21.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 10:05:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPsUC-0007IX-H3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 10:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab1KNJFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 04:05:47 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44363 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab1KNJFq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 04:05:46 -0500
Received: by wwe5 with SMTP id 5so4070182wwe.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :x-mailer:content-transfer-encoding:mime-version;
        bh=DD0/wJCzilTgjhGpeSwbchl5/QTCoisF6L36QhMCXvY=;
        b=Ioo0DTlF9+2sWJb8Ms9FuP9vF7OyfCmxtwN9Dme/ra95RTwYCTvrYyssb/DglFRnlh
         VhWptjx28bbVMzTFzun74euntPFa506qd2z+XCxQ85/k+BmV7nPf5gkm1cbvEqwvJjJf
         2gq29tfJnOEVCQsfEX7bXcKAExZn1OokDIafw=
Received: by 10.181.13.82 with SMTP id ew18mr24266473wid.16.1321261544742;
        Mon, 14 Nov 2011 01:05:44 -0800 (PST)
Received: from [192.168.88.55] (2-229-9-18.ip194.fastwebnet.it. [2.229.9.18])
        by mx.google.com with ESMTPS id db1sm11849691wib.19.2011.11.14.01.05.42
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 01:05:42 -0800 (PST)
In-Reply-To: <1318592153.2938.21.camel@mastroc3.mobc3.local>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185371>

On Fri, 2011-10-14 at 13:35 +0200, Daniele Segato wrote:
> On Fri, 2011-10-14 at 13:31 +0200, Daniele Segato wrote:
> > Hi all,
> > 
> > 
> > following from a discussion in IRC freenode #git between me, sitaram an
> > shruggar
> > 
> > 
> > step to reproduce:
> > 
> > $ mkdir /tmp/gitbug
> > $ cd /tmp/gitbug/
> > 
> > $ # create a fake remote repo
> > $ git init --bare remote.git
> > 
> > $ # clone it with the user that will generate the bug
> > $ git clone remote.git buggenerator
> > $ cd buggenerator/
> > $ touch whatever
> > $ git add .
> > $ git commit -m "first commit"
> > $ git push origin master 
> > 
> > $ # now clone the same repo the other guy is the "victim" of this issue
> > $ cd ..
> > $ git clone remote.git victim
> > 
> > $ # time to create the remote HEAD branch
> > $ cd buggenerator/
> > $ git push origin HEAD:HEAD
> > 
> > $ # the remote refs has been created!
> > $ git ls-remote
> > 
> > $ # another commit
> > $ echo 'any change' >> whatever 
> > $ git commit -a -m "some change"
> > $ git push origin master 
> > 
> > $ # the refs/heads/HEAD is still where it was
> > $ git ls-remote
> > 
> > $ # now from the victim perspective
> > $ cd ../victim/
> > 
> > $ # every time executing a fetch he will get a force update
> > $ # or maybe even an error, seen it my real repo, don't know how
> > $ # to reproduce
> > $ git fetch 
> > $ git fetch 
> > $ git ls-remote
> > $ git fetch 
> > $ git ls-remote
> > $ git branch -a
> 
> This should also help understanding what happen in the "victim" local
> repo at every fetch:
> 
> mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
> * master                11d0a12 [behind 1] first commit
>   remotes/origin/HEAD   -> origin/master
>   remotes/origin/master 77852ef some change
> mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
> From /tmp/gitbug/remote
>  + 77852ef...11d0a12 HEAD       -> origin/HEAD  (forced update)
> mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
> * master                11d0a12 first commit
>   remotes/origin/HEAD   -> origin/master
>   remotes/origin/master 11d0a12 first commit


Hi again,

I'm aware my request has been ignored for a good reason but I would
appreciate someone stepping in and explaining to me why this is not a
bug or why it has been ignored.

Thanks.

Regards,
Daniele Segato
