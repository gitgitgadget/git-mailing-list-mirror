From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] git-apply: apply submodule changes
Date: Fri, 10 Aug 2007 22:43:42 -0700
Message-ID: <7vd4xupqwh.fsf@assigned-by-dhcp.cox.net>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
	<20070810135744.GA29243MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes.Schindelin@gmx.de
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Aug 11 07:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJjlO-0007kT-4b
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 07:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXHKFnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 01:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXHKFnp
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 01:43:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40047 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbXHKFno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 01:43:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811054345.GKPO1335.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 01:43:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aVji1X00u1kojtg0000000; Sat, 11 Aug 2007 01:43:43 -0400
In-Reply-To: <20070810135744.GA29243MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Fri, 10 Aug 2007 15:57:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55587>

Sven Verdoolaege <skimo@kotnet.org> writes:

> @@ -1994,20 +2014,18 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
>  	alloc = 0;
>  	buf = NULL;
>  	if (cached) {
> -		if (ce) {
> -			enum object_type type;
> -			buf = read_sha1_file(ce->sha1, &type, &size);
> -			if (!buf)
> -				return error("read of %s failed",
> -					     patch->old_name);
> -			alloc = size;
> -		}
> +		if (read_file_or_gitlink(ce, &buf, &size))
> +			return error("read of %s failed", patch->old_name);
> +		alloc = size;
>  	}
>  	else if (patch->old_name) {
>  		size = xsize_t(st->st_size);
>  		alloc = size + 8192;
>  		buf = xmalloc(alloc);
> -		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
> +		if (S_ISGITLINK(patch->old_mode))
> +			size = snprintf(buf, alloc,
> +				"Subproject commit %s\n", sha1_to_hex(ce->sha1));
> +		else if (read_old_data(st, patch->old_name, &buf, &alloc, &size))

Who guarantees that ce is given to apply_data() in this codepath?
