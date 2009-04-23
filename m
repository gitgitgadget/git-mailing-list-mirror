From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src) when that is unreliable
Date: Thu, 23 Apr 2009 21:16:10 +0200
Message-ID: <200904232116.10769.j6t@kdbg.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4Qm-0000MW-Gn
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759054AbZDWTQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757293AbZDWTQP
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:16:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:33529 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744AbZDWTQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:16:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 111C2CDF83;
	Thu, 23 Apr 2009 21:16:11 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D7EEB3B3F7;
	Thu, 23 Apr 2009 21:16:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117367>

On Donnerstag, 23. April 2009, Johannes Schindelin wrote:
> It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> has an unnerving bug: if you link() a file and unlink() it right away,
> the target of the link() will have the correct size, but consist of NULs.
>
> It seems as if the calls are simply not serialized correctly, as
> single-stepping through the function move_temp_to_file() works flawlessly.
>
> As ufsd is "Commertial software", I cannot fix it, and have to work

"commercial software"

> around it in Git.
>
> At the same time, it seems that this fixes msysGit issues 222 and 229 to
> assume that Windows cannot handle link() && unlink().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
...
> @@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char
> *filename) {
>  	int ret = 0;
>
> -	if (link(tmpfile, filename))
> +	if (unreliable_hardlinks)
> +		ret = ~EEXIST;

It took me a while to see why we need a tilde here, but it's ok. Perhaps this 
helps others:

+		ret = ~EEXIST;	/* anything but EEXIST */

Nevertheless:

Acked-by: Johannes Sixt <j6t@kdbg.org>

> +	else if (link(tmpfile, filename))
>  		ret = errno;

-- Hannes
