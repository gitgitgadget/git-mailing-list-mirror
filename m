From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH maint-1.6.5] block-sha1: avoid unaligned accesses on some
 big-endian systems
Date: Sat, 14 Jul 2012 12:55:30 -0700
Message-ID: <CA+55aFwKYhUtXfaRcbOmMsvQW8p+h8N9PKpxW_y1kj6L=FQQNw@mail.gmail.com>
References: <20120713233957.6928.87541.reportbug@electro.phys.waikato.ac.nz>
 <20120714002950.GA3159@burratino> <5000CBCA.8020607@orcon.net.nz>
 <20120714021856.GA3062@burratino> <50010B84.5030606@orcon.net.nz>
 <20120714075906.GD3693@burratino> <CA+55aFy+y=TCoJUQarinaduibt4i-46TAuvpp7fsAmjDZj_+3w@mail.gmail.com>
 <20120714195022.GB23242@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Cree <mcree@orcon.net.nz>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:56:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq8RZ-00035M-GS
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 21:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab2GNTzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 15:55:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52564 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2GNTzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 15:55:52 -0400
Received: by wgbdr13 with SMTP id dr13so4130737wgb.1
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=dkdGaZIO8ffYnQQiSx0YjfKqR0EqKtSHY5uatTcfNlw=;
        b=ISW38XHApvXfKPtjpJTUEIz0jQtfTZp3Q0FIzE2wApdkjO4BHkx6+BbbN7fq0AzKC8
         qev9wZd0cRGkpi7mqNGbgheLXTaXmrA1AFuICEfrS/nLY+XpgtvkYkNZdvj5HXDy7E6m
         PFy29mmDDSqobqw7/FB6qgYIh5YNpc5lokj9m7zAOHiUSVDt43jcqckpAlOirPquiuJm
         ZuZheWeLGKuXWlDwe3Li5M0GhaL8KgV5bZK47WmO44VK4xYXpL7ZYp4pF/3Hh110O6eH
         TZzkmd8Mjaj/9WMX0aYhHnhfgae0LQgcpslbf8v1/3FnSdDyVYIf6o49mQWnVXX9Rh8A
         WU8Q==
Received: by 10.216.9.142 with SMTP id 14mr9140wet.112.1342295751194; Sat, 14
 Jul 2012 12:55:51 -0700 (PDT)
Received: by 10.216.142.14 with HTTP; Sat, 14 Jul 2012 12:55:30 -0700 (PDT)
In-Reply-To: <20120714195022.GB23242@burratino>
X-Google-Sender-Auth: UqxOdJvRtSNKaudzyLHO3IG745s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201450>

On Sat, Jul 14, 2012 at 12:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> After the patch, what reason does gcc have to expect that 'block' is
> 32-bit aligned except when it is?  The code (including the code I
> didn't touch) never casts from char * to int * except in get/put_be32
> on arches that don't mind unaligned accesses.

Ahh. I was looking at the cast you added:

    blk_SHA1_Block(ctx, (const unsigned char *) ctx->W);

but I guess that if gcc inlines that and sees the original int type,
it doesn't matter, because that *is* aligned.

So it's ok, but please just make blk_SHA1_Block() take a "const void
*" instead and that cast can go away.

               Linus
