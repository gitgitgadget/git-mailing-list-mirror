From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB nonzero, not 7
Date: Thu, 05 Apr 2007 15:51:36 -0700
Message-ID: <7vr6qymo3r.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZant-0003m1-Ag
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767249AbXDEWvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767392AbXDEWvi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:51:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60442 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767249AbXDEWvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:51:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405225138.NFJR25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 18:51:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jarc1W00Y1kojtg0000000; Thu, 05 Apr 2007 18:51:37 -0400
In-Reply-To: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 15:24:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43877>

"Dana How" <danahow@gmail.com> writes:

> Subject: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB nonzero, not 7
>
> ---
>  builtin-pack-objects.c   |    2 +-
>  builtin-unpack-objects.c |    2 +-
>  index-pack.c             |    2 +-
>  sha1_file.c              |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index b5f9648..50246e1 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1014,7 +1014,7 @@ static void check_object(struct object_entry *entry)
>  				ofs = c & 127;
>  				while (c & 128) {
>  					ofs += 1;
> -					if (!ofs || ofs & ~(~0UL >> 7))
> +					if (!ofs || ofs & ~(~0UL >> 1))
>  						die("delta base offset overflow in pack for %s",
>  						    sha1_to_hex(entry->sha1));
>  					c = buf[used_0++];

The line after these context does this:

	ofs = (ofs << 7) + (c & 127);

If you do not check the top 7 bits, wouldn't you miss overflow?
