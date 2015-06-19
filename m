From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship
 with git-mailinfo
Date: Fri, 19 Jun 2015 17:22:11 +0800
Message-ID: <CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 11:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sVA-0000P1-01
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbbFSJWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:22:16 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33196 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbFSJWN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:22:13 -0400
Received: by laka10 with SMTP id a10so70500056lak.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SrRfOeJq9JgW0eQ1udPT4Xgbws6FgIy0FM+5zY0MBtc=;
        b=o/aTQo0zh5sMVSEO7IUG6CVmFiXWfz8dM94yl4tLFZFdDAT07MWGuY7OrhRrQsJ9iq
         yWtrJ6PrbjwqqofsTekcLwCj6lVmZxXc4R+Jnh2ARBLCJt+agjey2aHV8/64T2XgWTy+
         Vp3bM78vzANok3THAVBu6gZEgNSLKJZNUG7fjKDVBPoU1hoJ9O337BSFl/MBMB/COaJv
         Tr5cwNV5QMKtVp08h2oEOi1Jzry6ypBuzyCk5THb0Am50qdUp8RnuKfxWSABUz5XKrG3
         tk8nBzzsyC2Qroh9JMwxyWeDftvuGUBElKlnKKj4eZhId/Dm7oxFJCa/KPatRXSd21wz
         GI1Q==
X-Received: by 10.152.22.99 with SMTP id c3mr17333239laf.32.1434705731922;
 Fri, 19 Jun 2015 02:22:11 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 19 Jun 2015 02:22:11 -0700 (PDT)
In-Reply-To: <xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272111>

On Fri, Jun 19, 2015 at 5:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +     /* commit message and metadata */
>> +     struct strbuf author_name;
>> +     struct strbuf author_email;
>> +     struct strbuf author_date;
>> +     struct strbuf msg;
>
> Same comment as "dir" in the earlier patch applies to these.  If the
> fields are read or computed and then kept constant, use a temporary
> variable that is a strbuf to read/compute the final value, and then
> detach to a "const char *" field.  If they are constantly changing
> and in-place updates are vital, then they can and should be strbufs,
> but I do not think that is the case for these.

I do think it is the case here. The commit message and metadata fields
change for every patch we process, and we could be processing a large
volume of patches, so we must be careful to not leak any memory.

We could use a char* field, but then to prevent memory leaks we would
then have to free() it and malloc() a new string for every patch we
process, which will lead to lots of malloc()s and free()s over a large
volume of patches that can lead to memory fragmentation.

Regards,
Paul
