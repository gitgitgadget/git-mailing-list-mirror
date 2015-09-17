From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:54:39 -0700
Message-ID: <xmqqoah1hqxs.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
	<20150917171308.GA28046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdOU-0007Mq-IW
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbbIQRym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:54:42 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33734 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbIQRyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:54:41 -0400
Received: by pacex6 with SMTP id ex6so25833921pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RKvQWfUhy4u6FI7hOqVpalW1b0i1Qj7RYXJ42eFcnnI=;
        b=fI/O0brrmH3bHbo+/bhdm7TUb2xU10yPi0Aq5oGXW2QB4+b/198CwjkLQe58ySfSr1
         4rbVvUFsTvEnOyxt+C0T3mdB3zCXL+phpiAIupR7Mdeq+GPa7/fL7ng569K5zOkyJJh5
         97TO8W9yHBmNILOmm+R1cOmbZYIGLC1FEUZ2F6AAWGL4gJYK8xSP9+2wzuA/MOV/F0r6
         6dyUiP1TpPt9hTwCSXkMNvTounXu7haQgZOUJpBhXtjp3XP9NlCTtrTWnaqZEwCBL+mM
         UFyKc2azKuuavl869zga4sRQ7kdavqg663XVs2/wbBSZwuyoeMnfzD96zXfi64dyeqAy
         KvSg==
X-Received: by 10.68.234.200 with SMTP id ug8mr749685pbc.13.1442512480797;
        Thu, 17 Sep 2015 10:54:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id a2sm4594370pas.47.2015.09.17.10.54.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 10:54:40 -0700 (PDT)
In-Reply-To: <20150917171308.GA28046@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Sep 2015 13:13:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278154>

Jeff King <peff@peff.net> writes:

> I think they have to loop for correctness, but they may do this:
>
>   if (xread(fd, buf, len) < 0)
> 	die_errno("OMG, an error!");
>
> which is not correct if "fd" is unknowingly non-blocking.
> ...
> The spinning behavior is not great, but does mean that we spin and
> continue rather than bailing with an error.

OK, that is a problem (I just read through "git grep xread -- \*.c".
There aren't that many codepaths that read from a fd that we didn't
open ourselves, but there indeed are some.

So it seems that we would want a xread() that spins to help such
codepaths, and xread_nonblock() that gives a short-read upon
EWOULDBLOCK.  They can share a helper function, of course.

> If we reset errno to "0" at the top of the function, we could get around
> one problem, but it still makes an annoying interface: the caller has to
> check errno for any 0-return to figure out if it was really EOF, or just
> EAGAIN.
>
> If we return -1, though, we have a similar annoyance. If the caller
> notices a -1 return value and finds EAGAIN, they still may need to check
> sb->len to see if they made forward progress and have data they should
> be dealing with.

OK.  Trying to repurpose strbuf_read() for non-blocking FD was a
silly idea to begin with, as it wants to read thru to the EOF, and
setting FD explicitly to O_NONBLOCK is a sign that the caller wants
to grab as much as possible and does not want to wait for the EOF.

So assuming we want strbuf_read_nonblock(), what interface do we
want from it?  We could:

 * Have it grab as much as possible into sb as long as it does not
   block?

 * Have it grab reasonably large amount into sb, and not blocking is
   an absolute requirement, but the function is not required to read
   everything that is available on the FD (i.e. the caller is
   expected to loop)?

If we choose the latter, then your "EAGAIN? EOF?" becomes easier,
no?  We only have to do a single call to xread(), and then we:

 - get EAGAIN or EWOULDBLOCK; leave sb as-is, set errno==EAGAIN and
   return -1.

 - get something (in which case that is not an EOF yet); append to
   sb, return the number of bytes.

 - get EOF; leave sb as-is, return 0.


ssize_t strbuf_read_nonblock(struct strbuf *sb, int fd, size_t hint)
{
	strbuf_grow(sb, hint ? hint : 8192);
	ssize_t want = sb->alloc - sb->len - 1;
	ssize_t got = xread_nonblock(fd, sb->buf + sb->len, want);
	if (got < 0) {
		if (errno == EWOULDBLOCK)
			errno = EAGAIN; /* make life easier for the caller */
		return got;
	}
	sb->len += got;
	sb->buf[sb->len] = '\0';
	return got;
}
