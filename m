From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Fri, 8 Oct 2010 17:57:16 -0500
Message-ID: <AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
	<AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
	<20101008195120.GA10810@sigill.intra.peff.net>
	<AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
	<20101008200657.GA10954@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 09 00:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Lsh-0007ci-M8
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 00:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab0JHW5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 18:57:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62886 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0JHW5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 18:57:17 -0400
Received: by qwf7 with SMTP id 7so920472qwf.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=QsATppcrEAYkwV7YEmYtyl9gpkbVAeQyev56rwklpgQ=;
        b=UuCJ1gzDZYlxkh9TU2uo4EeYRP9/nvc1MNQdKgrgY6WDjiqJy8yZoQv9bxRwbmZtTA
         3T2k46VY6yyNlNKT7c4613d64g+vK4wm5yguyW+uVwQcD46wUvVX/J8q1HZGP+/A8RPr
         PM4n1fPLk1611Gx733ZmrQBfGS/y6+VsANzO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wnYVf0+G5+zFKq4VPWBSWJrpYSEHbc/RxCBZlVRrv+LDwAyxDbOa1kUXvntbP3iZrC
         3O6rnOF5+SqhC0ysjJfX8it1dmQHEgop7Ye4pWWfQ77+6hhkqYonM/wQ7n6eHRnr9MVe
         +7+bQ0cNcks4Ap5k5IZG9oi8Rn3VMtogJfj6E=
Received: by 10.229.192.4 with SMTP id do4mr2546658qcb.164.1286578636309; Fri,
 08 Oct 2010 15:57:16 -0700 (PDT)
Received: by 10.220.187.9 with HTTP; Fri, 8 Oct 2010 15:57:16 -0700 (PDT)
In-Reply-To: <20101008200657.GA10954@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158547>

On Fri, Oct 8, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:
> Re-reading your original message, I have a few more thoughts.
>
> One is that you don't need to do this per-commit. You probably want to
> do it per-updated-ref, each of which may be pushing many commits. And
> then you either reject the new ref value or not.

I think I do, actually, because let's say the developer pushes two
commits, 1<-2. Suppose commit 1 violates the rule, but commit 2
reverts the violation. One might think that we don't care, since the
head will now be on 2, which is a correct state. But in fact we do,
because this is Git, and anyone may branch of from 1 in the future,
and voila we have a head in an incorrect state.

> Also, you could try not looking at the whole tree by [...]
> only be manually expanding each level [...]
> But that means many git ls-tree calls.

Yeah, that's a pretty good idea, if not for the many ls-tree calls.
With their overhead, I strongly suspect it may be slower than the
solution you seem to propose, which is:

git ls-tree -r <commit>

which should give the full list of all paths in a commit, upon which I
can decide to accept or reject.

Thanks, D
