From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Mon, 26 Sep 2005 14:19:31 -0700
Message-ID: <7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
References: <20050926175204.GC9410@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 23:20:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0Ns-0003Xt-Pl
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVIZVTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIZVTe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:19:34 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8100 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932107AbVIZVTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 17:19:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926211932.JCDK16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 17:19:32 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050926175204.GC9410@reactrix.com> (Nick Hengeveld's message of
	"Mon, 26 Sep 2005 10:52:04 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9335>

Nick Hengeveld <nickh@reactrix.com> writes:

> +	unlink(prevfile);
> +	rename(tmpfile, prevfile);
> +	unlink(tmpfile);

If rename() succeeds then tmpfile is no more.  If rename() fails
because there were no tmpfile to begin with, it is not an error
(i.e. you are not recovering) and that case there would not be
tmpfile either.  Otherwise, if tmpfile still remains to unlink()
because rename() failed for any other reason, wouldn't you
rather report it as an error and abort?

I wonder what happens if by mistake or intentionally we run two
http-fetch instances simultaneously.  IIRC, the current code is
safe -- the resulting object database will have the object file
fetched by one of the instance, and the updating of ref is done
via write_ref_sha1(), so it also is safe.  But your change may
introduce an interesting case where one creates a tmpfile, the
other one moves it to prevfile and starts using its partial
contents, and possibly gets confused -- it will probabaly fail
at the end detecting inconsistent object so it is probably not a
big loss.

Personally, I do not think people would mind much if we
introduce the BKL at the beginning of git-fetch.sh to prevent
multiple fetches stomping on each other, if somebody cared
enough (hint, hint).

> -	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX",
> -		 get_object_directory());
> +	local = open(tmpfile, O_WRONLY | O_CREAT | O_EXCL, 0666);
> -	local = mkstemp(tmpfile);

I introduced this mkstemp() part recently to mimic the local
object creation where newly created object files are built in
the same directory, hoping that they would be allocated close to
each other when more than one are created in sequence.  I do not
know it matters much in practice -- has anybody measured, and
does anybody care?

> +	/* Reset inflate/SHA1 if there was an error reading the previous temp
> +	   file; also rewind to the beginning of the local file. */

Maybe not just rewind but truncate as well?  It probably does
not matter in practice much, but previous representation your
fetch was interrupted in the middle could have been much larger
than the representation you are slurping right now.

There was a discussion about an object file of the same SHA1 and
the same contents can have different compressed representations
(we hash then compress so the resulting filesize depends on the
compression level without affecting the contents of the object).
In a "doctor, it hurts when I do this -- don't do it, then" kind
of corner case, a DNS rotated pair of webservers could be
serving the same object in different representations and you may
get interrupted while fetching from one, and restart the
transfer from the other.  The SHA1 check at the end hopefully
would catch this kind of situation, and that round of http-fetch
would fail -- the user needs to re-run the fetch so it is not a
big loss, but it is something to keep in mind.
