From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 2/4] gitignore: read from index if .gitignore is
 assume-unchanged
Date: Mon, 10 Aug 2009 18:33:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101826250.8324@intel-tinevez-2-302>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> <1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-86698705-1249921991=:8324"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXol-0001vG-R5
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbZHJQdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbZHJQdN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:33:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:46221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755580AbZHJQdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:33:13 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:33:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 10 Aug 2009 18:33:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IhHJGR5wIjKsM8MxzCkGW/bqybx2FRs1I6E5tuX
	AQ8OcqRgYzDwWu
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1249917562-5931-3-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125483>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-86698705-1249921991=:8324
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/dir.c b/dir.c
> index e05b850..e55344f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -200,11 +200,36 @@ void add_exclude(const char *string, const char *base,
>  	which->excludes[which->nr++] = x;
>  }
>  
> +static void *read_index_data(const char *path, size_t *size)

How about calling it "read_assume_unchanged_from_index()" instead?  I 
suggest this because it does not read the index from the data if the path 
is not marked assume unchanged...

> @@ -212,27 +237,31 @@ static int add_excludes_from_file_1(const char *fname,
>
> [...]
>  
>  	if (buf_p)
>  		*buf_p = buf;
> -	buf[size++] = '\n';
>  	entry = buf;
> -	for (i = 0; i < size; i++) {
> -		if (buf[i] == '\n') {
> +	for (i = 0; i <= size; i++) {
> +		if (i == size || buf[i] == '\n') {
>  			if (entry != buf + i && entry[0] != '#') {
>  				buf[i - (i && buf[i-1] == '\r')] = 0;
>  				add_exclude(entry, base, baselen, which);

Should this change not rather be a separate one?

> @@ -241,17 +270,12 @@ static int add_excludes_from_file_1(const char *fname,
>  		}
>  	}
>  	return 0;
> -
> - err:
> -	if (0 <= fd)
> -		close(fd);
> -	return -1;
>  }
>  
>  void add_excludes_from_file(struct dir_struct *dir, const char *fname)
>  {
>  	if (add_excludes_from_file_1(fname, "", 0, NULL,
> -				     &dir->exclude_list[EXC_FILE]) < 0)
> +				     &dir->exclude_list[EXC_FILE], 0) < 0)

Could you mention in the commit message why this function does not want to 
check the index (I _guess_ it is because this code path only tries to read 
.git/info/exclude, but it would be better to be sure).

>  		die("cannot use %s as an exclude file", fname);
>  }
>  
> @@ -302,7 +326,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
>  		add_excludes_from_file_1(dir->basebuf,
>  					 dir->basebuf, stk->baselen,
> -					 &stk->filebuf, el);
> +					 &stk->filebuf, el, 1);
>  		dir->exclude_stack = stk;
>  		current = stk->baselen;
>  	}
> diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
> index c65bca8..88b69bc 100755
> --- a/t/t3001-ls-files-others-exclude.sh
> +++ b/t/t3001-ls-files-others-exclude.sh
> @@ -85,6 +85,26 @@ test_expect_success \
>         >output &&
>       test_cmp expect output'
>  
> +test_expect_success 'setup sparse gitignore' '
> +	git add .gitignore one/.gitignore one/two/.gitignore &&
> +	git update-index --assume-unchanged .gitignore one/.gitignore one/two/.gitignore &&
> +	rm .gitignore one/.gitignore one/two/.gitignore
> +'

You're probably less sloppy than me; I'd have defined a variable like 
this:

	ignores=".gitignore one/.gitignore one/two/.gitignore"

and used it for the three calls, just to make sure that I do not fsck 
anything up there due to fat fingers.

Thanks,
Dscho

--8323329-86698705-1249921991=:8324--
