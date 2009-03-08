From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been added
Date: Sun, 8 Mar 2009 18:27:17 +0800
Message-ID: <be6fef0d0903080327u551c0b4mcb86f2ba76473efc@mail.gmail.com>
References: <49B266B0.4020304@gmail.com>
	 <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
	 <be6fef0d0903071249s42ac7f94o82461ca32dcdfcd5@mail.gmail.com>
	 <7vd4ctm29m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 11:28:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgGFV-0007pC-FK
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 11:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbZCHK1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 06:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbZCHK1V
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 06:27:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:39112 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZCHK1U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 06:27:20 -0400
Received: by rv-out-0506.google.com with SMTP id g9so1259237rvb.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZorY8Rv2NnDWj5BMJ9hGRsyP5HMRNQbJ89wcahElJA0=;
        b=HWueSmeX+EJ3jL4mC1L7sb4iNJrvMP9jZKTgPvJa83JXD8OKaWTGAHy1PQS5ggFMo7
         xVwS9nG+3OmJHLrj8yC9MvJ/FEnhw+Y9eb9OKypgy0d6YrTwCe5BARsiNRY97tYfX+wX
         /8mDeTG6sohRVlKsRnW+CLnI76PGzM/4J4txc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dAN5SH9Um01ZI2LtjLMOSc12Lsr2JCdtbihx1/bOMnk4IZ1vBaWiH9fcqaKRp6+XB0
         xFEPUud4nQBpOl4YpQ7QI2CtQO0eXJhAjIVRqywlomQn5hfnipDhMpULkk1zFSYF54Fn
         aLKmwwLpqjsefGc9GlScyFOSh3/IB7q9Axqdw=
Received: by 10.114.74.18 with SMTP id w18mr2752147waa.205.1236508037462; Sun, 
	08 Mar 2009 03:27:17 -0700 (PDT)
In-Reply-To: <7vd4ctm29m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112615>

Hi,

On Sun, Mar 8, 2009 at 5:49 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I didn't look at the callers of add_fill_function(), but "fill" takes=
 a
> callback data and different invocation of add_fill_function() could b=
e
> passing different callback data. =A0In such a case, doesn't it feel w=
rong to
> omit the "duplicated" calls to register the fill callback? =A0Your pa=
tch
> makes me suspect that it _might_ be better to fix the callers not to =
call
> the function repeatedly when they know they only want one-shot invoca=
tion.

Omitting duplicate calls in fill_active_slots does not mean that
repeated calls of the fill functions won't take place.

In the current use instances in http-push and http-walker,
run_active_slot and finish_all_active_slots (which calls
run_active_slot) will always be called, because they are the functions
that actually start the http requests[1], and that means the fill
functions will be called repeated, because

run_active_slot, in its while loop, repeatedly calls
  step_active_slots calls
    fill_active_slots calls
      our fill functions.

fill_active_slots is the only direct caller of fill functions
(duplicate ones included).

So we can be sure that the fill functions are called repeatedly (at
least for the slot's active duration).

[1] Actually calling step_active_slots will start http requests,
without you having to call run_active_slot.

--=20
Cheers,
Ray Chuan
