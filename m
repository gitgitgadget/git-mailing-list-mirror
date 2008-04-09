From: Roman Shaposhnik <rvs@sun.com>
Subject: Intricacies of submodules [was: Migrating svn to git with heavy	use of
 externals]
Date: Wed, 09 Apr 2008 12:57:34 -0700
Message-ID: <1207771054.13123.228.camel@work.sfbay.sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 21:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjgK1-000058-TI
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 21:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbYDITuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 15:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbYDITuU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 15:50:20 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:45756 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008AbYDITuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 15:50:20 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m39JoJM5017065
	for <git@vger.kernel.org>; Wed, 9 Apr 2008 12:50:19 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZ200401PFDBO00@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Wed, 09 Apr 2008 12:50:19 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZ200E5QPRS5V90@fe-sfbay-10.sun.com>; Wed,
 09 Apr 2008 12:50:16 -0700 (PDT)
In-reply-to: <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79126>

On Wed, 2008-04-09 at 02:34 -0400, Avery Pennarun wrote:
> On Wed, Apr 9, 2008 at 12:39 AM, Roman Shaposhnik <rvs@sun.com> wrote:
> > > In my own use case, I think having all the objects from the
> > > supermodule *and* submodules all be in the same repo is what I want.
> > > This kind of obviates the need for .gitmodules entirely, if
> > > git-checkout and friends will do the right thing.  I think I'll submit
> > > some patches eventually once I have this figured out properly.
> >
> >  Hm. But what about those who might want to pull from you? .git/config
> >  doesn't propagate, which means that they'll be kind of stuck, don't
> >  you think?
> 
> Not exactly.  The idea is that if the supermodule and submodules are
> all lumped into a single repo (and your refs are set up correctly),
> then cloning the supermodule will also clone all the submodules.  

Interesting! How do you make it happen? Do you use git hooks or
something? On my end, I can't really reproduce that behavior of clone
but I would very much like to:
  $ alias mkrepo="git init; touch file; git add file; git commit -mInit"
  $ mkdir super ; cd super
  $ mkrepo
  $ mkdir submodule ; cd submodule
  $ mkrepo
  $ cd ..
  $ git submodule add submodule
  Adding existing repo at 'submodule' to the index
  $ git commit -mSubmodule
  Created commit 5921c87: Submodule
     2 files changed, 4 insertions(+), 0 deletions(-) 
     create mode 100644 .gitmodules
     create mode 160000 submodule

Now, when I clone super I don't actually have submodule cloned:
   $ git clone super super-clone
   $ cd  super-clone
   $ git submodule status
   -7482d0433ed681aa243629f13cd97ca5be242393 submodule

In fact, it seems that I can't even do "submodule update", which
seems like a bug to me, by the way:
    $ git submodule init  
    Submodule 'submodule' (submodule) registered for path 'submodule'

    $ git submodule update
    Initialized empty Git repository in /tmp/TEST/super-clone/submodule/.git/
    fatal: no matching remote head
    fetch-pack from 'submodule' failed.
    Clone of 'submodule' into submodule path 'submodule' failed

Any ideas on what's going on here? Or what am I doing wrong?

> So everyone will have all the necessary refs anyway; as long as
> git-checkout checks them out, .gitmodules shouldn't have to exist at
> all, becaues there's nothing "special" for git-submodule to do.

I would very much like to have that, yes. Please do provide additional
details on how's your setup is different from mine.

Thanks,
Roman.
