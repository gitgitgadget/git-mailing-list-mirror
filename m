From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 3 Sep 2015 21:35:36 +0530
Message-ID: <CAOLa=ZTndOz5M-3dErpKG5FHxa31ccgvQB+3AK2gQotNDkTF8Q@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <vpq8u8ptcjq.fsf@anie.imag.fr>
 <CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
 <vpq7fo8ol7i.fsf@anie.imag.fr> <CAOLa=ZRiGg1snfsi_mxQYq-wV6Zz4cTkxum47dRowp1XopQejw@mail.gmail.com>
 <CAOLa=ZRSbixzcNyF_s2E+oHMJsG7SuKizb5WHHk5Dmj-OKEetw@mail.gmail.com> <vpq8u8nh85k.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXX1l-0000cV-OL
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbbICQGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:06:08 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34744 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973AbbICQGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:06:07 -0400
Received: by obcts10 with SMTP id ts10so36494434obc.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s9DIJ03vzGbsk+equkWsAoqxwlcJq+VpifA0GaSOf5M=;
        b=YUHeLu/kprn5Nsp6OFQX2PRzfs0xY1OBkTuHULHtT/c+Uj+KOmfyX42W4/3QicRLOT
         KzaPstFN1nrWGFZaczrSRjnMTXzdFWJW0X+ZvFc5o7PyQZiIHxt/KQmviEpk3385za7r
         FSrBxSsx+RllgQE+r4TFqq55BO/a0dogacuy1e3CPpjHBNKZcB0gLyMSkeHmaN/VKpi8
         AEEnEG+8utz8UceEpSaEzkPJFp048BT9/cF1RKNDDpvI3CFhLtunzETtrZEc21nylzb7
         4m0L4AfRqOSdCGFqKv3yeat8BH4OCYjpBbEGMZ5f5dCBn8fpM0q+cWuHM24DC0RmkHbz
         GWFw==
X-Received: by 10.182.196.101 with SMTP id il5mr15976513obc.41.1441296366285;
 Thu, 03 Sep 2015 09:06:06 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 3 Sep 2015 09:05:36 -0700 (PDT)
In-Reply-To: <vpq8u8nh85k.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277219>

On Thu, Sep 3, 2015 at 8:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Thu, Sep 3, 2015 at 7:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>                         struct strbuf s = STRBUF_INIT;
>>>>                         if (strtoul_ui(valp, 10, &v->u.contents.lines))
>>>>                                 die(_("positive width expected contents:lines=%s"), valp);
>>>> -                       append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
>>>> +                       append_lines(&s, subpos, bodypos + bodylen - subpos, v->u.contents.lines);
>>>>                         v->s = strbuf_detach(&s, NULL);
>>>>                 }
>>>>         }
>>
>> append_lines(&s, subpos, bodylen + bodypos - subpos - siglen,
>> v->u.contents.lines);
>>
>> We need to eliminate the signature if existing also.
>
> Indeed. I thought body did not include the signature.
>
> I'd write it as
>
>   bodylen + bodypos - siglen - subpos
>
> or even
>
>   char *contents_end = bodylen + bodypos - siglen;
>   ...
>   append_lines(&s, subpos, contents_end - subpos, ...);
>
> to make it self-explanatory.
>

I was thinking of adding a comment but a self explanatory comment
seems like a good idea. Thanks.

-- 
Regards,
Karthik Nayak
