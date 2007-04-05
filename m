From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 10/13] update delta handling in write_object() for --pack-limit
Date: Thu, 05 Apr 2007 16:18:21 -0700
Message-ID: <7v3b3emmv6.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051538na4393d7k5e51ed2a511cc86e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZbED-0003EW-0T
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767406AbXDEXSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767412AbXDEXSl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:18:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59593 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767273AbXDEXSW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:18:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405231823.MYFB373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 19:18:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jbJM1W00U1kojtg0000000; Thu, 05 Apr 2007 19:18:21 -0400
In-Reply-To: <56b7f5510704051538na4393d7k5e51ed2a511cc86e@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 15:38:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43883>

"Dana How" <danahow@gmail.com> writes:

> Subject: [PATCH 10/13] update delta handling in write_object() for --pack-limit
>
> ---
>  builtin-pack-objects.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index ccc2d15..a243eed 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -419,13 +419,17 @@ static off_t write_object(struct sha1file *f,
>  	}
>  
>  	if (!to_reuse) {
> +		int usable_delta =	!entry->delta ? 0 :
> +					!offset_limit ? 1 :
> +					entry->delta->no_write ? 0 :
> +					entry->delta->offset ? 1 : 0;
>  		buf = read_sha1_file(entry->sha1, &type, &size);
>  		if (!buf)
>  			die("unable to read %s", sha1_to_hex(entry->sha1));
>  		if (size != entry->size)
>  			die("object %s size inconsistency (%lu vs %lu)",
>  			    sha1_to_hex(entry->sha1), size, entry->size);
> -		if (entry->delta) {
> +		if (usable_delta) {
>  			buf = delta_against(buf, size, entry);
>  			size = entry->delta_size;
>  			obj_type = (allow_ofs_delta && entry->delta->offset) ?

This really needs explanation on *why*, at least in the commit
log, and perhaps also in the code as comment.

Here is my attempt to understand that logic (please make
necessary corrections).

 (1) When there is no delta base found by the earlier
     find_deltas()/try_delta() loop, obviously we cannot write
     deltified so we write plain.

 (2) Otherwise if we are not offset limited, then we keep the
     old way of using that delta base.

 (3) If the delta base is not in this pack (because of
     offset-limit chomping the pack into two or more), then we
     cannot use it as the base.

 (4) If the delta has already been written, we can use it as the
     base for this object, but otherwise we cannot.

(3) makes me wonder if we can still allow it in the thin-pack
case by just loosening the condition here.

Also I need explanation to understand why (4) is needed --
doesn't write_one() always write base object out before writing
a deltified object that depends on it?
