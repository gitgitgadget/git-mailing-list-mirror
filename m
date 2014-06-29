From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/4] diff: mark any file larger than
 core.bigfilethreshold binary
Date: Sun, 29 Jun 2014 08:11:16 +0700
Message-ID: <CACsJy8BobwPCnyBgYJw6yVZF_05aKeaBGRe=C4GxvUL4V58y_Q@mail.gmail.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
 <1403610336-27761-1-git-send-email-pclouds@gmail.com> <1403610336-27761-4-git-send-email-pclouds@gmail.com>
 <xmqqegyb5zeh.fsf@gitster.dls.corp.google.com> <53ADBE51.9050005@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 03:11:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X13ew-0000Bf-7y
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 03:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbaF2BLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 21:11:48 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:39870 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaF2BLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 21:11:47 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so5381695qaq.10
        for <git@vger.kernel.org>; Sat, 28 Jun 2014 18:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6GZhtqW/siYeTNEY8bDVirWi0FoweGXRBMdTbVY0yzs=;
        b=SyxoloNv5YFCCVWnv2vPjaLAoK7BC3q9NezS2gydB6Vjg/jtITkIjTRnm8e6a/gyt6
         Kfaro3ySLNsP7Iwn2bsfB3NbiHE9loOAWOj0meEHPpB1ttWPF67qtk/NmU/l4anZKQfO
         RGfOCQBlpBiDGFoZzR7OseR3OSmWSg65T3MUfxppCZesMz+YvbjtjPky+o6I3tUUXQDJ
         efLrHAjB8C6AVKp5Vh3ywcXivqP4UsRTPFk8bl24CeQ3Np9zkhM4tZFdkMWDf0+lj8ar
         7PyTKmCxYgHu79QJVqBlkc05aRqYjvBKo9lVXYHxt2zjZkliraSFYHpL0mQriRSaXnoH
         Lolg==
X-Received: by 10.140.83.209 with SMTP id j75mr44950148qgd.42.1404004306406;
 Sat, 28 Jun 2014 18:11:46 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 28 Jun 2014 18:11:16 -0700 (PDT)
In-Reply-To: <53ADBE51.9050005@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252625>

On Sat, Jun 28, 2014 at 1:56 AM, Thomas Braun
<thomas.braun@virtuell-zuhause.de> wrote:
>> The name is misleading and forced me to read it twice before I
>> realized that this is "populating the is-binary bit".  It might make
>> it a bit better if you renamed it to DIFF_POPULATE_IS_BINARY_BIT or
>> perhaps DIFF_POPULATE_CHECK_BINARY or something.  For consistency,
>> the other bit may want to be also renamed from SIZE_ONLY to either
>>
>>  (1) CHECK_SIZE_ONLY
>>
>>  (2) One bit for CHECK_SIZE, another for NO_CONTENTS, and optionally
>>      make SIZE_ONLY the union of two
>>
>> I do not have strong preference either way; the latter may be more
>> logical in that "not loading contents" and "check size" are sort of
>> orthogonal in that you can later choose to check, without loading
>> contents, only the binary-ness without checking size, but no calles
>> that passes a non-zero flag to the populate-filespec function will
>> want to slurp in the contents in practice, so in that sense we could
>> declare that the NO_CONENTS bit is implied.

Will do (and probably go with (1) as I still prefer zero as "good defaults")

>> But more importantly, would this patch actually help?

Well yes as demonstrated by the new test ;-) Unfortunately the scope
of help is limited to --stat.. I should have done more thorough
testing.

>> For one
>> thing, this wouldn't (and shouldn't) help if the user wants --binary
>> diff out of us anyway, I suspect, but I wonder what the following
>> codepath in the builtin_diff() function would do:
>>
>>               ...
>>       } else if (!DIFF_OPT_TST(o, TEXT) &&
>>           ( (!textconv_one && diff_filespec_is_binary(one)) ||
>>             (!textconv_two && diff_filespec_is_binary(two)) )) {
>>               if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
>>                       die("unable to read files to diff");
>>               /* Quite common confusing case */
>>               if (mf1.size == mf2.size &&
>>                   !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
>>                       if (must_show_header)
>>                               fprintf(o->file, "%s", header.buf);
>>                       goto free_ab_and_return;
>>               }
>>               fprintf(o->file, "%s", header.buf);
>>               strbuf_reset(&header);
>>               if (DIFF_OPT_TST(o, BINARY))
>>                       emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
>>               else
>>                       fprintf(o->file, "%sBinary files %s and %s differ\n",
>>                               line_prefix, lbl[0], lbl[1]);
>>               o->found_changes = 1;
>>       } else {
>>               ...
>>
>> If we weren't told with --text/-a to force textual output, and
>> at least one of the sides is marked as binary (and this patch marks
>> a large blob as binary unless attributes says otherwise), we still
>> call fill_mmfile() on them to slurp the contents to be compared, no?
>>
>> And before you get to the DIFF_OPT_TST(o, BINARY), you memcmp(3) to
>> check if the sides are identical, so...
>
> Good point. So how about an additional change roughly sketched as
>
> @@ -2223,6 +2223,14 @@ struct userdiff_driver *get_textconv(struct
> diff_filespec *one)
>         return userdiff_get_textconv(one->driver);
>  }
>
> +/* read the files in small chunks into memory and compare them */
> +static int filecmp_chunked(struct diff_filespec *one,
> +       struct diff_filespec *two)
> +{
> +       // TODO add implementation
> +       return 0;
> +}
> +


We have object streaming interface to do similar like this. In fact
index-pack already does large file memcmp() for hash collision test. I
think I can move some code around and support large file in this code
path..
-- 
Duy
