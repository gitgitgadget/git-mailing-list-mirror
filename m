From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Thu, 04 Nov 2010 01:49:47 +0100
Message-ID: <201011040149.47968.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <7vsjzixty5.fsf@alter.siamese.dyndns.org>
 <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 01:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDo1e-0004Jo-Pp
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162Ab0KDAty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 20:49:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64463 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab0KDAtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 20:49:53 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBC00EG44Z1JDD0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Nov 2010 01:49:49 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 1B2D617993A6_CD2032DB	for <git@vger.kernel.org>; Thu,
 04 Nov 2010 00:49:49 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9B7221799335_CD2032CF	for <git@vger.kernel.org>; Thu,
 04 Nov 2010 00:49:48 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBC00KDP4Z0YK10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 04 Nov 2010 01:49:48 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <AANLkTin_NuzQocOab+w=B3Ka+n22j2-OXQu8=J6uzByS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160655>

On Wednesday 03 November 2010, Sverre Rabbelier wrote:
> On Wed, Nov 3, 2010 at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
> > I was actually thinking more along the lines of "not keeping track of
> > remote state at all".  We don't do that for tags either.
> 
> I would rather see us go the other way (and make the tags refspec put
> tags under refs/tags/remotes/.../). I can understand not scoping tags
> (since they're supposed to be immutable, and are usually global), but
> I don't think the same holds for notes. Notes _are_ versioned, and
> it's expected that users will collaborate.

Agreed. I don't see how you can easily share and manipulate notes between 
repos _without_ keeping the remote state separate from the local state.


I'm probably gonna be flamed for this, but I'd like to go even further, and 
- for a future major version of Git - reconsider Git's default refspecs. 
Currently we have:

  Remote repo    ->   Local repo
  ------------------------------------------------
  refs/heads/*        refs/remotes/$remote/*
  refs/tags/*         refs/tags/*
  refs/notes/*        ???

Of these, the first is specified in the config, the second is 
implicit/magic, and the third would be specified in the config.

I'd probably suggest a more straightforward (and hopefully less confusing) 
setup like this:

  Remote repo    ->   Local repo
  ------------------------------------------------
  refs/heads/*        refs/remotes/$remote/heads/*
  refs/tags/*         refs/remotes/$remote/tags/*
  refs/notes/*        refs/remotes/$remote/notes/*

...and these would all be set in the config, i.e. no implicit/magic 
refspecs.

Now, there would obviously need to be some accompanying changes:

We would, for example, extend the ref disambiguation of <name> (as 
documented in the "SPECIFYING REVISIONS" section of git-rev-parse(1)), so 
that in the cases where <name> is of the form "<foo>/<bar>" AND <foo> is an 
existing remote, we also check for the following refs (after none of the 
existing checks have returned a match):

  7. refs/remotes/<foo>/tags/<bar>
  8. refs/remotes/<foo>/heads/<bar>

We would also need similar disambiguation rules for notes refs, e.g.:

  1. $GIT_DIR/<name>
  2. refs/notes/<name>
  3. refs/remotes/<foo>/notes/<bar> (when <name> is of the form <foo>/<bar>)

With these rules, we could use "origin/master", "origin/v1.2.3" and 
"origin/bugnotes" to refer to "refs/remotes/origin/heads/master", 
"refs/remotes/origin/tags/v1.2.3" and "refs/remotes/origin/notes/bugnotes" 
respectively.

As a bonus, we'd get better handling of conflicting tag names: If e.g. 
remotes "alice" and "bob" each have a tag "xyzzy" pointing to different 
objects, you could reference and compare both tags (using "alice/xyzzy" and 
"bob/xyzzy", respectively), and optionally set your own local tag 
("refs/tags/xyzzy") to match either of them.


...Johan (scrambles for a flame retardant suit)


-- 
Johan Herland, <johan@herland.net>
www.herland.net
