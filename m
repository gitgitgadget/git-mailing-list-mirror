From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git on afs
Date: Sat, 20 Oct 2007 01:29:06 -0400
Message-ID: <20071020052906.GT14735@spearce.org>
References: <20071018203106.GA13518@fries.net> <20071019054814.GJ14735@spearce.org> <200710190742.08174.todd@fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 07:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij6tt-0002vt-Il
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 07:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbXJTF3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 01:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXJTF3R
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 01:29:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45435 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbXJTF3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 01:29:16 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij6tY-0002A2-Nh; Sat, 20 Oct 2007 01:29:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3BE0620FBAE; Sat, 20 Oct 2007 01:29:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200710190742.08174.todd@fries.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61785>

"Todd T. Fries" <todd@fries.net> wrote:
> It should not matter, but I'm using arla's afs client on OpenBSD; the errno
> is 17 (EEXIST), the very errno that bypasses the coda hack's rename():
...
> I can assure you that the 2nd argument to link does not exist ;-)
...
> The only downside is that either on coda or if the file already exists, it
> will try a spurrous rename(), in which case it will fail with EEXIST again,
> so I hope this is not a big negative.

Actually there is a really big downside.  rename() is defined to
unlink the destination if it already exists, so you'll never get
EEXIST from a rename() call.

This means that an existing (known to be good) object can be
overwritten as a result of a rename with another copy of the object.
We've never really had that behavior as part of our security model
has been to always trust what is already in the repository and
refuse to replace something we already have.
 
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2004,8 +2004,13 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
>  	 *
>  	 * When this succeeds, we just return 0. We have nothing
>  	 * left to unlink.
> +	 *
> +	 * AFS hack - afs is similar to coda, but inconveniently
> +	 * set errno to EEXIST, so call rename() if the link()
> +	 * above fails unconditionally.  Small bit of extra work
> +	 * so afs functions properly.
>  	 */
> -	if (ret && ret != EEXIST) {
> +	if (ret) {
>  		if (!rename(tmpfile, filename))
>  			return 0;
>  		ret = errno;

This is very unfortunate.  There's no way to tell that the file
already exists.  This whole AFS link() returning EEXIST is sort of
like the unlink() call on Solaris UFS working on directories as root
and leaving corrupted filesystems.  At some point the application
just cannot be reasonably expected to work on a system that acts
this insane.

I think I would rather change sha1_file.c to write temporary files
into the destination directory, rather than one level up and try to
hardlink them into position.  At least there we can rely on hardlinks
within Coda and AFS, and only need this rename special case for FAT.

-- 
Shawn.
