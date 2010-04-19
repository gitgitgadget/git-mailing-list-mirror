From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2 1/3] stash bug: stash can lose data in a file removed
 from the index
Date: Mon, 19 Apr 2010 08:45:20 +0100
Message-ID: <20100419074520.GA5513@hashpling.org>
References: <20100418182749.GA29329@hashpling.org>
 <7vvdbotkz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 09:45:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lfc-0006iE-TG
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab0DSHpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 03:45:23 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:52119 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926Ab0DSHpX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 03:45:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEABeny0vUnw4T/2dsb2JhbACbdXG5eYUQBA
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.pcl-ipout01.plus.net with ESMTP; 19 Apr 2010 08:45:21 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1O3lfU-0007Tr-UP; Mon, 19 Apr 2010 08:45:21 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O3lfU-0001sh-Nf; Mon, 19 Apr 2010 08:45:20 +0100
Content-Disposition: inline
In-Reply-To: <7vvdbotkz0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: 1e42d7a0e8f55489f7895d83b9d26491
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145274>

On Sun, Apr 18, 2010 at 04:11:15PM -0700, Junio C Hamano wrote:
> Charles Bailey <charles@hashpling.org> writes:
> 
> It is likely that this needs to be protected with SYMLINKS prerequisite.
> Also I am a bit unhappy about the use of "readlink" which is not even in
> POSIX.1 here.  We already have one use of it in the tests but that only
> happens while doing valgrind.  Traditionally this has been more portably
> done by reading from "ls -l file", like so:
> 
> 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac

I don't have access to many flavours of unix at the moment and I
failed to look up the POSIXness of readlink. I'll re-roll with greater
portability.

> Also, whether "readlink file" or "ls -l file" is used to check the result,
> the "test -f file" is redundant.

Yes, of course. Not sure what I was thinking.

What about "test -h"? Is this sufficiently portable
for use in our tests? I understand that it's supposed to be POSIX and
available on Solaris sh.

> 
> > +test_expect_failure 'stash directory to file' '
> > +	git reset --hard &&
> > +	mkdir dir &&
> > +	echo foo >dir/file &&
> > +	git add dir/file &&
> > +	git commit -m "Add file in dir" &&
> > +	rm dir/file &&
> > +	rmdir dir &&
> > +	echo bar >dir &&
> > +	git stash save "directory to file" &&
> > +	test -d dir &&
> > +	test foo = "$(cat dir/file)" &&
> > +	test_must_fail git stash apply &&
> > +	test bar = "$(cat dir)" &&
> > +	git reset --soft HEAD^
> > +'
> 
> I have a feeling that this test is being a bit unfair.
> 
> What should a successful invocation of "stash apply" leave in the working
> tree in this case, especially when you consider that in a real life use
> case you may have other files in "dir" directory or changes to "dir/file"?

Actually I now think that this is completely wrong. There's no reason
that stash apply shouldn't succeed. If we managed to save the new file
where the directory was in the stash then why shouldn't apply be able
to at least attempt to remove the tracked files in the directory that
were originally removed and replace them with the stashed file?

Even if we decide that it can't or shouldn't, we should expect a
failing stash apply to leave the tree as it currently is. That does
leave the question of how the user is supposed to get stuff out of his
stash. After all, he's trying to apply the stash on exactly the state
that stash left him in.

Is it sensible to be guided by these two principles: git stash should
be safe, i.e. it should never remove content that it doesn't save in
the database. git stash && git stash apply should leave the working
tree exactly as it was before the git stash invocation (if the stash
succeeds it may be equivalent to a git reset)?

If so we definitely need to fix the behaviour where git stash
vaporizes local changes when there's a file <-> directory change
in the working tree. Even if we cop out and make git stash fail if it
determines that it wouldn't restore the changes.

Charles.
