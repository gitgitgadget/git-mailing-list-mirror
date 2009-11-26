From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 2/8] builtin-merge.c: call exclude_cmds() correctly.
Date: Thu, 26 Nov 2009 17:00:59 -0500
Message-ID: <32541b130911261400t6b1b439em6305c4e1bfe135f8@mail.gmail.com>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> 
	<cover.1259201377.git.apenwarr@gmail.com> <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> 
	<7vpr75hmpq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 23:01:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmOy-0006Ff-N1
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 23:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbZKZWBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbZKZWBN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 17:01:13 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:41880 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZKZWBM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 17:01:12 -0500
Received: by yxe26 with SMTP id 26so928259yxe.4
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=B8VV5y9PhHCp9GZgVh7+VKG4BywF02ZRBHE48vXR98o=;
        b=Hd1X/ZGBbLCLZF8w+vOCMpDgk4/OinBmBukWzL5svirXSNu/5KNmEUY+DINGYQ2hoz
         rCw3cudMP4rIOIv0yoSRzL7R+VN89NBCScNrrV73R/4DqHqUipGtoap6KrGeW2Qq4eWJ
         8d7xS4p60Gc5KfC2DTWzzs0mnNncBvGa9r9Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aZ/0+9hl3NnJqOSEOTCjpJOMucYsWSmhw1lBXIL5q4jxZ2mc9YJV8boYUZCAANCGEg
         4Rjo5SC2II2jvOXnfyyCI5N/Rm5ewueb99We+bbda0CXH24GryEpZwX3pUJX+8waOme0
         Q3dfFpAF2GSctZznOtQ/yIS/W/rTA3c+iyCGc=
Received: by 10.150.254.7 with SMTP id b7mr518855ybi.137.1259272879051; Thu, 
	26 Nov 2009 14:01:19 -0800 (PST)
In-Reply-To: <7vpr75hmpq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133841>

On Thu, Nov 26, 2009 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>
>> We need to call exclude_cmds() after the loop, not during the loop, =
because
>> excluding a command from the array can change the indexes of objects=
 in the
>> array. =A0The result is that, depending on file ordering, some comma=
nds
>> weren't excluded as they should have been.
>
> As an independent bugfix, I would prefer this to be made against 'mai=
nt'
> and not as a part of this series.
>
> How did you notice it? =A0Can you make a test case out of your experi=
ence of
> noticing this bug in the first place, by the way (I am suspecting tha=
t you
> saw some breakage and chased it in the debugger)?

The story behind this one is a bit silly, but since you asked: I
forgot to add recursive-ours and recursive-theirs to the list of known
merge strategies, but was surprised to find that my test for
recursive-theirs passed, while recursive-ours didn't.  Investigating
further, I found that the printed list of "found" strategies included
recursive-theirs but not recursive-ours.  Turns out that this is
because when recursive-ours was being (correctly) removed, that slot
in the array was being filled by recursive-theirs, and then
immediately i++, which meant that recursive-theirs was never checked
for exclusion as it should have been.

Of course, after fixing this bug *both* tests were broken, but the
correct thing to do was add both strategies to the list, which hides
the effect of this bugfix.

Since the bug is actually that *too many* strategies are listed
instead of too few, it's pretty minor and I doubt it needs to go into
maint.  Also, I don't know of a way to test it that would be reliable.
 And I doubt this particular bug will recur anyway.  (If it were too
*few* strategies listed, I'm guessing it would be caught by any number
of other tests.)

Suggestions welcome.

Thanks,

Avery
