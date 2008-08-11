From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Tue, 12 Aug 2008 01:47:33 +0200
Message-ID: <20080811234733.GB28340@leksak.fem-net>
References: <20080811190924.GR18960@genesis.frugalware.org> <1218491096-28756-1-git-send-email-s-beyer@gmx.net> <7v7ianuo8q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 01:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSh80-0001T3-2e
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbYHKXrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbYHKXrk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:47:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:36921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753725AbYHKXrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:47:40 -0400
Received: (qmail invoked by alias); 11 Aug 2008 23:47:37 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp057) with SMTP; 12 Aug 2008 01:47:37 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/gFv5QDEvg9mUyQbYqTqa/drIQfNeRRymTlnk9Jg
	vgOXLgEw7sRt1q
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSh6r-0002XK-Vl; Tue, 12 Aug 2008 01:47:33 +0200
Content-Disposition: inline
In-Reply-To: <7v7ianuo8q.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92025>

Hi,

Junio C Hamano wrote:
> I am not absolutely sure if the phoney commit-looking object that has
> nonsense SHA-1 created by make_virtual_commit() would have any unintended
> side effects to the rest of the system, but it does not look like it is
> even inserted into the global object hash table, so this should be Ok.

Hmm, the git-merge-recursive process that was run before, calls get_ref()
and that also used make_virtual_commit() and thus this virtual_id.
So if there is some danger regarding this, then it has also been there
before my patch :-)

> That was the last piece of worry coming from me regarding this "call
> recursive internally" theme.

Well, for simple cherry-pick/revert your other worries can be ignored,
because it only runs merge_recursive() _once_ and the die()s do not
hurt.  Wrong?

> Would we need to consolidate this and Miklos's "call recursive internally
> from git-merge wrapper" by making them into three patches?
> I.e.
> 
>  (1) move bulk of code from builtin-merge-recursive.c to a new file
>      merge-recursive.c and introduce merge_recursive_helper() in there so
>      that both of you and cmd_merge_recursive() itself can call it;

I'd like to see a "libified" merge-recursive.c, but I wouldn't call the
interesting function merge_recursive_helper(), I'd just take
merge_recursive().
Of course those index locking could be done in it.

Looking at my sequencer code, I'd also be satisfied, if it takes SHAs
as argument and no "struct commit *".
But then this should be more generic, i.e. OBJ_TAG has to be handled
correctly (builtin-revert does that at the beginning at parse-args()).

Hmm, then step (1) is ok. :-)

>  (2) make revert.c use merge_recursive_helper();
> 
>  (3) make builtin-merge.c use merge_recursive_helper().

This is ok then.

Thanks and regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
