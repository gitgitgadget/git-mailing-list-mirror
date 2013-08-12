From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] push: respect --no-thin
Date: Mon, 12 Aug 2013 18:30:24 +0700
Message-ID: <CACsJy8C-c1TXRiYBO7Mm0jGZvttqzRTONTkskuoU3_kZxHhuCQ@mail.gmail.com>
References: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
 <1376211178-17444-1-git-send-email-pclouds@gmail.com> <7vhaev1mao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 13:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8qKy-00040k-CN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 13:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab3HLLa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 07:30:56 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:42793 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab3HLLaz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 07:30:55 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so9419031oag.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bos5ouJ9x8rE5qyiUHW0F7w/nWhUb0wdZh3Kzc1nbmg=;
        b=uUitkD1fsglqiCwG8rq+pEV6auN8ZIyn8FPU53m13gn7IsywCklUvLoU1x69uoMkxk
         ekJ9FMTiOEE8agFkf9eeJJkCJDQFBT7miItyN6k9h03jqiWE/z/wGVUsxKlnW+23e/o4
         WWba+Yt9BLFapENWJYA51fyzocQyijryYeME/mmcPr1WptTn0SaAE1xyYtJiA5XYCEAW
         /X2CYqorrXgcyuCrQw19EYWGK+Z7YqZLfXIn5q2qMdD8txjlCN0X9XtXo0fOSFlr/RZD
         mljWBIp5uXfCj8EXcpla2R3cfa1moO+T2pYi+r1eOldKbAeo2cZWvmrc+v64noe6ggdS
         ibBA==
X-Received: by 10.60.78.228 with SMTP id e4mr10182483oex.89.1376307054871;
 Mon, 12 Aug 2013 04:30:54 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 12 Aug 2013 04:30:24 -0700 (PDT)
In-Reply-To: <7vhaev1mao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232183>

On Mon, Aug 12, 2013 at 12:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -15,7 +15,7 @@ static const char * const push_usage[] = {
>>       NULL,
>>  };
>>
>> -static int thin;
>> +static int thin = 1;
>>  static int deleterefs;
>>  static const char *receivepack;
>>  static int verbosity;
>> @@ -313,8 +313,7 @@ static int push_with_options(struct transport *transport, int flags)
>>       if (receivepack)
>>               transport_set_option(transport,
>>                                    TRANS_OPT_RECEIVEPACK, receivepack);
>> -     if (thin)
>> -             transport_set_option(transport, TRANS_OPT_THIN, "yes");
>> +     transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
>>
>>       if (verbosity > 0)
>>               fprintf(stderr, _("Pushing to %s\n"), transport->url);
>
> Hmm, I am utterly confused.
>
> How does the original code have thin as an non-overridable default?
> The variable is initialized to 0, parse-options specifies it as
> OPT_BOOLEAN, and TRANS_OPT_THIN is set only if "thin" is set.
>
> Updated code flips the default to "1" but unconditionally uses
> TRANS_OPT_THIN to set it to either "yes" or NULL.  While it is not
> wrong per-se, do_push() (i.e. the caller of this function) grabs the
> transport from transport_get() which initializes the transport with
> the thin option disabled by default,

transport_get() actually sets thin option to 1 by default. If I don't
misread the code, the first version of transport.c already flipped
"thin" from 0 (in push.c) to 1 (in transport.c), see 9b28851 (Push
code for transport library - 2007-09-10). The funny thing is that
commit was just one day after Shawn flipped 'thin' from 1 to 0 in
push.c in a4503a1.

> so it is not immediately
> obvious to me why "always call TRANS_OPT_THIN but set it explicitly
> to NULL when --no-thin is asked" is necessary or improvement.
-- 
Duy
