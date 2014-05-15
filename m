From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] open_sha1_file: report "most interesting" errno
Date: Thu, 15 May 2014 15:11:28 -0400
Message-ID: <20140515191127.GA29746@sigill.intra.peff.net>
References: <20140515085405.GA27033@sigill.intra.peff.net>
 <xmqqbnuzgelt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 21:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl142-0001fm-O0
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 21:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaEOTLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 15:11:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:52465 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751191AbaEOTLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 15:11:30 -0400
Received: (qmail 29933 invoked by uid 102); 15 May 2014 19:11:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 14:11:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 15:11:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnuzgelt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249185>

On Thu, May 15, 2014 at 10:02:06AM -0700, Junio C Hamano wrote:

> >     $ chmod 0 .git/objects/??/*
> >     $ git rev-list --all
> >     fatal: loose object b2d6fab18b92d49eac46dc3c5a0bcafabda20131 (stored in .git/objects/b2/d6fab18b92d49eac46dc3c5a0bcafabda20131) is corrupt
> 
> Hmmmmmmmm.  So we keep track of a more interesting errno we get from
> some other place than what we get for this local loose object, and
> we no longer give this message pointing at the local loose
> object---is that the idea?

Yes, though my main goal was to stop saying "corrupt" when that is not
the problem at all. Not pointing to the wrong object was a secondary
consideration. :)

I would also be happy to just show the error for the local object, even
if it is exists somewhere else.  The main thing I am changing here is
that we currently _never_ show the errno from the main odb. We either
show the errno from the last alternate we looked at, or we show ENOENT
(because we explicitly set ENOENT right before looking at the
alternates).

I think it's a separate problem that the "stored in..." is sometimes
wrong. That comes when we get ENOENT, and we check has_loose_object().
IOW, we guess "we couldn't find it, but we claim to have it, so it must
have been corrupt". But that does not say _where_ we found it, and our
call to sha1_file_name is a guess that may be wrong.

I'm actually not sure if we can even trigger that code path now. It
depended on returning ENOENT from read_object, which we used to
frequently do erroneously. Now we will only do it when the object truly
does not exist, which means has_loose_object should generally not return
true.

I'm also a bit surprised that errno actually survives here. That clearly
was the intent, so I don't think my patch is making anything worse. But
it's possible that we would prepare_packed_git or open/mmap packfiles
between the call to open_sha1_file and when read_sha1_file_extended
looks at errno.

> What I am wondering is that this report we give in the new code
> 
> >     $ git rev-list --all
> >     fatal: failed to read object b2d6fab18b92d49eac46dc3c5a0bcafabda20131: Permission denied
> 
> may want to say which of the various possible places we saw this
> most interesting errno, which I think was the original motivation
> came from e8b15e61 (sha1_file: Show the the type and path to corrupt
> objects, 2010-06-10) that added "(stored in ...)".
> 
> But that may involve a larger surgery, and I definitely do not want
> to add unnecessary logic in the common-case codepath to keep track
> of pieces of information that are only used in the error codepath,
> so it smells like that this is the best fix to the issue the commit
> message describes.

Yes, I think doing this right would involve a lot more surgery, and I
don't know if it is worth the effort. But in addition to the problems
above, I note that we simply open the first object we can find, and do
not loop if mmap or checksums fail. So unlike packed objects, which are
resilient to corruption, we would fail immediately.

So I think the right thing to do would be:

  1. Don't loop across alternates in open_sha1_file. Loop in read_object
     (which means looping in _other_ calls to map_sha1_file, like in
     sha1_object_info).

  2. Fail quickly, since the common case is that we will find the object
     elsewhere. But when we do have an error, take time to go back and
     actually find the location of the object and the real error (i.e.,
     have a diagnose_object or something).

Neither is a particularly high priority to me, though, so I don't plan
on working on them anytime soon. The only reason I went this far was
that I saw the "loose object is corrupt" / EPERM confusion in the real
world.

-Peff
