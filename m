From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Add a lockfile function to append to a file
Date: Thu, 17 Apr 2008 16:41:28 -0700
Message-ID: <7v3apkm4lz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0804171931480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 18 01:42:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmdkI-0005oj-Nd
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 01:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbYDQXlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYDQXlk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 19:41:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233AbYDQXlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 19:41:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF1902D4D;
	Thu, 17 Apr 2008 19:41:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 026642D4B; Thu, 17 Apr 2008 19:41:31 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0804171931480.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 17 Apr 2008 19:32:26 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79853>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This takes care of copying the original contents into the replacement
> file after the lock is held, so that concurrent additions can't miss
> each other's changes.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  cache.h    |    1 +
>  lockfile.c |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 2a1e7ec..4a113b0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -391,6 +391,7 @@ struct lock_file {
>  	char filename[PATH_MAX];
>  };
>  extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
> +extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
>  extern int commit_lock_file(struct lock_file *);
>  
>  extern int hold_locked_index(struct lock_file *, int);
> diff --git a/lockfile.c b/lockfile.c
> index 663f18f..95fd3d1 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -160,6 +160,23 @@ int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on
>  	return fd;
>  }
>  
> +int hold_lock_file_for_append(struct lock_file *lk, const char *path, int die_on_error)
> +{
> +	int fd = lock_file(lk, path);
> +	struct stat st;
> +	if (!stat(path, &st)) {
> +		int orig_fd = open(path, O_RDONLY);
> +		size_t mmap_size = xsize_t(st.st_size);
> +		void *mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE,
> +				   orig_fd, 0);
> +		write_or_die(fd, mmap, mmap_size);
> +		munmap(mmap, mmap_size);
> +	}
> +	if (fd < 0 && die_on_error)
> +		die("unable to create '%s.lock': %s", path, strerror(errno));

Copying and checking are the other way around, aren't they?  Grab the
lock, error out if you cannot, then read and copy.

> +	return fd;
> +}
> +
>  int close_lock_file(struct lock_file *lk)
>  {
>  	int fd = lk->fd;
> -- 
> 1.5.4.3.610.gea6cd
