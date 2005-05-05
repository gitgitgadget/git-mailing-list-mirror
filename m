From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Wed, 04 May 2005 19:13:43 -0700
Message-ID: <7vy8aul8rs.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<20050504223532.GA22967@vrfy.org>
	<7vwtqemvjt.fsf@assigned-by-dhcp.cox.net>
	<20050505012051.GA26201@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 04:07:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTVlq-00062T-6m
	for gcvg-git@gmane.org; Thu, 05 May 2005 04:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVEECNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 22:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVEECNy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 22:13:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31670 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261800AbVEECNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 22:13:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050505021345.FTZA7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 22:13:45 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050505012051.GA26201@vrfy.org> (Kay Sievers's message of
 "Thu, 5 May 2005 03:20:51 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

>> * It continues to assume that S_IFREG, S_IFDIR and S_IFLNK have
>> the same bit pattern everywhere....

>> * read-cache.c:cache_match_stat() ...

KS> Both included and updated.

The second one, yes, but the first one is "not really".  If you
are going to do this:

KS> +#define CE_IFREG  0100000
KS> +#define CE_IFDIR  0040000
KS> ...
KS> +#define CE_IFMASK 0770000
 
then you need to touch these things:

KS> +	mode = ntohl(ce->ce_mode);
KS> +	if (S_ISLNK(mode)) {

Here mode encodes type in CE_ format, so S_ISLNK() is bad.

KS> @@ -165,7 +165,7 @@ static void prepare_temp_file(const char
KS>  		}
KS>  		strcpy(temp->hex, sha1_to_hex(null_sha1));
KS>  		sprintf(temp->mode, "%06o",
KS> -			S_IFREG |ce_permissions(st.st_mode));
KS> +			S_IFREG | ce_permissions(st.st_mode));
KS>  	}

Likewise here, although this is my bad.  I did not know if you
are going to take CE_ type suggestion so I left it as it was.

There are more.  "grep 'S_I[SF]' *.[ch] */*.[ch]" would tell us
most if not all.  We probably would want to have CE_ISLNK() and
friends, parallel to S_ISLNK() and friends if we go this route.

Does POSIX or something have nice to say that we do not have to
worry about this?  Or are the stat type bits really different on
different Unixen?  I used to do porting for living across a
dozen or so different Unixen long time ago and I should know the
answer to this kind of thing by heart, but I do not anymore X-<.

