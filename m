From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 22:53:17 -0400
Message-ID: <20131019025317.GB13895@sigill.intra.peff.net>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
 <CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
 <CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
 <CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
 <20131018190537.GB11040@sigill.intra.peff.net>
 <xmqq7gdawfeg.fsf@gitster.dls.corp.google.com>
 <CALKQrgdAhLZStLUquizkW_t6wVQsWs0hpGauEm8NjB6tZ67JFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Oct 19 04:53:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXMfb-0002pc-KE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 04:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab3JSCxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 22:53:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:51868 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751950Ab3JSCxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 22:53:20 -0400
Received: (qmail 15283 invoked by uid 102); 19 Oct 2013 02:53:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Oct 2013 21:53:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Oct 2013 22:53:17 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgdAhLZStLUquizkW_t6wVQsWs0hpGauEm8NjB6tZ67JFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236384>

On Sat, Oct 19, 2013 at 01:45:03AM +0200, Johan Herland wrote:

> I'm trying to mentally construct a scenario where two writers with
> different configuration contexts - one with shared_repository and one
> without - compete in this race, and we somehow end up with one of them
> not being able to write its object. But the best/worst case I manage
> to construct is this:
> 
> 1. core.sharedRepository = 0640 (group-read-only)
> 2. Fetch A starts running
> 3. core.sharedRepository = 0660 (group-writable)
> 4. Fetch B starts running as a non-owner (i.e. depends on group-writability)
> 5. One of them (doesn't matter which) wins the mkdir() race
> 6. A and B next enter the adjust_shared_perm() race
> 7. B first sets dir mode to 0660
> 8. A then sets dir mode to 0640
> 9. B now tries to write its object into the dir, but fails because
> it's not group-writable
> [...]
> Trying to code around this (frankly insane) case in the
> create_tmpfile()/adjust_shared_perm() code is IMHO silly.

Yeah, I'd agree. You cannot just willy-nilly set core.sharedRepository
per-process and expect things to work. I do not think your patch makes
anything worse there.

I was wondering more about the chmod call itself in adjust_shared_perms,
though, even if both processes have the same settings.  If we have lost
the mkdir race, then the other process created the directory, and it may
have a different owner, causing our chmod to fail.

If we call adjust_shared_perm after an EEXIST, we are subject to this
race:

  1. A calls mkdir, creates directory
  2. B calls mkdir, gets EEXIST
  3. B calls adjust_shared_perm, which wants to set g+w. It calls
     chmod(), which fails (it's A's directory)
  4. A calls adjust_shared_perm, which sets g+w; all is well if B now
     creates the object, but it already barfed after failing step 3.

But if we do not call adjust_shared_perm, we are subject to this race:

  1. A calls mkdir, creates directory
  2. B calls mkdir, gets EEXIST
  3. B tries to create object in the directory, but fails (no
     permission)
  4. A calls adjust_shared_perm, but B has already barfed due to failure
     in step 3

I do not see an easy way around it. Only A can set the permissions, and
B cannot continue until A has done so. So we would need some kind of
synchronization (B busy-waits checking for A's chmod? Yech), or we would
need to atomically create the directory with the right permissions (and
group).

I do not think of any of this is introduced or made worse by your patch,
though.  Without your patch, we do not even get as far as wondering
about permissions. :)

Your patch successfully handles the single-user case, but stops short of
handling the multi-user case. I am not sure if it is worth trying to
follow-on to fix the multi-user race, but even if we do, it would want
to build on top of your patch anyway.

-Peff
