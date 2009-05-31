From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Sun, 31 May 2009 23:18:20 +0100
Message-ID: <efe2b6d70905311518w4c2d79ecy8cdabd15a8effc7c@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 
	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 
	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com> 
	<4A1E00F1.4030709@zytor.com> <efe2b6d70905281407x56bb788aq3dba4b27eb91d7a6@mail.gmail.com> 
	<4A1F07FA.6040008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 00:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAtNt-0004VL-Ip
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 00:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbZEaWSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 18:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZEaWSk
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 18:18:40 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42425 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZEaWSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2009 18:18:39 -0400
Received: by ewy24 with SMTP id 24so7462846ewy.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZaGotHW50KHBao6OE49I0llhn7GZTx1zPmKM+dhVIe0=;
        b=ewKoe4VltZuaoVkx13ZVOShSU2jFbMTxNBWcGpedZa2nixs9BRyQpYQ/nfI4E9oczS
         HERHRGifUk0taNv4kvCu1DB/twBUYWB66EACMOpVgmV3rsgxZcVzHPFytJYLkKI21Ic6
         mrNHrWyoS6bFD1w1fD8W8lAoQJ8ljSkA58EbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RXGrsmBejJA1SM6MMp2/qS9WXRfFeM363csK+llEPdIgIZuH4frx0L7jVv8ueRAFYl
         BosGKzNXV5HPyTje22GGFd9YoHnJAJgXserLrVRQjSCvqRE7T0XxcjKMQwPC9O7y8KPF
         p4x3nBaaSCB5TPyP5dzyvn/GGW9f+84eJxgIw=
Received: by 10.216.3.195 with SMTP id 45mr1646180weh.8.1243808320124; Sun, 31 
	May 2009 15:18:40 -0700 (PDT)
In-Reply-To: <4A1F07FA.6040008@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120434>

On Thu, May 28, 2009 at 10:54 PM, H. Peter Anvin <hpa@zytor.com> wrote:

> How about simply modelling it linearly, with 100% probability for kno=
wn
> skip point, 0% for a known good/bad point, and a linear gradient in
> between? =A0It's probably a good enough model. =A0In practice, it wil=
l
> vastly overestimate the probability of a skip, so if a linear model
> turns out to be too conservative, I would probably just try to model =
it
> as a higher-order power function.

Sounds plausible. It's not obvious how to generalise it to a DAG, thoug=
h.

What's easier to implement is simple geometric decay (from a
probability of 1 at the commit of an actual skip).  It even has a
plausible rationale - the probability that someone notices the
brokenness
and fixes it is probably a constant, which would lead to geometric
decay. That probably doesn't reflect what happens when someone breaks
a whole swath of stuff retrospectively somehow, though.

I've implemented geometric (and arithmetic) decay in bbchop, with a
configurable decay factor. With a factor sufficiently close to one
(eg, 0.99) it can be persuaded to hop a reasonable distance, which
seems to scale to a certain extent with the number of commits left, so
hopefully it won't be necessary to fiddle with the factor a lot.

http://github.com/Ealdwulf/bbchop/tree/master

Ealdwulf
