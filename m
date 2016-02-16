From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/18] use st_add and st_mult for allocation size computation
Date: Tue, 16 Feb 2016 00:47:24 -0500
Message-ID: <CAPig+cT0P0noxEEM3xCLyYzSFhKXQqW42L3v8EwHraF9Y_5-dg@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215310.GH10287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:47:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVYU9-0005hq-JW
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 06:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbcBPFrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 00:47:37 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33827 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbcBPFrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 00:47:24 -0500
Received: by mail-vk0-f50.google.com with SMTP id e185so124269358vkb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 21:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=l6Y21CBvsh9TJ9zbFCYfqhTnNjQzvwSPdAn3MOetk6E=;
        b=J+ibNpMcWNbtuoJXFSfUZjoq3UeMnZyw22qeKOHjS6gs9fcAd1TPs+HYHQpSs67s8d
         C39wghhLvl1j5nn5ZYft7Rbwx8974jVrn7mEZZju7ea7gaUGm/B/wVlfR3laSM/LyFWQ
         oGOjcG9V1lgjAw4H4/kdFCNzZbRJn4iLmmnDdRQKnKBex98Ua4V5/uY4FqQ0pKNWBD32
         cw2LhyliJXwYfbSoY1faprJoKVXclKIAFKnBnUz46aTE6WniOkh84ptUmH6arnufd/1H
         eWR2+plLwo1618xKtZTEfABYMoNfado98jKkGKIHW1dX7g2cOT8fjEQ4YnnwuLzXJ9io
         sgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=l6Y21CBvsh9TJ9zbFCYfqhTnNjQzvwSPdAn3MOetk6E=;
        b=kIIRNl7WjZtxpg+Elnaxcm4OQs+o8IKVerCvIvg9BG0rDesHttmABFIn1W3VLQ2KGn
         Wz/LJ8r8Ar4evW7P+zJjcXP8vemcW8ETb37PfArXZOfHPqPWFLeyuJFxTrgzv6XrlVt3
         gNB1Pdu3pyGZuLdMZGK4M2paofiF29eq58FdMlFWn16sCMXbSpvciaVUBC2XGwahjT+Z
         5lvSQ0vyFStGPNlTxBql0I3WKImI2sYOENZZDTMbrzV73sKwQund/03AsFzmD8mRKMDB
         O9qk+5GMjT49NsVwC5nSRGk77SJJPOJVhjwJYyhfry4FEu9STa2etAALVhkT+meYOx4d
         qJUQ==
X-Gm-Message-State: AG10YOSKyNd/TOICtmN5QhKrxZNRbUP/RsP4ZsZcUP1/HTEfTlw+0fbEhuzHy4TIJH6rXGU4JasvBjsuvN8xuA==
X-Received: by 10.31.47.135 with SMTP id v129mr16178994vkv.115.1455601644111;
 Mon, 15 Feb 2016 21:47:24 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 21:47:24 -0800 (PST)
In-Reply-To: <20160215215310.GH10287@sigill.intra.peff.net>
X-Google-Sender-Auth: JFrNAV5TrIKhn0ZXoLSrxT8Fmjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286322>

On Mon, Feb 15, 2016 at 4:53 PM, Jeff King <peff@peff.net> wrote:
> If our size computation overflows size_t, we may allocate a
> much smaller buffer than we expected and overflow it. It's
> probably impossible to trigger an overflow in most of these
> sites in practice, but it is easy enough convert their
> additions and multiplications into overflow-checking
> variants. This may be fixing real bugs, and it makes
> auditing the code easier.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -2632,7 +2632,7 @@ static void update_image(struct image *img,
> -       result = xmalloc(img->len + insert_count - remove_count + 1);
> +       result = xmalloc(st_add3(st_sub(img->len, remove_count), insert_count, 1));

Phew, what a mouthful, and not easy to read compared to the original.
Fortunately, the remainder of the changes in this patch are
straightforward and often simple.

> diff --git a/sha1_name.c b/sha1_name.c
> @@ -87,9 +87,8 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
>                 const char *objdir = get_object_directory();
> -               int objdir_len = strlen(objdir);
> -               int entlen = objdir_len + 43;
> -               fakeent = xmalloc(sizeof(*fakeent) + entlen);
> +               size_t objdir_len = strlen(objdir);
> +               fakeent = xmalloc(st_add3(sizeof(*fakeent), objdir_len, 43));
>                 memcpy(fakeent->base, objdir, objdir_len);
>                 fakeent->name = fakeent->base + objdir_len + 1;

If we've gotten this far without die()ing due to overflow in st_add3()
when invoking xmalloc(), then we know that this fakeent->name
computation won't overflow. Okay.

>                 fakeent->name[-1] = '/';
