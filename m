From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 22:31:10 -0500
Message-ID: <CAMP44s1WDzRAFV8iNj_RYiiRwJdBcuUDVR-Ew5FF37qdpEO5Mg@mail.gmail.com>
References: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-fc <git-fc@googlegroups.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 05:31:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2sCb-00077m-68
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 05:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbcERDbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 23:31:12 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33984 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcERDbL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 23:31:11 -0400
Received: by mail-vk0-f44.google.com with SMTP id c189so45464543vkb.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 20:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Y0SPhg1eGiL9aapsz7cQrw9VBidPiIz4wOaMnuAYeGk=;
        b=ysk94PMWkTP7MbRVGn2SwcbQc+zq44A9QeKwfrp5FCYrHThzeQUT8jOIHdsp2yZsfW
         J9enik7mAREW3ROdZQb/AoLVNwzVnQ955iuPYNuKlYJneCuDMkAEMJKr4HQ/14dSki66
         9aO1Zv8Nd/iKUC9k9RHiozrrhLAUSuZ8dhU2hIXmuAK3qvAtj326YAm3tGirkRE9/gN6
         GqbKj+lkF7rWcKhIbgONPfMfjVhMb+ay0S2B++KmDLsTTtnce2BkOAuGfhbbZOOUwCbX
         /7QodBXlPKbbKULdsHtYH6xBPzI/ij/P6uwcjUrVESFbmfYR4wYNhhnoYQ85oiYXfOLC
         kPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y0SPhg1eGiL9aapsz7cQrw9VBidPiIz4wOaMnuAYeGk=;
        b=g1EKvMseVdASYTv4rVVQ0U6MBAycdy1xy3lCKANjyemECbsqUS4y7WIjjCXe+A1c5l
         ggH7LvtwgebK0cBID61Mxro3DwcykFTsrSE7PUrrz9uhdYaNZAd+MkRHJt5aen/L5knx
         4B6CN6X3eeIeGtXxlohPiXqYSulbPjfBblNsvRllzfogedD/RcFQyl0mIlp4ka0ZHdQU
         kWrRc2DUG+ZyfPutpMDHqWBdEZYJ6WN0wzONgXpKcXmkeH9+hsw0EdP8eKfJA0dgW1s2
         2oaDoYGEbVRnklLH45Gg5hq5YPclgb7oMZz1QtKjE5R2W6ZqfKhw8t/htsdkC6szrO/U
         dK4Q==
X-Gm-Message-State: AOPr4FWxpkLaHFITy1PPVOzY59fM2BxZak+jH0NtGAq4+NA/kWIu0yBJMYFhC1z+Z8kYuir1qih/hSgCw1PIEw==
X-Received: by 10.31.188.73 with SMTP id m70mr2730193vkf.70.1463542270532;
 Tue, 17 May 2016 20:31:10 -0700 (PDT)
Received: by 10.31.192.137 with HTTP; Tue, 17 May 2016 20:31:10 -0700 (PDT)
In-Reply-To: <xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294928>

On Tue, May 17, 2016 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Certain lines of the marks file might be corrupted (or the objects
>> missing due to a garbage collection), but that's no reason to truncate
>> the file and essentially destroy the rest of it.
>
> Hmm, so the issue is:
>
>  - we use die_nicely() that calls dump_marks() after writing a crash
>    report as our die_routine().
>
>  - when dump_marks() is called, and export_marks_file names an
>    existing file, it tries to write marks in it.  If we let it go
>    through, we would end up writing a new marks file based on an
>    incomplete set of marks we have only half-read in the earlier
>    step, which is bad, as the resulting one is incomplete, and the
>    original one that this replaced may have been a good one.
>
> Is that what this change addresses?

Yes. As I said; the marks file gets truncated.

> I am just wondering if a solution to preserve both files is more
> desirable.
>
> This change looks a bit over-eager to discard the dump die_nicely()
> is trying to create in one scenario, and a bit less careful at the
> same time in another scenario.
>
>  - Even if we are reading from somewhere, export_marks_file can
>    point at a completely new file that is different from
>    import_marks file, in which case, we are not really losing any
>    information by freshly creating a new marks file, no?

Right, we are not losing any information, but we are not gaining much
either: it's a truncated version of the import marks.

>  - Even if we did not read from any existing marks file, if we are
>    given export_marks_file that names an existing file, wouldn't we
>    want to avoid corrupting it with a dump from this aborted run?

If we don't run from an existing marks file, this patch has no effect.

-- 
Felipe Contreras
