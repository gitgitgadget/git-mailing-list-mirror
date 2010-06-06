From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 3/4] textconv: support for blame
Date: Sun, 6 Jun 2010 17:51:59 -0400
Message-ID: <20100606215159.GA6993@coredump.intra.peff.net>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 06 23:52:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNlK-0006OA-RQ
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 23:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab0FFVwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 17:52:05 -0400
Received: from peff.net ([208.65.91.99]:49630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036Ab0FFVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 17:52:03 -0400
Received: (qmail 12274 invoked by uid 107); 6 Jun 2010 21:52:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 17:52:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 17:51:59 -0400
Content-Disposition: inline
In-Reply-To: <1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148546>

On Thu, Jun 03, 2010 at 12:47:17PM +0200, Axel Bonnet wrote:

>  /*
> + * Prepare diff_filespec and convert it using diff textconv API
> + * if the textconv driver exists.
> + * Return 1 if the conversion succeeds, 0 otherwise.
> + */
> +static int textconv_object(const char *path,
> +			   const unsigned char *sha1,
> +			   unsigned short mode,
> +			   struct strbuf *buf)
> +{
> +	struct diff_filespec *df;
> +
> +	df = alloc_filespec(path);
> +	fill_filespec(df, sha1, mode);
> +	get_textconv(df);
> +
> +	if (!df->driver|| !df->driver->textconv) {
> +		free_filespec(df);
> +		return 0;
> +	}

df->driver is always non-NULL these days, isn't it? Also, why not just
use the return value of get_textconv, which does handles this
conditional for you already (and avoids peeking directly at df->driver,
which was what get_textconv was meant to abstract). I.e.:

  struct userdiff_driver *textconv;
  ...
  textconv = get_textconv(df);
  if (!textconv)
     ... free and return ...

> +	buf->len = fill_textconv(df->driver, df, &buf->buf);
> +	buf->alloc = 1;
> +	free_filespec(df);
> +	return 1;

Shoving the allocated buffer into a strbuf really feels like an abuse of
strbuf. I don't think there is any bug here (the original buffer
actually comes from a strbuf, and by setting alloc to 1, you indicate
that any further appending would need to realloc), but it just seems
like violating the boundary of the strbuf API.

And it isn't really necessary because:

> +		if (DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) &&
> +		    textconv_object(o->path, o->blob_sha1, mode, &buf))
> +			file->ptr = strbuf_detach(&buf, (size_t *) &file->size);

You just end up pulling it out into an mmfile_t, anyway. So why involve
strbuf at all?

>  static void fill_origin_blob(struct diff_options opt,
>  			     struct origin *o, mmfile_t *file)
>  {
> +	unsigned mode;
> +
>  	if (!o->file.ptr) {
> +		struct strbuf buf = STRBUF_INIT;
>  		enum object_type type;
>  		num_read_blob++;
> -		file->ptr = read_sha1_file(o->blob_sha1, &type,
> -					   (unsigned long *)(&(file->size)));
> +
> +		get_tree_entry(o->commit->object.sha1,
> +			       o->path,
> +			       o->blob_sha1, &mode);
> +		if (DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) &&
> +		    textconv_object(o->path, o->blob_sha1, mode, &buf))
> +			file->ptr = strbuf_detach(&buf, (size_t *) &file->size);
> +		else
> +			file->ptr = read_sha1_file(o->blob_sha1, &type,
> +						   (unsigned long *)(&(file->size)));
> +		strbuf_release(&buf);

I don't understand why there's a get_tree_entry call here. Don't we
already have the path and blob_sha1 fields? Is the mode actually
relevant (i.e., can we just fake it for the purposes of the
diff_filespec we will create)?

Even if we do need the get_tree_entry call, shouldn't it happen only if
we are allowing textconv, so non-textconv users don't pay for the call?

> @@ -2249,8 +2291,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	int cmd_is_annotate = !strcmp(argv[0], "annotate");
>  
>  	git_config(git_blame_config, NULL);
> +	git_config(git_diff_ui_config, NULL);

Like Junio, I am worried about the unintended consequences of
git_diff_ui_config. The userdiff drivers are parsed as part of
git_diff_basic_config, and you should use that.

Also, you are better to just add the call to git_blame_config (either
git_diff_basic_config, or looking directly to userdiff_config) instead
of calling git_config again, which will avoid parsing the config files
twice.

-Peff
