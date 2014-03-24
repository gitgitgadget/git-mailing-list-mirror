From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Modify fsck_commit. Replace memcmp by skip_prefix
Date: Sun, 23 Mar 2014 21:36:38 -0400
Message-ID: <CAPig+cSyDAa2r=0dBwwn56Wck7Ci5je6hmQ=U-9ELh9JfwRq6g@mail.gmail.com>
References: <1395501132-12894-1-git-send-email-ajha.dev@gmail.com>
	<CAPig+cRL3zFWtBq_yJQqwGa7Wc6GsdBqA_jrGm8p5ZMJVmr-yw@mail.gmail.com>
	<532EDD5F.9020402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: tanay abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>
To: Ashwin Jha <ajha.dev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 02:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRtor-0001fv-9v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 02:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbaCXBgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 21:36:40 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:58765 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaCXBgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 21:36:39 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so12990181ykr.9
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 18:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HeuOd1pecnuiTUYdlW8zvUbIVUY/xz0jRs+FYLxeCmk=;
        b=XzkQbtQYCooqJ0fw5CGOgLcBfL0PU/qnWDDyUZEqUfcX26QziMLhtuxlq4qvzcmjwO
         lk3IE7Pcr7yKbMc2fOqeA7OesoaXwLWu+ekOFInPg44CGH1n3rxt+YSBrllVMhgtHHOS
         YVuTapDR7Wp3KSvsWL1GN+pJYrx8K+qUdj1nMB0EbqUgyQvEeR4UXBWbgGyYFeyZderC
         D+k1WZAPMCiWGmX0DKhksEJtAD4wk/0s0BQsRErlsqXQm3z3ACkeWEHmbMrh1EDYGdD4
         wb//LC7CZ9r/5ucBP3A3tb3W/dv0DQD4NYoOqvvguFOGbkBMhyFxk0WDz26bs0oR7csj
         YGoQ==
X-Received: by 10.236.177.100 with SMTP id c64mr77700070yhm.30.1395624998836;
 Sun, 23 Mar 2014 18:36:38 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 23 Mar 2014 18:36:38 -0700 (PDT)
In-Reply-To: <532EDD5F.9020402@gmail.com>
X-Google-Sender-Auth: F8j118Wy_5evZWKhX_0XTIlVcHg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244809>

On Sun, Mar 23, 2014 at 9:10 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
> On 03/23/2014 02:10 PM, Eric Sunshine wrote:
>> On Sat, Mar 22, 2014 at 11:12 AM, Ashwin Jha <ajha.dev@gmail.com> wrote:
>>> -       if (memcmp(buffer, "tree ", 5))
>>> +       buffer = (char *)skip_prefix(buffer, "tree ");
>>
>> These casts are ugly. It should be possible to get rid of all of them.
>> Hint: Does this function modify the memory referenced by 'buffer'?
>> (The answer is very slightly involved, though not difficult. A proper
>> fix would involve turning this submission into a 2-patch series: one a
>> preparatory patch, and the other this patch without the casts.)
>
> Eric, certainly this function does not modify the memory referenced by
> 'buffer'.
> So, 'buffer' should be declared as a const char *.

Correct.

> But, what about the argument to fsck_ident(). First argument required is a
> char **.
> Now, the compiler will correctly give a warning for incorrect argument type.
>
> I have seen the code of fsck_ident(), and it is nowhere modifying the memory
> referenced by
> buffer. So, I know that this will not cause any problem. But, still it will
> be a bad practice to do away with
> warnings.

Your diagnosis about fsck_ident() is correct: It doesn't modify the
memory referenced by its incoming (char **) argument. Therefore, to
avoid casts upon updating fsck_commit() to employ skip_prefix(),
fsck_ident()'s argument should be decorated with 'const', as well.
With that done, the compiler will have no reason to warn.

> And can you explain me a bit about a 2-patch series.

Changes which are conceptually distinct deserve separate patches.
Fixing the const-ness of fsck_ident()'s argument and fsck_commits()'s
'buffer' variable are distinct from updating fsck_commit() to employ
skip_prefix(). So, a two-patch series would have:

patch 1/2: add missing 'const' to those two locations
patch 2/2: use skip_prefix() in place of memcmp()

(It can be argued that fixing const-ness at those two distinct
locations also can be split into separate patches, but let's try to
keep it simple.)

The <since> or <revision range> arguments mentioned by "git
format-patch"'s manual page let you create a multi-patch series, and
will correctly number them ([PATCH v3 1/2], etc.). Use the -v option
to get the v3 in there automatically. Likewise, "git send-email" will
happily send out the series. Try sending it to yourself first to make
sure it all works; then send to the mailing list.

> Once again thanks for your help.
