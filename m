From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Thu, 31 Mar 2016 20:46:15 -0400
Message-ID: <CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 02:46:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alnEG-0003Vi-QG
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 02:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbcDAAqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 20:46:17 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33394 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcDAAqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 20:46:16 -0400
Received: by mail-yw0-f171.google.com with SMTP id h65so123924820ywe.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=IH45N8xqzxiLrS2wkdkJJsFJGmcp3PBlxgRFxhTTZlk=;
        b=jkiB2iwxJswPDfKa8I965o/+GJkPwnXTs6f2Td1KpSkHfX2dId6soglCX4V2ce3Prk
         X+NfiksVTotZ15LPeKMawpPKoxoKp4Z+7ShrUY1bvg8t/DXSKByPALdCDSx4trUB/H3V
         KoZphl1ApAorUQopUUjCrNavJwGEBZ+K62WriXFXt4+hYusU9yz7glcWq0adzkpc/bRP
         c72ciBWXxMo9MpWNf2kZKHEypCnB4xC08xInjKw/DvIUN2M3rUttW3PP6F2pPjxfL1A+
         nr1Hm3HRLfIMpqdOfi+ZwQA03HGN3P+COuIuG8M7C/Wv4eCK+WHV3Pk7mqb/3z8KwegL
         vqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IH45N8xqzxiLrS2wkdkJJsFJGmcp3PBlxgRFxhTTZlk=;
        b=FQW/ghAmooa5GYEpUEoKu25qZ43ZPFaka7GYINgTlpKYmgAt7UX3Rj0aU+rUzHeQpG
         VeU41aT1L2HY4Kar6o+NTaD3BO69Yae2DPEvYQbL/YW/D570kyd7JZw+tmfDP6HU0KLt
         vC8mpO2c35gW73Ug8JuWuYEcvPLzMY/zgKo7h7D/pGk9O894pJq1wcSx+uRZxXjEauWy
         aCRxAmGRICkkd75PhfFdzLTn7O7v7DStaXHuWav/hrmLuBdiApKgasiAZgBJ71Ri/BFR
         kOXrhP+rVlMzZYowEz1ljJJs9vpNr5TgZ5uT3y0Qf7zy2+YjiFFTNnbAA22lIO9JdG2r
         HKlg==
X-Gm-Message-State: AD7BkJKkY8a36H0NTOyUDMb3AiSIhZSZnPXl/N6maD0BhIsKQt82D7cPwufIdn427ZqYF5pTudWnwukoP5yxBA==
X-Received: by 10.31.146.5 with SMTP id u5mr1723274vkd.19.1459471575299; Thu,
 31 Mar 2016 17:46:15 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 31 Mar 2016 17:46:15 -0700 (PDT)
In-Reply-To: <1459470946-16522-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 84tp5c-bkvbQ5xni7U2ZlafDAcI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290501>

On Thu, Mar 31, 2016 at 8:35 PM, Stefan Beller <sbeller@google.com> wrote:
> `value` is just a temporary scratchpad, so we need to make sure it doesn't
> leak. It is xstrdup'd in `git_config_get_string_const` and
> `parse_notes_merge_strategy` just compares the string against predefined
> values, so no need to keep it around longer.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 52aa9af..afcfa8f 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -741,13 +741,14 @@ static int merge_commit(struct notes_merge_options *o)
>  static int git_config_get_notes_strategy(const char *key,
>                                          enum notes_merge_strategy *strategy)
>  {
> -       const char *value;
> +       char *value;
>
> -       if (git_config_get_string_const(key, &value))
> +       if (git_config_get_string(key, &value))
>                 return 1;

Meh. Rather than reverting the git_config_get_value(), it would have
been just as easy and safer (less chance of a future change
re-introducing a leak) if you had just inserted the necessary check
here:

    if (!value)
        return  config_error_nonbool(key);

But, perhaps it's not worth the patch churn at this point...

>         if (parse_notes_merge_strategy(value, strategy))
>                 git_die_config(key, "unknown notes merge strategy %s", value);
>
> +       free(value);
>         return 0;
>  }
>
> --
> 2.5.0.264.gc776916.dirty
