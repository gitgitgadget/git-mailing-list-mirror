From: Jeff King <peff@peff.net>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 23:37:25 -0400
Message-ID: <20150430033725.GB12361@peff.net>
References: <1430341032.14907.9.camel@ubuntu>
 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
 <1430343059.14907.18.camel@ubuntu>
 <20150429214817.GA2725@peff.net>
 <1430346576.14907.40.camel@ubuntu>
 <20150429231150.GB3887@peff.net>
 <20150430003750.GA4258@peff.net>
 <1430355983.14907.55.camel@ubuntu>
 <20150430011612.GA7530@peff.net>
 <1430358345.14907.62.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 05:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnfI5-00051H-1j
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 05:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbbD3Dh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 23:37:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:52037 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751697AbbD3Dh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 23:37:27 -0400
Received: (qmail 7847 invoked by uid 102); 30 Apr 2015 03:37:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 22:37:27 -0500
Received: (qmail 1450 invoked by uid 107); 30 Apr 2015 03:37:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Apr 2015 23:37:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2015 23:37:25 -0400
Content-Disposition: inline
In-Reply-To: <1430358345.14907.62.camel@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268053>

On Wed, Apr 29, 2015 at 06:45:45PM -0700, David Turner wrote:

> On Wed, 2015-04-29 at 21:16 -0400, Jeff King wrote:
> > On Wed, Apr 29, 2015 at 06:06:23PM -0700, David Turner wrote:
> >   3. Ditto for out-of-tree. Note that this would be the _raw_ symlink
> >      contents, not any kind of simplification (so if you asked for
> >      "foo/bar/baz" and it was "../../../../out", you would the full path
> >      with all those dots, not a simplified "../out", which I think is
> >      what you were trying to show in earlier examples).
> 
> Unfortunately, we need the simplified version, because we otherwise
> don't know what the ..s are relative to in the case of a link to a link:
> 
>   echo content >dest ;# actual blob
>   mkdir -p foo/bar
>   ln -s foo/bar/baz fleem             # in-tree link-to-link 
>   ln -s ../../../external foo/bar/baz # out-of-tree link
> 
> If echo HEAD^{resolve}:fleem were to return ../../../external (after
> following the first symlink to the second), we would have lost
> information.

Urgh, yeah, thanks for the counter-example.

Here are some possible alternatives:

  1. If we can't resolve fully, don't resolve anything. I.e., return the
     "fleem" object here, and the caller can recurse if they want. This is
     simple and correct, but not as helpful to somebody who wants to follow
     the out-of-tree link (they have to re-traverse the fleem->foo/bar/baz
     link themselves).

  2. Consider it can error if resolution fails. If you ask for
     "HEAD^{tree}^{commit}", that does not resolve to anything (because
     we can't peel the tree to a commit). Like (1), this is simple and
     correct, but probably not all that helpful. The caller has to
     start from scratch and resolve themselves, rather than getting an
     intermediate result.

  3. Return an object with the symlink relative to the original
     filename (so "../external" in this case). This is kind of weird,
     though, because we're not just returning a string from the name
     resolution. It's an actual object.  So we'd be generating a fake
     object that doesn't actually exist in the object db and
     returning that. Feeding that sha1 to another program would fail.

  4. Return the last object we could resolve, as I described. So
     foo/bar/baz (with "../../../external" as its content) in this case.
     When you resolve a name, you can ask for the context we discovered
     along the way by traversing the tree. The mode is one example we've
     already discussed, but the path name is another. So something like:

       echo "HEAD^{resolve}:fleem" |
       git cat-file --batch="%(objectname) %(size) %(intreepath)"

     would show:

       1234abcd 17 foo/bar/baz
       ../../../external

     And then the caller knows that the path is not relative to the
     original "fleem", but rather to "foo/bar/baz".

     The problem is that although this context lookup is already part of
     get_sha1_with_context, that is not exposed through every interface.
     E.g., "git rev-parse HEAD^{resolve}:fleem" will give you an object,
     but you have no way of knowing the context.

I can't say that I'm excited about any of them. Perhaps you or somebody
else can think of a more clever solution.

Note that the complication with (3) does come from my trying to push
this down into the name-resolution code.

-Peff
