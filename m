From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Wed, 04 May 2005 16:16:22 -0700
Message-ID: <7vwtqemvjt.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<20050504223532.GA22967@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:10:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTT0B-0004Hy-2V
	for gcvg-git@gmane.org; Thu, 05 May 2005 01:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVEDXQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 19:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVEDXQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 19:16:29 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:642 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261949AbVEDXQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 19:16:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504231621.CJLH550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 19:16:21 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050504223532.GA22967@vrfy.org> (Kay Sievers's message of
 "Thu, 5 May 2005 00:35:32 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It seems to follow the original suggestion by Linus and looks
good.  Some comments:

 * It continues to assume that S_IFREG, S_IFDIR and S_IFLNK have
   the same bit pattern everywhere.  In the same spirit as we
   store mode bits in network byte order, it may be a good time
   to introduce something like this:

   -#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
   -#define create_ce_mode(mode) htonl(S_IFREG | ce_permissions(mode))
   +#define CE_IFREG  0100000
   +#define CE_IFDIR  0040000
   +#define CE_IFLNK  0120000
   +#define CE_IFMASK 0770000
   +
   +#define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644) /* REG only */ 
   +#define create_ce_mode(mode) htonl(S_ISREG(mode) ?
   +				   (CE_IFREG | ce_permissions(mode)) :
   +				   S_ISLNK(mode) ?
   +				   CE_IFLNK :
   +				   0) /* what would we do for unknowns? */

 * read-cache.c:cache_match_stat() needs to know about the
   object type.  It was allowed to assume that anything thrown
   at it was a file, but not anymore.  How about something like
   this:

     int cache_match_stat(struct cache_entry 
     {
            unsigned int changed = 0;

    +       switch (ntohl(ce->ce_mode) & CE_IFMASK) {
    +       case CE_IFREG:
    +               changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
    +               break;
    +       case CE_IFLNK:
    +               changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
    +               break;
    +       default:
    +               die("internal error: ce_mode is %o", ntohl(ce->ce_mode));
    +       }

    (in cache.h) 
     #define INODE_CHANGED   0x0010
     #define DATA_CHANGED    0x0020
    +#define TYPE_CHANGED    0x0040

  * update-cache.c:refresh_entry() needs to know that if the
    type of the path changed, it would never match:

            /*
    -        * If the mode has changed, there's no point in trying
    +        * If the mode or type has changed, there's no point in trying
             * to refresh the entry - it's not going to match
             */
    -       if (changed & MODE_CHANGED)
    +       if (changed & (MODE_CHANGED | TYPE_CHANGED))
                    return ERR_PTR(-EINVAL);

            if (compare_data(ce, st.st_size))

  * (this is just a minor nit).  Since you have st here,
    st.st_size can be used to see how big a buffer you need to
    prepare for readlink() here:

    +               unsigned int len;
    +               char target[1024];
    +               ce->ce_mode = htonl(S_IFLNK);
    +               len = readlink(path, target, sizeof(target));
    +               if (len == -1 || len+1 > sizeof(target))
    +                       return -1;

  * Probably diff.c needs to be made aware of this change.

