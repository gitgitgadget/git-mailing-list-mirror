From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] cat-file: fix a memory leak in cat_one_file
Date: Thu, 27 Nov 2014 01:18:30 -0500
Message-ID: <CAPig+cSnOc42msPYsBSv+PTgFsDyBqeL7yhSutuRQUkezpTdmw@mail.gmail.com>
References: <CANCZXo7CKz2bOM=6ehed-VLUGtyThuBbwtd_QaBMm2KKhEo=Bw@mail.gmail.com>
	<20141127002417.GT6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 07:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtsPX-00086Z-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 07:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbaK0GSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 01:18:31 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:63844 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaK0GSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 01:18:30 -0500
Received: by mail-yh0-f45.google.com with SMTP id f10so1999771yha.18
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 22:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n04Ac14qSgrgokcCrKvkZHQFhAQOgjJ9fahQLFC1+Cs=;
        b=C5Qbl9mDdBudDyPDFdywgD91Ox/nKSZJtMjZ04Q6rVDOryGc5WJkOIS0uMuMblKfbg
         MMqxfC0qeJopy618WhxL5REVLjQ7VTMK7W20NawQGXBbTKt/tL2GD246voO5VdWKSeT5
         KupZDWnuUk7HYbgG3S/WJd+XZ3njI8dmnuljAxRr1Dy9AufFbcyu4s4rnxF8YTnWorKa
         RBAZpTmxnKYCIf54jvcl3huJiWRoJaUQtLvJ909TezokC5v15LDt1upqHovz32gPfnx4
         OYf7j6+ffw+aY+4cJI+bZFjEr1k45gtS/H3kgEoQmKjC/vPrEfJRptrr/Uz1+/GxVKVt
         PnQw==
X-Received: by 10.170.128.207 with SMTP id u198mr38880262ykb.51.1417069110152;
 Wed, 26 Nov 2014 22:18:30 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Wed, 26 Nov 2014 22:18:30 -0800 (PST)
In-Reply-To: <20141127002417.GT6527@google.com>
X-Google-Sender-Auth: zF8-7BxD-3L2YZRJo-HM03KSNf0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260340>

On Wed, Nov 26, 2014 at 7:24 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Alexander Kuleshov wrote:
> [...]
>> +++ b/builtin/cat-file.c
>> @@ -68,9 +69,14 @@ static int cat_one_file(int opt, const char
>> +        buf_must_free = 1;
>> +
>> -        if (!buf)
>> +        if (!buf) {
>> +            free(buf);
>>              die("Cannot read object %s", obj_name);
>
> Is this free() needed?  The program die()s right afterward, which
> would free all memory automatically as part of exiting.  Tools like
> valgrind would understand that nothing is wrong since buf is still
> reachable through the stack.

Moreover, 'buf' can only be NULL inside the conditional, so the free()
is pointless.
