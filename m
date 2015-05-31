From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 5/8] for-each-ref: introduce 'ref_filter_clear_data()'
Date: Sun, 31 May 2015 09:38:30 +0200
Message-ID: <CAP8UFD341nSMLvsXynbDfQ4kLoddBL5rhXrhyePTT0LHACzfuQ@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 09:38:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyxpO-0005AM-S5
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 09:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044AbbEaHid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 03:38:33 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36130 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbbEaHic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 03:38:32 -0400
Received: by wgbgq6 with SMTP id gq6so91540504wgb.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 00:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t4otVI+NMbSCOt+gTGDBkWI/1p4TRM7zTVsIaBtgHW8=;
        b=iWVwPot+M+PsfPR90e9dXv6pufFGsu+hV2Bn8J2vhJ5ioiVxdDDfIVxZ2cMFLJfehw
         VcM+q4gLYBhxAp/pwd22+Dy7u34noGh1uJtDzFvln2IqXG7PG+thebozx5KfrUJva2mw
         LW2P7zibLit/wz717UO4qlAh4pYtSeEi4Cl4BApR4P6GlrAaDf+SZklXFG3VBaOYpjl3
         TmW2x7Tke3qu7BE3TOrn9dQdqjRPAbUZvc+WD+CgLkYMAGZyVzJHeQ12sDOJwHE8A/z6
         60Nit8VVFD1sNaqWM/j+0/cnR9O+LdSfYETp5Is07nfRbfRAAsvvqqj6Ti3ql59Gk2l2
         OrTA==
X-Received: by 10.180.105.38 with SMTP id gj6mr10158118wib.90.1433057910919;
 Sun, 31 May 2015 00:38:30 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 00:38:30 -0700 (PDT)
In-Reply-To: <1433008411-8550-5-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270315>

On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Introduce and implement 'ref_filter_clear_data()' which will free
> all allocated memory for 'ref_filter_cbdata' and its underlying array
> of 'ref_array_item'.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/for-each-ref.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index ef54c90..f896e1c 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -907,6 +907,18 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
>         return 0;
>  }
>
> +/* Free all memory allocated for ref_filter_cbdata */
> +void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata)
> +{
> +       int i;
> +
> +       for (i = 0; i < ref_cbdata->array.nr; i++)
> +               free(ref_cbdata->array.items[i]);
> +       free(ref_cbdata->array.items);
> +       ref_cbdata->array.items = NULL;
> +       ref_cbdata->array.nr = ref_cbdata->array.alloc = 0;
> +}

As this is clearing the array only, it would be better to have it in a
ref_array_clear() function.
There are already argv_array_clear() and sha1_array_clear() by the way.
And maybe if many such ref_array functions are created and start being
used elsewhere we can easily move everything into new ref-array.{c,h}
files.

Thanks,
Christian.
