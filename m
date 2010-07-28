From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Wed, 28 Jul 2010 06:09:55 -0700 (PDT)
Message-ID: <m3pqy7kb2z.fsf@localhost.localdomain>
References: <20100727122018.GA26780@pvv.org>
	<AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com>
	<9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com>
	<AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com>
	<20100728000009.GE25268@spearce.org>
	<AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Joshua Juran <jjuran@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 15:10:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe6Ob-0008Mh-4q
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 15:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab0G1NJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 09:09:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35380 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0G1NJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 09:09:58 -0400
Received: by fxm14 with SMTP id 14so1222617fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XLLmnxd4q3Xy550ur6D9bccWM/uIcgtO4PwlbYXHS1I=;
        b=sPNtKNQWpc+mRRRoeoO+1BylAsRfRtOR7TYA/0YUcOPchdo56cq58Jw1te1q4hB6Rd
         3c4dQhqB5+uA9K8aRpHmFiNIAjcVUpoY5mZgaT7WbWtNRdJ0TM+UPpQKaZaRDy33cU3v
         wHgHw908BS8YWBDvhL17mQPijKxmws3YMSzMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JwZjvhtZGL6kEeo3NIibwsMd+aklrX92XcJb8PwQaHR/5cKcSE8cX4K7e4S4Iz7gF6
         y+TWP1/CQ1wO5GnxTv+F02arwEem1WKjq/EkUPzuI8ooxdGsVJ+kYq0Ck9SJx5DrD3cA
         qqB9oeLFv7KdjBiP8jK3piWIIQBe1vRU8670k=
Received: by 10.223.122.6 with SMTP id j6mr9852002far.78.1280322596802;
        Wed, 28 Jul 2010 06:09:56 -0700 (PDT)
Received: from localhost.localdomain (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id k15sm2557571fai.40.2010.07.28.06.09.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 06:09:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6SD9COn013456;
	Wed, 28 Jul 2010 15:09:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6SD8qb5013452;
	Wed, 28 Jul 2010 15:08:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152083>

Avery Pennarun <apenwarr@gmail.com> writes:

> For speed, the bup index can just mark entries as deleted using a flag
> rather than actually rewriting the whole indexfile.  Unfortunately, I
> failed to make it sufficiently flexible to *add* new entries without
> needing to rewrite the whole thing.  In bup, that's a big deal
> (especially since python is kind of slow and there are typically >1
> million files in the index).  In git, it's maybe not so bad; after
> all, the current implementation rewrites the index *every* time and
> nobody notices.

Sidenote: couldn't you do what e.g. Mercurial did, i.e. rewrite
critical for performance parts in C?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
