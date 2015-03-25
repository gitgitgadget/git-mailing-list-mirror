From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/2] cat-file: teach cat-file a '--literally' option
Date: Wed, 25 Mar 2015 03:42:04 -0400
Message-ID: <CAPig+cSxYca7sQ+0PZLPq6n0PQzQ-1JDLSRkaqBLfDPXpC7pBA@mail.gmail.com>
References: <5512618B.2060402@gmail.com>
	<1427268126-16964-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YafxB-0006QT-Lt
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 08:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbbCYHmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 03:42:08 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:32870 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbCYHmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 03:42:06 -0400
Received: by lbcmq2 with SMTP id mq2so11426737lbc.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fjeZnzao/lh4T7qfTpGdNjiTNdSiB7Ko0XNVFaXeC4g=;
        b=OvoBW3F1Ca8PIH8935tY668vaz5kHl5tigm055plg8w9z/pamMvKp1Vh3L+3vxRBkz
         bpoRqYIcY+ol0adip//pt4W1ualPVlMf0t3bLrNGztjKAPmqovs0VQL5jiSBHO8QLix4
         lb2ru+750TohE7CvRj9h8qx7ApZOe66dlWQwmwpca5jSj/BQBWY9A9O8Yc1JZm2NVM9S
         SsC98usfjIxKL/tVbApafFkS3jWRTwIEa6H7Hks/pCBObc/JHCbXE9AH6Rte/AkqjYEy
         tB9qoDmZfyAMEycVmsmcN7uRc9U8W/bIqrHPUBt59ARkgw7kmqMvgZMON9S2MNMZmzO5
         CMCA==
X-Received: by 10.152.43.3 with SMTP id s3mr7197737lal.101.1427269324698; Wed,
 25 Mar 2015 00:42:04 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 25 Mar 2015 00:42:04 -0700 (PDT)
In-Reply-To: <1427268126-16964-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: VYDreEj40Cg2d-MF8o3uzgthqDk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266271>

On Wed, Mar 25, 2015 at 3:22 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object which is
> created using 'git hash-object --literally'. This is
> because these objects are usually of unknown types.
>
> Teach git cat-file a '--literally' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.
>
> Modify '-t' and '-s' options to call sha1_object_info_extended()
> directly to support the '--literally' option.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..6fee461 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -405,5 +423,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         if (batch.enabled)
>                 return batch_objects(&batch);
>
> -       return cat_one_file(opt, exp_type, obj_name);
> +       if (literally && (opt == 't' || opt == 's'))
> +               return cat_one_file(opt, exp_type, obj_name, literally);
> +       else if (literally)
> +               die("git cat-file --literally: use with -s or -t");
> +
> +       return cat_one_file(opt, exp_type, obj_name, literally);

Although I haven't read the patch closely yet, this unnecessarily
complex logic caught my eye as I was scanning the changes. If you
check for the illegal option combination first, then you can coalesce
the two identical cat_one_file() invocations, and this entire hunk
reduces to the more readable:

    if (literally && opt != 't' && opt != 's')
        die("git cat-file --literally: use with -s or -t");

    return cat_one_file(opt, exp_type, obj_name, literally);

>  }
> --
> 2.3.1.170.g5319d60.dirty
