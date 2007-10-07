From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Have a filter_start/filter_end API.
Date: Sun, 7 Oct 2007 23:50:41 +0200
Message-ID: <20071007215041.GB2765@steel.home>
References: <1191615571-15946-1-git-send-email-madcoder@debian.org> <1191615571-15946-2-git-send-email-madcoder@debian.org> <20071006090621.GB2711@steel.home> <20071007145355.GC10024@artemis.corp> <20071007160707.GA3270@steel.home> <20071007165218.GE10024@artemis.corp>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 23:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iee1Z-0008Fu-Ki
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbXJGVuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbXJGVuq
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:50:46 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:40531 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXJGVup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:50:45 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo52) (RZmta 13.4)
	with ESMTP id B02e28j97JeVNL ; Sun, 7 Oct 2007 23:50:41 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 45147277AE;
	Sun,  7 Oct 2007 23:50:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 23F71C502; Sun,  7 Oct 2007 23:50:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071007165218.GE10024@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60225>

Pierre Habouzit, Sun, Oct 07, 2007 18:52:18 +0200:
>   So, maybe there is a way to rename strbuf_start_filter so that it's
> more straightforward. The way to use the API is:
> 
>  @  char *to_free = NULL;
>  @  if ((src is inside dst && need_realloc) || operation is not in-place)
>  @      to_free = strbuf_detach(dst, NULL);
>  @  strbuf_make_room(dst, needed_size);

Why do you have to play these games with src being inside/outside?
Don't you know where src already is? AFAICS in convert.c crlf_to_git -
you do. And everywhere else you know this fact too.

>     // do whatever you want with src and dst
> 
>     free(to_free);
> 
> strbuf_start_filter tries to implement the block marked with `@'.  Of
> course:
>   * need_realloc == (needed_size >= dst->alloc)
>   * src is inside dst means:
>     src > dst->buf && src < dst->buf + dst->alloc

in convert.c it is never "inside". It is _exactly_ the ->buf.
No need for generic "inside" check. Just test if src == ->buf.

And AFAICS, there is no other users of the function.

> Though, those are both things that I find ugly to "know" in convert.c.
> How things are allocated in strbufs is one of the few things we don't
> want to assume anywhere outside of the strbuf module.

src is outside of strbuf scope. It is not internal to struct strbuf.
The caller must already know if it is inside of the given strbuf
instance.

need_realloc is covered by make_room, isn't it?

I'd suggest just fix the caller, it is simple in convert.c: just use
ret, which contains exactly this information. If you insist on editing
in-place, which makes your routines really need the in-placeability
informaion. Just give it to them, better explicitely. All of this
makes the routines very convert.c specific, which is the reason why I
argument to have them just there and nowhere else.

Alternatively, one can memdup ->buf (as it is the input for next
filter) every time a filter modifies it (which is safe, but simple,
slow, requires memory, and may fragment heap):

/* simplified */
int convert_to_git(const char *path, const char *src, size_t len, struct strbuf *dst)
{
	int crlf = CRLF_GUESS;
	int ident = 0, ret = 0;
	char *filter = NULL;
	const char *tmp = src;

	ret |= apply_filter(path, tmp, len, dst, filter);
	if (ret) {
		tmp = xmemdupz(dst->buf, dst->len);
		len = dst->len;
	}

	if (crlf_to_git(path, tmp, len, dst, crlf)) {
		ret |= 1;
		if (tmp != src)
			free((void*)tmp);
		tmp = xmemdupz(dst->buf, dst->len);
		len = dst->len;
	}

	ret |= ident_to_git(path, tmp, len, dst, ident);
	if (tmp != src)
		free((void*)tmp);
	return ret;
}

It is just to show that nothing like strbuf_start_filter is _needed_
at all.
