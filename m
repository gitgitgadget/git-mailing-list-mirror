From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 22/22] lockfile: allow new file contents to be written
 while retaining lock
Date: Tue, 1 Apr 2014 16:39:00 -0400
Message-ID: <20140401203900.GI21715@sigill.intra.peff.net>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
 <1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 22:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV5Sf-0000Yr-Ic
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 22:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbaDAUjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 16:39:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:52094 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751472AbaDAUjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 16:39:03 -0400
Received: (qmail 23443 invoked by uid 102); 1 Apr 2014 20:39:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 15:39:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 16:39:00 -0400
Content-Disposition: inline
In-Reply-To: <1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245657>

On Tue, Apr 01, 2014 at 05:58:30PM +0200, Michael Haggerty wrote:

> Add a new option flag, LOCK_SEPARATE_STAGING_FILE, that can be passed
> to hold_lock_file_for_update() or hold_lock_file_for_append() to use a
> staging file that is independent of the lock file.
> 
> Add a new function activate_staging_file() that activates the contents
> that have been written to the staging file without releasing the lock.
> 
> This functionality can be used to ensure that changes to two files are
> seen by other processes in one order even if correctness requires the
> locks to be released in another order.

Can you give an example of when this is useful? I'm guessing the
application is for writing out packed-refs before pruning loose refs in
git-pack-refs?

It seems like this makes the API much more confusing.  If I understand
correctly, this is basically allowing us to take a lock, write to
_another_ tmpfile that is not the lock, then rename the tmpfile into
place without releasing the lock (and then we can drop the lock at our
convenience).

I wonder if it would be simpler to build an API for that around the
lock_file API, rather than as part of it. Or am I misunderstanding
what's going on?

-Peff
