From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched branch
Date: Mon, 17 Sep 2012 15:25:20 +0200
Message-ID: <CAN0XMOJrFOWR4_Cdx5fJz2zKCf=mSKBKV16A0dy1f5DptdOMVA@mail.gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
	<1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
	<CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:25:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDbKM-0005zQ-F1
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 15:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336Ab2IQNZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 09:25:22 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33272 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab2IQNZW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 09:25:22 -0400
Received: by wibhr14 with SMTP id hr14so2526141wib.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z6NNvkbkcnCLjiWpSGVgQ9e8VGZbRygXOeJ33AJVpHY=;
        b=XCx56zgqCBaSTBCKwrvftu1mztu+Fz4lL6NWBkW63T90mugJkDKWy8txIzoqoEJZZq
         j1b5iraF3+7F8vPhVwo7rkGLL0r5ZUxHoq8lWaWvC2V2KNa5TShcYjQbNrIdy0Q82qgv
         eiN9b+8giLycEWjgDLMka12hVPrTL+OvInd/uS21HGarMTB2vzh+0oqfHSib/FoQe5lS
         DNpWg/8jimApQbbTPya2rWNQb5POTr4sl2GKN5mK40/ZWaCwVu90IrO/XqjLJyAolz7t
         X1E/wa6Dw1nbGh9dAHLesjzXuYBretU5sEc0gK+Cp+O9NMALExZWSVViQHUz69t6QIs5
         eYKw==
Received: by 10.180.104.200 with SMTP id gg8mr16174502wib.14.1347888320723;
 Mon, 17 Sep 2012 06:25:20 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Mon, 17 Sep 2012 06:25:20 -0700 (PDT)
In-Reply-To: <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205686>

On Mon, Sep 17, 2012 at 2:06 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sun, Sep 16, 2012 at 3:13 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
>> +       if (option_mirror || !option_bare) {
>> +               strbuf_reset(&value);
>
> I think we should use a new strbuf local variable here to avoid
> resetting this. At least reviewers don't have to check if this
> statememt causes any effect later on because "value"'s value is gone.
>

It seems that we don't need this reset here because it's already
done earlier in this function. The variable "key" is also used multiple
times so I wouldn't use a new variable.

>> +               if (option_single_branch) {
>> +                       if (option_branch)
>> +                               strbuf_addf(&value, "+%s%s:%s%s",
>> +                                               src_ref_prefix, option_branch,
>> +                                               branch_top.buf, option_branch);
>> +                       else if (remote_head_points_at)
>> +                               strbuf_addf(&value, "+%s:%s%s",
>> +                                               remote_head_points_at->name, branch_top.buf,
>> +                                               skip_prefix(remote_head_points_at->name, "refs/heads/"));
>> +                       /*
>> +                        * otherwise, the next "git fetch" will
>> +                        * simply fetch from HEAD without updating
>> +                        * any remote tracking branch, which is what
>> +                        * we want.
>> +                        */
>
> Maybe document updates too? Though if it's obvious that
> --single-branch should prepare refspec so that only one branch is
> fetched later on, then maybe not.
>

I think it's obvious.

>> +               } else {
>> +                       strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
>> +               }
>
> --mirror --single-branch combination does not look right. The "heads/"
> part is missing..
>
> $ git branch
>   master * wildmatch
> $ LANG=C ./git clone --mirror --single-branch .git abc
> Cloning into bare repository 'abc'...
> done.
> $ grep fetch abc/config
>         fetch = +refs/heads/wildmatch:refs/wildmatch
> $ rm -rf abc
> $ LANG=C ./git clone --mirror --single-branch --branch=master .git abc
> Cloning into bare repository 'abc'...
> done.
> $ grep fetch abc/config
>         fetch = +refs/master:refs/master
> --
> Duy

Thanks, I'll check this later and send a new version.
