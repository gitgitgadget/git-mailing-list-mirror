From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Tue, 3 Sep 2013 21:54:19 +0700
Message-ID: <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg> <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 16:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGs0M-0001Kt-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 16:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab3ICOyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 10:54:51 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:38941 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab3ICOyu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 10:54:50 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so5814147obc.41
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LA7Ung/dBfWagZuZ/YhGJs8SasBO0am8bI6PNWHzaEc=;
        b=JGM4HhPEDZ87NXxtoM6Xw7xll5TZXT+gGjuHa3vfYh4lQP6E7SYjbW9rViS9MsTFtx
         RL1lRnonAZcx6kigak72vRc+lG+kUUUALULjKarUrvRmqW3azLnEzHzqLAObr7tia/nZ
         3xC6z8qAj3jV6EzCxel8iU/AD46wURRciaEuA+cJiIM1v8qmRc0StyBpptWdSx767Wz2
         1MzgHLnofeWlKAMCFQ+88ka2R/VZ+80RVHwezT772WOGbRpRVnHkakQzT21ehmgnYB2n
         pns0zzPjshFT6ICZ5IG2X+tQLCtlSpQp3jgce2kZnTfYdZoz8q2AHCo6mekmA08/JGAw
         t0/A==
X-Received: by 10.60.95.99 with SMTP id dj3mr396475oeb.94.1378220089867; Tue,
 03 Sep 2013 07:54:49 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 3 Sep 2013 07:54:19 -0700 (PDT)
In-Reply-To: <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233726>

On Tue, Sep 3, 2013 at 6:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Sep 3, 2013 at 1:46 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> So... looks like pack v4 is now "functional".
>>
>> However something is still wrong as it operates about 6 times slower
>> than pack v3.
>>
>> Anyone wishes to investigate?
>
> You recurse in decode_entries too deep.I check the first 10000
> decode_entries() calls in pv4_get_tree(). The deepest level is 3491.

And I was wrong, the call depth is not that deep, but the number of
decode_entries calls triggered by one pv4_get_tree() is that many.
This is on git.git and the tree being processed is "t", which has 672
entries.. There are funny access patterns. This is the output of

   fprintf(stderr, "[%d] %d - %d %u\n", call_depth, copy_start,
copy_count, copy_objoffset);

[1] 0 - 1 48838573
[2] 0 - 1 48826699
[3] 0 - 1 48820760
[4] 0 - 1 48814812
[5] 0 - 1 48805904
[6] 0 - 1 48797000
[7] 0 - 1 48794034
[8] 0 - 1 48791067
[9] 0 - 1 48788100
[10] 0 - 1 48785134
[11] 0 - 1 48776221
[12] 0 - 1 48764321
[13] 0 - 1 48503227
[14] 0 - 1 48485415
[15] 0 - 1 48473512
[16] 0 - 1 48443621
[17] 0 - 1 48401788
[18] 0 - 1 48377834
[19] 0 - 1 48371841
[20] 0 - 1 48341809
[21] 0 - 1 48260734
[22] 0 - 1 48236635
[23] 0 - 1 46845105
[24] 0 - 1 14603061
[25] 2 - 1 48838573
[2] 0 - 1 48826699

It goes through 20+ base trees just to get one tree entry, I think..
-- 
Duy
