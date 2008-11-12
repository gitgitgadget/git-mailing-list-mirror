From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 17:40:23 +0000
Message-ID: <804p2cq1vc.fsf@tiny.isode.net>
References: <80wsf9ovsp.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 18:42:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0JjC-0002jW-Dy
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYKLRka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbYKLRk3
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:40:29 -0500
Received: from rufus.isode.com ([62.3.217.251]:44166 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbYKLRk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:40:27 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SRsVCAAJxRp6@rufus.isode.com> for <git@vger.kernel.org>;
          Wed, 12 Nov 2008 17:40:24 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 12 Nov 2008 17:40:24 +0000
X-Hashcash: 1:20:081112:git@vger.kernel.org::7qsRmjhglPjD5nkM:0000000000000000000000000000000000000000009PFb
In-Reply-To: <80wsf9ovsp.fsf@tiny.isode.net> (Bruce Stephens's message of "Wed\, 12 Nov 2008 14\:36\:54 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100780>

Bruce Stephens <bruce.stephens@isode.com> writes:

> The following works fine with 1.6.0.2 and before, but not 1.6.0.3 or
> later:
>
> 	git clone -n git git-test
>         cd git-test
>         git checkout -b work v1.6.0.2
>
> When it breaks, the error is:
>
> 	error: Entry '.gitignore' would be overwritten by merge. Cannot merge.
>
> I'm guessing it's a bug rather than a deliberate change?

According to "git bisect", the commit that caused this is the
following one.  Perhaps "git clone -n" doesn't start out with the
index empty in the relevant sense?

commit 5521883490e85f4d973141972cf16f89a79f1979
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Sep 7 19:49:25 2008 -0700

    checkout: do not lose staged removal
    
    The logic to checkout a different commit implements the safety to never
    lose user's local changes.  For example, switching from a commit to
    another commit, when you have changed a path that is different between
    them, need to merge your changes to the version from the switched-to
    commit, which you may not necessarily be able to resolve easily.  By
    default, "git checkout" refused to switch branches, to give you a chance
    to stash your local changes (or use "-m" to merge, accepting the risks of
    getting conflicts).
    
    This safety, however, had one deliberate hole since early June 2005.  When
    your local change was to remove a path (and optionally to stage that
    removal), the command checked out the path from the switched-to commit
    nevertheless.
    
    This was to allow an initial checkout to happen smoothly (e.g. an initial
    checkout is done by starting with an empty index and switching from the
    commit at the HEAD to the same commit).  We can tighten the rule slightly
    to allow this special case to pass, without losing sight of removal
    explicitly done by the user, by noticing if the index is truly empty when
    the operation begins.
    
    For historical background, see:
    
        http://thread.gmane.org/gmane.comp.version-control.git/4641/focus=4646
    
    This case is marked as *0* in the message, which both Linus and I said "it
    feels somewhat wrong but otherwise we cannot start from an empty index".
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
