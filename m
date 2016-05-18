From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 10/12] attr: convert git_all_attrs() to use "struct git_attr_check"
Date: Wed, 18 May 2016 09:34:22 -0700
Message-ID: <CAGZ79kZOFxRDAjXExVy5B4h=zSnd7VfxY6K3W5Y3-EQNQ8XMJA@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com> <20160516210545.6591-11-gitster@pobox.com>
 <xmqqeg90y5yz.fsf@gitster.mtv.corp.google.com> <xmqq7fesv1d6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 18:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34QW-0000Xk-7n
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcERQeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:34:24 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33614 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcERQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:34:23 -0400
Received: by mail-io0-f182.google.com with SMTP id f89so72310502ioi.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FqIwGeRAqyVb5LFYI9RD2ThP2fmbenHFmLS+5TsN2aU=;
        b=YiAPeZWWelFeGPAtBnSuTZYlPAc0OIC49BfZAHxCrmZfH6BAjCTyfiLxd8wI8raUGl
         SypYVbzwYF7QmDOShZ3bYGOxkUXkEQfbMirYilcXwUCCveZZZ0A4VDony+RfSSwKqyV1
         eL+lV5yoP90j2BQiIAIjoeyDUdpxUIAwj1SAvZuZDmYh7vyGWEaAfxYIysXFgJ83D/eU
         h3ZXziwDbj3l25ge4DnHxD+1A2M9c4MgnHq3FIS0vaOzF9W58UGKVEsYSXumKgdi8bqh
         RZ0/ywJpgQw6FjKKCIE8OfsSV3AVWtOhkWbPUuoa5kdgpy/t0/n1VTtQqDgLYm+A3I/j
         dXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FqIwGeRAqyVb5LFYI9RD2ThP2fmbenHFmLS+5TsN2aU=;
        b=b+KMnEXJNwQPdR4C5JxGUcXbD6N4rjJ7dC/gT3WL6zoG7Nj7Fp6NpBdrN97LLhV/D6
         jYwmASDeGA3RA1pPzVX86H9PHYalFqbVQ0nYiHW1yuvfXM2RlkARfbVKot341aK5EzJi
         eSBRfoTOlz+Fs+emq6qfJKQj0Jcf/OgGI7PcplFgJshl1BqpRICvN1sJtZE7Ap5BMMt6
         l3t6K9p8e1qY92h2djmSlhNrbgKyaC6lEQ0YN2SESdw2/fhoo/IqJPR2raR7vR44ecaS
         MXKmDs5g/PnLuabQvCYyueG1kBziQtCwx8zAsnLhzlTAOcNdZk0TKPLSf7VfE0LkCgHf
         2Lqw==
X-Gm-Message-State: AOPr4FXFZV+jSW5Gn0BEHiyyPgIh2GpPVNJlsJlT/73jTM8d+TebQA/sF/KU+jjSNyMYThDfm8JB7IFBkI91X2pD
X-Received: by 10.36.62.133 with SMTP id s127mr6031994its.98.1463589262575;
 Wed, 18 May 2016 09:34:22 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 09:34:22 -0700 (PDT)
In-Reply-To: <xmqq7fesv1d6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294970>

On Tue, May 17, 2016 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Given that one of the two expected callers, namely, "check-attr" and
>> Stefan's pathspec label magic, of this "alloc and then append" side
>> of the API wants to have an access to git_attr(name), I think
>> the function signature for this one should be updated to take not
>> "const char *name" but instead take "struct git_attr *attr", i.e.
>
> Perhaps this can be squashed into 12/12 to update the tutorial part
> to cover this less often used form.

That would be great!

Thanks,
Stefan

>
>  Documentation/technical/api-gitattributes.txt | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
> index 6f13f94..92fc32a 100644
> --- a/Documentation/technical/api-gitattributes.txt
> +++ b/Documentation/technical/api-gitattributes.txt
> @@ -55,7 +55,11 @@ Querying Specific Attributes
>
>  * Prepare `struct git_attr_check` using git_attr_check_initl()
>    function, enumerating the names of attributes whose values you are
> -  interested in, terminated with a NULL pointer.
> +  interested in, terminated with a NULL pointer.  Alternatively, an
> +  empty `struct git_attr_check` can be prepared by calling
> +  `git_attr_check_alloc()` function and then attributes you want to
> +  ask about can be added to it with `git_attr_check_append()`
> +  function.
>
>  * Call `git_check_attr()` to check the attributes for the path.
>
> @@ -112,6 +116,22 @@ static void setup_check(void)
>         }
>  ------------
>
> +To see how attributes in argv[] are set for different paths, only
> +the first step in the above would be different.
> +
> +------------
> +static struct git_attr_check *check;
> +static void setup_check(const char **argv)
> +{
> +       check = git_attr_check_alloc();
> +       while (*argv) {
> +               struct git_attr *attr = git_attr(*argv);
> +               git_attr_check_append(check, attr);
> +               argv++;
> +       }
> +}
> +------------
> +
>
>  Querying All Attributes
>  -----------------------
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
