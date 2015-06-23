From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 3/5] bisect: simplify the addition of new bisect terms
Date: Tue, 23 Jun 2015 13:49:14 -0400
Message-ID: <CAPig+cSzymZ+JEO8sPrayQ+XNag0kAry_9_eH4=kSqPp=JKk7w@mail.gmail.com>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435064084-5554-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7SJz-0003uI-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbbFWRtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:49:16 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:35010 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbbFWRtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:49:15 -0400
Received: by yhak3 with SMTP id k3so6821186yha.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=P5qmLSJrrx3eW6MZKMbeRgBoCZyS6X2M8qGe+axquqQ=;
        b=FGPU/F3tx7QoYNVpVh3rJf7XWMaKpjYTu0WqhjPUf9qioBIl5Ujy+GfM0I/C97hTvE
         wj4cRqqX2J4j9XqprDbqwTJ63bof7jd7C4F16vjsQhFUdZriJmrYexeRoIKuZIVhSFbo
         EkHGrwyd93Jbot9gN5mvp4JwfDdOX9ognCsavGVCZKXCmykHyUJKOusA5+nJb5cjeVoL
         B/hy8/MRCm5XndIfHvPoNTAb2i9OTCUL+RtRVRGtdLDd9t28WjSvLQMyuheiZFKj/M5q
         bzMEkWax18c7iz+gOt0A/gJ21w2+BH5V93oS3TA8a869ph6xT+PAyLW4lypaInXnpB06
         opWA==
X-Received: by 10.170.75.194 with SMTP id r185mr44066769ykr.69.1435081754324;
 Tue, 23 Jun 2015 10:49:14 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Tue, 23 Jun 2015 10:49:14 -0700 (PDT)
In-Reply-To: <1435064084-5554-4-git-send-email-Matthieu.Moy@imag.fr>
X-Google-Sender-Auth: UTKl0alB6l361zOEmW7leucZ0Mo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272473>

On Tue, Jun 23, 2015 at 8:54 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> diff --git a/revision.c b/revision.c
> index 3ff8723..f22923f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2076,14 +2079,32 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>         ctx->argc -= n;
>  }
>
> +extern void read_bisect_terms(const char **bad, const char **good);
> +
>  static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
> +       struct strbuf bisect_refs_buf = STRBUF_INIT;
> +       const char *bisect_refs_str;
> +       int status;
> +       strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
> +       strbuf_addstr(&bisect_refs_buf, name_bad);

A single strbuf_addf() rather than two strbuf_addstr()s?

> +       bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
> +       status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
> +       free((char *)bisect_refs_str);

Why the above rather than the simpler?

    strbuf_addstr(&bisect_refs, ...);
    status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
    strbuf_release(&bisect_refs);

What am I missing?

> +       return status;
>  }
>
>  static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
> +       struct strbuf bisect_refs_buf = STRBUF_INIT;
> +       const char *bisect_refs_str;
> +       int status;
> +       strbuf_addstr(&bisect_refs_buf, "refs/bisect/");
> +       strbuf_addstr(&bisect_refs_buf, name_bad);
> +       bisect_refs_str = strbuf_detach(&bisect_refs_buf, NULL);
> +       status = for_each_ref_in_submodule(submodule, bisect_refs_str, fn, cb_data);
> +       free((char *)bisect_refs_str);

Ditto.

> +       return status;
>  }
