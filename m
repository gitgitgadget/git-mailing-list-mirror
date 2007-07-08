From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFC] Dynamic window size on repack?
Date: Sun, 8 Jul 2007 14:35:05 -0700
Message-ID: <56b7f5510707081435h60c1787br16cf389161d7143@mail.gmail.com>
References: <20070708211606.GF4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eQA-0003YQ-Go
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbXGHVfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756969AbXGHVfS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:35:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:39801 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228AbXGHVfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 17:35:06 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1031683ugf
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 14:35:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VtLv/uXOdqq9ZOtryoXWEG4k73G83sVnYA28iI2Zz4bZ5nE657y9AmV/e2SvW32Lx703rMNo1hIgh4DjnxwuV2Tt3zqAy2J2UgiRXQzweQhBI9nvFDoIOzHEE60iZwCIJ8PAzEuBPNrf0hPi84VCOKpw3KxqiUQS8H5MjRDMq08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1v5le3YmoQ2QQa2rEtaQxNQEf2Q4fevFta6D1OSKlg2jA4oz5DHKazlHWvFBoPGBr5sRwr/2kw2e/n67Uca+wJRArd1X5OMsasPW1StgobwDRC2bu0xC2E1UEPx48IO/jnIST/wLgAMbR2VVLqIq+/cJbPlkMNWdurk0UJJFeE=
Received: by 10.78.204.7 with SMTP id b7mr1262143hug.1183930505268;
        Sun, 08 Jul 2007 14:35:05 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sun, 8 Jul 2007 14:35:05 -0700 (PDT)
In-Reply-To: <20070708211606.GF4087@lavos.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51923>

On 7/8/07, Brian Downing <bdowning@lavos.net> wrote:
> I have a CVS repository which is mostly sane, but has an approximately
> 20MB RTF file that has two hundred revisions or so.  (Thank you, Windows
> help.)
>
> Now, since this is old history, I want to make it as small as possible.
> The only problem is that when I use high --window values for repack,
> it goes along swimmingly until it gets to this file, at which point
> memory usage quickly rises to the point where I'm well into my swap file.
>
> I think what I'd like is an extra option to repack to limit window
> memory usage.  This would dynamically scale the window size down if it
> can't fit within the limit, then scale it back up once you're off of the
> nasty file.  This would let me repack my repository with --window=100
> and have it actually finish someday on the machines I have access to.
> The big file may not be as efficiently packed as possible, but I can
> live with that.
>
> My question is, is this sane?  Does the repack algorithm depend on having
> a fixed window size to work?  I'd rather not look into implementing this
> if it's silly on the face of it.

Sounds very sane to me.

It seems like you want something like this
(I've not referred to the code,  but there is a loop
 that could be modifed to include something like this):
  /* build list of delta candidates */
  tot = 0;
  for (i = 0; i < window; ++i ) {
    obj = objects_sorted_for_delta[here + i];
    tot += SIZE(obj);
    if ( tot > window_limit )
      break;
    /* insert obj in list of things to delta, or just try it here */
    ...
  }
  if ( i <= 1 )
    break/return;

window_limit could be set automatically like the variables
for the mmap windows are (no new options).
SIZE() should be defined to return the actual bytes consumed
by the object (I think for this it's uncompressed and undeltified,
but as I said I haven't looked at the code).

It would be better if the current list of objects in the window
were a FIFO.  Before each deltification attempt,  add objects
from the sort list until #objects > window or tot > window_limit.
After each attempt, drop off the object we were trying to delta.

I like your idea and think you should look into implementing it.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
