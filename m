From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 2/2] cat-file: teach cat-file a '--literally' option
Date: Wed, 25 Mar 2015 13:18:34 +0530
Message-ID: <55126852.2080002@gmail.com>
References: <5512618B.2060402@gmail.com> <1427268126-16964-1-git-send-email-karthik.188@gmail.com> <CAPig+cSxYca7sQ+0PZLPq6n0PQzQ-1JDLSRkaqBLfDPXpC7pBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:48:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yag3O-0003IP-MX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 08:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbbCYHsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 03:48:38 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34046 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbCYHsh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 03:48:37 -0400
Received: by pdbni2 with SMTP id ni2so20283257pdb.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0XSBeCRPouwBSNUFfpodgE75tOIFgPyh5EJM6BFlk+g=;
        b=mvXtS8AGjFdyoypQvzcClB0ahykoPUZg5G8DA+Mqdqd7JmbE8Fuom+izn6bd15cKnu
         MBtxJBqLPGLt/6jyg4Trn83I80gSjAuV4c6YruB7H1LHqoCdcygPFJ4odK7rUFyVHrO4
         Ze2azI7SB5M/fNwdxhMy+fihMgfv6+5bPFpKTz78eUgFox/MqMUFU/14LlAVvxdpEQIA
         U6l7J3PFWScp9LDYcdyV+o7/UcWWTwGYefb2nGa9dTm6yEYspKw70mYZp9/1Is8UuRQu
         SMrou5kG52tFydhGm8L/3yDxXDr0fqbSrWs/+WgBriH54aoB9RE+ai8flxi6GQY+FGSL
         d0Rw==
X-Received: by 10.66.102.65 with SMTP id fm1mr14449566pab.115.1427269717515;
        Wed, 25 Mar 2015 00:48:37 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id q2sm1503582pdp.68.2015.03.25.00.48.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 00:48:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cSxYca7sQ+0PZLPq6n0PQzQ-1JDLSRkaqBLfDPXpC7pBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266272>


On 03/25/2015 01:12 PM, Eric Sunshine wrote:
> On Wed, Mar 25, 2015 at 3:22 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > Currently 'git cat-file' throws an error while trying to
> > print the type or size of a broken/corrupt object which is
> > created using 'git hash-object --literally'. This is
> > because these objects are usually of unknown types.
> >
> > Teach git cat-file a '--literally' option where it prints
> > the type or size of a broken/corrupt object without throwing
> > an error.
> >
> > Modify '-t' and '-s' options to call sha1_object_info_extended()
> > directly to support the '--literally' option.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Helped-by: Eric Sunshine <sunshine@sunshineco
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index df99df4..6fee461 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -405,5 +423,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
> >          if (batch.enabled)
> >                  return batch_objects(&batch);
> >
> > -       return cat_one_file(opt, exp_type, obj_name);
> > +       if (literally && (opt == 't' || opt == 's'))
> > +               return cat_one_file(opt, exp_type, obj_name, literally);
> > +       else if (literally)
> > +               die("git cat-file --literally: use with -s or -t");
> > +
> > +       return cat_one_file(opt, exp_type, obj_name, literally);
>
> Although I haven't read the patch closely yet, this unnecessarily
> complex logic caught my eye as I was scanning the changes. If you
> check for the illegal option combination first, then you can coalesce
> the two identical cat_one_file() invocations, and this entire hunk
> reduces to the more readable:
>
>      if (literally && opt != 't' && opt != 's')
>          die("git cat-file --literally: use with -s or -t");
>
>      return cat_one_file(opt, exp_type, obj_name, literally);
>
> >   }
> > --
> > 2.3.1.170.g5319d60.dirty
Hey Eric,
Yes that could be done.

When small fixes like these need to be done, Is it sufficient to reply to this mail
with the fixed patch, or should I resend the whole patch series?

Thanks,
Karthik
