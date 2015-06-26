From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 5/7] bisect: simplify the addition of new bisect terms
Date: Fri, 26 Jun 2015 14:27:57 -0700
Message-ID: <xmqq381etb1e.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1ofg01R1rEWk3MJweGAQsVc-yrgCH=fjJ_JeU_81yyTA@mail.gmail.com>
	<1435350769-10973-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bAL-0001DP-R6
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbbFZV2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:28:02 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:32979 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbFZV2B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:28:01 -0400
Received: by ieqy10 with SMTP id y10so83925881ieq.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kc97frpw9PXa6qa4Co+P1ple88hv0CvmokFcJ1lMUiE=;
        b=Us0mubZQIJ7YJWcD233CiucE5GdaJpXvBKEYOcCN9//C8E34atin32VDQSztxhXdBt
         x1NMbDz29mXq4WGeNdxMArNXwQdCWBMcntvNch0I77xeEmqzuC+xjWZwi28FTq8qtzai
         YMz4bt6cY+Ymt8YCztW0/vFhKPArbCljTO8ObQnoo/PZ9Vk6wBHeyuJFgSnNprOwOhIj
         Q2OVOolJsv1TrVJ4SoTVDQdCe33TrEcKRMSgV1aVYKSskFtqKphqRwaA6dEJxqurpOfz
         l3WcByPyuJA6nb+miN3SR2N/wEc0HzHTEqPBTZ2sjnqxlvALDWF9ObDvs/pzWNGWPQyj
         CVfw==
X-Received: by 10.50.114.40 with SMTP id jd8mr158579igb.47.1435354080465;
        Fri, 26 Jun 2015 14:28:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id e10sm72965igy.11.2015.06.26.14.27.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 14:27:59 -0700 (PDT)
In-Reply-To: <1435350769-10973-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 26 Jun 2015 22:32:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272829>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> We do need two functions because we pass the pointer as callback, but
> it reads nicer with a third helper function.
>
> diff --git a/revision.c b/revision.c
> index 3ff8723..5cd08e9 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -21,6 +21,9 @@
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> +static const char *name_bad;
> +static const char *name_good;
> +
> ...
> +
> +static int for_each_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data, const char *term) {
> +	struct strbuf bisect_refs = STRBUF_INIT;
> +	int status;
> +	strbuf_addf(&bisect_refs, "refs/bisect/%s", term);
> +	status = for_each_ref_in_submodule(submodule, bisect_refs.buf, fn, cb_data);
> +	strbuf_release(&bisect_refs);
> +	return status;
> +}
> +
>  static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -	return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
> +	return for_each_bisect_ref(submodule, fn, cb_data, "bad");
>  }

Shouldn't this be passing name_bad instead of "bad"?

>  
>  static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -	return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
> +	return for_each_bisect_ref(submodule, fn, cb_data, "good");
>  }

Likewise.
