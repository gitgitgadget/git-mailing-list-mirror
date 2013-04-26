From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git grep" parallelism question
Date: Fri, 26 Apr 2013 13:31:41 -0700
Message-ID: <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
	<CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
	<7vip39w14d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpJ5-0006nh-0k
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab3DZUbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:31:43 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43502 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836Ab3DZUbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:31:42 -0400
Received: by mail-vb0-f46.google.com with SMTP id 11so3839145vbe.19
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OcUTrO4qNcAgVN0A/XHWGjcoOKLG/pASgk4MBjXdEL4=;
        b=iUCQyesdlrKpiNuO5uTOcyvthnM8sSdviSTmFpD/QerUUAcNrQLwC64+yX8DaO95G2
         8HlIBAMxwhQ+QPRADrRKLkePJhyfKnkX6GwKTPg3nhF8ci3bcshvedexlcWfa0dqBI+/
         7i7sYo9osMUOwh/bVOJ+B5rpbASSz7+LHe+H7ZDeH2fPLN1tvOEMNzUQ3Tj0GLgE2HVM
         Ekg/u6EZIhX2ssurS7Gudq1Oh7EhIMY/W/6rgDGLWREroW+dHmi0N4MHEhqJoSA7RvxR
         Tk6FSFzGPuQn6juGoG44DzruJ8QoCeQlxe+teaOKHy6mxmaqJBIkHOefCKCmuHdDEle9
         gNyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=OcUTrO4qNcAgVN0A/XHWGjcoOKLG/pASgk4MBjXdEL4=;
        b=UZwt/chQ8GRUyyBrJUQ0rOxbFWT/WFPTDep7ZQmo4rKzKOeI0ifpLMVVco1l9lzIUL
         rZm+aU40wOfi99kx222DwFM04yXw6ENxTK1RCR3wgmOwy5unjxEYeBSOgpPTwY+Zy7jn
         MbxExUsXa3Vxk8gXWXNaEU+SL6RH578dKmQlo=
X-Received: by 10.52.166.84 with SMTP id ze20mr24665949vdb.115.1367008301208;
 Fri, 26 Apr 2013 13:31:41 -0700 (PDT)
Received: by 10.220.186.197 with HTTP; Fri, 26 Apr 2013 13:31:41 -0700 (PDT)
In-Reply-To: <7vip39w14d.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: j-kj7nY9rYUGWQ4tA3jg8utIuEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222577>

On Fri, Apr 26, 2013 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> OK, you have to recompile at least once for experiment, so perhaps
> building the test binary with this patch may help.

So here's my experiment on my machine with this patch and the kernel
tree. First I did the warm-cache case:

  for i in 1 4 8 16 32 64
  do
    echo $i:
    for j in 1 2 3 4
    do
      t=$(sh -c "time git grep --threads=$i hjahsja" 2>&1 | grep real)
      echo $i $t
    done
  done

and the numbers are pretty stable, here's just he summary (best of
four tries for each case):

   1 real 0m0.598s
   4 real 0m0.253s
   8 real 0m0.235s
  16 real 0m0.269s
  32 real 0m0.412s
  64 real 0m0.420s

so for this machine, 8 threads (our old number) is actually optimal
even if it has just four cores (actually, two cores with HT). I
suspect it's just because the load is slightly unbalanced, so a few
extra threads helps. Looks like anything in the 4-16 thread range is
ok, though. But 32 threads is clearly too much.

Then I did the exact same thing, but with the "echo 3 >
/proc/sys/vm/drop_caches" just before the timing of the git grep.
Again, summarizing (best-of-four number, the variation wasn't that
big):

   1 real 0m17.866s
   4 real 0m6.367s
   8 real 0m4.855s
  16 real 0m4.307s
  32 real 0m4.153s
  64 real 0m4.128s

here, the numbers continue to improve up to 64 threads, although the
difference between 32 and 64 is starting to be in the noise. I suspect
it's a combination of better IO overlap (although not all SSD's will
even improve all that much from overlapping IO past a certain point)
and probably a more noticeable imbalance between threads.

Anyway, for *my* machine and for *this* particular load, I'd say that
we're already pretty close to optimal. I did some trials just to see,
but the best hot-cache numbers were fairly reliably for 7 or 8
threads.

Looking at the numbers, I can't really convince myself that it would
be worth it to do (say) 12 threads on this machine. Yes, the
cold-cache case improves from the 8-thread case (best-of-four for 12
threads: 0m4.467s), but the hot-cache case has gotten sufficiently
worse (0m0.251s) that I'm not sure..

Of course, in *absolute* numbers the cold-cache case is so much slower
that a half-second improvement from going to 16 threads might be
considered worth it, because while the the hot-cache case gets worse,
we may just not care because it's fast enough that it's not
noticeable.

Anyway, I think your patch is good if for no other reason that it
allows this kind of testing, but at least for my machine, clearly the
current default of eight threads is actually "good enough". Maybe
somebody with a very different machine might want to run the above
script and see if how sensitive other machines are to this parameter..

                   Linus
