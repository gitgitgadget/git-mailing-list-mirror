From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH/RFC v4 02/13] read-cache.c: Re-read index if index file changed
Date: Sat, 25 Aug 2012 18:02:39 +0200
Message-ID: <001d01cd82db$0dc00870$29401950$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 18:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5Ipq-0007Qd-3G
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 18:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2HYQCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 12:02:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50687 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab2HYQCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 12:02:52 -0400
Received: from DualCore (dsdf-4d0a03be.pool.mediaWays.net [77.10.3.190])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LsR2m-1TkruV0s8W-0123Sr; Sat, 25 Aug 2012 18:02:51 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2C2w0i71hpNMziTkGsR/z3vgRoWw==
Content-Language: de
X-Provags-ID: V02:K0:EjaUmr35QNcBJxLR3HRNsoJ0I7LqXeQtCB5A0ncT2np
 zIPgeTJA4R1bqa/A9spaTBW36wAE3icgyTAXdH1UPliLkYX540
 Awaip7PZV1lql9cjUfqm6ghKQt7vcnXaqkQWpmEPyabr9YOdSh
 8iMUdEwAeMdZkX/ekv68Eo3jQ4bArfezXHovvjcxXNQS49CjJO
 bTHFOM3TkHrK6TLv2MyDhjbJ8N0GW55iMjY7IG2dyd37tjTwvd
 CrAYOALefU+FX6xPyvgRSUmEnDLlJTpNY0+OFzf6dNvOCO+Vaw
 zQ4Oo2K7rogkdCoDWyxJ+CHdGpEpOFY/+5X8vi4fr1bQLNlG5E
 SpXYyCNRzegJYZX+wX3NhNItKI2qtrbrJzOYVrej4+W8YNN6Pm
 XnEAS4voesbuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204275>

"Thomas Gummerer" <t.gummerer@gmail.com> schrieb im Newsbeitrag news:<1345111129-6925-3-git-send-email-t.gummerer@gmail.com>...
> Add the possibility of re-reading the index file, if it changed
> while reading.
> 
> The index file might change during the read, causing outdated
> information to be displayed. We check if the index file changed
> by using its stat data as heuristic.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c | 87 +++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 60 insertions(+), 27 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 6a8b4b1..cdd8480 100644
> --- a/read-cache.c
> +++ b/read-cache.c
...
> @@ -1186,38 +1209,48 @@ int read_index_from(struct index_state *istate, const char *path)
>  	errno = ENOENT;
>  	istate->timestamp.sec = 0;
>  	istate->timestamp.nsec = 0;
> -	fd = open(path, O_RDONLY);
> -	if (fd < 0) {
> -		if (errno == ENOENT)
> -			return 0;
> -		die_errno("index file open failed");
> -	}
> +	do {
> +		err = 0;
> +		fd = open(path, O_RDONLY);
> +		if (fd < 0) {
> +			if (errno == ENOENT)
> +				return 0;
> +			die_errno("index file open failed");
> +		}
>  
> -	if (fstat(fd, &st))
> -		die_errno("cannot stat the open index");
> +		if (fstat(fd, &st_old))
> +			die_errno("cannot stat the open index");
>  
> -	errno = EINVAL;
> -	mmap_size = xsize_t(st.st_size);
> -	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> -	close(fd);
> -	if (mmap == MAP_FAILED)
> -		die_errno("unable to map index file");
> +		errno = EINVAL;
> +		mmap_size = xsize_t(st_old.st_size);
> +		mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +		close(fd);
> +		if (mmap == MAP_FAILED)
> +			die_errno("unable to map index file");
>  
> -	hdr = mmap;
> -	if (verify_hdr_version(istate, hdr, mmap_size) < 0)
> -		goto unmap;
> +		hdr = mmap;
> +		if (verify_hdr_version(istate, hdr, mmap_size) < 0)
> +			err = 1;
>  
> -	if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
> -		goto unmap;
> +		if (istate->ops->verify_hdr(mmap, mmap_size) < 0)
> +			err = 1;
>  
> -	istate->ops->read_index(istate, mmap, mmap_size);
> -	istate->timestamp.sec = st.st_mtime;
> -	istate->timestamp.nsec = ST_MTIME_NSEC(st);
> +		if (istate->ops->read_index(istate, mmap, mmap_size) < 0)
> +			err = 1;
> +		istate->timestamp.sec = st_old.st_mtime;
> +		istate->timestamp.nsec = ST_MTIME_NSEC(st_old);
> +		if (lstat(path, &st_new))
> +			die_errno("cannot stat the open index");
>  
> -	munmap(mmap, mmap_size);
> -	return istate->cache_nr;
> +		munmap(mmap, mmap_size);
> +
> +		if (!index_changed(st_old, st_new) && !err)
> +			return istate->cache_nr;
> +
> +		usleep(10*1000);


usleep() is not available to anybody, e.g. it is not in HP NonStop (not in every case at least)

Bye, Jojo
