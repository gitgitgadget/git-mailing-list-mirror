From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH] git-svn: workaround for a bug in svn serf backend
Date: Mon, 30 Dec 2013 20:01:10 +0400
Message-ID: <CANiYKX5Nd8YTsAKshma_-Ezqzw1tkC_-UJas0_oDxUZbcfaAAA@mail.gmail.com>
References: <87ha9wdh8g.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
	<1388059524-4864-1-git-send-email-rkagan@mail.ru>
	<87lhz2o7ht.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Benjamin Pabst <benjamin.pabst85@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 30 17:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxfHI-0007EQ-7W
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 17:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756006Ab3L3QBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 11:01:12 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:58630 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab3L3QBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 11:01:11 -0500
Received: by mail-qc0-f176.google.com with SMTP id i8so10964963qcq.7
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 08:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=LeY5MgzWNWKR9UD/BbZJCwAhC+JKS5POzkmZPhKkIb0=;
        b=c2FSQ4Prvmr5kHb2BWTVbU6hDu0SHFts2W+GMGx316PloBnYAsdFkSYQNGQ7n2Y2Uf
         M8vqmeA/IOzmv1JqzJXolx/9HGeLfLeV51+41XPlKdMEQ0PXgP5e6Szgi5Pd1mdnHyVP
         hInnUK6M0W7RoT1/A9LSQEt+76Ezt/sPgUoT4srUwGsEhY8/qCheIuVETDgOd5BgUAD8
         iLTbvN1zjn2iJIb5KY+WeVCN6wj1osBvBqyYIRLjqnle7Hvu6PqSOTZFQdZnGxsvRinB
         aXXM4DJBIHxC1yOLQOPR/z3pQI+t9ANwZBEkkFUwjhvHuK/xFs1xjSbuWzG41IU7etoK
         3D+A==
X-Received: by 10.49.28.101 with SMTP id a5mr112114760qeh.70.1388419270310;
 Mon, 30 Dec 2013 08:01:10 -0800 (PST)
Received: by 10.224.98.146 with HTTP; Mon, 30 Dec 2013 08:01:10 -0800 (PST)
In-Reply-To: <87lhz2o7ht.fsf@thomasrast.ch>
X-Google-Sender-Auth: CEvFcVUk2IWeT70joeW6CXY7Sao
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239807>

2013/12/30 Thomas Rast <tr@thomasrast.ch>:
> Roman Kagan <rkagan@mail.ru> writes:
>
>> +     # workaround for a bug in svn serf backend (v1.8.5 and below):
>> +     # store 3d argument to ->add_file() in a local variable, to make it
>> +     # have the same lifetime as $fbat
>> +     my $upa = $self->url_path($m->{file_a});
>>       my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
>> -                             $self->url_path($m->{file_a}), $self->{r});
>> +                             $upa, $self->{r});
>
> Hmm, now that you put it that way, I wonder if the patch is correct.
>
> Let me first rephrase the problem to verify that I understand the issue:
>
>   $fbat keeps a pointer to the $upa string, without maintaining a
>   reference to it.  When $fbat is destroyed, it needs this string, so we
>   must ensure that the lifetime of $upa is at least as long as that of
>   $fbat.

No.  The string is needed in subversion's close_file(), so we want to
keep it alive until close_file() returns. Surviving till the end of
the current function scope is sufficient for that.

> However, does Perl make any guarantees as to the order in which local
> variables are unreferenced and then destroyed?

We don't care about the order they are destroyed WRT each other.

Roman.
