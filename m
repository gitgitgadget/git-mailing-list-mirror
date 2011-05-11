From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Wed, 11 May 2011 08:14:26 -0500
Message-ID: <20110511131356.GI2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBu8-0007zE-PR
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab1EKQEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:04:34 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:42487 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab1EKQEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:04:32 -0400
Received: by yia27 with SMTP id 27so211861yia.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2XL2FYtSiIX15Z9GxQolnd6H4VFez3ettjF1ta/0pV0=;
        b=WZ+xZmPSLObSq+3WOegHHje/VtOA5/Kfa7g/hu9dA9VZILpCAFmNT9ffmdbz+3YPoZ
         FgBFUgUWFktUL2smfEkmtl3+JQUXrkQZswk/PfzOY2w2y1ar8ZGyRdXnTVIMNCIG2UBj
         6iauhceGQ+tctBSEn7olQEVY43s+kCHzxNbO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ujPCbRRlKfShScHNFRE9EVj+YHsx1Ysr54SBoBgeB1qV0KcKhBmgfE8xI5Ynv3y14M
         z3GCMjTlT8zhuKxr8+nuwSkaMv0upwLtZ5vnI2lgxnO/4jYDbPElMmSUDLowvgVqlY6Q
         FlkoGhPul5Oi6RX6SpTHvUhrpo+5glBG99UUg=
Received: by 10.150.2.21 with SMTP id 21mr6806343ybb.354.1305119670288;
        Wed, 11 May 2011 06:14:30 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id w15sm2022283ybk.16.2011.05.11.06.14.28
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 06:14:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173400>

Ramkumar Ramachandra wrote:

> I've not attempted to add anything new in this series -- It merely
> fixes all the mistakes in the previous iteration.  I've tried to
> integrate the improvements suggested by all the previous reviews.

Thanks!  This is much more readable, probably because of the commit
messages. ;-)

> All tests pass in all patches, and I hope no
> stray lines have travelled b/w the patches during the rebase.

Speaking of which, some tests and documentation would be nice as icing
on the cake.

> Ramkumar Ramachandra (8):
>   revert: Improve error handling by cascading errors upwards
>   revert: Make "commit" and "me" local variables
>   revert: Introduce a struct to parse command-line options into
>   revert: Separate cmdline argument handling from the functional code
>   revert: Catch incompatible command-line options early
>   revert: Introduce head, todo, done files to persist state
>   revert: Implement parsing --continue, --abort and --skip
>   revert: Implement --abort processing

The heart is patch 6/8.  I have not thought about this deeply yet, but
I wonder if it would be simpler if the behavior of "git cherry-pick
1..10" looked like this:

. if there is state in .git/sequencer already, error out
. lock .git/sequencer/head with the lockfile API to prevent
  concurrent access
. write current state, including remaining commits to cherry-pick
. unlock .git/sequencer/head
. cherry-pick commit #1
. lock sequencer, check state, update state, unlock
. cherry-pick commit #2
 ...

This way, even if cherry-picking causes git to segfault, the sequencer
state is in good order and we know where to pick up.  More
importantly, massive refactoring of the merge_recursive API would not
be needed to keep everything in working order.  An atexit and sigchain
handler could be added to print advice for the reader about how to
resume, but that's just an extra hint and it's okay if it sometimes
doesn't happen sometimes.

What do you think?

Ciao,
Jonathan
