From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Wed, 30 Oct 2013 05:30:17 -0400
Message-ID: <20131030093017.GA12125@sigill.intra.peff.net>
References: <1382873743-4648-1-git-send-email-johan@herland.net>
 <20131030091927.GQ11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 10:30:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbS6a-0006VI-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 10:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab3J3JaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 05:30:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:58362 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730Ab3J3JaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 05:30:20 -0400
Received: (qmail 21549 invoked by uid 102); 30 Oct 2013 09:30:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 04:30:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 05:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20131030091927.GQ11317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237006>

On Wed, Oct 30, 2013 at 05:19:27AM -0400, Jeff King wrote:

> > To achieve this, I guess we have to follow the same procedure we do for
> > loose object creation:
> > 
> >  1. Create a temporary directory with a unique name (mkdtemp?)
> > 
> >  2. Adjust permissions
> > 
> >  3. Rename into place
> > 
> > Can this be done sufficiently atomically across all platforms?
> 
> Yeah, I think that is the only way to do it. I do not know offhand of
> any platforms that have problems with atomic directory renames, though I
> would not be surprised if some network filesystems don't handle it well.

Actually, thinking on this more, we do not want "rename into place"
semantics, as that usually implies overwrite. We would prefer a
hard-link solution, where only one linker "wins", and the other gets
EEXIST. But you cannot hard-link directories.

POSIX does specify that rename() should return EEXIST rather than
overwriting if the destination directory exists and is not empty. So
in theory that would work, as we would then just be racing against the
other process creating the actual object (and either we replace the
directory with ours before they write the object, or they write the
object first and we get EEXIST).

But I don't know how well that is followed in the real world.

-Peff
