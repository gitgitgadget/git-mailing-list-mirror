From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 05/17] ls-files: buffer full item in strbuf before printing
Date: Thu, 27 Mar 2014 06:18:30 +0700
Message-ID: <CACsJy8B653BGo8GEBv1VFMZ1ncEeYXFqY5KcR-4thv9hk2+ApA@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com> <1395841697-11742-6-git-send-email-pclouds@gmail.com>
 <CAPig+cRpL9PYKLEH8DocKWo2-ZnqtD6j30TLES1NyOnk52D+Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:19:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSx6C-0004FW-QH
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756520AbaCZXTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 19:19:02 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:59654 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508AbaCZXTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 19:19:01 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so1792278qge.16
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nNFK6oqaebL1DMEmr8mdl3BB5MSWva/K+PrXNIn/rlA=;
        b=EaR4fazptoSPNYj/7T8aVpKB+JbiAz1FGthVvo2QsymZnVFr6nS5/gfxnhY7dArjYm
         tHmwid4cF5wIMC1jCT5dKEdjM+hTtX6azsT0U0VGeVVj2BXL9ODVk1HW6Fr2ABPvX3YU
         XbGlH24FXhCK9aaXXSvCC6I3UHiXgzGPozZuEtPnBOH9J08B3rN9uxkCPn2UrrZ+Vd++
         kI1ZZ+Yxs9V/gmRLdnUEoJ7e+psaPWkRqZEID8eOeBmUq1yLyoIV/e8+Qbpcjjf+eT0c
         88Gy5mlnEUyuSBpT6aEsLYsGGpbXcdvuhTz54c5OyA9x5mLr724oHdL9NCFMh+uSCNqv
         p5ig==
X-Received: by 10.224.130.9 with SMTP id q9mr1586770qas.89.1395875940425; Wed,
 26 Mar 2014 16:19:00 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Wed, 26 Mar 2014 16:18:30 -0700 (PDT)
In-Reply-To: <CAPig+cRpL9PYKLEH8DocKWo2-ZnqtD6j30TLES1NyOnk52D+Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245257>

On Thu, Mar 27, 2014 at 2:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>  static void show_dir_entry(const char *tag, struct dir_entry *ent)
>>  {
>> +       static struct strbuf sb = STRBUF_INIT;
>>         int len = max_prefix_len;
>>
>>         if (len >= ent->len)
>> @@ -67,8 +79,10 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
>>         if (!dir_path_match(ent, &pathspec, len, ps_matched))
>>                 return;
>>
>> -       fputs(tag, stdout);
>> -       write_name(ent->name);
>> +       strbuf_reset(&sb);
>> +       strbuf_addstr(&sb, tag);
>> +       write_name(&sb, ent->name);
>> +       strbuf_fputs(&sb, stdout);
>
> strbuf_release(&sb);

Not strictly necessary because sb is static and will be reset at the
next call. I just want to lower the number of allocation (write_name
allocates some more). It may be a premature optimization though.

The same for changes in show_ce_entry().
-- 
Duy
