From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 18:20:55 +1000
Message-ID: <AANLkTimqBSTRzcU++jW6izMgeA=HB00wBXQVHuSsn1oR@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org>
	<AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
	<AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
	<20100728000009.GE25268@spearce.org>
	<AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
	<52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com>
	<AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com>
	<AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Finn Arne Gangstad <finnag@pvv.org>,
	git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 10:21:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1sx-0007iY-NR
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 10:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0G1IU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 04:20:59 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44404 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0G1IU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 04:20:56 -0400
Received: by qyk8 with SMTP id 8so3350618qyk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qZFQAkSYx2dRN8u0yy0CoE3anHc9TUwvtBLF3RyOGpw=;
        b=s9YiFO62ABjh5//pu71q2oK5NXu2DubfiFtOT3JUHreoL71plpY6YvM6t7u5yMSDad
         cMuUhw7YyRUoZlucBboIq6a+cAEH4wpmSvjttXLpwGXMMw+EYSPsnzjKORyL8Q6AhznT
         3cCYHpbc1JR0UofhFgZd9VmX6hzYd0o/sF4+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dNeIWD6kvUPK4isXcEmz5TQ765pz0NxZSOmil4AY6lln3djnJCdguuIlzKIxQZmW5K
         VRLD3VtJaMutiRf8DLOAq7xaQ4oStKWa0yz7eJP/DiCjI6GeiPwIFgHja8lEQkAHWFcp
         dtfr4xebXnss5wmfxe1Z8h7yT4+Q6jBVzvc9Y=
Received: by 10.224.45.147 with SMTP id e19mr592259qaf.64.1280305255822; Wed, 
	28 Jul 2010 01:20:55 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Wed, 28 Jul 2010 01:20:55 -0700 (PDT)
In-Reply-To: <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152057>

On Wed, Jul 28, 2010 at 4:03 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Tue, Jul 27, 2010 at 20:31, Avery Pennarun <apenwarr@gmail.com> wrote:
>> That's what made me think that
>> sqlite might be a sensible choice, since it's already a database :)
>
> Sounds very sensible to me, especially the fact that (if it is indeed
> fast enough, which I can't imagine it not being) it would make
> development so much easier. At least, I think that having sqlite deal
> with backwards comparability of your schema is easier than having to
> manually do that? Also, sqlite is known to scale, is exactly one file
> worth of dependency, what's not to love (other than having to support
> upgrading to 'index vSqlite').

Even more sensible to replace all pack index with a single database.
But then we could as well drop git object store in favor of Fossil (OK
I'm going to far).
-- 
Duy
