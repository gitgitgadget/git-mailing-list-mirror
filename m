From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/67] strbuf: make strbuf_complete_line more generic
Date: Tue, 15 Sep 2015 20:45:48 -0400
Message-ID: <CAPig+cT9piy2dGx6jbcQNyzY5kQ1XgaEB_mYNUOYBUCJ5wAc_w@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152528.GG29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 02:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc0rC-000590-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 02:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbbIPApu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 20:45:50 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34060 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbIPApt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 20:45:49 -0400
Received: by vkhf67 with SMTP id f67so91413864vkh.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gH1trD+kuzkbKSVN4ga/Pt1jNRRDqBPjNmVfv8Qz2JQ=;
        b=wfBQy0uSagMqcVUPfiKUbGxsp4Q5Ja2kOjHvj2NV7H71ce+gJgGs8qrUA++TG+D98h
         uojTJrxt/Ztli6J9OVlvtuOHu0+9WAtYJT7t6aVIYNWwD6/WFlnf5UxC3xQWYtv8za+j
         Cjd3BwWsH5tsIPM6bQ8fEF/eNVgHWxfeFc9OECYNAtMcugeVW5F9SGKRcSSfsS6wRzdl
         pMbujAPPeOrhnSbizLo13TkgnVUJSSBRhhGEzZrK9aH96osfBHazoFS9TtwYo4ybj+fI
         efpQsQ8356obP9Uxd+icfngzhocUxVMjxB/CxnPq11+ZRWEChmfBgZ6h6I6crkIxhYDj
         Qh8g==
X-Received: by 10.31.6.20 with SMTP id 20mr25678233vkg.151.1442364348597; Tue,
 15 Sep 2015 17:45:48 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 17:45:48 -0700 (PDT)
In-Reply-To: <20150915152528.GG29753@sigill.intra.peff.net>
X-Google-Sender-Auth: vlPJRA1lMVhmNz7xSAVYQLlXuT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277987>

On Tue, Sep 15, 2015 at 11:25 AM, Jeff King <peff@peff.net> wrote:
> The strbuf_complete_line function make sure that a buffer

s/make/makes/

> ends in a newline. But we may want to do this for any
> character (e.g., "/" on the end of a path). Let's factor out
> a generic version, and keep strbuf_complete_line as a thin
> wrapper.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> +/**
> + * Ensure that `sb` ends with the character `term`, if it does not
> + * already.
> + */
> +static inline void strbuf_complete(struct strbuf *sb, char term)
> +{
> +       if (sb->len && sb->buf[sb->len - 1] != term)
> +               strbuf_addch(sb, term);
> +}

Hmm, so this only adds 'term' if not already present *and* if 'sb' is
not empty, which doesn't seem to match the documentation which says
that it "ensures" termination.

But, is that reasonable behavior? Intuitively, I'd expect 'term' to be
added when 'sb' is empty:

    if (!sb->len || sb->buf[sb->len - 1] != term)
        strbuf_addch(sb, term);

strbuf_complete_line()'s existing behavior of not adding '\n' to an
empty string may have been intentional, but actually smells like a
bug.

> +
> +/**
> + * Ensure that `sb` ends with a newline.
> + */
>  static inline void strbuf_complete_line(struct strbuf *sb)
>  {
> -       if (sb->len && sb->buf[sb->len - 1] != '\n')
> -               strbuf_addch(sb, '\n');
> +       strbuf_complete(sb, '\n');
>  }
