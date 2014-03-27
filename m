From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/17] ls-files: buffer full item in strbuf before printing
Date: Thu, 27 Mar 2014 01:22:07 -0400
Message-ID: <CAPig+cQ5amNNUh4XHp=tJh8BWpTASThPOB-750SzAdUi3Q1Dzw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-6-git-send-email-pclouds@gmail.com>
	<CAPig+cRpL9PYKLEH8DocKWo2-ZnqtD6j30TLES1NyOnk52D+Mw@mail.gmail.com>
	<CACsJy8B653BGo8GEBv1VFMZ1ncEeYXFqY5KcR-4thv9hk2+ApA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 06:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT2m5-0002KY-2I
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 06:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbaC0FWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 01:22:10 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42852 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaC0FWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 01:22:08 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so3073032yha.24
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=27AQxeHxtOzwj4druvE9BtiCkPypiLvU3SrCWW1rZmI=;
        b=hyboiHFGEY7/KCJHQ+KezVLuoGRLdp/4T8bV0OEklbLadQXFrKSPD5veZlXCcJ5GCW
         wlh6P8/dgmUPMhjl65kq58n+IrqtGYtAe+5T24DDpUk1gRfbh0fLI8WIR8v+GKr/15GC
         YQE/50Ue9fTqpLcMCeQ6SWK77FeWoytSDtq3peCHYob4zLdf8UGShXfFDu1/2YV8PD78
         EDLTD3mXlyWUHea3QEOLoMx1DL/7Xb40oIPNwMXO3MNZYvO/o2SYQGRB4LREpvwrr99D
         gXrGu6SVYDAyt92Y2UuvzEzaBXrgk3icJtfMalODCaktO4RcWoSm8h4mNGuIrwlTQ1Se
         B5/A==
X-Received: by 10.236.175.37 with SMTP id y25mr24545161yhl.100.1395897727842;
 Wed, 26 Mar 2014 22:22:07 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 22:22:07 -0700 (PDT)
In-Reply-To: <CACsJy8B653BGo8GEBv1VFMZ1ncEeYXFqY5KcR-4thv9hk2+ApA@mail.gmail.com>
X-Google-Sender-Auth: 56BOfKP_rTraRY_NKBuOCRLm0ek
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245260>

On Wed, Mar 26, 2014 at 7:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 27, 2014 at 2:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>  static void show_dir_entry(const char *tag, struct dir_entry *ent)
>>>  {
>>> +       static struct strbuf sb = STRBUF_INIT;
>>>         int len = max_prefix_len;
>>>
>>>         if (len >= ent->len)
>>> @@ -67,8 +79,10 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
>>>         if (!dir_path_match(ent, &pathspec, len, ps_matched))
>>>                 return;
>>>
>>> -       fputs(tag, stdout);
>>> -       write_name(ent->name);
>>> +       strbuf_reset(&sb);
>>> +       strbuf_addstr(&sb, tag);
>>> +       write_name(&sb, ent->name);
>>> +       strbuf_fputs(&sb, stdout);
>>
>> strbuf_release(&sb);
>
> Not strictly necessary because sb is static and will be reset at the
> next call. I just want to lower the number of allocation (write_name
> allocates some more). It may be a premature optimization though.

Ah, yes. I noted the 'static' on my initial read-through but had
forgotten about it by the time I finally got to a computer with which
I could send plain-text email. Sorry for the noise.

> The same for changes in show_ce_entry().
> --
> Duy
