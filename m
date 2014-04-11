From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Fri, 11 Apr 2014 09:47:09 +0200
Message-ID: <53479DFD.4020702@web.de>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com> <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 09:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYWBN-0008JA-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 09:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbaDKHr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 03:47:26 -0400
Received: from mout.web.de ([212.227.17.11]:57962 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbaDKHrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 03:47:25 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lh6fv-1XIrhN2jTD-00oZoj; Fri, 11 Apr 2014 09:47:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ep1EhUJtqH0e09JbuMhNN5kZC7mSbWIVGnZ5bJIYVUDgb8iadjd
 u535BfieduboIWV5HqWl2Dp85g8UQx9eCy9P53UkjEIEPIXCnPDbhsgSjnF95EwEH1efzku
 Sgm3mjcyiSP1GuiqDQEFxqakC8a4xbxrB8oSBJMyGUMr/7naYZe7AC/ppYntfsMPE2H8ZEf
 /dG3/+Kiw7gumaNOJkMVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246067>

On 2014-04-10 21.28, Junio C Hamano wrote:
> Yiannis Marangos <yiannis.marangos@gmail.com> writes:
> 
>> +	n = xpread(fd, sha1, 20, st.st_size - 20);
>> +	if (n != 20)
>> +		goto out;
> 
> I think it is possible for pread(2) to give you a short-read.
> 
> The existing callers of emulated mmap and index-pack are prepared to
> handle a short-read correctly, but I do not think this code does.
> 
> I'll queue this instead in the meantime.
> 
> -- >8 --
> From: Yiannis Marangos <yiannis.marangos@gmail.com>
> Date: Thu, 10 Apr 2014 21:31:21 +0300
> Subject: [PATCH] read-cache.c: verify index file before we opportunistically update it
> 
> Before we proceed to opportunistically update the index (often done
> by an otherwise read-only operation like "git status" and "git diff"
> that internally refreshes the index), we must verify that the
> current index file is the same as the one that we read earlier
> before we took the lock on it, in order to avoid a possible race.
> 
> In the example below git-status does "opportunistic update" and
> git-rebase updates the index, but the race can happen in general.
I'm not sure if we need the second or third commit of process A at all.
My understanding is that the simplified version will have problems as well:

  1. process A calls git-rebase (or does anything that updates the index)
  2. process change
  3. process B calls git-status (or does anything that updates the index)
  4. process B reads the index file into memory
  5. process change
  6. process A applies a commit:
      - read the index into memory
      - take the lock
      - update the index file on disc
      - release the lock
  7. process change
  8. process B applies a commit:
      - take the lock
      - update the index in memory and write the index file to disc
      - release the lock

   Now process B has overwritten the commit from process A, which is wrong.

The new code works like this:

  8. process B applies a commit:
      - take the lock
      - verifies tha the index file on disc has the same sha as the one read before
      # And if not: What do we do? die() or retry() ?
      - update the index file on disc
      - release the lock
[]
> 
> +static int verify_index_from(const struct index_state *istate, const char *path)
> +{
> +	int fd;
> +	ssize_t n;
> +	struct stat st;
> +	unsigned char sha1[20];
> +
> +	if (!istate->initialized)
> +		return 0;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return 0;
> +
> +	if (fstat(fd, &st))
> +		goto out;
> +
> +	if (st.st_size < sizeof(struct cache_header) + 20)
> +		goto out;
> +
> +	n = pread_in_full(fd, sha1, 20, st.st_size - 20);
Minor :
What is the advantage of pread() against a lseek()/read_in_full() combo?
fd is opened and used only in one thread.
Introducing pread()/ pread_in_full() could be done in an other commit,
or do I miss something ?
> +	if (n != 20)
> +		goto out;

> +static int verify_index(const struct index_state *istate)
> +{
> +	return verify_index_from(istate, get_index_file());
> +}
> +
Minor:
Do we really need the wrapper function verify_index_from()?
It seems as if the whole code from verify_index_from() could go into
verify_index(), which will call get_index_file()
  
 
>  static int has_racy_timestamp(struct index_state *istate)
>  {
>  	int entries = istate->cache_nr;
> @@ -1766,7 +1811,7 @@ static int has_racy_timestamp(struct index_state *istate)
>  void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
>  {
>  	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
> -	    !write_index(istate, lockfile->fd))
> +	    verify_index(istate) && !write_index(istate, lockfile->fd))
>  		commit_locked_index(lockfile);
>  	else
>  		rollback_lock_file(lockfile);
> diff --git a/wrapper.c b/wrapper.c
> index 5b3c7fc..bc1bfb8 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -232,6 +232,26 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>  	return total;
>  }
>  
> +ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
> +{
> +	char *p = buf;
> +	ssize_t total = 0;
> +
> +	while (count > 0) {
> +		ssize_t loaded = xpread(fd, p, count, offset);
> +		if (loaded < 0)
> +			return -1;
> +		if (loaded == 0)
> +			return total;
> +		count -= loaded;
> +		p += loaded;
> +		total += loaded;
> +		offset += loaded;
> +	}
> +
> +	return total;
> +}
> +
>  int xdup(int fd)
>  {
>  	int ret = dup(fd);
> 
