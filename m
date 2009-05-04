From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/6] Remove return undef from ask()
Date: Sun, 3 May 2009 22:26:25 -0400
Message-ID: <76718490905031926i771b0234ua7b45d5e0d827913@mail.gmail.com>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
	 <1241010743-7020-2-git-send-email-wfp5p@virginia.edu>
	 <1241010743-7020-3-git-send-email-wfp5p@virginia.edu>
	 <1241010743-7020-4-git-send-email-wfp5p@virginia.edu>
	 <20090503202625.GC20468@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Bill Pemberton <wfp5p@virginia.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 04 04:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0ntk-0003dv-G9
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 04:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbZEDC00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 22:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbZEDC00
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 22:26:26 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:13825 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbZEDC0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 22:26:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2071182ywb.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YcyuhwvI6Sisf3IvVTC9JGO7n9N54ymDY2+YP3wzmFU=;
        b=vmD5Q0daVmne9YB+Mjf/VS6CHVa745uuXUxBgydwekttumGvJwACbgwSKUGLqbxV3l
         Uj7LEaLHNUjdo4wQhfY1CeRH+58JKlvU9Zp1HfPpQInAYQyWsq/XVExmyLfHjbPer1Op
         ulml5p6ujDNkueaf6oz2+4e46TJacS3pw/2s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CM85wckDXGAE99hEFxmhtPkBwwt1fBtTfiYn9igC23H1WsDBANVIufKpMWBDDSvbDD
         Ervtluq+kDw+ZGMfBhYiRICK9fYVKZs8smQIukQ2aDMkKJ7iazK3FKKrebVqMS7K5wFv
         bKMJWZA7AIseBXNRtEnkkv+DZDj/wHAAq+Fjg=
Received: by 10.151.136.4 with SMTP id o4mr11084503ybn.238.1241403985093; Sun, 
	03 May 2009 19:26:25 -0700 (PDT)
In-Reply-To: <20090503202625.GC20468@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118201>

On Sun, May 3, 2009 at 4:26 PM, Jeff King <peff@peff.net> wrote:
> On a side note, while looking at this function, I wonder if that "return
> undef" is correct after all. We get there only if the user has failed to
> give valid input 10 times, so presumably it is a sanity check to
> prevent runaway input errors

Correct, that is why it is there.

> (and I am cc'ing Jay, who added the
> function not too long ago). Should we be respecting the default here, as
> we do when we get EOF?

The original motivation was a user who was running send-email from
cron and it was looping forever. That case is now actually handled
before the loop, and all other normal cases are handled inside the
loop.

So the only thing that can cause the loop to exit (AFAIK) is when
$valid_re is passed in and the user provides invalid input 10x.

> Although I tend to think if the user is
> repeatedly giving us bogus input that we should not just proceed, but
> should probably die. Because otherwise we are guessing at what they
> might have wanted.

Well, it returns undef, at which point it's up to the caller to figure
out what to do. You'll notice the one caller which passes in $valid_re
dies:

die "Send this email reply required" unless defined $_;

Letting the caller decide what to do provides more flexibility.

j.
