From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/6] many cleanups to sha1_file.c
Date: Sat, 23 Sep 2006 01:44:56 -0700
Message-ID: <7v7izvug3b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609210004550.2627@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 10:45:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR38d-0004se-Id
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 10:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWIWIo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 04:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWIWIo6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 04:44:58 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11248 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWIWIo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 04:44:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923084457.OYCE21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sat, 23 Sep 2006 04:44:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rkkz1V0021kojtg0000000
	Sat, 23 Sep 2006 04:44:59 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27570>

Nicolas Pitre <nico@cam.org> writes:

> Those cleanups are mainly to set the table for the support of deltas
> with base objects referenced by offsets instead of sha1.  This means
> that many pack lookup functions are converted to take a pack/offset
> tuple instead of a sha1.

There still remains some "struct pack_entry" and I wonder if it
would make sense to get rid of them if only for consistency's
sake.

> diff --git a/sha1_file.c b/sha1_file.c
> index b89edb9..6fae766 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -926,8 +925,8 @@ static int packed_delta_info(unsigned ch
>  
>  		memset(&stream, 0, sizeof(stream));
>  
> -		data = stream.next_in = base_sha1 + 20;
> -		stream.avail_in = left - 20;
> +		data = stream.next_in = (unsigned char *) p->pack_base + offset;;
> +		stream.avail_in = p->pack_size - offset;
>  		stream.next_out = delta_head;
>  		stream.avail_out = sizeof(delta_head);
>  

";;"?

> @@ -989,75 +988,60 @@ int check_reuse_pack_delta(struct packed
>  ...
> +static int packed_object_info(struct packed_git *p, unsigned long offset,
>  			      char *type, unsigned long *sizep)
>  {
> +	unsigned long size;
>  	enum object_type kind;
>  
> -	if (use_packed_git(p))
> -		die("cannot map packed file");
> +	offset = unpack_object_header(p, offset, &kind, &size);
>  

Do all callers of packed_object_info() call use_packed_git to
make sure p is mapped?  Ah sha1_object_info() is the only one
except packed_delta_info() that calls itself and it protects it
with use_packed_git(), so you are safe.

We would need to revamp use/unuse code when we implement the
partial mapping anyway, but we still need to get this right for
now.
