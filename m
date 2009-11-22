From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC 0/3] git rerere unresolve file
Date: Sun, 22 Nov 2009 15:19:54 +0100
Message-ID: <200911221519.55658.j6t@kdbg.org>
References: <200911211958.40872.j6t@kdbg.org> <7v6393mfqz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 15:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCDIa-0006wT-OJ
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 15:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbZKVOUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 09:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZKVOUD
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 09:20:03 -0500
Received: from [93.83.142.38] ([93.83.142.38]:64137 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753980AbZKVOUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 09:20:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id EB38D19F694;
	Sun, 22 Nov 2009 15:19:55 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v6393mfqz.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133432>

On Sonntag, 22. November 2009, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > ... But
> > there is no other way to remove an incorrect resolution short of purging
> > the whole rr-cache.
>
> No, no no, no.  You do not have to.

Oh, yeah, I know. But even for people who know how to drive plumbing commands, 
this:

> "ls -t1 .git/rr-cache/*/thisimage | head"
> would be one way to manually find out which one it is.

does not count as "you can" in my book. ;) It assumes that there are at most a 
handful conflicted files. In my case, for example, I have to fix a merge 
where there are ~100 conflicted files.

>  * Then the user tells rerere that "this is the corrected resolution",
>    perhaps
>
>    $ git rerere update Documentation/git-commit.txt
>
>    This will
>
>    - Internally recompute the original conflicted state, i.e. run
>      "checkout --conflict=merge Documentation/git-commit.txt" in-core;
>
>    - feed it to rerere.c::handle_file() to learn the conflict hash;
>
>    - read the user's updated resolution from the work tree, and update
>      "postimage" with it.
>
> ...
>
> The "forget" subcommand may be useful, but the real implementation should
> be the first half of the "update", iow, recreate conflict in-core in order
> to compute the conflict hash, and drop existing "postimage", without
> replacing it from the work tree.  We should leave it up to the user using
> "checkout --conflict" to reproduce the conflict in the work tree.

Thank you for your elaborate feedback and the guidelines about how to move 
forward.

I actually think that 'forget' should be the primary subcommand. Because after 
the postimage was purged, the next implicit or explicit 'git rerere' will 
record the resolution anyway. I'll see what I can do.

-- Hannes
