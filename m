From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Mon, 3 Aug 2015 15:50:00 +0530
Message-ID: <CAOLa=ZTNv7bRMZL_yAGSKxDyBPUBuMQKsybQBg3sKbLzM=m0YQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <vpqh9oov017.fsf@anie.imag.fr>
 <CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
 <vpq3807gdp0.fsf@anie.imag.fr> <CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
 <vpqbneucddv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 03 12:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMCrD-0006Fy-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 12:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbbHCKUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 06:20:31 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35503 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbHCKUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 06:20:30 -0400
Received: by obbop1 with SMTP id op1so95731716obb.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P0GnzDzXzd871xDhRLycDGqgX/yNix9Z5X0OF+FgwPU=;
        b=N33tE+CkfW7ExHcLCvUHUThAiiDRmnMrM3aab5Gn5NstOUNg5D9HmKnJA1iYH8j4Z6
         LodrbZwcWImwN4AW3qzJ6z3VMYJeGsdj2yHjeAusdVl4jOSqf7XJue2Jl2dhptBqAdE+
         9Pa8kQGXRxuRjuw8PNzAs6iRwEtf9A7uhrB9mA/xI2kCtdH91waYCWUD0h+yabN9cU3v
         Odl+rN4iNRnPjcg0JEN9c9/emCVzBeWmjQVy3XO55t/t7WE9HYxz61ImAuVJUFDJSk+q
         iACbUuf/0njSd6fg6oSAcpotoJm89a51Gj30QuztIR+iBoT08QnKDqphePKmCrFqp6G7
         67ZA==
X-Received: by 10.182.29.68 with SMTP id i4mr15259114obh.57.1438597229583;
 Mon, 03 Aug 2015 03:20:29 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 03:20:00 -0700 (PDT)
In-Reply-To: <vpqbneucddv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275159>

On Thu, Jul 30, 2015 at 12:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> Solving this doesn't seem much harder than
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 6c0189f..a4df287 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1117,7 +1117,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>         struct commit *commit = NULL;
>         unsigned int kind;
>
> -       if (flag & REF_BAD_NAME) {
> +       if (!filter->show_bad_name_refs && (flag & REF_BAD_NAME)) {
>                   warning("ignoring ref with broken name %s", refname);
>                   return 0;
>         }
> diff --git a/ref-filter.h b/ref-filter.h
> index 98ebd3b..b9d2bbc 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -79,7 +79,7 @@ struct ref_filter {
>                 match_as_path : 1;
>         unsigned int lines, branch_kind;
>         int abbrev, verbose;
> -       int detached : 1;
> +       int detached : 1, show_bad_name_refs : 1;
>  };
>
>  struct ref_filter_cbdata {
>
> and setting filter->show_bad_name_refs when needed (untested). Did I
> miss something?
>

This allows it to be added to ref_array. But it would still fail while
trying to obtain
object details prior to printing.

> IIRC, historicaly Git allowed some weirdly named refs which made some
> commands ambiguous (e.g. a branch named after an option like '-d').
> We're forbidding their creation so people shouldn't have any, but we
> it's important to continue showing them in case some people have old
> bad-named branches lying around.
>
> I'd rather have the code strictly better after your contribution than
> before.
>

Agreed. But then again the warning tells about the broken ref, as in it's name
So I think It's ok?

for e.g. t1430 :
[trash directory.t1430-bad-ref-name] ../../git branch
warning: ignoring ref with broken name refs/heads/broken...ref
* master


-- 
Regards,
Karthik Nayak
