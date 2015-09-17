From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 09:58:00 -0700
Message-ID: <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:58:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccVd-0003kk-6M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbbIQQ6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:58:04 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33099 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbIQQ6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:58:03 -0400
Received: by pacex6 with SMTP id ex6so24699209pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i8NUOkhu3I6ijwOz3CFeZ4h5KM0YinJQ0iyvOz44kts=;
        b=yRyx2T8eeV2wdeLp0dZDgz39XKLzX+ELQMjpCZ6NZC1smULbOTcYhPW8l+6E8N6LE/
         FlL8518yUuxItZGXQPVxpoly5VQ7J4jAwm7STtJUZPrfEyL31MByrTwdqecrCzOAeYlC
         ngd3JoABysR8tGIdV7MsJYNpb3iPKBZtIQnp1HjKKMT3sl8uvO/x3hYnU8QAd78KMDcp
         Q8Adj2a3qhHcNAEnlI5tm3jm8SAC5CpoiFx/fvL0LOmrCjoWOnOvfbPMJ+K1+PsYS2oc
         6u0ID2JRVvEUST1YwA7RkFabwfkQe/xnl8iacNUAmoIo+gJp5HVPTLfTUBlPUnQZUCBD
         T3FA==
X-Received: by 10.68.194.170 with SMTP id hx10mr338861pbc.64.1442509082239;
        Thu, 17 Sep 2015 09:58:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id rb8sm4442916pab.14.2015.09.17.09.58.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 09:58:01 -0700 (PDT)
In-Reply-To: <20150917163012.GB25837@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Sep 2015 12:30:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278141>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 17, 2015 at 09:13:40AM -0700, Junio C Hamano wrote:
>
>> And your new caller that does O_NONBLOCK wants to do more than
>> looping upon EWOULDBLOCK.  It certainly would not want us to loop
>> here.
>> 
>> So I wonder if you can just O_NONBLOCK the fd and use the usual
>> strbuf_read(), i.e. without any change in this patch, and update
>> xread() to _unconditionally_ return when read(2) says EAGAIN or
>> EWOULDBLOCK.
>> 
>> What would that break?
>
> Certainly anybody who does not realize their descriptor is O_NONBLOCK
> and is using the spinning for correctness. I tend to think that such
> sites are wrong, though, and would benefit from us realizing they are
> spinning.

With or without O_NONBLOCK, not looping around xread() _and_ relying
on the spinning for "correctness" means the caller is not getting
correctness anyway, I think, because xread() does return a short
read, and we deliberately and explicitly do so since 0b6806b9
(xread, xwrite: limit size of IO to 8MB, 2013-08-20).

> But I think you can't quite get away with leaving strbuf_read untouched
> in this case. On error, it wants to restore the original value of the
> strbuf before the strbuf_read call. Which means that we throw away
> anything read into the strbuf before we get EAGAIN, and the caller never
> gets to see it.

I agree we need to teach strbuf_read() that xread() is now nicer on
O_NONBLOCK; perhaps like this?

 strbuf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index cce5eed..49104d7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -368,6 +368,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
 		if (cnt < 0) {
+			if (errno == EAGAIN || errno == EWOULDBLOCK)
+				break;
 			if (oldalloc == 0)
 				strbuf_release(sb);
 			else
