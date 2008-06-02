From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Mon, 2 Jun 2008 09:26:52 -0700
Message-ID: <7f9d599f0806020926j7ac9fb12jefa5a14fe5708226@mail.gmail.com>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
	 <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
	 <20080602064218.GA15144@sigill.intra.peff.net>
	 <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com>
	 <alpine.DEB.1.00.0806021635220.13507@racer.site.net>
	 <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>
	 <alpine.DEB.1.00.0806021717130.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 02 18:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Csy-0004hW-Bf
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 18:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYFBQ0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 12:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYFBQ0z
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 12:26:55 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:40690 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYFBQ0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 12:26:54 -0400
Received: by py-out-1112.google.com with SMTP id p76so474391pyb.10
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=tj6Zq67OCHgU5yU93AmbJVFw4CTexCmLBuIgyeYklfg=;
        b=uu0owhSbEvoH1O+daw682fWVyfvp+IytRKtqK3aRoLqlymPzP9aqJwiP3s4n+8eugmAun2amUzucCt25vTzr7xs9gNPMnykIofQ9/G6IJvYZgYv6F1ESwPG0Y1nyIrVpHjYh3agEullxl7qwz1n1fTKHx6B2PckKmaOPNc2ULKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FLZR4TnSAaAAY2aEeNQgiaxd0qMUMsWaTPd6/k3gHVR0SexrvGtcTiOUobCDhGbAyG33+GPEg5GcuDxnUyXCj5QqTkmZx5zFn8JLJESYf+BeMYSUjm/+9ghkn7NOM8TaUCDkWAvk3SbyLMURc5wefD2fNCD4lggFB2BWXomBtWA=
Received: by 10.141.33.21 with SMTP id l21mr5095601rvj.140.1212424012479;
        Mon, 02 Jun 2008 09:26:52 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Mon, 2 Jun 2008 09:26:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806021717130.13507@racer.site.net>
Content-Disposition: inline
X-Google-Sender-Auth: 74e2ce42ddebe83f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83542>

On Mon, Jun 2, 2008 at 9:18 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 2 Jun 2008, Geoffrey Irving wrote:
>
>> On Mon, Jun 2, 2008 at 8:37 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > Another issue that just hit me: this cache is append-only, so if it
>> > grows too large, you have no other option than to scratch and recreate
>> > it. Maybe this needs porcelain support, too?  (git gc?)
>>
>> If so, the correct operation is to go through the hash and remove
>> entries that refer to commits that no longer exist.  I can add this if
>> you want.  Hopefully somewhere along the way git-gc constructs an easy
>> to traverse list of extant commits, and this will be straightforward.
>
> I don't know... if you have created a cached patch-id for every commit (by
> mistake, for example) and do not need it anymore, it might make git-cherry
> substantially faster to just scrap the cache.

Well, ideally hash maps are O(1), but it could be a difference between
a "compare 40 bytes" constant and a "read a 4k block into memory"
constant, so in practice yes.  Scrapping it entirely will also make
the implementation much simpler.

It seems a little sad to wipe all that effort each time, but
regenerating the cache is likely to be less expensive than a git-gc,
so it shouldn't change any amortized complexities.

Geoffrey
