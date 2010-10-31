From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: index rebuild for cloned repo
Date: Sun, 31 Oct 2010 13:07:58 -0500
Message-ID: <20101031180758.GC5683@burratino>
References: <20101031174430.GA30236@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 19:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCcKE-0003DS-NL
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 19:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486Ab0JaSIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 14:08:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52524 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943Ab0JaSII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 14:08:08 -0400
Received: by vws13 with SMTP id 13so2624996vws.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PDASzN8RIJmoK22hlJ7IihcTvVhkAgHBSeWSX1eXJ70=;
        b=uSD0nwz9S+wt9ZvkO87msAALpbv3oRMC95c4PhWRm92FXPvOKMxAMjGfhwq74+WIty
         snTUhReHqwrfYGynS6TqEkYIQbOzBBjl2/xmNIyLqtpPOfvrqOrART7aegExTQLsdcYu
         s8vUwJZSNBVaIkgO2umJRvhRGDL3yTJDXdXHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ea8vDj1AUK0fTeFHfoUE4lxVsnfeejcU6w5wvFEZzzsRKFT2iJipR3XrD/xTKWeaQc
         tTVsQYUlia1eGmPgmNVW30CAywJabpTCe5DbWa/iqfAE41OAXhkyegfMKa0rhk8bPAm7
         AcOPNrx9e+X5EHnQMO2EvFYNkjSk7QmvzNG/4=
Received: by 10.229.245.213 with SMTP id lv21mr8031022qcb.293.1288548487984;
        Sun, 31 Oct 2010 11:08:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u2sm4193910qcq.43.2010.10.31.11.08.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 11:08:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031174430.GA30236@arf.padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160446>

Hi Pete,

Pete Wyckoff wrote:

>                                                          While
> the data is identical, much of the inode information changes:
> uid, gid, ino, dev, mtime, ctime.
> 
> What is the best way to rewrite .git/index in the clone?  Options
> that work but are slow:
> 
>     git reset --hard HEAD

Not very good for this use case, as you noticed.

>     git update-index --refresh
> 	stat and read all files, 5 min 55 sec

That's better (better yet with -q).  The user-facing version is
"git add --refresh .".

[...]
>     HACKED git update-index --refresh
> 	Just the stat, 13 sec
> 
> The lstat() is required to look up the new inode number.
> 
> The rest of the clone operation takes around 3 min, so
> I'd like to avoid this additional 5+ min of read()s if
> possible.  Is there a way to do so using existing commands?
> Should I add a new option to update-index

Yes, a new option sounds sane.

> P.S.  The user-observable problem that occurs if I do not
> rebuild the index is, e.g.:
> 
>     $ git cherry-pick build/top
>     error: Your local changes to 'file.h' would be overwritten by merge.  Aborting.
>     Please, commit your changes or stash them before you can merge.

That's a bug.  In general, the "high-level commands (porcelain)"
listed in the git manpage (other than gitk) are supposed to hide an
un-refreshed index from the user, generally by transparently
refreshing the index.

Thanks for reporting.

Hope that helps,
Jonathan
