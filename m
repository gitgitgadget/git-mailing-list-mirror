From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Documentation: clarify .gitattributes search
Date: Mon, 6 Apr 2009 14:59:45 -0400
Message-ID: <20090406185944.GB28120@coredump.intra.peff.net>
References: <49D96C63.9070200@redhat.com> <7viqlicp1y.fsf@gitster.siamese.dyndns.org> <49DA19C8.5010308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 21:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqu4j-0002VP-BR
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 21:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbZDFTAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 15:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbZDFTAH
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 15:00:07 -0400
Received: from peff.net ([208.65.91.99]:44525 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbZDFTAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 15:00:06 -0400
Received: (qmail 25978 invoked by uid 107); 6 Apr 2009 19:00:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 15:00:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 14:59:45 -0400
Content-Disposition: inline
In-Reply-To: <49DA19C8.5010308@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115867>

On Mon, Apr 06, 2009 at 11:03:36AM -0400, Jason Merrill wrote:

> Junio C Hamano wrote:
>>  (2) also wondered why you were confused to think if your home directory
>>      (for that matter, any higher directory, like /.gitattributes at the
>>      filesystem root level) that is clearly outside of the project could
>>      possibly affect what happens inside a project; and
>
> Because it would be useful if it did; specifically, it would be  
> convenient to be able to say that ChangeLog files use git-merge-changelog 
> wherever they appear, and not have to repeat that in all my projects.  I 
> didn't really expect it, but thought that maybe it was designed to work 
> that way.

I don't think per-user attribute patterns are an unreasonable thing to
want, but I think traversing above the git worktree root is not a good
way to implement it. Specifically:

  1. It's inefficient. If your repo is only two directories deep, we now
     might look at 2 gitattributes files. But if you put your repo in
     /some/long/path/in/your/filesystem, we now have to check _each_ of
     those, even though they are very unlikely to contain gitattributes
     files.

  2. It doesn't cover the per-user case very well. Repositories in your
     home directory and repositories in (for example) /tmp would need
     two separate gitattributes files.

Specifically checking $HOME/.gitattributes does make some sense to me
(though perhaps it is worth giving it a different basename in case your
home directory actually is a git repository).

The argument against it would be that it is up to the repo to define the
_types_ of its files, and for the user to define what to do with those
types. But if you have many repos, I could certainly see it being
convenient to globally say "for lack of better information, assume *.foo
files are type foo".

And there is already some precedent, as you note, in core.excludesfile.

-Peff
