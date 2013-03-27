From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 22:32:27 +0530
Message-ID: <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtkq-0002lR-Bk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3C0RCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:02:49 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:53774 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3C0RCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:02:48 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so7614605iag.3
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ofLuhBBWheRE1QWURjFS2olcGPlGZL1GawMpsPzjtHg=;
        b=AhW98zCdsIV0RH7AaHeXb24wR9v6taF/I8M7MtALBr3mabZdwH1x1W/WaobObLWpR6
         nMnLCJ0XYIuOogg8iljqFf+MzTcsAUKwTDODlpn2aFRZppBVSeWXl0Tcz4XZO1HI8B9D
         7rjAk1TpA9AZt+vdseLD/wyPwyzLUdCLezYNF7dZ4d5h1AFme+NMY9w6h4JF1c2A8S3n
         pUb1sxfpqApGAyF1pKuSyhrTV8w5oLNffH754k3sTIGkDGFWl/DnX+QvND71pqC/TNF5
         lkjT39diuXMen04Njzleah3uzn+ekNTLDudKwNGQ2z+9F9DfTkkSDjGBYyVE377Xv66A
         YkbA==
X-Received: by 10.50.119.102 with SMTP id kt6mr4937996igb.12.1364403767854;
 Wed, 27 Mar 2013 10:02:47 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 27 Mar 2013 10:02:27 -0700 (PDT)
In-Reply-To: <7vvc8comj5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219276>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Junio C Hamano wrote:
>>> So you have to stash it somewhere.  We could have made it to move
>>> them to $HOME/.safeplace or somewhere totally unrelated to the
>>> superproject.  So in that sense, the repositories are *not* owned by
>>> the superproject in any way.  However, you are working within the
>>> context of the superproject on the submodule after all, and
>>> somewhere under $GIT_DIR/ of the superorject is not too wrong a
>>> place to use as such a safe place.
>>
>> Thanks for the explanation.
>
> What do you _exactly_ mean by that?  You understood why things are
> arranged in that way, and no longer think that it is unnecessary,
> ugly and unwieldy to stash the real copy of $GIT_DIR of submodules
> away from their working trees and store them inside $GIT_DIR/modules
> of the superproject?

In essence, git commands are built to act on pure worktrees.  It's
trivially Correct to pretend that an object store present in the
toplevel directory (as .git/) of the worktree doesn't exist, but it's
quite non-trivial to handle a .git directory anywhere else in the
worktree.  Since we built git ground-up to act on a single
repository's worktree, embedding one repository inside another is a
hack: as a "workaround", we simply relocate the object store of the
submodule repository.  Even then, working with one worktree embedded
inside another is something git never designed for: it explains why I
have to literally fight with git when using submodules (no offense
Jens; it's a very hard problem).

Representing submodules as commit objects in the tree is also a hack.
I'm sorry, but a submodule is not a commit object.  We need a fifth
object type if we want them to be first-class citizens.

Sorry, I'm deviating.  I learnt why you think the hack is necessary
and not "too wrong".  As I explained above, the entire design is
asymmetric and inelegant; I think we can do much better than this.
