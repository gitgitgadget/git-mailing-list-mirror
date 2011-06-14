From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] archive: support gzipped tar files
Date: Tue, 14 Jun 2011 21:39:55 +0200
Message-ID: <4DF7B90B.9050802@lsrfire.ath.cx>
References: <20110614181732.GA31635@sigill.intra.peff.net> <20110614181821.GA32685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZTD-0006iI-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab1FNTkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:40:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:58580 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab1FNTkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:40:08 -0400
Received: from [192.168.2.106] (p579BE7E7.dip.t-dialin.net [87.155.231.231])
	by india601.server4you.de (Postfix) with ESMTPSA id EB7B92F8055;
	Tue, 14 Jun 2011 21:40:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110614181821.GA32685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175794>

Am 14.06.2011 20:18, schrieb Jeff King:
> git-archive already supports the creation of tar files. For
> local cases, one can simply pipe the output to gzip, and
> having git-archive do the gzip is a minor convenience.
> 
> However, when running git-archive against a remote site,
> having the remote side do the compression can save
> considerable bandwidth. Service providers could always wrap
> git-archive to provide that functionality, but this makes it
> much simpler.

That's a good point and one that was overlooked when this topic came up
earlier (see http://kerneltrap.org/mailarchive/git/2009/9/10/11507 and
http://kerneltrap.org/mailarchive/git/2009/9/11/11577).  That
implementation was ... heavier than yours, but it also avoided an
unnecessary level of buffering.  I wonder if it makes a measurable
difference, though.

> Creating gzipped archives is of course more expensive than
> regular tar archives; however, the amount of work should be
> comparable to that of creating a zip file, which is already
> possible. So there should be no new security implications
> with respect to creating load on a remote server.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-archive.txt |   17 +++++++++++++++--
>  archive-tar.c                 |   27 +++++++++++++++++++++++++++
>  archive.c                     |    1 +
>  archive.h                     |    1 +
>  builtin/archive.c             |    6 ++++++
>  t/t5000-tar-tree.sh           |   26 ++++++++++++++++++++++++++
>  6 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index 9c750e2..963bec4 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -34,10 +34,11 @@ OPTIONS
>  -------
>  
>  --format=<fmt>::
> -	Format of the resulting archive: 'tar' or 'zip'. If this option
> +	Format of the resulting archive: 'tar', 'tgz', or 'zip'. If this option
>  	is not given, and the output file is specified, the format is
>  	inferred from the filename if possible (e.g. writing to "foo.zip"
> -	makes the output to be in the zip format). Otherwise the output
> +	creates the output in the zip format; "foo.tgz" or "foo.tar.gz"
> +	creates the output in the tgz format). Otherwise the output
>  	format is `tar`.
>  
>  -l::
> @@ -89,6 +90,12 @@ zip
>  	Highest and slowest compression level.  You can specify any
>  	number from 1 to 9 to adjust compression speed and ratio.
>  
> +tgz
> +~~~
> +-9::
> +	Highest and slowest compression level. You can specify any
> +	number from 1 to 9 to adjust compression speed and ratio.
> +
>  
>  CONFIGURATION
>  -------------
> @@ -133,6 +140,12 @@ git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
>  
>  	Create a compressed tarball for v1.4.0 release.
>  
> +git archive --prefix=git-1.4.0/ -o git-1.4.0.tar.gz v1.4.0
> +
> +	Same as above, except that we use the internal gzip. Note that
> +	the output format is inferred by the extension of the output
> +	file.
> +
>  git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
>  
>  	Create a compressed tarball for v1.4.0 release, but without a
> diff --git a/archive-tar.c b/archive-tar.c
> index b1aea87..86c8aa9 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -260,3 +260,30 @@ int write_tar_archive(struct archiver_args *args)
>  	output = output_write;
>  	return write_tar_archive_internal(args);
>  }
> +
> +static gzFile gz_file;
> +static void output_gz(const char *buf, unsigned long len)
> +{
> +	if (!gzwrite(gz_file, buf, len))
> +		die("unable to write compressed stream: %s",
> +		    gzerror(gz_file, NULL));
> +}

Does this do the right things when faced with interrupted writes or
truncated pipes?  I ask because the earlier attempt had a
gzwrite_or_die() which did that, but I don't know anymore if that is
strictly needed.  Oh, and bridging the gap between unsigned long and int
was certainly another reason for the existence of this function.
