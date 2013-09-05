From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 23:18:24 +0700
Message-ID: <CACsJy8C4PN4n1W71ajnoyFjaWCsxQjbXMbT-tcfgpXeoJKyXyA@mail.gmail.com>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHcHC-00070S-K9
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3IEQTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:19:04 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:47084 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab3IEQSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 12:18:55 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so2459231oag.21
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jpkpSnAW9Q/3fEWl3ZH2jCdCKsjzt1YOp78OvRU2Reo=;
        b=PrfyeN6/YlKAeQCpw6pTSIwKkghTz6r5qUl7BUrqp1VBLe4zcNzRtStmro3mNVasXj
         71Sh2sVqlr7NgzImoWaLoGuCCLQUU1Ret+Bog3Wqwl5Gk+Ihr1+1uqB0V/jVAph9BBr4
         wHmKwdOASLjEPi9Crulmu71MEcYAeqJf+j55vQg5vgLaGmIFk9I6eSZPNjEqr4Tr942Q
         fALHsvLnJDBSQU4gTRmrqEKztmv2LERi8WtxUhXPv//o68hF/UKxCVxx7FPAhfxxmRbI
         pAxCZ3xCoEbpwcZkAI0rZodIl2oZgLdNVPW+dN6dl2SLYblohpPjpWlupZ1pjigJKZw+
         C+Tw==
X-Received: by 10.182.237.14 with SMTP id uy14mr6984151obc.102.1378397934547;
 Thu, 05 Sep 2013 09:18:54 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 5 Sep 2013 09:18:24 -0700 (PDT)
In-Reply-To: <20130905153646.GA12372@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233965>

On Thu, Sep 5, 2013 at 10:36 PM, Jeff King <peff@peff.net> wrote:
>> > This is going to screw up pack v4 (yes, someday I'll have the
>> > time to make it real).
>>
>> I don't know if this is still true, but given that patches are
>> being sent out about it, I thought it relevant.
>
> I haven't looked carefully at the pack v4 patches yet, but I suspect
> that yes, it's still a problem. The premise of pack v4 is that we can do
> better by not storing the raw git object bytes, but rather storing
> specialized representations of the various components. For example, by
> using an integer to store the mode rather than the ascii representation.
> But that representation does not represent the "oops, I have a 0-padded
> mode" quirk. And we have to be able to recover the original object, byte
> for byte, from the v4 representation (to verify sha1, or to generate a
> loose object or v2 pack).
>
> There are basically two solutions:
>
>   1. Add a single-bit flag for "I am 0-padded in the real data". We
>      could probably even squeeze it into the same integer.
>
>   2. Have a "classic" section of the pack that stores the raw object
>      bytes. For objects which do not match our expectations, store them
>      raw instead of in v4 format. They will not get the benefit of v4
>      optimizations, but if they are the minority of objects, that will
>      only end up with a slight slow-down.

3. Detect this situation and fall back to v2.

4. Update v4 to allow storing raw tree entries mixing with v4-encoded
tree entries. This is something between (1) and (2)

> As I said, I have not looked carefully at the v4 patches, so maybe they
> handle this case already. But of the two solutions, I prefer (2). Doing
> (1) can solve _this_ problem, but it complicates the format, and does
> nothing for any future compatibility issues. Whereas (2) is easy to
> implement, since it is basically just pack v2 (and implementations would
> need a pack v2 reader anyway).

I think (4) fits better in v4 design and probably not hard to do. Nico
recently added a code to embed a tree entry inline, but the mode must
be encoded (and can't contain leading zeros). We could have another
code to store mode in ascii. This also makes me wonder if we might
have similar problems with timezones, which are also specially encoded
in v4..

(3) is probably easiest. We need to scan through all tree entries
first when creating v4 anyway. If we detect any anomalies, just switch
back to v2 generation. The user will be force to rewrite history in
order to take full advantage of v4 (they can have a pack of weird
trees in v2 and the rest in v4 pack, but that's not optimal).
-- 
Duy
