From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 15:05:37 -0400
Message-ID: <20131018190537.GB11040@sigill.intra.peff.net>
References: <1382102267-18151-1-git-send-email-johan@herland.net>
 <CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
 <CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
 <CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXFMm-0001Sd-SG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011Ab3JRTFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:05:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:51681 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756805Ab3JRTFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:05:39 -0400
Received: (qmail 23296 invoked by uid 102); 18 Oct 2013 19:05:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Oct 2013 14:05:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Oct 2013 15:05:37 -0400
Content-Disposition: inline
In-Reply-To: <CALKQrgcc6gXcthgZgrGS6YA0b8KmnaG=WO=Eu_YQc9pgjRRj6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236363>

On Fri, Oct 18, 2013 at 05:41:54PM +0200, Johan Herland wrote:

>  (c) mkdir() fails with EEXIST, i.e. we lost the race. We do the
> adjust_shared_perms() which might fail (-> abort) or succeed, and we
> then _retry_ the git_mkstemp_mode(). There is no case where the
> "whatever" that happened between the first git_mkstemp_mode() and
> mkdir() will have a different outcome (create_tmpfile() failing or
> suceeding) than if it had happened _before_ the first
> git_mkstemp_mode().

I think your (c) is fine as long as adjust_shared_perms() is idempotent,
as we will run it twice (one for each side of the race). But from my
reading, I think it is.

I was almost tempted to say "we do not even need to run
adjust_shared_perm twice", but we do, or we risk another race: one side
loses the mkdir race, but wins the open() race, and writes to a
wrong-permission directory. Of course, that should not matter unless the
racers are two different users (in a shared repo), and in that case, we
wins the adjust_shared_perm race, but does not have permission to change
the mode.

> And it is not our responsibility to control what
> other/unrelated processes might end up doing with directories inside
> .git/objects/...

Agreed. We already leave a wrong-permission directory in place if it
existed before we started create_tmpfile. The code before your patch,
when racing with such a wrong-directory creator, would abort the
tmpfile. Now it will correct the permissions. Either behavior seems fine
to me (yours actually seems better, but the point is that it does not
matter because they are dwarfed by the non-race cases where the
directory is already sitting there).

-Peff
