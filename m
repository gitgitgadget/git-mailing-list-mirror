From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 11:27:29 -0700
Message-ID: <7v3apfawry.fsf@gitster.siamese.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org>
 <20080420215700.GA18626@bit.office.eurotux.com>
 <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
 <7vk5isatpe.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:28:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo0kl-0004FF-CB
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 20:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbYDUS1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 14:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755251AbYDUS1p
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 14:27:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbYDUS1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 14:27:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7B92825CD;
	Mon, 21 Apr 2008 14:27:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6BADD25CC; Mon, 21 Apr 2008 14:27:37 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 20 Apr 2008 20:15:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80033>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Here's a trial balloon patch that totally revamps how that whole function 
> works. Instead of passing in a "symlink_cache" thing that it modifies for 
> the caller, it just has its totally *internal* cache of where it found the 
> last symlink, and what the last directory it found last time was.
>
> So now the logic becomes:
>
>  - if a pathname that is passed in matches the last known symlink prefix, 
>    we don't even need to do anything else - it is known to have a symlink 
>    prefix.
>
>  - if the pathname that is passed in matches the last known directory 
>    prefix, we start looking just from that point onward (since we know 
>    that the leading part is a directory without symlinks)

That makes sense.

> Caveat: I do think we should add a way to invalidate the pathname caches 
> when we turn a symlink into a directory or vice versa, so this patch isn't 
> really complete as-is, but I think it's a good start.

True.

There are a few patches in flight that are not in 'master' (Dmitry quoted
one of them), that use more has_symlink_leading_path() calls.  In
retrospect, the function was misnamed.  It describes what it checks
(i.e. "does the path have leading component that is a symlink?") but I
probably should have named it after what it really wants to tell
(i.e. "lstat(2) says this exists, but does it really, from the point of
view of git?")

Doesn't it become very tempting to replace lstat() calls we make to check
the status of a work tree path, with a function git_wtstat() that is:

        int git_wtstat(const char *path, struct stat *st)
        {
                int status = lstat(path, st);

                if (status)
                        return status;

                if (!has_symlink_leading_path(path, strlen(path)))
                        return 0;

                /*
                 * As far as git is concerned, this does not exist in
                 * the work tree!
                 */
                errno = ENOENT;
                return -1;
        }

This unfortunately is not enough to hide the need for has_symlink calls
from outside callers.  When we check out a new path "a/b/c/d/e", for
example, if we naively checked if we creat(2) "a/b/c/d/e" (and otherwise
we try the equivalent of "mkdir -p"), we would be tricked by a symlink
"a/b" that points at some random place that has "c/d" subdirectory in it,
and we need to unlink "a/b" first, and the above git_wtstat() does not
really help such codepath.
