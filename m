From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/13] delete_ref(): handle special case more explicitly
Date: Mon, 8 Jun 2015 09:48:23 -0700
Message-ID: <CAGZ79kZvmf0WWEAHb5Hq6o5ayu7ADxQoAS4xsewoc==VEHKoPw@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<1a8670c63b4e8b3b2f99d0e1acbb18162111f166.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20KS-0003H3-6t
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbFHQzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:55:12 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33566 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbbFHQzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:55:10 -0400
Received: by ykfr66 with SMTP id r66so54798227ykf.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EdvBOm4pDeSyXVOy64V/ZseW2TIDNUZQZfOBh7X05Yg=;
        b=Eje+cz3l4Yp/69mEIR1l4JlM6mcI5p7wju4oPz1tN4CFUWffD2XcwzXzubZqYyggCq
         /qriKszweIRpVZ7YXrwHMtQX+5iGT8IbiPGxpuLqtnHbxWdnQ+MeMZviTJpiBDsmjz5n
         Wx1ezMohpcYrocaNlRj5OnHoTNgMSBcTP49v78zIs5oyeZvOJJw4R68HYxsZpXItdKLr
         sMjU/9+cCpajjjwjve3P9YBFOjVHV1Nojj38phhm3Wf62+N1Ta7vMh0RagWgaLizpelk
         7oCBOoWPhukIjpTrLdkpE2X0399bsArqPEzwFjzF/mAwwu8bcUMwH8CVemc4C+Z252Qj
         SllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EdvBOm4pDeSyXVOy64V/ZseW2TIDNUZQZfOBh7X05Yg=;
        b=dcmYjq34zI50CiDQnRGNXXaTkN2bzHzkAvwhLYHXmAQ+MD6GO41fiD/34GJ4ErXTiL
         a5/nzzmlOxuDL24o/h3zehgtsmfZX3X7iLVelZsN4i9/gmT2gkrwn2/fzJ+9a7oYvgqQ
         wc/X0t33wpcCkHuuHzBxdYe+RPhz63CRlNUah4/qGszc8cXzwZTN0D6otEF4C1ZU9Erw
         OdChhPhhXa8VVGha7kDWiJM+6y8ZxW9Y2sRnXa/bZfAfJsFZBXH7NugugiLilOk92nrI
         WHEigRyWdKg7nEHAycf76ul3lZDj/FhfHaiKh5YsR3FAez1CljxJihMNvOwuvDostpoH
         sZ7g==
X-Gm-Message-State: ALoCoQmJrsq5PTE40KfjVx+Dx2vGWDx3rg+CCi1vhrGk4zSZHau3gUdNtQMEb5SaC4mB3ljwzeWw
X-Received: by 10.170.112.18 with SMTP id e18mr19428535ykb.101.1433782103181;
 Mon, 08 Jun 2015 09:48:23 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 09:48:23 -0700 (PDT)
In-Reply-To: <1a8670c63b4e8b3b2f99d0e1acbb18162111f166.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271076>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> delete_ref() uses a different convention for its old_sha1 parameter
> than, say, ref_transaction_delete(): NULL_SHA1 means not to check the
> old value. Make this fact a little bit clearer in the code by handling
> it in explicit, commented code rather than burying it in a conditional
> expression.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b575bb8..f9d87b6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2795,10 +2795,13 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
>         struct ref_transaction *transaction;
>         struct strbuf err = STRBUF_INIT;
>
> +       /* Treat NULL_SHA1 as "don't care" */

and by "don't care" you mean we still care about getting it deleted,
the part we don't care about is the particular sha1 (could be a bogus ref).

> +       if (old_sha1 && is_null_sha1(old_sha1))
> +               old_sha1 = NULL;
> +
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
> -           ref_transaction_delete(transaction, refname,
> -                                  (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
> +           ref_transaction_delete(transaction, refname, old_sha1,
>                                    flags, NULL, &err) ||
>             ref_transaction_commit(transaction, &err)) {
>                 error("%s", err.buf);
> --
> 2.1.4
>
