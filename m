From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 13:59:18 -0700
Message-ID: <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
 <1461079290-6523-3-git-send-email-sbeller@google.com> <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
 <20160420041827.GA7627@sigill.intra.peff.net> <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:59:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFVo-0002WS-6m
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbcD2U7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:59:40 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35460 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbcD2U7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 16:59:39 -0400
Received: by mail-oi0-f52.google.com with SMTP id x19so132227533oix.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UMOYu77n+yLY9m+YNI6l3WwgBAtV9S7/yuxSn/1jqOw=;
        b=KVmQ9J4NR7MUOjuq46fhZpzpC7XRDqIhjItZuVdwuYjEKDqpklAC9P9nZtnJRS0/wk
         nUrrOa4u63jRK89Gk4k9rUEbqjd+Fftta34E8IMGQKtfo0UY6LMQxI97xQ8b9vY9zk0P
         TblN7uCD/gnLXIZeOZ+HfcXPXIBx1+8LqadonW/EA5RaTCDD9f/aMOPhzQcQ1EDZWXl9
         Kbqbzsqqt6AzQ8Nw1i60E6+Ov6T/TZXvE7qp4u2bMWDJf6hyV4w3+4p5TjNYknS41KRg
         g9Wm7MuhIO080svdEk8dVZ9paSnDMiwBMcOUwqdec+wrGiUJQwgM9YkQf+GJUo00WeCk
         TfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UMOYu77n+yLY9m+YNI6l3WwgBAtV9S7/yuxSn/1jqOw=;
        b=M/FSZPeyfTDnJcunPaqZoisVh1BK4222chTRm95brpudYt2B6douicWeDWe/Nes2jQ
         qSPb8Lc8tYIOLjIUiwkjQBLgoqGgYgKkTHljnzH1pBsoAeT/XntYbH3pOhEMYDvEktXW
         Cm41Nr7IgJb1hK/5k23oh5j/kTz1KqKuChpUAdi1MEJNqQpUY+ocXZMPu2taFmeq09Vm
         AQtPpGB6lWM2dfRITVUH4Ing3qxdxhC7I7r5UJColNL8Gh9AANpq9eJNYRTB9fawQZeY
         qb+dRS+a7Au8kGcl92JrHwBlftdJRvuediUU7SvrByRA8BqXVNGxaaFWGDHxxwYYhmM5
         TH8A==
X-Gm-Message-State: AOPr4FVaNCVkKKg3I4DyW2aA4bgZT8s12h3yXUY0ldoHIGNwZc5oQL3eIewUgeJD7j8qOZ7SROyf+FksGN9yAQ==
X-Received: by 10.157.49.1 with SMTP id e1mr10803676otc.148.1461963578398;
 Fri, 29 Apr 2016 13:59:38 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Fri, 29 Apr 2016 13:59:18 -0700 (PDT)
In-Reply-To: <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293055>

On Fri, Apr 29, 2016 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> ... Having the two directly next to each other reads
>> better to me. This is a pretty unusual diff, though, in that it did
>> change the surrounding whitespace (and if you look further in the diff,
>> the identical change is made elsewhere _without_ touching the
>> whitespace). So this is kind of an anomaly. And IMHO the weirdness here
>> is outweighed by the vast number of improvements elsewhere.
>
> So... is everybody happy with the result and now we can drop the
> tweaking knob added to help experimentation before merging the
> result to 'master'?
>
> I am pretty happy with the end result myself.

I am very happy with it. I haven't had any issues, and I think we'll
find better traction by enabling it at this point and seeing when/if
someone complains.

I think for most it won't be noticed and for those that do it will
likely be positive.

Thanks,
Jake
