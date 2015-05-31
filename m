From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [WIP/PATCH v4 4/8] for-each-ref: introduce new structures for
 better organisation
Date: Sat, 30 May 2015 23:14:39 -0400
Message-ID: <CAPig+cSj8Ri=cz9gt_MmMcQQg7iH1beweKfrvEL3MExDY_EiKg@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 05:16:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yytjj-0003Z1-3t
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 05:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbbEaDOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 23:14:42 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34984 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbbEaDOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 23:14:40 -0400
Received: by iesa3 with SMTP id a3so88097509ies.2
        for <git@vger.kernel.org>; Sat, 30 May 2015 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w0NikRKn/kYOAGEH6MABMQMiFvEPk3ugQFyznLmgY5o=;
        b=AXVn5D/TDgiIO0WdIdft3vqZgq75Fq0YXCKLef3Oj1gK282LanZOM8t8+sM6wG4/Ws
         jvlEVBYW6AcLUxRIsz+RsKcoOzUHup+uKoEXtxLg8kZvwcFQT0Qj1b2M4ZVCXa1KqSQM
         0ueuHTQrRVGKz/IGKTqKLLNgenqkbVoR2Ht51ZSMTDQHxeoHPoQsU/T6B3+JvvnNWLgG
         iFtk184zeZyJV4qkLGjYREjK7U62xOABLz+uEm232+Q6GrPCoh/dCSIZTF97tOI/wPxn
         x5YuUsDHihSX56NTkwIKjHSrYWN3EEqdC6dVdd0ihCcUauVIc2jM7eSD56AjAGv5LhSm
         vtUg==
X-Received: by 10.50.138.70 with SMTP id qo6mr5575069igb.15.1433042079886;
 Sat, 30 May 2015 20:14:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 30 May 2015 20:14:39 -0700 (PDT)
In-Reply-To: <1433008411-8550-4-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: y8wKukmqA_AUBGem0QvDqb9PmAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270312>

On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Intoduce 'ref_filter_cbdata' which will hold 'ref_filter'

s/Intoduce/Introduce/

> (Conditions to filter the refs on) and 'ref_array' (The array

s/Conditions/conditions/
s/The/the/

> of ref_array_items). Modify the code to use these new structures.
>
> This is a preparatory patch to eventually move code from 'for-each-ref'
> to 'ref-filter' and making it publically available.

s/publically/publicly/

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index e634fd2..ef54c90 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -85,7 +99,7 @@ static struct {
>   * a "*" to denote deref_tag().
>   *
>   * We parse given format string and sort specifiers, and make a list
> - * of properties that we need to extract out of objects.  ref_array_item
> + * of properties that we need to extract out of objects. ref_array_item

Sneaking in whitespace change?

>   * structure will hold an array of values extracted that can be
>   * indexed with the "atom number", which is an index into this
>   * array.
> @@ -1076,12 +1085,12 @@ static char const * const for_each_ref_usage[] = {
>
>  int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  {
> -       int i, num_refs;
> +       int i;
>         const char *format = "%(objectname) %(objecttype)\t%(refname)";
>         struct ref_sort *sort = NULL, **sort_tail = &sort;
>         int maxcount = 0, quote_style = 0;
> -       struct ref_array_item **refs;
> -       struct grab_ref_cbdata cbdata;
> +       struct ref_filter_cbdata ref_cbdata;
> +       memset(&ref_cbdata, 0, sizeof(ref_cbdata));
>
>         struct option opts[] = {

Declaration (struct option opts[]) after statement (memset). I think
you want to leave the memset() where it was below.

>                 OPT_BIT('s', "shell", &quote_style,
> @@ -1119,17 +1128,14 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>         /* for warn_ambiguous_refs */
>         git_config(git_default_config, NULL);
>
> -       memset(&cbdata, 0, sizeof(cbdata));
> -       cbdata.grab_pattern = argv;
> -       for_each_rawref(grab_single_ref, &cbdata);
> -       refs = cbdata.grab_array;
> -       num_refs = cbdata.grab_cnt;
> +       ref_cbdata.filter.name_patterns = argv;
> +       for_each_rawref(grab_single_ref, &ref_cbdata);
>
> -       sort_refs(sort, refs, num_refs);
> +       sort_refs(sort, &ref_cbdata.array);
>
> -       if (!maxcount || num_refs < maxcount)
> -               maxcount = num_refs;
> +       if (!maxcount || ref_cbdata.array.nr < maxcount)
> +               maxcount = ref_cbdata.array.nr;
>         for (i = 0; i < maxcount; i++)
> -               show_ref(refs[i], format, quote_style);
> +               show_ref(ref_cbdata.array.items[i], format, quote_style);
>         return 0;
>  }
> --
> 2.4.2
