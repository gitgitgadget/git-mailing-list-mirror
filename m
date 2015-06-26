From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 5/7] bisect: simplify the addition of new bisect terms
Date: Fri, 26 Jun 2015 21:22:26 +0200
Message-ID: <CAP8UFD1ofg01R1rEWk3MJweGAQsVc-yrgCH=fjJ_JeU_81yyTA@mail.gmail.com>
References: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435337896-20709-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:23:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ZDW-0004zS-SE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 21:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbbFZTW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 15:22:29 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33060 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFZTW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 15:22:28 -0400
Received: by wiwl6 with SMTP id l6so53174170wiw.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3E4TSroENfVMd9LE55Bf99z2TqRtSuh2tXkxXdzcgQE=;
        b=o4Vabd0w2Uz4nPKnF/oROgXEpn+8EeY/qIJhddZzzhFbDzri+xazrgbgEN84NaR8rM
         iotgOYIwWvHFCf4Tm2bgs4yXzKZzxUkaw9VH6aBLBfh2MhK/6pCU1loKaDLXd/DNLxds
         kU/mfa+FPXrq4634sq0kaUE+fLzzQNXxMvvrw5KJBAJTPkyKg8Ke2HJsNf3K2Jcv1Zik
         84fuNNCXWpZyhEwa0Wv4aMu2OGYW5R4/GnBn8B0uWRGIV5Rcsggl55T42h4FK7FDGduN
         +gOG0+DiaGurZ4huXmNf0fQu6bgiPY+B3fiG5udQye+H9wj9KzI0BjICQrYDJaXStDXt
         PI5Q==
X-Received: by 10.194.2.68 with SMTP id 4mr5693394wjs.82.1435346546758; Fri,
 26 Jun 2015 12:22:26 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 12:22:26 -0700 (PDT)
In-Reply-To: <1435337896-20709-6-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272814>

On Fri, Jun 26, 2015 at 6:58 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
>  static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
> +       struct strbuf bisect_refs = STRBUF_INIT;
> +       int status;
> +       strbuf_addf(&bisect_refs, "refs/bisect/%s", name_bad);
> +       status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
> +       strbuf_release(&bisect_refs);
> +       return status;
>  }
>
>  static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
> +       struct strbuf bisect_refs = STRBUF_INIT;
> +       int status;
> +       strbuf_addf(&bisect_refs, "refs/bisect/%s", name_good);
> +       status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
> +       strbuf_release(&bisect_refs);
> +       return status;
>  }

I wonder if it would not be better to just have:

static int for_each_bisect_ref(const char *submodule, each_ref_fn fn,
const char *term, void *cb_data)
{
      struct strbuf bisect_refs = STRBUF_INIT;
      int status;
      strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
      status = for_each_ref_in_submodule(submodule, bisect_refs.buf,
fn, cb_data);
      strbuf_release(&bisect_refs);
      return status;
}

This way it can be used with either name_good, name_bad or "skip" as
the term argument.
