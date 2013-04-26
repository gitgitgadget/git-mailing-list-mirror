From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git grep" parallelism question
Date: Fri, 26 Apr 2013 11:54:09 -0700
Message-ID: <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	<7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:54:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnmi-0007zJ-7X
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab3DZSyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:54:11 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:53357 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab3DZSyK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:54:10 -0400
Received: by mail-vc0-f177.google.com with SMTP id gf12so1871808vcb.8
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SkT9bxulzDqzWkM/JZIrOhvqCJ/8S/gkz2ZxxEdM6Ks=;
        b=mlRWq/H47sJUmydigk/4V3IuTznw1n82r4QoEk0vTMsSTD9GFp99vYgffR3UFVZcl9
         KTUrfYik2ec5bXpzdqcKkoQ0gcnMxTbDOg8gPlRYBc6M5A6IMdRuIMw2rFtO/j3IhL+C
         /uRB62Th3PfylIvQORzgHtcrT5WOYHbkytUyAD9ftJA3hjg5uDBG/HZVtfj9BbJ/H0IP
         t2XDn5cwZCWtrZ2oNxxx7goTI3cmlBNfI4zj9oYcpOYM78AK1x+1qhrU3MshNtwaWytk
         6La2TDqguB+T3cBmEImOXYB+bbcPBbethBELdJbK/LkyymFqZS2qCsEwrxG0Aw6SJS1W
         jsjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SkT9bxulzDqzWkM/JZIrOhvqCJ/8S/gkz2ZxxEdM6Ks=;
        b=WVupJc1454GW2LAQkwmqi+C/1eNMf4A0hSTNPuK9NCBeaX9bXMsRsIUpwlxkH4EvYK
         DgTDbfqaKcDqrnqp1pYgUCfiAC4hElQrdhDN+oD9oaLWaRn0pQrP4DucgYMx705bXq0k
         lYORpvcFXzI4k+hSiWYIcQewZwoaFVbtUabNs=
X-Received: by 10.220.244.137 with SMTP id lq9mr29820926vcb.13.1367002449136;
 Fri, 26 Apr 2013 11:54:09 -0700 (PDT)
Received: by 10.220.186.197 with HTTP; Fri, 26 Apr 2013 11:54:09 -0700 (PDT)
In-Reply-To: <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 2JBAt5LQ9hE7yEBkEW8p6euqCP8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222554>

On Fri, Apr 26, 2013 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> The real issue may be that we do not have a good estimate of how
> many paths are involved in the request before starting these
> threads, though.

Yes. Also, I'm not sure if the 15% possible improvement on my SSD case
is even worth it for something that in the end isn't necessarily the
common case. I *suspect* that it might be a much bigger deal on NFS
(IO parallelism really does end up being a big deal sometimes, and
caching tends to be less aggressive too), but on rotational media it
might be much less clear, or even a loss..

Are there people out there who use "git grep" over NFS and have been
unhappy with performance? If are willing to recompile git with a
different THREAD value in builtin/grep.c, then on a Linux client you
can try

    echo 3 > /proc/sys/vm/drop_caches

to largely force cold-cache behavior for testing (I say "largely",
because it won't drop busy/dirty pages, but for "git grep" kind of
loads it should be good).

Of course, you need root for it, so..

                  Linus
