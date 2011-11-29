From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 07:23:19 -0800
Message-ID: <CAJo=hJvavm6feUjxOZ-qvJjs0nT=uKtFqs1Z82rcyEqazFxUOg@mail.gmail.com>
References: <1322546563.1719.22.camel@yos> <20111129090733.GA22046@sigill.intra.peff.net>
 <CACsJy8BRhoYM+Lb8afp=3rKzYNOEq0JY8uS9mD1ovz3uyJVWOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Bill Zaumen <bill.zaumen+git@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 16:23:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVPXA-0005iS-UH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 16:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab1K2PXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 10:23:44 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62010 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab1K2PXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 10:23:43 -0500
Received: by ywa9 with SMTP id 9so4189571ywa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 07:23:43 -0800 (PST)
Received: by 10.236.161.103 with SMTP id v67mr69984295yhk.87.1322580222755;
 Tue, 29 Nov 2011 07:23:42 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Tue, 29 Nov 2011 07:23:19 -0800 (PST)
In-Reply-To: <CACsJy8BRhoYM+Lb8afp=3rKzYNOEq0JY8uS9mD1ovz3uyJVWOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186061>

On Tue, Nov 29, 2011 at 05:17, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Tue, Nov 29, 2011 at 4:07 PM, Jeff King <peff@peff.net> wrote:
>> However, it's harder for trees. Each entry needs to have the new digest
>> added, but there simply isn't room in the format. So we would have to
>> change the tree format, breaking interoperability with older versions of
>> git. And all of your tree sha1's would change as soon as you wrote them
>> with the new format. That's only slightly better than just swapping
>> sha1 out for a better algorithm.
>
> I think we could hide the new digest after NUL at the end of path
> name. C Git at least does not seem to care whatever after NUL.

No, you can't. The next byte after the NUL at the end of a path name
is the SHA-1 of that entry. After those 20 bytes of SHA-1 data is
consumed, the "mode SP name\0" of the next entry is parsed.

There is not room in the tree format for any additional data. Period.
At best you can modify the mode value to be a new octal code that is
not recognized by current Git implementations. But that doesn't get
you a whole lot of data, and its pretty risky change because its
rather incompatible.
