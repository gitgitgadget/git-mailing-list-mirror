From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Sun, 24 Aug 2014 16:39:37 -0700
Message-ID: <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com> <53FA0054.5060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLhOF-0000Af-DG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 01:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbaHXXj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 19:39:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37639 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbaHXXj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 19:39:58 -0400
Received: by mail-la0-f46.google.com with SMTP id b8so12014127lan.19
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eAYua+8F6Y+w1Ucrk8IWqHds9qImduz6uTZ5AcfJUxc=;
        b=z+MLASK7fgheOzVBSdPe31hMlWZGZyLGmJBsvAYry+rkAv2NUvy1KpmHdVAiJtIeNd
         gofi7Ucs94dBXUESlv0k2EIi3UOS0tZkCIKlHBEldtar5mLX74AJQkRPbyDtF2mjUvkl
         I3yzwftvQYPbm/D25i8IorY87tDPauSiOZukemaWvYLFK3ayqiL3Zp/0t7pZZTFbagT8
         /tBeeQcxJLXGTg0GpROGZZMR09rpUdGRcK07U6/o8qjKM5WSGyPep7Syx14QnmPkiJ9M
         crWQannF7+HwL+G5Jyv4oL714oxcT+TfXYgOsdqbBr4UASheIZd4n0CKeQSqClbhZ+DY
         avKA==
X-Received: by 10.112.136.230 with SMTP id qd6mr3943747lbb.90.1408923597065;
 Sun, 24 Aug 2014 16:39:57 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Sun, 24 Aug 2014 16:39:37 -0700 (PDT)
In-Reply-To: <53FA0054.5060808@gmail.com>
X-Google-Sender-Auth: 5Q7Y803NyZutwiXb7uH5vEU_BnY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255816>

On Sun, Aug 24, 2014 at 8:10 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
>>       for (p = list, i = 0; i < cnt; i++) {
>> -             struct name_decoration *r = xmalloc(sizeof(*r) + 100);
>> +             char name[100];
>
> Would it make sense to convert the 'name' into a git strbuf?
> Please have a look at Documentation/technical/api-strbuf.txt

Why not go one step further and format it twice, once only
to measure the necessary size to allocate, allocate and
then format into it for real? Then you do not need to print
into a temporary strbuf, copy the result and free the strbuf,
no?

BUT.

The string will always be "dist=" followed by decimal representation of
a count that fits in "int" anyway, so I actually think use of strbuf is way
overkill (and formatting it twice also is); the patch as posted should be
just fine.

Or am I missing some uses that require larger/unbounded buffer outside
the context of the patch?
