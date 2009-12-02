From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any time
Date: Wed, 2 Dec 2009 10:03:33 +0800
Message-ID: <be6fef0d0912011803u2ec9ab1bsa167cf59de4dd47c@mail.gmail.com>
References: <25718488.post@talk.nabble.com>
	 <20091127234110.7b7e9993.rctay89@gmail.com>
	 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
	 <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>
	 <20091201161428.GC21299@spearce.org>
	 <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Martin Storsj?" <martin@martin.st>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFeZ9-0003h0-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbZLBCD2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 21:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbZLBCD1
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:03:27 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:57263 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbZLBCD1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:03:27 -0500
Received: by iwn1 with SMTP id 1so3552755iwn.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W6SPmlbOUworhoCVOxWdY9MDGhUBiv3neokKgENNAu0=;
        b=brUSUw2cZMT2uychisr6aOXoukoT8DdhnMZE4lqeZ1uSuNcWc2OyVEl/wxttnKcjO9
         LBtA5R3bH04oZU7SxY9BuULz3twL4UXnmpn9nNfzkglkBztGxmE0o8Q2NaSkJ1HMCvG/
         zHrblU3Xg7E3xgdzzpmvb9UKH/QnD+dnvZsjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QsyQFpyZRz8ClOis6EBiAHC4/Sd57ZNEmA0exz0QBrTU6vhmvSqtUDPNA6gMFt/PHn
         wmgjKDyF9/yz3u5busWIm7kaMZwR2erf5T/ndOa95HDRTexyy41XnFrH+/RmBh+HtpQH
         Eq/wHKeF5nuqAtwmS+FsKPpijNY52YXM2d3X8=
Received: by 10.231.1.22 with SMTP id 22mr878469ibd.56.1259719413409; Tue, 01 
	Dec 2009 18:03:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134280>

Hi,

On Wed, Dec 2, 2009 at 2:18 AM, Daniel Stenberg <daniel@haxx.se> wrote:
> If '#@!*@!*' is your pattern for matching libcurl or curl, then sure =
libcurl
> certainly has no problem at all to send as many requests you like
> back-to-back.

I have a feeling Shawn's referring to the git http library on top of th=
at. ;)

> The rewinding business is only really necessary for multipass authent=
ication
> when Expect: 100-continue doesn't work (and thus libcurl has started =
to send
> data that the server will discard and thus is needed to get sent agai=
n). And
> that's not something you can blame "the #@!*@!* library" for, but rat=
her
> your server end and/or how HTTP is defined to work.

According to Martin, Expect: 100-continue is not working due to libcurl=
=2E

I quote him:

Date: Tue, 1 Dec 2009 12:28:26 +0200 (EET)
Subject: Re: [PATCH 0/2] http: allow multi-pass authentication

On Tue, Dec 1, 2009 at 6:28 PM, Martin Storsj=F6 <martin@martin.st> wro=
te:
> Normally, libcurl should add the Expect: 100-continue header
> automatically, but for some reason
> (http://article.gmane.org/gmane.comp.web.curl.library/25992) it doesn=
't,
> so that's probably why we're manually adding that header in
> remote-curl.c:371 at the moment. libcurl doesn't detect this at the m=
oment
> (http://article.gmane.org/gmane.comp.web.curl.library/25991) so it wo=
n't
> wait for the 100 continue response before starting to send the body d=
ata.

But, again, don't read my blaming of libcurl for this 100 business as
a criticism of curl.

--=20
Cheers,
Ray Chuan
