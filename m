From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 3/3] git-push: make git push --dry-run --porcelain
 exit with status 0 even if updates will be rejected
Date: Mon, 8 Feb 2010 16:49:39 -0500
Message-ID: <20100208214939.GA11355@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <032264a40d15cb9f4a86885947ffa23a603bfb0e.1265661033.git.larry@elder-gods.org>
 <7vpr4figv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NebUI-0003CN-7j
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 22:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab0BHVtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 16:49:41 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:58391 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHVtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 16:49:40 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id B9AB982205A; Mon,  8 Feb 2010 16:49:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vpr4figv3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139323>

* Junio C Hamano (gitster@pobox.com) [100208 15:59]:
> Larry D'Anna <larry@elder-gods.org> writes:
> 
> > The script calling git push --dry-run --porcelain can see clearly from the
> > output that the updates will be rejected.  However, it will probably need to
> > distinguish this condition from the push failing for other reasons, such as the
> > remote not being reachable.
> 
> I am not sure about this reasoning.  If you are telling the script writers
> to decide what happened by reading from the output, shouldn't the program
> say "I fail because I cannot reach the other side" to its standard output
> so that the script can read it as well?

Wouldn't that just complicate life for the script writer?  If you send such
messages to the standard output, the script would have to include logic to
distinguish error messages from the rest of the output.  If you send them to the
standard error then the script knows exactly where to find them.

> Having said that, I don't think it matters either way.  If a script wants
> to know if push would fully succeed or not, it will run without
> --porcelain (perhaps while discarding the standard error) and check the
> status.  Even without this patch, if a script runs with --porcelain and
> gets non-zero status, it can inspect the output and if it got rejection,
> that is a sure sign that it at least reached the other end to get enough
> information to decide that it will be rejected, no?

Yes, it's a sure sign that it reached the other side, but how does the script
know nothing else went wrong?  What if a malloc failed?  OK that's a bit far
fetched, but it's really, really nice to be able to get an unambiguous status
bit out of a command so you know if the requested operation succeeded or not.
Without this patch, a script calling git push --porcelain --dry-run has no way
of distinguishing these two situations

1) "git push" would try to push a ref that would get rejected, but everything
else is fine.

2) "git push" would try to push a ref that would get rejected, and also some
unknown type of error occurred that this script has no idea how to handle.

        --larry
            
