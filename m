From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Mon, 26 Sep 2005 17:09:31 -0700
Message-ID: <20050927000931.GA15615@reactrix.com>
References: <20050926175204.GC9410@reactrix.com> <7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 02:10:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK32c-0002pY-TQ
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 02:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVI0AJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 20:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVI0AJn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 20:09:43 -0400
Received: from 194.37.26.69.virtela.com ([69.26.37.194]:22919 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750817AbVI0AJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 20:09:43 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j8R09WUj017258;
	Mon, 26 Sep 2005 17:09:32 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j8R09VIP017256;
	Mon, 26 Sep 2005 17:09:31 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9355>

On Mon, Sep 26, 2005 at 02:19:31PM -0700, Junio C Hamano wrote:

> If rename() succeeds then tmpfile is no more.  If rename() fails
> because there were no tmpfile to begin with, it is not an error
> (i.e. you are not recovering) and that case there would not be
> tmpfile either.  Otherwise, if tmpfile still remains to unlink()
> because rename() failed for any other reason, wouldn't you
> rather report it as an error and abort?

I didn't see that as a fatal condition since the transfer would still
take place, albeit a full transfer rather than a partial one.  It does
seem worth at least reporting it as a warning though.  If a previous
tmpfile exists and both the rename and unlink fail, the subsequent
tmpfile open will also fail - unlikely but probably also worth
detecting and reporting.

> I wonder what happens if by mistake or intentionally we run two
> http-fetch instances simultaneously.  IIRC, the current code is
> safe -- the resulting object database will have the object file
> fetched by one of the instance, and the updating of ref is done
> via write_ref_sha1(), so it also is safe.  But your change may
> introduce an interesting case where one creates a tmpfile, the
> other one moves it to prevfile and starts using its partial
> contents, and possibly gets confused -- it will probabaly fail
> at the end detecting inconsistent object so it is probably not a
> big loss.

How about using mkstemp on the prev file to keep multiple instances
from stepping on each other?  Since O_CREAT | O_EXCL is used to
open the tmpfile, only one instance will be able to succeed and
continue.

> > +	/* Reset inflate/SHA1 if there was an error reading the previous temp
> > +	   file; also rewind to the beginning of the local file. */
> 
> Maybe not just rewind but truncate as well?  It probably does
> not matter in practice much, but previous representation your
> fetch was interrupted in the middle could have been much larger
> than the representation you are slurping right now.

Good point, I'll update the patch.

> There was a discussion about an object file of the same SHA1 and
> the same contents can have different compressed representations
> (we hash then compress so the resulting filesize depends on the
> compression level without affecting the contents of the object).
> In a "doctor, it hurts when I do this -- don't do it, then" kind
> of corner case, a DNS rotated pair of webservers could be
> serving the same object in different representations and you may
> get interrupted while fetching from one, and restart the
> transfer from the other.  The SHA1 check at the end hopefully
> would catch this kind of situation, and that round of http-fetch
> would fail -- the user needs to re-run the fetch so it is not a
> big loss, but it is something to keep in mind.

That's an annoying case, all right...  Would it be worth including a 
full retry if a partial failed the SHA1 check?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
