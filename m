X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Default modules to load ...
Date: Tue, 24 Oct 2006 21:58:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610242145040.3962@g5.osdl.org>
References: <20061020140918.GA12400@suse.de> <45390142.7010808@sun.com>
 <20061024121754.GA11716@suse.de> <BAYC1-PASMTP013A64CB1BD217DE7EE26AAE010@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 25 Oct 2006 04:58:52 +0000 (UTC)
Cc: Matthias Hopf <mhopf@suse.de>,
	Alan Coopersmith <alan.coopersmith@sun.com>,
	xorg@lists.freedesktop.org, Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP013A64CB1BD217DE7EE26AAE010@CEZ.ICE>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30033>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcaqm-0003Zz-5r for gcvg-git@gmane.org; Wed, 25 Oct
 2006 06:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422988AbWJYE6p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 00:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWJYE6p
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 00:58:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33001 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1422988AbWJYE6o (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 00:58:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9P4wOPo010732
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 24
 Oct 2006 21:58:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9P4wHU6027855; Tue, 24 Oct
 2006 21:58:20 -0700
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org



On Tue, 24 Oct 2006, Sean wrote:
> 
> Add Linus to CC so maybe you'll get better answers than I can offer.

The git list is probably even better.. Added to the Cc:

> > Hm. And why don't I find this in my regularly cloned and updated git
> > repository? I just noted that I wouldn't find this commit after a
> > 'git-pull', but it would after a 'git-pull -t'.
> 
> "Git-pull -t" pulls down all remote tags (regardless of which branch
> they're on) and then grabs all the commits they point to.  But it
> won't actually pull down the full branch references.  Typically,
> you don't ever need to use "-t".

Correct. 

Normally, git only tracks the branches you _asked_ it to track. It will 
follow any tags that happen along those branches, but it won't follow 
branches you haven't asked it to follow.

The reason is actually very simple: people track different things, and 
there is _not_ a 1:1 "local repository" to "parent repository" tracking. 
It's quite possible (and even sensible) to track two _different_ remote 
repositories in the same local repository, and adding branches just 
because the remote repository has a branch that you don't track, would 
actually be really _wrong_.

> "Git-pull" pulls down all the new commits for the branches you're
> following, and then any tags associated with any of the commits
> you pulled.

Yes, again with the exception that it's limited to just branches you share 
with _that_ repository. This is important to understand not because it is 
important in itself, but because it explains the behaviour. Once you 
realize that there's not any real 1:1 relationship, the git behaviour 
makes sense, and anythign else would actually be a bad idea.

That said, we could possibly try to introduce a special _flag_ saying "add 
new branches from this remote repository automatically", if that is 
actually a common issue.

> > So this basically boils down to the question:
> > 
> >   How on earth am I supposed to keep up with an upstream repository, if
> >   'git-pull -t' is not doing enough? Nobody can't be suggesting doing a
> >   new git-clone all the time...
> 
> You shouldn't really ever need "git-pull -t"; just use "git pull".  It will
> automatically grab all the tags you need.
> 
> But you will need to explicitly add new branches into your repo if you
> want to follow them.  Perhaps Git could make this easier.

It actually is very easy already. You just need to be aware of the new 
branch you want to track (which you can either be when somebody just 
_tells_ you about it, or you can figure it out with "git ls-remote"), 
and then you just do

	git fetch origin remotebranch:localbranch

and you now have that branch locally.

Now, if you want to continue to _track_ that branch, you probably want to 
just tell git so explicitly, and the easiest way tends to just edit the 
".git/remotes/origin" file, which has such a simple format that I don't 
think you even need to read the documentation, and you will just _guess_ 
what you should do.

But yeah, if somebody wants to send Junio a

	git addbranch

script (a line or two of shell), go wild. It should be easy, and you'll 
get the satisfaction of being able to use a command that you know you 
wrote yourself!  It really isn't very complicated.

