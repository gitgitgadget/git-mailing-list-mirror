From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Unify write_index_file functions
Date: Fri, 01 Jun 2007 13:15:54 -0700
Message-ID: <7vy7j3xwg5.fsf@assigned-by-dhcp.cox.net>
References: <20070601194856.66DFB4D7206@potomac.gnat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@gnat.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:16:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuDXZ-00083C-1v
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 22:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762303AbXFAUP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 16:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762558AbXFAUP4
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 16:15:56 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48924 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762303AbXFAUPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 16:15:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601201554.VNPG14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 16:15:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6LFu1X0071kojtg0000000; Fri, 01 Jun 2007 16:15:54 -0400
In-Reply-To: <20070601194856.66DFB4D7206@potomac.gnat.com> (Geert Bosch's
	message of "Fri, 1 Jun 2007 15:18:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48882>

Geert Bosch <bosch@gnat.com> writes:

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index e52332d..d4c5d2b 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -24,9 +24,10 @@ git-pack-objects [{ -q | --progress | --all-progress }] [--max-pack-size=N] \n\
>  
>  struct object_entry {
>  	unsigned char sha1[20];
> -	uint32_t crc32;		/* crc of raw pack data for this object */
>  	off_t offset;		/* offset into the final pack file */
>  	unsigned long size;	/* uncompressed size */
> +	uint32_t crc32;		/* crc of raw pack data for this object */
> +
>  	unsigned int hash;	/* name hint hash */
>  	unsigned int depth;	/* delta depth */
>  	struct packed_git *in_pack; 	/* already in pack */

Why?  off_t offset used to be 8-byte aligned but now it is not...

> diff --git a/index-pack.c b/index-pack.c
> index 58c4a9c..ed6ff9c 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -13,13 +13,14 @@ static const char index_pack_usage[] =
>  
>  struct object_entry
>  {
> +	unsigned char sha1[20];
>  	off_t offset;
>  	unsigned long size;
> -	unsigned int hdr_size;
>  	uint32_t crc32;
> +
> +	unsigned int hdr_size;
>  	enum object_type type;
>  	enum object_type real_type;
> -	unsigned char sha1[20];
>  };
>  
>  union delta_base {

Ah, you wanted to match the shape of the early part of two
structures.  Sounds error prone for people who would want to
maintain both programs in the future.

Why not make the private "struct object_entry" in each users
have an embedded structure at the beginning like this:

	struct object_entry {
        	struct idx_object_entry idx;
                unsigned int hash;
                unsigned int depth;
                ...
	}; /* in builtin-pack-objects.c */

        struct object_entry {        
        	struct idx_object_entry idx;
                unsigned int hdr_size;
                enum object_type type;
                enum object_type real_type;
	}; /* in index-pack.c */
