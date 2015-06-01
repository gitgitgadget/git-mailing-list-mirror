From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Mon, 1 Jun 2015 16:09:55 -0400
Message-ID: <CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
References: <20150601001759.GA3934@kroah.com>
	<xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
	<xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Git List <git@vger.kernel.org>,
	Gaston Gonzalez <gascoar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 22:10:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzW25-0000Iu-B6
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 22:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbFAUJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 16:09:57 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35773 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbbFAUJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 16:09:55 -0400
Received: by igbyr2 with SMTP id yr2so70907281igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ChZF+DSsKPQkcu1YiuQHZoQWe57Ep0Ju0wMUK0tWYiw=;
        b=liG3MYtv7xJRvWXGwM/adBJyp4Vp1VmjYspkMSkJKSyqQ5522VeXz4LPZO1QbtMKRW
         SSI+YvdzBqTzvzZVjOG71lswrd3hfMP3FgxGPku+KYAim4jd2m3zfzAl2WCUkfgP7KQW
         o/Q7ngpWZ85Y7ncjxM45V7roM9A6m/X9Gjo154ax7408g90HyjX6Q7llDOrk9vwq/KTc
         Y1wx5nLQbvz0hti7pJClcYF9PgMi9wJL6pEYG0uad7oscVEE3t8+PMeceYzFHmnla8A0
         9Xwv7UQhoFeVTjbuSEHHlvBpwd9n4oVuwU0HuuckAL2Vl4hhC1Xum4N8j3IKTktFPJ7G
         Ampg==
X-Received: by 10.107.137.80 with SMTP id l77mr28083934iod.92.1433189395384;
 Mon, 01 Jun 2015 13:09:55 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 1 Jun 2015 13:09:55 -0700 (PDT)
In-Reply-To: <xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: R1HqdgiEBnctZmnlQfg1lShLr0M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270468>

On Mon, Jun 1, 2015 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: apply: reject a hunk that does not do anything
>
> A hunk like this in a hand-edited patch without correctly adjusting
> the line counts:
>
>      @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
>              auth = (struct ieee80211_authentication *)
>                      skb_put(skb, sizeof(struct ieee80211_authentication));
>      -       some old text
>      +       some new text
>      --
>      2.1.0
>
>      dev mailing list
>
> at the end of the patch does not have a good way for us to diagnose
> it as corrupt patch.  We just read two lines and discard the remainder
> as cruft, which we must do in order to ignore the e-mail footer.
>
> If the hand-edited hunk header were "@@ -660,3, +660,2", this fix
> will not help---we would just remove the old text without adding the
> enw one, and treat "+ some new text" and everything after that line

s/enw/new/

> as trailing cruft.  So it is dubious that this patch would help very
> much in practice, but it is better than nothing ;-)
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 146be97..54aba4e 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1638,6 +1638,9 @@ static int parse_fragment(const char *line, unsigned long size,
>         }
>         if (oldlines || newlines)
>                 return -1;
> +       if (!deleted && !added)
> +               return -1;
> +
>         fragment->leading = leading;
>         fragment->trailing = trailing;
>
> --
