From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 15:02:58 -0500
Message-ID: <20150202200258.GA28915@peff.net>
References: <4727F1DC-2FC3-49BE-8C6D-0C4D7D8B107C@jonathonmah.com>
 <xmqqk300t772.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <me@jonathonmah.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:03:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINDA-0004dO-FW
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbbBBUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:03:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:44197 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753762AbbBBUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:03:01 -0500
Received: (qmail 16426 invoked by uid 102); 2 Feb 2015 20:03:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 14:03:01 -0600
Received: (qmail 11213 invoked by uid 107); 2 Feb 2015 20:03:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 15:03:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 15:02:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk300t772.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263282>

On Mon, Feb 02, 2015 at 12:00:17PM -0800, Junio C Hamano wrote:

> Jonathon Mah <me@jonathonmah.com> writes:
> 
> > +test_expect_success 'prune: handle alternate object database' '
> > +	test_create_repo A &&
> > +		(cd A &&
> > +		echo "Hello World" >file1 &&
> > +		git add file1 &&
> > +		git commit -m "Initial commit" file1) &&
> > +	git clone -s A B &&
> > +		(cd B &&
> > +		echo "foo bar" >file2 &&
> > +		git add file2 &&
> > +		git commit -m "next commit" file2 &&
> > +		git prune)
> > +'
> 
> The issue does not have much to do with introducing new path to the
> cloned repository, or the original having any specific content for
> that matter, so I am tempted to simplify the above to something like
> this intead:
> 
> 	test_create_repo A &&
> 	git -C A commit --allow-empty -m "initial commit" &&
> 	git clone --shared A B &&
> 	git -C B commit --allow-empty -m "next commit" &&
> 	git -C B prune

Yeah, I'd agree that more clearly demonstrates the issue (I didn't check
that it actually triggers the failure, but presumably you did).

I think we could also construct a more elaborate example where we fail
to pick up an unreachable segment of history based on the mtime of a tip
commit found only in the alternate (whereas this is only testing that we
don't bungle the alternate filename so completely that prune barfs).

-Peff
