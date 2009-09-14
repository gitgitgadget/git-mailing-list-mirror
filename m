From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Mon, 14 Sep 2009 14:56:20 +0200
Message-ID: <40aa078e0909140556j401085ccmdf43521b8b839e8e@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <1252923370-5768-2-git-send-email-kusmabite@gmail.com>
	 <20090914105750.GB9216@sigill.intra.peff.net>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
	 <20090914124428.GA9394@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 14:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnB6c-0006WP-L8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 14:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZINM4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 08:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZINM4V
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 08:56:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45549 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbZINM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 08:56:20 -0400
Received: by bwz19 with SMTP id 19so2050791bwz.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0ZMgiOjLkn+RwBAuDYxTec+pJNep0rQ+DrXOvjl9PMc=;
        b=ekUWkTocfaxUuXllB+koFLFCZHKXURh02O7E+lT4nQeLNzUq45FQD+jK37ILaiVcM9
         8675dxnImlof0K1f8wPpVflyi1cuDTr1Ebt5YlilOkP6DdtSf5A1mae6jeO7zHl/Rltb
         1dZLs92Di9EUwHg0q+ZiSu6RmfEQHU9QXReus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jttvLTHB7VekWKl2sfgveoigqTa+76Ijpp6Ye+nZc+mntLS8bYBrdLdH8QhGM1vGCO
         1+4ZRbKKnYBy6qd0pptRdb1cAbnnTTe0tZm/40I0wYA+N5sOo0lIQZ6/b4zVOpcJHjqr
         Afr7JNFggTr9vVV79ifGQou4fM8Yar8Unh4ig=
Received: by 10.204.21.4 with SMTP id h4mr5114286bkb.58.1252932982612; Mon, 14 
	Sep 2009 05:56:22 -0700 (PDT)
In-Reply-To: <20090914124428.GA9394@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128455>

On Mon, Sep 14, 2009 at 2:44 PM, Jeff King <peff@peff.net> wrote:
> Right. What I'm guessing is that it sees the noreturn on die(), but then
> doesn't actually look inside die to confirm that the noreturn is upheld.
> You could test that with:
>
> #include <stdlib.h>
> void __declspec(noreturn) die(void);
> void die(void) { }
> int main(void) { die(); }
>
> If it doesn't complain, then I am right. If it does, then it is
> something magic with the function pointer (presumably it decides that
> the function pointer could exit, so it stops the analysis and gives your
> code the benefit of the doubt).

It seems that you are right. It doesn't complain here.

>> The arguments against each solution I see are these:
>> - abort() gives a run-time error instead of a compile-time warning, so
>> breakage is trickier to detect (on GCC, which seems to be the target
>> compiler for the vast majority of git-developers).
>> - NORETURN_PTR might be bit big of a hammer for a small problem, as it
>> "pollutes" the whole git source-tree instead of just usage.c.
>
> I don't know that NORETURN_PTR pollutes the whole source-tree. At least
> no more than NORETURN does. The only functions that will need it are
> these two function pointers.

Well, it does pollute the global name space, and it's "noise" when
reading the source code. But those are really very unimportant points
IMO.

And sure, that "pollution/noise" is there for the NORETURN case anyway
for a functional/practical reason, so you might argue that it
justifies the presence in the NORETURN_PTR case.

I'll wait a day or so and see if anyone else has any insight. If not,
I'll go ahead and re-post a version based on the
NORETURN_PTR-solution.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
