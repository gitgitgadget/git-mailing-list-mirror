From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Look at both unpacked and packed objects for short name expansion
Date: Thu, 15 Sep 2005 17:28:00 -0700
Message-ID: <7vfys5votr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509160120470.3859@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 02:28:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG45O-0007yq-2w
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 02:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbVIPA2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVIPA2I
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 20:28:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11167 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030476AbVIPA2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 20:28:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916002801.MTAW3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 20:28:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509160120470.3859@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 16 Sep 2005 01:21:18 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8655>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We used to check for a unique expansion in the unpacked objects, and if
> one was found, we forgot to check in the packed objects, too.

> diff --git a/sha1_name.c b/sha1_name.c
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -115,7 +115,8 @@ static int get_short_sha1(const char *na
>  	if (i < 4)
>  		return -1;
>  	if (find_short_object_filename(i, canonical, sha1))
> -		return 0;
> +                /* do not allow non-unique short names */
> +                return find_short_packed_object(i, res, canonical)!=0?-1:0;
>  	if (find_short_packed_object(i, res, sha1))
>  		return 0;
>  	return -1;

Sorry, I do not understand what you are doing here.

We find an unpacked object file in the local object store, and
then if we find a unique match (otherwise we try if
short-packed-object finds unique match) we try to see if we have
the same one in one of the packs we have and refuse?  Wouldn't
this make things inconvenient for people who run 'git repack'
without running 'git prune-packed' afterwards?

And reading find_short_object_filename() I noticed it does not
do anything with alternates, and wonder if is this intentional.
Who did this part anyway?

Also find_short_packed_object() does not appear to require
unique prefix when it does its thing.

I would prefer a proper fix to:

 - find_short_object_filename() to look at alt_odb as well;

 - find_short_packed_object() to make sure it is getting a
   unique match.

 - get_short_sha1() to make sure that the input is overall
   unique.  I think with the current code structure, with or
   without your patch, would do a wrong thing if you pass a
   prefix that matches two unpacked objects and two packed
   ones.

I suspect your patch is an attempt to fix the last one, but I am
not sure..
