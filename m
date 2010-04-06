From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Tue, 6 Apr 2010 01:55:30 -0400
Message-ID: <20100406055530.GE3901@coredump.intra.peff.net>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
 <1270392557-26538-1-git-send-email-avarab@gmail.com>
 <20100404224324.GB12655@gmail.com>
 <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
 <7vy6h2wsvg.fsf@alter.siamese.dyndns.org>
 <buor5mu7acd.fsf@dhlpc061.dev.necel.com>
 <20100405055139.GA28730@coredump.intra.peff.net>
 <o2h51dd1af81004050550v9427b9flfb13a9e1ad4056a@mail.gmail.com>
 <20100405175822.GA32083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 07:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1lS-000375-ES
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 07:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab0DFFzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 01:55:50 -0400
Received: from peff.net ([208.65.91.99]:58580 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0DFFzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 01:55:48 -0400
Received: (qmail 3245 invoked by uid 107); 6 Apr 2010 05:56:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Apr 2010 01:56:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Apr 2010 01:55:30 -0400
Content-Disposition: inline
In-Reply-To: <20100405175822.GA32083@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144100>

On Mon, Apr 05, 2010 at 12:58:22PM -0500, Jonathan Nieder wrote:

> > There's probably a lot of code out there doing `git commit -m"Yet
> > another revision"' from some cron job.
> 
> FWIW, I have no strong opinion about whether to add this --allow-empty-message
> option.  Maybe it would make something more convenient for someone,
> though that has to be weighed against it making it harder for everyone
> else to read the manual.

I meant to mention this in my other response: I would prefer if such an
option doesn't clutter up the usage message. --allow-empty is already
there, and probably doesn't need to be. "git commit -h 2>&1 | wc -l"
shows a whopping 39 lines, which IMHO is too many for a short usage
summary. I mean, "--no-post-rewrite", is that really one of the top-used
options?

> Hint:
> 
> 	parent=HEAD && : or whatever &&
> 	tree=$(git write-tree) &&
> 	printf "%s\n" message |
> 	commit=$(git commit-tree "$tree" -p "$parent") &&
> 	git update-ref refs/heads/somebranch "$commit"

In addition to the bug you mention later, you also probably want to do:

  parent=`git rev-parse --verify HEAD`
  [...]
  git update-ref \
    -m 'automated commit by tool X' \
    refs/heads/somebranch $commit $parent

which will give your reflog entry a more useful message, and will
protect against simultaneous updates losing history (update-ref will
make sure, while locked, that somebranch contains the $parent sha1 you
wrote as part of the commit object).

And of course it still doesn't handle parentless root commits.

So doing it right really is a bit more work than just calling "git
commit".

-Peff
