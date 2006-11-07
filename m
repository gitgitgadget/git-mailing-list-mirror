X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 00:11:30 +0100
Message-ID: <20061107231130.GA5141@steel.home>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com> <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com> <eiq9vm$l7c$1@sea.gmane.org> <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org> <20061107185648.GE26591@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 23:11:59 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061107185648.GE26591@spearce.org>
User-Agent: Mutt/1.5.11
X-ID: r3Smk0ZdwerGS26e0svj2kfklJcQvbqy7NvOexbtys1+T4gEjxqPgb
X-TOI-MSGID: 0d667b0b-38f9-4f86-8aab-f7ea60a6d697
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31099>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gha6Y-0003IW-3F for gcvg-git@gmane.org; Wed, 08 Nov
 2006 00:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753242AbWKGXLj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 18:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbWKGXLj
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 18:11:39 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:34465 "EHLO
 mailout11.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1753242AbWKGXLi (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006
 18:11:38 -0500
Received: from fwd27.aul.t-online.de  by mailout11.sul.t-online.com with smtp
  id 1Gha6O-0003Dr-00; Wed, 08 Nov 2006 00:11:32 +0100
Received: from tigra.home
 (r3Smk0ZdwerGS26e0svj2kfklJcQvbqy7NvOexbtys1+T4gEjxqPgb@[84.163.111.6]) by
 fwd27.sul.t-online.de with esmtp id 1Gha6N-2ERIau0; Wed, 8 Nov 2006 00:11:31
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id DCD7C277AF; Wed,  8 Nov 2006 00:11:30 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Gha6M-0000os-1C; Wed, 08 Nov 2006 00:11:30 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce, Tue, Nov 07, 2006 19:56:48 +0100:
> I've pushed the changes out to repo.or.cz:
> 
> 	http://repo.or.cz/w/git/fastimport.git
> 
> in the window-mapping branch.  Note that this is based on a slightly
> older version of Git (v1.4.2).  There are two "tuneables" on line 376
> of sha1_file.c, this is the maximum amount of memory (in bytes) to
> denote to packs and the maximum chunk size of each pack (in bytes).

Thanks.
I couldn't help noticing that the interface to the packs data is
a bit complex:

    unsigned char *use_pack(struct packed_git *p,
			    struct pack_window **window,
			    unsigned long offset,
			    unsigned int *left);
    void unuse_pack(struct pack_window **w);

Can I suggest something like below?

    unsigned char *use_pack(struct packed_git *p,
			    off_t offset, size_t size, size_t *mapped);
    void unuse_pack(struct packed_git *p, off_t offset, size_t size);
    or
    void unuse_pack(struct packed_git *p, unsigned char *data);

    (where size/maxsize is the amount of bytes at the offset in the
    pack file the caller was asking for. use_pack would fail if offset
    or size do not pass sanity checks (offset past end of file, size
    is 0).  The mapped argument would get the length of the data
    actually mapped, and can be less than requested, subject to end of
    data). The window sliding code seem to have all information it
    needs with this set of arguments.

Or am I missing something very obvious, and something like this
is just not feasible for some reasons?

I'm asking because I tried to slowly rebase the window-mapping up and
merge the newer branches into it (to get it working with more recent
code). At some point I came over conflicts and one of them got me
thinking about the interface. That's the part:

<<<<<<< HEAD/sha1_file.c
	c = *use_pack(p, w, offset++, NULL);
	*type = (c >> 4) & 7;
	size = c & 15;
	shift = 4;
	while (c & 0x80) {
		c = *use_pack(p, w, offset++, NULL);
		size += (c & 0x7f) << shift;
		shift += 7;
	}
	*sizep = size;
	return offset;
=======
	used = unpack_object_header_gently((unsigned char *)p->pack_base +
					   offset,
					   p->pack_size - offset, type, sizep);
	if (!used)
		die("object offset outside of pack file");

	return offset + used;
>>>>>>> f685d07de045423a69045e42e72d2efc22a541ca/sha1_file.c

I was almost about to move your code into unpack_object_header_gently,
but ... The header isn't that big, is it? It is variable in the pack,
but the implementation of the parser is at the moment restricted by
the type we use for object size (unsigned long for the particular
platform). For example:

	/* Object size is in the first 4 bits, and in the low 7 bits
	 * of the subsequent bytes which have high bit set */
	#define MAX_LOCAL_HDRSIZE ((sizeof(long) * 8 - 4) / 7 + 1)
	unsigned long size;
	unsigned char *header = use_pack(p, offset, MAX_LOCAL_HDRSIZE, &size);
	if (!header)
	    die("object header offset out of range");
	/* unpack_object_header_gently takes care about truncated
	 * headers, by returning 0 if it encounters one */
	used = unpack_object_header_gently(header, size, type, sizep);

Wouldn't have to change unpack_object_header_gently at all.

(BTW, current unpack_object_header_gently does not use it's len
argument to check if there actually is enough data to hold at least
minimal header. Is the size of mapped data checked for correctness
somewhere before?)
