From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 21:31:18 -0700
Message-ID: <56b7f5510705262131g2d4186a0q605abbcea624d42d@mail.gmail.com>
References: <20070526052419.GA11957@spearce.org>
	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>
	 <alpine.LFD.0.99.0705262223540.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun May 27 06:31:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsAPm-0002z8-QR
	for gcvg-git@gmane.org; Sun, 27 May 2007 06:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbXE0EbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 00:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXE0EbU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 00:31:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58219 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXE0EbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 00:31:19 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1401503ugf
        for <git@vger.kernel.org>; Sat, 26 May 2007 21:31:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s49KvNW+WG3/AIGW14uheQu7fRYqOjIlExwv61JEw9G2giDxzq19sk+7iyKqbypIVpHSIVVKi1USNzEM1d1FNuOONX64iiD81NPhleBCcyfJ0+69QoHTPLKODdTsHLpfanWqrEvBD3iM/2RNG1LjWnn+nNWkvq+4twbVq/sTf2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q9mnuLDVGLqWMJ2Ky6EuXSBE0FHe7DZ71ztZQsdKG+5K5qql1wypGQR85qgDrtl3oCiNTbV5KCL3xYcZSpa7qfyzS07yaY1oHgWbcF4bJ6orLBHmICSR28oaMneMYM3JqWSaeNz6E0b9Z5sVr858TXU2STztKgMfG7wpaGAidZE=
Received: by 10.78.131.8 with SMTP id e8mr1339570hud.1180240278307;
        Sat, 26 May 2007 21:31:18 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Sat, 26 May 2007 21:31:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705262223540.3366@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48516>

On 5/26/07, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 26 May 2007, Dana How wrote:
> > (1) git-repack -a -d repacks everything on each call.  You would need:
> > (1a) Rewrite builtin-pack-objects.c so only the object_ix hash
> >       accesses the "objects" array directly, everything else
> >       goes through a pointer table.
> > (1b) Sort the new pointer table by object type,  in order
> >       tag -> commit -> tree -> nice blob -> naughty blob.
> >      The sort is stable so the order within each group is unchanged.
>
> Because commit objects are so fundamental to many graph operations they
> are already all packed together.  But tree and blob objects are
> intermixed for the reason stated above.
I noticed that all the commits were together and
wondered if that was deliberate.

> The naughty blob is a really special category and I think they should be
> treated as such. Therefore I don't think the common/normal case should
> be impacted with a generic change for something that is still a special
> case.
This argument makes sense.

> In other words, I think the naughty blob could simply be recognized as
> such and be referenced in a special list instead of being written out
> initially.  Then when everything is believed to be written, the special
> list can be walked to force write those naughty blob at last.  No need
> to modify the current object order.
This works as long as a naughty blob can't be a delta base for a nice blob
(causing it to be pushed out early by the recursion in write_one()).
I think that's a reasonable and understandable restriction.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
