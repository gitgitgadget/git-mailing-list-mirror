From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 02/11] ref-filter: introduce ref_formatting_state
Date: Mon, 03 Aug 2015 13:42:33 -0700
Message-ID: <xmqqzj286r46.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
	<1438620861-25219-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMZJ-0003th-Sd
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbbHCUmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:42:36 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35129 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbHCUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:42:35 -0400
Received: by pasy3 with SMTP id y3so22410107pas.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IX9MSB834OS7/0vl+cb2XlahkNtWIuU97dbyEGYhBUM=;
        b=s2EnVPhszN/QUvHDAJ4iy4g0tglcDG9hLi5gKK2a1p7l6lKEIUk1HQhCeeaUQInaSR
         vSRNiTYgK2dcS/4CKgSzEQy0mTr52TysnG/NI6i9ggylET0YjD2xP+PSojefmxts/KRW
         o+ePKjVm41xA/aM/06pi2P/7PwOEDKPJZAyXng58RoCfHLIYGQPTGJsl02a3Sl3F+XHJ
         oS8yar52HEpon+MKhC5he4C8ELY4BnNcrIHu1TshmlZetj0BGJPqKZHWeWkm9i5Fv6SF
         MCQg+NXMu+E0u/2Z7T7fNpscp4Z4G4OgEl7+B1p9ANwnmyQg4qHKxk4Mjti6mzR1klzz
         PdFw==
X-Received: by 10.66.197.234 with SMTP id ix10mr38515538pac.152.1438634554997;
        Mon, 03 Aug 2015 13:42:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id v4sm18426913pdg.79.2015.08.03.13.42.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 13:42:34 -0700 (PDT)
In-Reply-To: <1438620861-25219-2-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Mon, 3 Aug 2015 22:24:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275196>

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce a ref_formatting_state which will eventually hold the values
> of modifier atoms. Implement this within ref-filter.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 49 +++++++++++++++++++++++++++++++++++++------------
>  ref-filter.h |  4 ++++
>  2 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index febdc45..c4c7064 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1190,9 +1190,10 @@ void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  	qsort(array->items, array->nr, sizeof(struct ref_array_item *), compare_refs);
>  }
>  
> -static void print_value(struct atom_value *v, int quote_style, struct strbuf *output)
> +static void print_value(struct atom_value *v, struct ref_formatting_state *state,
> +			struct strbuf *output)
>  {

I expect that the state would eventually become a stack of states
(i.e. the topmost one passed around, each having a pointer to the
previous level) in order to implement that "divert" mechanism for
(possibly nested) if ... end construct.

With that in mind, I suspect that state->output should be "where the
current level would output to", i.e. no need to pass state and
output around separately.

> +static void apply_formatting_state(struct ref_formatting_state *state, struct strbuf *value,
> +				   struct strbuf *format)
> +{

The name "format" feels quite misleading; the readers would expect
that you would use it in "strbuf_addf(format, value)", but that is
not what is going on here.

> @@ -1275,12 +1299,13 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>  		if (color_parse("reset", color) < 0)
>  			die("BUG: couldn't parse 'reset' as a color");
>  		resetv.s = color;
> -		print_value(&resetv, quote_style, &output);
> +		print_value(&resetv, &state, &value);
> +		apply_formatting_state(&state, &value, &final_buf);
>  	}
> -	for (i = 0; i < output.len; i++)
> -		printf("%c", output.buf[i]);
> +	for (i = 0; i < final_buf.len; i++)
> +		printf("%c", final_buf.buf[i]);
>  	putchar('\n');
> -	strbuf_release(&output);
> +	strbuf_release(&final_buf);
>  }
>  
>  /*  If no sorting option is given, use refname to sort as default */
> diff --git a/ref-filter.h b/ref-filter.h
> index 6bf27d8..b64677f 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -16,6 +16,10 @@
>  #define FILTER_REFS_INCLUDE_BROKEN 0x1
>  #define FILTER_REFS_ALL 0x2
>  
> +struct ref_formatting_state {
> +	int quote_style;
> +};
> +
>  struct atom_value {
>  	const char *s;
>  	unsigned long ul; /* used for sorting when not FIELD_STR */
