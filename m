X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 12:32:08 +0100
Message-ID: <200612021232.08699.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 11:32:32 +0000 (UTC)
Cc: sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33019>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqT6P-0007hB-Ub for gcvg-git@gmane.org; Sat, 02 Dec
 2006 12:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423351AbWLBLcP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 06:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423589AbWLBLcO
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 06:32:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:63671 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423351AbWLBLcO (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 06:32:14 -0500
Received: (qmail invoked by alias); 02 Dec 2006 11:32:12 -0000
Received: from p5496B2C8.dip0.t-ipconnect.de (EHLO noname) [84.150.178.200]
 by mail.gmx.net (mp042) with SMTP; 02 Dec 2006 12:32:12 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 01:12, Linus Torvalds wrote:
> On Sat, 2 Dec 2006, Josef Weidendorfer wrote:
> > 
> > So you are for a global submodule namespace in supermodule repositories,
> > do I understand correctly?
> > 
> > Otherwise, how would you specify the submodules at clone time given the
> > ability that submodule roots can have relative path changed arbitrarily
> > between commits?
> 
> The only _true_ namespace would be the SHA1 of the commit (and maybe allow 
> a pointer to a tag too, but the namespace ends up being the same).

I am not so sure about this.
Perhaps we want the namespace to be more than the space of commit ids.

Suppose you have some superproject which uses two compiler major versions
(GCC 3 and GCC 4) as submodules because you want to have your regression
test suite run with both major versions.
So you would have a submodule at path "gcc3/" and "gcc4/" in your supermodule.
As both the gcc 3 and gcc 4 are branches from the same project, the submodule
links will go into a connected DAG (suppose GCC uses git).

Alone from the commit link, it is not easy to see to what submodule it belongs
to (at least from a practical point of view).

So it actually _is_ more information if the proposed link objects in the supermodule
contain some submodule ID they belong to. They only need be unique in the scope of
the superproject (not really globally unique).

So another argument for submodule names: Merging. Otherwise, how do you decide
to which submodule a link belongs to, especially in the scope of above example?

> How to _find_ a repository that contains that SHA1 must be left to higher 
> levels. After all, repositories move around, and the place you found them 
> originally is not a stable name.

I did not talk about a special format for these submodule IDs yet.
We could use an URL, but with such a value a user automatically associates
some semantic which can be confusing, as repository URLs can change. 

We can use some symbolic name which has some meaning in the scope of
the superproject, and is specified at submodule creation, like "gcc3" or
"gcc4". However, this is a local decision of the person which is importing
the submodule. So if two developers of the same project using supermodules
independently decide that the import of "gcc" as submodule is the right
thing, but use slightly different submodule IDs, you will get 2 different
submodules when merging.

I argue that this is even the correct thing, and they should decide about the
name before both are doing the import, or only one imports and the other
pulls.

Another option for a submodule ID could be the root commit of the submodule
commit DAG. This looks nice as such an ID really is globally unique for
projects (more or less: the first commit always contains the time stamp at
creation, and the author/commiter email address, even if the tree happens
to be the same because you start with the same dummy file).

But my example above (with the 2 different submodules from the
same GCC project) shows that this is not working. A superproject never
could create different submodules from the same (e.g. GCC) project.

So I just vote for a symbolic name choosen at submodule creation time.

