From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 14:59:57 -0700
Message-ID: <CAGdFq_h3L-1rPvb=dSYeXqEea+f+g2kRHp7aAjaU-AxjZHB7dQ@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-5-git-send-email-felipe.contreras@gmail.com>
 <CAGdFq_j1RROOwxDi1FfJZJ6wiP9y9FWzSpc7MXVSvRmgk0sF9A@mail.gmail.com>
 <CAMP44s3MHrG_XeZEodnxemrW-V18+NHnFvi7koyx9mH8XuHc6w@mail.gmail.com>
 <CAGdFq_jJwZMLq=3co13hs7gas6y9kZRTKwcT+CP=n6-24Uv5Og@mail.gmail.com> <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ">" <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:00:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJrg-0005ct-4e
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab2J3WAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:00:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48141 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab2J3WAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:00:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so792492oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1KRZFPuIExha2Lz77Ej8jjtvz4jmsnfWg6lGgE72Cuk=;
        b=fYp80ZAIf3hnFBEAqHzlWRkAqWFMQTb0bfsjNuwHY9SUspSr/WPwmpXNiAjXttXdS8
         EMCvBYshYPaKesDaMWD8C95E3yk0Q4AFMUQNovLO9vCUzv0e6EFfkzVcoy5oS7RCqZTY
         yruWEgSQUrsVI+39EtxfwmG6MUYmVwo8z9zKFOX0Nj+Kft2Y9a8pGhI3tQlRtPYasWQ9
         kbEgopgpTzopng5tzfeCC43RMPd3eUEM4N3XfAWmH+JnFuT2+6dBnc6Xatw5v2FiNs3l
         7GKBYR3x2TEl1fg8Jt9yIQMJMBEg3oIXx9XeXHORVHi0MFxeFWMFn00OD4eJQFao9iRf
         z2cQ==
Received: by 10.60.32.5 with SMTP id e5mr11014624oei.46.1351634437806; Tue, 30
 Oct 2012 15:00:37 -0700 (PDT)
Received: by 10.60.95.97 with HTTP; Tue, 30 Oct 2012 14:59:57 -0700 (PDT)
In-Reply-To: <CAMP44s2QwdZKqJq0BZ5HOtZYiCMxCxycui9EmxxfL+Sa6M_6+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208753>

On Tue, Oct 30, 2012 at 2:35 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Oct 30, 2012 at 10:17 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Tue, Oct 30, 2012 at 11:47 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Why would it? We are not changing the way objects are exported, the
>>> only difference is what happens at the end
>>> (handle_tags_and_duplicates()).
>>
>> Because the marking is per-commit, not per-ref, right?
>
> Oh, you meant using marks?

No, I meant the 'SHOWN' flag, doesn't it get added per commit, not per
ref? That is, commit->object.flags & SHOWN refers to the object
underlying the ref. So I suspect this scenario doesn't pass the tests:

git init &&
echo first > content &&
git add content &&
git commit -m "first" &&
git branch first &&
echo two > content &&
git commit -m "second" &&
git branch second &&
git fast-export first > actual &&
test_cmp actual expected_first &&
git fast-export second > actual &&
test_cmp actual expected_second

With expected_first being something like:
<fast-export stream with the first commit>
<reset command to set first to the right commit>

And expected_second being something like
<fast export stream with the first and second command>
<reset command to set first and second to their respective branches>

-- 
Cheers,

Sverre Rabbelier
