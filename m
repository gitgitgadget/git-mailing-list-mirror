From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 1/4] tag: speed up --contains calculation
Date: Wed, 23 Feb 2011 16:51:02 +0100
Message-ID: <AANLkTinL-gN3sCkUzzsBbzwxo1AYx1NURjKaE8D4TgvU@mail.gmail.com>
References: <20100705122723.GB21146@sigill.intra.peff.net>
	<20100705123335.GA25699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 23 16:51:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsH0B-0008Dx-OB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 16:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab1BWPvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 10:51:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64280 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab1BWPvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 10:51:38 -0500
Received: by fxm17 with SMTP id 17so4114599fxm.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WwL73SUfWt9JC/IYq8YjvqRD4cHt1jMXwgUeX5FUdFU=;
        b=mI/nIQOE8W9GVzykI55W8mFYU5NxZPMjshuoXstyWrsVDANJuTN2yFr6OIgxG5wG9x
         Gw0zGBwVp+2TLY/zukEIMlz9aZNjyE8izvAztMlgQVqR//JYa451LVnI+R/61sQ6PdeH
         ZgVANL7louUYgEFaf3us5JPnEIthVvD7+DDbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R9/wBdK7c7uJk1i3mNdOuI08sgIo4fNMICQ7Db5r8dlafXneDkfAKitjSY6nfBZKtr
         Cu4ClMeQg96zp/+Zt13Fc4M2rb/pfhFpRUV8MdBf1bYx03QVqy2JvVHRIzz/NhvPXPp1
         kybvyK1kRda9vXbwIM898y2VYk3Mjeos3NSu0=
Received: by 10.223.70.136 with SMTP id d8mr5268571faj.3.1298476263193; Wed,
 23 Feb 2011 07:51:03 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 23 Feb 2011 07:51:02 -0800 (PST)
In-Reply-To: <20100705123335.GA25699@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167698>

On Mon, Jul 5, 2010 at 14:33, Jeff King <peff@peff.net> wrote:
> When we want to know if commit A contains commit B (or any
> one of a set of commits, B through Z), we generally
> calculate the merge bases and see if B is a merge base of A
> (or for a set, if any of the commits B through Z have that
> property).

On a work repo with around 10k tags after and before this patch:

    $ time ~/g/git/git tag --contains HEAD~200 | wc -l
    113

    real    0m0.421s
    user    0m0.380s
    sys     0m0.042s

    $ time git tag --contains HEAD~200 | wc -l
    113

    real    2m18.861s
    user    2m18.750s
    sys     0m0.092s

I'd love to have this merged downwards from pu. It's the single
biggest usability improvement in my Git workflow for as long as I can
remember.
