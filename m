From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Fri, 12 Sep 2014 01:12:03 -0400
Message-ID: <20140912051202.GA6097@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <20140909220709.GA14029@peff.net>
 <20140912033830.GA5507@peff.net>
 <20140912042939.GA5968@peff.net>
 <CAPc5daXMMpqtH=DwLLXgHXVfHThN5MfHwn6dPK6OaZvAQGXT_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 07:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSJ9n-0007Tc-LF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 07:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbaILFML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 01:12:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:47338 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751935AbaILFMF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 01:12:05 -0400
Received: (qmail 1606 invoked by uid 102); 12 Sep 2014 05:12:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Sep 2014 00:12:05 -0500
Received: (qmail 31927 invoked by uid 107); 12 Sep 2014 05:12:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Sep 2014 01:12:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Sep 2014 01:12:03 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daXMMpqtH=DwLLXgHXVfHThN5MfHwn6dPK6OaZvAQGXT_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256900>

On Thu, Sep 11, 2014 at 09:58:45PM -0700, Junio C Hamano wrote:

> On Thu, Sep 11, 2014 at 9:29 PM, Jeff King <peff@peff.net> wrote:
> > [+cc mhagger for packed-refs wisdom]
> >
> > If we only have a packed copy of "refs/heads/master" and it is broken,
> > then deleting any _other_ unrelated ref will cause refs/heads/master to
> > be dropped from the packed-refs file entirely. We get an error message,
> > but that's easy to miss, and the pointer to master's sha1 is lost
> > forever.
> 
> Hmph, and the significance of losing a random 20-byte object name that
> is useless in your repository is? You could of course ask around other
> repositories (i.e. your origin, others that fork from the same origin,
> etc.), and having the name might make it easier to locate the exact
> object.

Because your repository is corrupted and broken, and we then forget that
fact. I.e., it is not a random 20-byte object name. It is the thing that
your branch is pointing at, and that is valuable in itself. If you can
restore the object (e.g., from another repository), you need to know
which object to restore.

But I also think corrupting a repository and not noticing is quite bad
in itself.

> But in such a case, either they have it at the tip (in which case you
> can just fetch the branch you lost), or they have it reachable from
> one of their tips of branches you had shown interest in (that is why
> you had that lost object in the first place). Either way, you would be
> running "git fetch" or asking them to send "git bundle" output to be
> unbundled at your end, and the way you ask would be by refname, not
> the object name, so I am not sure if the loss is that grave.

Yes, but after you get the objects from the other person, what do you
set your ref to? If I know my tip was at commit X, I can get any set of
objects from another untrusted person that includes X, verify what they
sent me cryptographically, and restore my tip to X.

If I do not know X, they can send me any random set of objects. I can
verify that the sha1s are OK and the graph is complete, but I cannot
verify that the contents are sane. I am effectively just picking their
"master" as my new starting point, and trusting that it has not been
tampered with.

-Peff
