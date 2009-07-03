From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 03 Jul 2009 11:18:21 +0200
Message-ID: <4A4DCCDD.9030901@viscovery.net>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net> <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain> <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com> <4A4DA1D6.40301@viscovery.net> <20090703085608.GA18757@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMeuh-0007ry-ME
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 11:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbZGCJSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 05:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbZGCJSX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 05:18:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63767 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbZGCJSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 05:18:23 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MMeuU-0007lY-Ct; Fri, 03 Jul 2009 11:18:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 13B616B7; Fri,  3 Jul 2009 11:18:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090703085608.GA18757@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122690>

Dmitry Potapov schrieb:
> On Fri, Jul 03, 2009 at 08:14:46AM +0200, Johannes Sixt wrote:
>> (We don't yet have an implementation of fsync() :-( )
> 
> Why?

Nobody cared. ;)

> It appears rather straightforward to me. Here is a patch that
> implements it. Or did I miss something?

Yes, but it's not critical; see below ;)

> +int fsync(int fd)
> +{
> +	HANDLE h = (HANDLE) _get_osfhandle(fd);
> +	if (h == INVALID_HANDLE_VALUE)
> +	{
> +		errno = EBADF;
> +		return -1;
> +	}
> +	if (!FlushFileBuffers(h))
> +	{
> +		errno = err_win_to_posix(GetLastError());
> +		return -1;
> +	}

Do we ever call fsync on a pipe? In this case, fsync should fail with
EINVAL, but your implementation would wait until the reader has drained
all data.

> -static inline int fsync(int fd)
> -{ return 0; }
> +int fsync(int fd);

This declaration is now in the wrong section of mingw.h. And someone who
cares should test it first; so I won't bless this patch as is.

Thanks anyway,
-- Hannes
