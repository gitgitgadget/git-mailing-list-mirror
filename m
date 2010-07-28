From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 06:06:22 -0700 (PDT)
Message-ID: <m3tynjkb90.fsf@localhost.localdomain>
References: <20100727122018.GA26780@pvv.org>
	<AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
	<AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
	<20100728000009.GE25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 15:06:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6LE-0006g9-48
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab0G1NGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 09:06:30 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45380 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab0G1NG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:06:28 -0400
Received: by bwz1 with SMTP id 1so3932974bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CuuTFvUdhsEefsiQjihiUVWGtqXsLYtQG/91tXH8obw=;
        b=l75cZU6zy4ujtgZ06AwQ6SABtgzwgfQ1RVpFw7z4ycYC6JAowEI6Ja0d+36e7zp0Cn
         hLHn5UqHwocjW4CE/CcvDUBzuVmOS6UVnmkn13D/Wmu/B36TMP5SBJTbunhyPD94D2fp
         rmBU/Do8BN60tn3a74qEjT5oYOKQK2iV/DOCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jsN2yR9ig2+NThWnw09317nvnhFUzmpWinaG7Nv/ErfcdPQrJ8FFLivkV+S7nI5u6S
         CKyGqK9lQut/i3ZX0ZHvY+VNRTpz4j7lT6S0ZOUcSlEDsrqKvBP1Dy3LUjJYbiv4KrOa
         M0rxBrCQgnHbFpj22fXayIuOAkLUQB8bzoQQw=
Received: by 10.204.7.219 with SMTP id e27mr7547723bke.191.1280322383094;
        Wed, 28 Jul 2010 06:06:23 -0700 (PDT)
Received: from localhost.localdomain (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id x19sm4766570bkv.21.2010.07.28.06.06.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 06:06:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6SD5gIa013414;
	Wed, 28 Jul 2010 15:05:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6SD5GLd013406;
	Wed, 28 Jul 2010 15:05:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100728000009.GE25268@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152082>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Avery Pennarun <apenwarr@gmail.com> wrote:
> > 
> > While we're here, it's probably worth mentioning that git's index file
> > format (which stores a sequential list of full paths in alphabetical
> > order, instead of an actual hierarchy) does become a bottleneck when
> > you actually have a huge number of files in your repo (like literally
> > a million).  You can't actually binary search through the index!  The
> > current implementation of submodules allows you to dodge that
> > scalability problem since you end up with multiple smaller index
> > files.  Anyway, that's fixable too.
> 
> Yes.
> 
> More than once I've been tempted to rewrite the on-disk (and I guess
> in-memory) format of the index.  And then I remember how painful that
> stuff is in either C git.git or JGit, and I back away slowly.  :-)
> 
> Ideally the index is organized the same way the trees are, but
> you still can't do a really good binary search because of the
> ass-backwards name sorting rule for trees.  But for performance
> reasons you still want to keep the entire index in a single file,
> an index per directory (aka SVN/CVS) is too slow for the common
> case of <30k files.

I guess that modern filesystems solve the problem of very many files
in a single directory somehow (hash tables?).  Perhaps the index file
could borrow some such mechanism as an extension.

Index for index?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
