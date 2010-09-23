From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] pack-objects: never deltify objects bigger than window_memory_limit.
Date: Wed, 22 Sep 2010 22:01:45 -0700
Message-ID: <AANLkTinZtJc7LA5rpW85Yk+64oE38MZrs-b5af9-e1mT@mail.gmail.com>
References: <1285151105-32454-1-git-send-email-apenwarr@gmail.com> <alpine.LFD.2.00.1009220749440.13233@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 23 07:02:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oydwl-0001lE-5z
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 07:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab0IWFCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 01:02:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48568 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab0IWFCH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 01:02:07 -0400
Received: by wwb34 with SMTP id 34so267010wwb.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vuZN6x7Q+YMTzJB18W9VBj+iY3flfEP99JUWx8xM7Ts=;
        b=DOzis3VZN6Yj87hyH8j87TOmK3bSNdf+oBnMF8XJt3VHXfMyjfQoaYe9Y+/fdf5l9U
         3fBCveKocFvQUgjB4aL4DQDkOqD/zNEQQcrk4WBlgR2zGXTmGq41mS7T0hvclCWKa97r
         EKF529nHPN8N+1wCM0MY6NSycptYdyFtNRD6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EOs26u0HzZlitcW2wlOHli7K+RoY7BEmvEifsQWwdPN6cuJc8WtciFaq8w+MEuCukt
         Yj+sCy1uVN59jqEjFOyEEgdY53vrMOF4jtY9Gu8sKqUIvqtRTINBODHRypu/jnWn86/C
         3vjjsFEZ9bsqyPl/qkw/jPFAnkBQh5F43V/6o=
Received: by 10.216.48.146 with SMTP id v18mr993215web.56.1285218125811; Wed,
 22 Sep 2010 22:02:05 -0700 (PDT)
Received: by 10.216.165.15 with HTTP; Wed, 22 Sep 2010 22:01:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009220749440.13233@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156848>

On Wed, Sep 22, 2010 at 5:00 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Wed, 22 Sep 2010, Avery Pennarun wrote:
> To not load big objects into memory, we'd have to add support for the
> core.bigFileThreshold config option in more places.

Well, it could be automatic in git-pack-objects if it was enabled when
the object is larger than window_memory_limit.  But I see your point.

Anyway, it requires more knowledge of the guts of git (plus patience
and motivation) than I currently have.  My patch was sufficient to get
my previously-un-packable repo packed on my system, which was a big
step forward.

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (window_memory_limit && entry->size > w=
indow_memory_limit)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>
> I think you should even use entry->size/2 here, or even entry->size/4=
=2E
> The reason for that is 1) you need at least 2 such similar objects in
> memory to find a possible delta, and 2) reference object to delta
> against has to be block indexed and that index table is almost the sa=
me
> size as the object itself especially on 64-bit machines.

I would be happy to re-spin my exciting two line patch to include
whatever threshold you think it best :)

Good point about #1; dividing by two does seem like a good idea.
(Though arguably you could construct a small object from a large one
just by deleting a lot of stuff, and a small + large object could fit
in a window close to the large object's size.  I doubt this happens
frequently, though.)

As for #2, does the block index table count toward the
window_memory_limit right now?  If it doesn't, then dividing by 4
doesn't seem to make sense.  If it does, then it does make sense, I
guess.  (Though maybe dividing by 3 is a bit more generous just in
case.)

Anyway, the window_size_limit stuff seems pretty weakly implemented
overall; with or without my patch, it seems like you could end up
using vastly more memory than the window size.  Imagine setting the
window_memory_limit to 10MB and packing a 1GB object; it still ends up
in memory at least two or three times, for a 200x overshoot.  Without
my patch, it's about 2x worse than even that, though I don't know why.

So my question is: is it worth it to try to treat window_memory_limit
as "maximum memory used by the pack operation" or should it literally
be the maximum size of the window?  If the former, well, we've got a
lot of work ahead of us, but dividing by 4 might be appropriate.  If
the latter, dividing by two is probably the most we should do.

=46WIW, the test timings described in my commit message are unaffected
whether we divide by 1, 2, or 4, because as it happens, I didn't have
any objects between 25 and 100 MB in size :)

Have fun,

Avery
