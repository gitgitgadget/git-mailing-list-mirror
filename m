X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 09:56:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 17:56:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86y7pd6oz7.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34116>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuBs6-0003wJ-0s for gcvg-git@gmane.org; Tue, 12 Dec
 2006 18:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932313AbWLLR4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 12:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWLLR4Q
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 12:56:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51036 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932313AbWLLR4P
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 12:56:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBCHuCID007221
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 09:56:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBCHuBW0009987; Tue, 12 Dec
 2006 09:56:12 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Randal L. Schwartz wrote:

> >>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
> 
> Randal> I just got this on this morning's git-fetch:
> 
> Randal>     error: no such remote ref refs/heads/pu
> Randal>     error: no such remote ref refs/heads/next
> Randal>     Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> 
> Randal> Here's my remotes/origin:
> 
> Randal>     URL: git://git.kernel.org/pub/scm/git/git.git
> Randal>     Pull: master:origin
> Randal>     Pull: man:man
> Randal>     Pull: html:html
> Randal>     Pull: +pu:pu
> Randal>     Pull: +next:next
> 
> And then it mysteriously fixed itself a few minutes later.
> Is there some sort of publishing failure, or intermittent race condition?

It's mirroring.

The way that kernel.org works is that there is one master site, which is 
not actually running any public services at all. That's the one that 
people who have write access can ssh into, and rather than run any public 
services, it runs the security-conscious things, like the secure logins 
and the automated signing scripts.

The actual _public_ sites are just mirrors, with just rsync between the 
things. All to keep the services on the master site minimal.

But because the public sites just mirror using rsync, and aren't really 
aware of git repositories etc at that stage, what can happen is that a 
mirroring is on-going when Junio does a push, and then the changes to the 
"refs/" directory might get rsync'ed before the "object/" directory does, 
and you end up with the public sites having references to objects that 
don't even _exist_ on those public sites any more.

When they then run git-daemon, git-deamon will basically see a corrupt git 
archive, and not expose those "broken" refs at all. Which explains what 
you see.

And once the mirroring completes, the issue just goes away, which explains 
why it just magically works five minutes later.

If the public sites used git itself to synchronize git repositories, 
they'd never see anything like this (because git itself will only write 
the new refs after it has actually updated the data). But since the thing 
needs mirroring for non-git uses too, and since rsync generally _works_ 
apart from the slight race-condition issue, that's what it just uses.

