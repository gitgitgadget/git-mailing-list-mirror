X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Tue, 7 Nov 2006 18:04:43 +0100
Message-ID: <200611071804.43724.Josef.Weidendorfer@gmx.de>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de> <200611071153.32840.Josef.Weidendorfer@gmx.de> <20061107135609.GA32376@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 17:06:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <20061107135609.GA32376@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31077>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhUOm-0006Ik-7O for gcvg-git@gmane.org; Tue, 07 Nov
 2006 18:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965563AbWKGRFj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 12:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965569AbWKGRFj
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 12:05:39 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:8321 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S965563AbWKGRFi (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 12:05:38 -0500
Received: from dhcp-3s-44.lrr.in.tum.de (dhcp-3s-44.lrr.in.tum.de
 [131.159.35.44]) by mail.in.tum.de (Postfix) with ESMTP id 288522702; Tue,  7
 Nov 2006 18:04:46 +0100 (MET)
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Tuesday 07 November 2006 14:56, you wrote:
> But what happens when an unexperienced user gets this conflict for the
> first time (having for the first time used two different remotes)?
> Your scheme forces her to learn two new things instead of one,
> creating the artificial barrier I mentioned above.

I give the user a warning that she has to specify a branch
name herself. This does not force her to rename all her branches
and go with the new naming <remote>/<remote branch>, but probably
makes her do

 repo developer1, branch next => next (magic behavior)
 repo developer2, branch next => next2 (manual specification)

and perhaps rename next to next1 afterwards.

At least I do not want to type long branch names; most of the
cloned repos I have do have only one remote. So I would rename
the branches names created with the complex magic scheme.

Of course, another way is to be more smart with branch name parsing.
Currently, a given name is searched in
	.git/
	.git/refs/
	.git/refs/tags/
	.git/refs/heads/
	.git/refs/remotes/
	.git/refs/remotes/*/HEAD

What about adding before remotes
	.git/refs/heads/<first-part-of-current-branchname>/
and at the end
	.git/refs/remotes/<first-part-of-current-branchname>/
Ie. when on branch "origin/next", a given name "master" is
parsed as "refs/heads/origin/master" when existing?
So the parsing rule is: "With current branch X and given name Y,
search for a branch as near as possible to X which has Y as
last name component".

This would match current UI, where you have simple branch names
like "master" or "next".
With above rule, you can use "master" to refer
to "refs/heads/origin/master" in the complex model,
and for a read-only remote head "refs/heads/remotes/origin/next",
it is enough to say
	git-checkout next
to get a new local branch "refs/heads/origin/next" created
to work on.

You keep the simple UI and still get the perfect overview with
eg. with "gitk --all" even in the case where you work on
10s of remote branches from multiple repository.

