From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Sat, 12 Sep 2015 18:04:30 -0700
Message-ID: <xmqqlhcbxh7l.fsf@gitster.mtv.corp.google.com>
References: <20150715132552.GA28574@lanh>
	<1440204002-7638-1-git-send-email-pclouds@gmail.com>
	<1440204002-7638-3-git-send-email-pclouds@gmail.com>
	<xmqq8u8i9okf.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CD+cNdM5EppcStJViRA7yPpyAHyUX=ct4LEK6RCrJrFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, bjornar@snoksrud.no
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 03:04:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zavif-0001SG-RU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbbIMBEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:04:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33079 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbbIMBEd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:04:33 -0400
Received: by pacex6 with SMTP id ex6so108959417pac.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=48ersOixU0I01MS/fBjI9gzarMx3p/fV88uubt0kww0=;
        b=JpMKaBrp4i+8O52CPzo1XCBQySBkiMerG5kzHdOQwaPqgZh1X37XtWgyrmDLI1QO2+
         fsmBxoveLJfA9+gzetUBbtWgDmQo7pyyEeJSqCLKIWI3pRNk9Of444nd/pLJJwylaY1i
         nHo5s+ixMrtPOJGIBFjFm+FpRV36Yi92MDjgCpxTyL9OvUSM9HeWFp/uY98jfZ5/svtV
         xzd/CqyZ+HWmZbR5ffpO4+KKm2G9H9w1AktJnTnnDSUPbkn+caELN2Of+DRpwOPq8y+s
         7kxY8QlDk90hg7hwfQZerl4ddtZ5wIyQCmEgQ/yjynuEIQjlwZW93qnRSHKLxeipiFpR
         NK+w==
X-Received: by 10.69.26.5 with SMTP id iu5mr3203455pbd.12.1442106272861;
        Sat, 12 Sep 2015 18:04:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:413:bc37:a4ef:e17c])
        by smtp.gmail.com with ESMTPSA id sb6sm2747965pbc.12.2015.09.12.18.04.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 12 Sep 2015 18:04:31 -0700 (PDT)
In-Reply-To: <CACsJy8CD+cNdM5EppcStJViRA7yPpyAHyUX=ct4LEK6RCrJrFw@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 13 Sep 2015 07:49:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277749>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Sep 7, 2015 at 11:33 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>
>> The cover letter talks about "local clone", and in this entire
>> series, I saw new tests only for the local case, but doesn't this
>> and the next change also affect the case where a Git daemon or a
>> upload-pack process is serving the remote repository?
>>
>> And if so, how is that case affected?
>
> People who serve .git-dir repos should not be affected (I think we
> have enough test cases covering that). People can serve .git-file
> repos as well, which is sort of tested in the local clone test case
> because upload-pack is involved for providing remote refs, I think.

Unfortunately, the above is still not unclear to me.

Was serving from a linked repository working without these five
patches, i.e. was the local case the only one that was broken and
needed fixing with these five patches?  If so, the log message
should mention that (i.e. "remote case was working OK but local was
broken because ...; change this and that to make local one work as
well").  If the remote case also was broken and fixed by these five
patches, then that is also worth mentioning the same way.

I didn't ask you to explain it to me in the first place in a
response.  The review comment pointed out that the proposed log
message was unclear and those who will be reading "git log" output
need clearer description.

Thanks.
