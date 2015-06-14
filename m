From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 0/11] Create ref-filter from for-each-ref
Date: Sun, 14 Jun 2015 13:54:28 +0530
Message-ID: <CAOLa=ZSxw15NYq+_E9kusiwQYDBQ-WrUwWjV1h2FsWGMEuVJKQ@mail.gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <vpq8ubmemx9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:24:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43Du-0007Ek-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbbFNIYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:24:54 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36179 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbFNIYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:24:50 -0400
Received: by obpc2 with SMTP id c2so17920324obp.3
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vp2U+10TZPrNmLKMiaGCCLez77MH527xdRVMeiXHtUY=;
        b=Ade3gV/AayPBSfodG/E4caY87UHaGqogo/INSYxSZA3gp0KwxwPtKIT8ZDS2X77RSp
         7LtOyFOJlAxkS+FqZkuWUY4cbE7EwtohV26DBpDyN8UuTtAuMAzpZSFnE6Ce9BU5/nXf
         RmuBgUHXSv8ssJUj8xOep46E8dC+OrA/OQcrsZlbeBaQfykJtpB8W+lIDlWkNfMLiGVz
         1iP7kOhxSD6VrklbGVaSngvT4oiw/4LveQETfOfld2lEddkvpH+Eorz7Rt3/0QDYiYfn
         MpyXhUI0PajO5zA8sgwB9Lx9mryCV+C/fmeMA/46bWUm2JPhlIkUHXxJ9A34HpJxTNF1
         zxyQ==
X-Received: by 10.202.190.134 with SMTP id o128mr17984845oif.111.1434270289236;
 Sun, 14 Jun 2015 01:24:49 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Sun, 14 Jun 2015 01:24:28 -0700 (PDT)
In-Reply-To: <vpq8ubmemx9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271612>

On Sun, Jun 14, 2015 at 1:34 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> The previous version of the patch can be found at :
>> http://thread.gmane.org/gmane.comp.version-control.git/271423
>>
>> Changes :
>> * Removed an unnecessary commit (v7 3/12)
>> * Change a comment in 01/11 (v8)
>
> And change the order of parameters in ref_filter. More precisely the
> diff with v7 is the following, and it looks good to me:
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index e2f15e6..7919206 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -58,7 +58,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>         memset(&array, 0, sizeof(array));
>         memset(&filter, 0, sizeof(filter));
>         filter.name_patterns = argv;
> -       filter_refs(&array, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN, &filter);
> +       filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
>         ref_array_sort(sorting, &array);
>
>         if (!maxcount || array.nr < maxcount)
> diff --git a/ref-filter.c b/ref-filter.c
> index 310ecd6..43502a4 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -818,10 +818,10 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
>  }
>
>  /*
> - * Return 1 if the refname matches with one of the patterns,
> - * otherwise 0.  The patterns can be literal prefix (e.g. a
> - * refname "refs/heads/master" matches a pattern "refs/heads/")
> - * or a wildcard (e.g. the same ref matches "refs/heads/m*",too).
> + * Return 1 if the refname matches one of the patterns, otherwise 0.
> + * A pattern can be path prefix (e.g. a refname "refs/heads/master"
> + * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
> + * matches "refs/heads/m*",too).
>   */
>  static int match_name_as_path(const char **pattern, const char *refname)
>  {
> @@ -912,7 +912,7 @@ void ref_array_clear(struct ref_array *array)
>   * as per the given ref_filter structure and finally store the
>   * filtered refs in the ref_array structure.
>   */
> -int filter_refs(struct ref_array *array, unsigned int type, struct ref_filter *filter)
> +int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type)
>  {
>         struct ref_filter_cbdata ref_cbdata;
>
> diff --git a/ref-filter.h b/ref-filter.h
> index 6ab2a75..6997984 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -23,7 +23,7 @@ struct atom_value {
>
>  struct ref_sorting {
>         struct ref_sorting *next;
> -       int atom; /* index into 'struct atom_value *' array */
> +       int atom; /* index into used_atom array (internal) */
>         unsigned reverse : 1;
>  };
>
> @@ -55,7 +55,7 @@ struct ref_filter_cbdata {
>   * as per the given ref_filter structure and finally store the
>   * filtered refs in the ref_array structure.
>   */
> -int filter_refs(struct ref_array *array, unsigned int type, struct ref_filter *filter);
> +int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
>  /*  Clear all memory allocated to ref_array */
>  void ref_array_clear(struct ref_array *array);
>  /*  Parse format string and sort specifiers */
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Thanks for summing it up.

-- 
Regards,
Karthik Nayak
