From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] pretty: Pass graph width to pretty formatting for use
 in '%>|(N)'
Date: Wed, 23 Dec 2015 00:03:19 +0700
Message-ID: <CACsJy8C8DCi_pZDd=m1hE70t7Z+MX3j6WcMe-Hp-u0y5VvwKqg@mail.gmail.com>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com> <1442013913-2970-1-git-send-email-josef@kufner.cz>
 <xmqqa8sfa7di.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josef Kufner <josef@kufner.cz>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 18:03:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBQLq-0007t8-PJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbbLVRDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:03:51 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35166 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbbLVRDu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 12:03:50 -0500
Received: by mail-lb0-f171.google.com with SMTP id bc4so34400350lbc.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 09:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tFDH7eSN3RS9quJ4ZF12GcNsfSFquEc0EsEJOM9rdWs=;
        b=GK/Qa0IWJwpRDZ/HMc1wXbxuzz3HtoBi5/idRywTMECQWukmiTU2ATuUqomP/cKqJS
         cIUAIMi9sApc7DvWrTtCsxZZT09aNdC6xVqbB0eFCGBzjGjlQYc+9QXrCmcJbGf1unpM
         DKLd/iZGAdFZgZ0y22afBx3Xh9WSFzIqHk81SZc8LaxAXIBkmoF5mQiHxzkXjCHAz2Qe
         DN75WN066y+AGUuqrmjGmD3IA4OpfGvc3nzSEHZIcIQdKitcXG9APHCIVdAzsqihF32t
         lZzgPTztHHK4jjS4+N36dXlF2haKVudT7Fnob616wFQrZapno+jMfKam9ePbFQI8ZQNm
         a0KA==
X-Received: by 10.112.137.101 with SMTP id qh5mr8445204lbb.81.1450803828864;
 Tue, 22 Dec 2015 09:03:48 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 22 Dec 2015 09:03:19 -0800 (PST)
In-Reply-To: <xmqqa8sfa7di.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282886>

(I'm joining the newer thread [1] back to this one, thanks for
reminding me about this)

[1] http://thread.gmane.org/gmane.comp.version-control.git/282771

On Tue, Sep 22, 2015 at 2:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Josef Kufner <josef@kufner.cz> writes:
>
>> Pass graph width to pretty formatting, so N in '%>|(N)' includes columns
>> consumed by graph rendered when --graph option is in use.
>>
>> Example:
>>   git log --all --graph --pretty='format: [%>|(20)%h] %ar%d'
>>
>>   All commit hashes should be aligned at 20th column from edge of the
>>   terminal, not from the edge of the graph.
>>
>> Signed-off-by: Josef Kufner <josef@kufner.cz>
>> ---
>
> [CC'ed Duy for ideas, as the "%>|(ALIGN)" thing is his invention]
>
> If you imagine an entry for a commit in the "git log" output as a
> rectangle that has its commit log message, "--graph" draws a bunch
> of lines on the left hand side and place these rectangles on the
> right of these lines.  Space allocated to each of these rectangles
> may and do begin at a different column.  For example, here is an
> output from
>
>  $ git log -12 --graph --oneline
>
>  *   7d211c9 Merge branch 'jk/graph-format-padding' into pu
>  |\
>  | * ead86db pretty: pass graph width to pretty formatting
>  * |   5be4874 Merge branch 'ld/p4-detached-head' into pu
>  |\ \
>  | * | 4086903 git-p4: work with a detached head
>  | * | 6d2be82 git-p4: add failing test for submit from detached
>  head
>  * | |   7cec6a3 Merge branch 'ls/p4-lfs' into pu
>  |\ \ \
>  | * | | 5fac7db git-p4: add Git LFS backend for large file system
>  | * | | 53b938f git-p4: add support for large file systems
>  | * | | 760e31c git-p4: return an empty list if a list config has
>  no values
>  | * | | c1e88b8 git-p4: add gitConfigInt reader
>  | * | | 465af7a git-p4: add optional type specifier to gitConfig
>  reader
>  * | | |   5197bd3 Merge branch 'nd/clone-linked-checkout' into pu
>
> I can understand why you would want to include the varying width of
> the river on the left hand side in the "space allocated for the
> commit", and under that mental model, the patch makes sense, but at
> the same time, it is also a perfectly good specification to make
> "%>|(20)%h" pad "%h" to 20 columns from the left edge of the space
> given to the commit.
>
> I have a suspicion that 50% of the users would appreciate this
> change, and the remainder of the users see this break their
> expectation.  To avoid such a regression, we may be better off if we
> introduced a new alignment operator that is different from '%>|(N)'
> so that this new behaviour is available to those who want to use it,
> without negatively affecting existing uses.

I tend to agree with Josef. >|(N) is about columns relative to the
left edge of the screen. You can already use >(N) to be relative to
the left edge of the space given to the commit.
-- 
Duy
