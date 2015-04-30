From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 21:16:12 -0400
Message-ID: <20150430011612.GA7530@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:16:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynd5X-0002Qw-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbD3BQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:16:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:51987 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbbD3BQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:16:15 -0400
Received: (qmail 32136 invoked by uid 102); 30 Apr 2015 01:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 20:16:15 -0500
Received: (qmail 621 invoked by uid 107); 30 Apr 2015 01:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 21:16:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 21:16:12 -0400
Content-Disposition: inline
In-Reply-To: <1430355983.14907.55.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268043>

On Wed, Apr 29, 2015 at 06:06:23PM -0700, David Turner wrote:

> >   HEAD^{resolve}:foo/bar
> [...]
>
> Just to clarify: if you do git rev-parse, and the result is an
> out-of-tree symlink, you see /foo or ../foo instead of a sha?  And if
> you "git show" it it says "symlink HEAD:../foo"?

I had imagined we would stop resolution and you would just get the last
object peeled object. Combined with teaching cat-file to show more
object context, doing:

  echo content >dest ;# actual blob
  ln -s dest link    ;# link to blob
  ln -s broken foo   ;# broken link
  ln -s out ../foo   ;# out-of-tree link
  git add . && git commit -m foo
  for i in link broken out; do
	echo HEAD^{resolve}:$i
  done |
  git cat-file --batch="%(intreemode) %(size)"

would yield:

 (1)   100644 8
       content
 (2)   040000 3
       foo
 (3)   040000 6
       ../foo

where the left-margin numbers are for reference:

  1. We dereference a real symlink, and pretend like we actually asked
     for its referent.

  2. For a broken link, we can't dereference, so we return the link
     itself. You can tell by the mode, and the content tells you what
     would have been dereferenced.

  3. Ditto for out-of-tree. Note that this would be the _raw_ symlink
     contents, not any kind of simplification (so if you asked for
     "foo/bar/baz" and it was "../../../../out", you would the full path
     with all those dots, not a simplified "../out", which I think is
     what you were trying to show in earlier examples).

-Peff
