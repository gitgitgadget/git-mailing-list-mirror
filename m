From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify strbuf uses in archive-tar.c using the proper functions.
Date: Wed, 19 Sep 2007 01:06:24 -0700
Message-ID: <7v8x73qdtr.fsf@gitster.siamese.dyndns.org>
References: <20070905085720.GD31750@artemis.corp>
	<11890199232110-git-send-email-madcoder@debian.org>
	<11890199232128-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuZw-0004Rw-OA
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbXISIGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXISIGa
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:06:30 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:44268 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbXISIG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:06:29 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 65C5B1342D1;
	Wed, 19 Sep 2007 04:06:48 -0400 (EDT)
In-Reply-To: <11890199232128-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Wed, 5 Sep 2007 21:18:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58686>

Pierre Habouzit <madcoder@debian.org> writes:

>   This is just cleaner way to deal with strbufs, using its API rather than
> reinventing it in the module (e.g. strbuf_append_string is just the plain
> strbuf_addstr function, and it was used to perform what strbuf_addch does
> anyways).
> ---
>  archive-tar.c |   65 ++++++++++++++-------------------------------------------
>  1 files changed, 16 insertions(+), 49 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index a0763c5..c84d7c0 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -260,28 +237,18 @@ static int write_tar_entry(const unsigned char *sha1,
>                             const char *base, int baselen,
>                             const char *filename, unsigned mode, int stage)
>  {
> -	static struct strbuf path;
> +	static struct strbuf path = STRBUF_INIT;
>  	int filenamelen = strlen(filename);
>  	void *buffer;
>  	enum object_type type;
>  	unsigned long size;
>  
> -	if (!path.alloc) {
> -		path.buf = xmalloc(PATH_MAX);
> -		path.alloc = PATH_MAX;
> -		path.len = path.eof = 0;
> -	}
> -	if (path.alloc < baselen + filenamelen + 1) {
> -		free(path.buf);
> -		path.buf = xmalloc(baselen + filenamelen + 1);
> -		path.alloc = baselen + filenamelen + 1;
> -	}
> -	memcpy(path.buf, base, baselen);
> -	memcpy(path.buf + baselen, filename, filenamelen);
> -	path.len = baselen + filenamelen;
> -	path.buf[path.len] = '\0';
> +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));

Where are you getting the MAX() macro from?  On my Linux box
it appears that <sys/params.h> happens to define it but I do not
think that is something we can rely upon portably.

Moreover, isn't this allocation wrong?  I thought "grow" was
about "we want this much more in addition to the existing
length", not "reserve at least this much", and this "path" is a
static that will keep the buffer and length from the previous
invocation.

> +	strbuf_reset(&path);
> +	strbuf_add(&path, base, baselen);
> +	strbuf_add(&path, filename, filenamelen);
>  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> -		strbuf_append_string(&path, "/");
> +		strbuf_addch(&path, '/');
>  		buffer = NULL;
>  		size = 0;
>  	} else {

Having said that, I suspect that the preallocation does not
really matter in practice.  How about doing something like:

	strbuf_reset(&path);
        strbuf_grow(&path, PATH_MAX);
        strbuf_add(&path, base, baselen);
        strbuf_add(&path, filename, filenamelen);
