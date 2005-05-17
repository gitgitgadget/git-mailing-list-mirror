From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 10:12:50 -0700
Message-ID: <7vfywlhj3h.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505171130460.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 17 19:21:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY5iy-000618-4Y
	for gcvg-git@gmane.org; Tue, 17 May 2005 19:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEQRTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 13:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVEQRP6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 13:15:58 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:9935 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261894AbVEQRMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 13:12:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517171252.EGBW550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 13:12:52 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505171130460.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 17 May 2005 11:52:17 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> I'm already going to add a per-type global to have the parse functions
DB> also unpack the object contents user-visibly, for the case that Junio
DB> pointed out. (Making it: parse_* doesn't change whether the contents are
DB> unpacked, unless you tell it to unpack objects.)

That sounds better than the patch you sent last night, but are
we sure that callers would be satisfied if you just make some
_types_ more special than others?

Parse functions need to unpack anyway, so it might make more
sense to add an optional callback just after where unpacking
happens to ask the main program if it wants the unpacked raw
data to be kept.  So you would do something like:

    struct object *parse_object(unsigned char *sha1)
    {
   ...
                    unsigned long size;
                    void *buffer = unpack_sha1_file(map, mapsize, type, &size);
                    munmap(map, mapsize);
                    if (!buffer)
                            return NULL;
   ...             
                    } else {
                            obj = NULL;
                    }
+		    if (obj && keep_object_raw_data(sha1, type, size, buffer)) {
+                           obj.raw_data = buffer;
+                           obj.raw_size = size;
+                   } else 
                            free(buffer);
                    return obj;
            }
            return NULL;
    }

And put a dummy implementation of keep_object_raw_data() that
says "I do not want anything to be kept" in the libgit.a.  Main
programs that _care_ about raw data can implement their own
keep_object_raw_data() callback that is more intelligent.
In addition you give them the interface to free raw data you
already have.

DB> I think the only likely bug would be unpacking objects after parsing
DB> them, instead of before, which is correct but inefficient. It should be
DB> clear to a user whether the raw contents are available at any point in the
DB> user code.

Another possibility is not to make double unpacking too costly
by having an LRU of unpack_sha1_file(), but I am not sure how
effective that would be.

