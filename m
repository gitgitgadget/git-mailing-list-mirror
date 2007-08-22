From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull REMOTE" question
Date: Tue, 21 Aug 2007 22:11:49 -0700
Message-ID: <7vtzqsjgq2.fsf@gitster.siamese.dyndns.org>
References: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
	<7vy7g4jids.fsf@gitster.siamese.dyndns.org>
	<buo8x84kwkq.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 07:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INiVz-0006Nu-IQ
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 07:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbXHVFL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 01:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbXHVFL7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 01:11:59 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbXHVFL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 01:11:58 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 67C20125AB2;
	Wed, 22 Aug 2007 01:12:18 -0400 (EDT)
In-Reply-To: <buo8x84kwkq.fsf@dhapc248.dev.necel.com> (Miles Bader's message
	of "Wed, 22 Aug 2007 13:44:05 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56352>

Miles Bader <miles.bader@necel.com> writes:

> This apparent association of each local branch with a single remote
> seems slightly odd to me

I share the feeling.  I think pulling from more than one remote
is the norm, and moreover, pulling from more than one branch of
one remote (depending on which branch you are pulling into) is
also common.  I did not even want to have the "when we are on
this branch we would pull from that branch of that remote" we
currently have to begin with, but this is what the list wanted,
so there you are.

I _think_ the right approach is:

	git pull remote_name

when the user does not tell git which branch he is interested in
merging should be to say:

 1. Do we have an association of our current-branch and the
    remote name that defines which branch to merge?  If so, use
    it (we do not have this right now, except for the case where
    remote_name matches branch.$current_branch.remote);

 2. Do we have a map from (current-branch, remote_name) to the
    branch to be merged?  If so, use it (we do not have this
    right now).

 3. Is there the primary branch remote side defines (aka
    refs/remotes/remote_name/HEAD)?  If so, use it (we do not do
    this at all);

So, how about extending the syntax for [branch $current_branch]
section of the config like this?

 ;; traditional -- when on "master", use '[remote "origin"] url'
 ;; and '[remote "origin"] fetch' to decide where to fetch from,
 ;; and merge their refs/heads/master to our branch.
 [branch "master"]
 	remote = origin
        merge = refs/heads/master

 ;; new -- when on "master', and the user says to pull from "usb"
 ;; without saying which branch to merge, use '[remote "usb"] url'
 ;; and '[remote "usb"] fetch' to decide where to fetch from,
 ;; and merge their refs/heads/xprm to our branch.
 [branch "master:usb"]
 	merge = refs/heads/xprm

The trick in the new syntax is that you cannot have a colon in
refname, so there is no way for existing [branch $name] section
to crash with the new style definition.
