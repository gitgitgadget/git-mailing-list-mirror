From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_read: skip unnecessary strbuf_grow at eof
Date: Mon, 01 Jun 2015 09:23:47 -0700
Message-ID: <xmqq382b8kj0.fsf@gitster.dls.corp.google.com>
References: <1433096205-14516-1-git-send-email-gjthill@gmail.com>
	<20150601105901.GE31792@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:23:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSVH-00025z-HU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbbFAQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 12:23:51 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36455 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbbFAQXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:23:49 -0400
Received: by igbpi8 with SMTP id pi8so65746052igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+VKIMN78P0XBfw9dRUA2iwUK4PKrK/4VaQrci2lCdz0=;
        b=UKBSlwAs4KYkEqXR9b1D1TKdrqM2hpRjFxYgCIF+8HwQ4Ic12uxouG0e/5b4O9/t7w
         VeHLpDFM4YcMHJxNbxEnl9Wr0W4nQEZYSJ8brV/ubYREr4RJxmd5Bf1NerMWj4y5fvZl
         D38bz/7QGrzYVe6UwDcYy3Y+sr3RQpYvG35nF93aVFyEXXKQUsGzYj8/7I1MPCFd/ZNR
         ei0bwDZpnf3mk61AGR8WwLYkt9U652eD1wAGrJLf6UCDkb50UC4oedQMoPzKVaTwdLV/
         cXHUOHGxlE42XzEosKk4Kw06qa4XXuDyrCJRfQW2sPFHsYyynsUQKQAuNZHhqPDNDKB3
         yPbQ==
X-Received: by 10.50.117.35 with SMTP id kb3mr14751600igb.13.1433175829341;
        Mon, 01 Jun 2015 09:23:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id g3sm8125993igi.10.2015.06.01.09.23.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 09:23:48 -0700 (PDT)
In-Reply-To: <20150601105901.GE31792@peff.net> (Jeff King's message of "Mon, 1
	Jun 2015 06:59:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270434>

Jeff King <peff@peff.net> writes:

> On Sun, May 31, 2015 at 11:16:45AM -0700, Jim Hill wrote:
>
>> Make strbuf_read not try to do read_in_full's job too.  If xread returns
>> less than was requested it can be either eof or an interrupted read.  If
>> read_in_full returns less than was requested, it's eof. Use read_in_full
>> to detect eof and not iterate when eof has been seen.
>
> I think this makes sense. I somehow had to read this over several times
> to understand that the main point is not the cleanup, but rather the
> space savings from not doing an extra strbuf_grow. Perhaps it is because
> the main idea is mentioned only in the subject. Or perhaps I was just
> being dense.

Even after seeing (not "reading", as it was before my first cup of
caffeine ;-) this message 30 minutes ago and then reading the patch
with a fresh eye, I had the same impression, until I realized there
is "too" at the end of the first sentence.

Perhaps

	The loop in strbuf_read() uses xread() repeatedly while
	extending the strbuf until the call returns zero.  If the
	buffer is sufficiently large to begin with, this results in
	xread() returning the remainder of the file to the end
	(returning non-zero), the loop extending the strbuf, and
	then making another call to xread() to have it return zero.

	By using read_in_full(), we can tell when the read reached
	the end of file: when it returns less than was requested,
	it's eof.  This way we can avoid an extra iteration that
	allocates an extra 8kB that is never used.

In any case, the change is very sensible.  Thanks, both.
