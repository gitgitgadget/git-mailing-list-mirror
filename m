X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:06:40 +0100
Message-ID: <200612012306.41410.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 22:07:10 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32970>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGWz-0000f8-Pu for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162059AbWLAWGu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162060AbWLAWGu
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:06:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:11731 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162059AbWLAWGu (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:06:50 -0500
Received: (qmail invoked by alias); 01 Dec 2006 22:06:48 -0000
Received: from p5496B457.dip0.t-ipconnect.de (EHLO noname) [84.150.180.87] by
 mail.gmx.net (mp010) with SMTP; 01 Dec 2006 23:06:48 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 21:13, Linus Torvalds wrote: 
> > There seems to be some agreement to store the commit id of
> > the submodule instead of a plain tree id in the supermodules tree object, and
> > that all objects that are reachable from this commit are made part of the
> > supermodule repository (either fetched or via alternates). Do you agree?
> 
> Well, I would actually argue that you may often want to have a supermodule 
> and then at least have the _option_ to decide to not fetch all the 
> submodules.

If you want to allow this, you have to be able to cut off fetching the
objects of the supermodule at borders to given submodules, the ones you
do not want to track. With "border" I mean the submodule commit in some
tree of the supermodule.

This looks a little bit like a shallow clone, where you introduce
graft points at the border to some of the submodule's object DAGs.
But I am not sure that this is scalable: for supermodules with
a large number of submodules you are not interested in,
your graft file would grow very fast, as there will be new borders
with every change in some submodule, which happens to be tracked
in the supermodule.

So IMHO, instead of a huge graft file, you want to have a fast way
to check at a submodule border which submodule this given border is
going into. Then, at fetch time, you easily can decide that you do
not want to fetch any object from the submodule.
Otherwise, you would have to ask the remote end at cloning time:
"Is this commit from some submodule I am locally not interested in?"

So I think we should introduce a submodule namespaces in supermodules.
And at every border from super- to submodules, the name of the
submodule we are going into should be specified.
Which actually means that we need to introduce a "submodule" object,
and trees of a supermodule can have such submodule objects as borders
into a submodule. In a submodule object, of course we have the
SHA1 of the commit into the submodule DAG, and there would be the global
unique name we have choosen for this submodule in this supermodule.
Something like

 submodule: gcc
 commit: 6287376...

Before cloning a supermodule, you should be able to list the names of
the submodules available, and select the submodules you want to have
cloned together with the supermodule.

> Ie, you very much should be able to to do
>
>         git clone supermodule/that/one/submodule
> my-own-version-of-submodule
>
> to clone a submodule _without_ getting anything else (but still get all
> the work you did within he submodule - very much including your own
> private branch work).

So in the example, "that/one/submodule" is _not_ the path of the working
tree which happens to be the root of the submodule at current supermodule
HEAD, but the unique name from the submodule namespace.

This is important, as you should be able to move the root of a submodule
inside of your supermodule like moving any other file or directory.
I.e. for every supermodule commit, the path to the root directory of a
given submodule can change, making it useless as a name for a submodule
selection at clone time.

