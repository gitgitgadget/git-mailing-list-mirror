From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] fast-import: Let importers retrieve blobs
Date: Mon, 18 Oct 2010 03:26:12 -0500
Message-ID: <20101018082612.GB3979@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 10:30:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7l6Y-0000Ly-GX
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 10:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab0JRI3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 04:29:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47103 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab0JRI3u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 04:29:50 -0400
Received: by gwaa18 with SMTP id a18so213875gwa.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lVtzTeZeaCA6godS0DrvpipX54DVUuYY5dgNN+6lQv4=;
        b=SiXgqhHs+KldT93oxzf+el/P5/967VNY+S8y9ydiNLpWXqF+m1Lfjp/BlBraXGeULJ
         OppQz1EwYXfQaDWMK9TMuH9OXTtkazuWvj9iJnoB2Yl71TZqsATaPfOO069L8BewYHJN
         29nuHPMy4Ny/AtMk/SPZZonAstnTM0z0yhxvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kkCCK69brh+3I8U5bZVZwH9BMmt+WWzeAsFgt+4gcJSA6eFlXHvFx1w/A9gCkxvS0e
         QmHDob7ohb6k4Ycf5VgeE/dH5nQPiZ3Lb8bP21myJLDPQoOF0mRZNlmvD8QBXHJteCdy
         H03SiJmTGZbL2M7kaPOW4NV4QuHLuYPOuaMlw=
Received: by 10.236.103.165 with SMTP id f25mr7616938yhg.90.1287390588144;
        Mon, 18 Oct 2010 01:29:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r25sm6235071yhc.0.2010.10.18.01.29.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 01:29:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159237>

(+cc: Sam)

Hi,

David Barr wrote:

> So introduce another way: a "cat-blob" command introduced in the
> command stream requests for fast-import to print a blob to stdout
> or a file descriptor specified by the argument --cat-blob-fd.

Yes, please!

> Cc: Shawn O. Pearce <spearce@spearce.org>
> Cc: Ramkumar Ramachandra <artagnon@gmail.com>

It turns out these Cc tags are not supposed to be used except in
some very weird circumstances.  See [1] if curious.

[...]
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -92,6 +92,17 @@ OPTIONS
>  	--(no-)-relative-marks= with the --(import|export)-marks=
>  	options.
>  
> +--cat-blob-fd=<fd>::
> +	Specify the file descriptor that will be written to
> +	when the `cat-blob` command is encountered in the stream.
> +	The default behaviour is to write to `stdout`.

Sounds good.

> ++
> +The described objects are not necessarily accessible
> +using standard git plumbing tools until a little while
> +after the next checkpoint.  To request access to the
> +blobs before then, use `cat-blob` lines in the command
> +stream.

This is stale explanation from --report-fd, I think, to explain
why the commit ids it printed were not very useful.  It would
be possible to reword it to describe cat-blob-fd but since the
frontend does not have easy access to blob names as it is, I
think cat-blob motivates itself on its own.

[...]
> @@ -876,6 +892,23 @@ Placing a `progress` command immediately after a `checkpoint` will
>  inform the reader when the `checkpoint` has been completed and it
>  can safely access the refs that fast-import updated.
>  
> +`cat-blob`
> +~~~~~

   ~~~~~~~~~~

> @@ -896,6 +929,7 @@ The following features are currently supported:
>  * date-format
>  * import-marks
>  * export-marks
> +* cat-blob

The explanation says (paraphrased) "Features work identically to their
option counterparts, with the exception of import-marks as described
below".

Maybe ought to be reworded?

 date-format::
 export-marks::
 relative-marks::
 no-relative-marks::
 force::
	See the corresponding command-line option.

 import-marks::
	Like --import-marks, except in two respects.  First, only one
	"feature import-marks" command is allowed per stream.  Second,
	an --import-marks= specified on the command line will override it.

 cat-blob::
	No-op to check that the importer supports the cat-blob command.

By the way, it might be nice to make cat-blob not just check the importer
but the environment in which it was invoked, like this:

	exporter says:
		feature this
		feature that
		feature cat-blob
		feature another
		...

	importer says:
		feature cat-blob

That is, after writing "feature cat-blob\n", an exporter could tell if
the backchannel was set up correctly by reading for "feature cat-blob\n"
from the importer.

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2680,6 +2685,77 @@ static void parse_reset_branch(void)
>  		unread_command_buf = 1;
>  }
>  
> +static void cat_blob_write(const char *buf, unsigned long size)
> +{
> +	if (write_in_full(cat_blob_fd, buf, size) != size)
> +		die_errno("Write to frontend failed");
> +}

An odd operation, since if the pipe_buf gets filled then it blocks
until the exporter finds time to read.  Maybe in some future version
this would write to a private ring buffer and there would be an
event loop or seperate thread to flush it out when the exporter is
ready.

Upshot: I am happy with this as a separate function.

[...]
> @@ -2808,6 +2892,8 @@ static int parse_one_feature(const char *feature, int from_stream)
>  		option_import_marks(feature + 13, from_stream);
>  	} else if (!prefixcmp(feature, "export-marks=")) {
>  		option_export_marks(feature + 13);
> +	} else if (!prefixcmp(feature, "cat-blob")) {
> +		/* Don't die - this feature is supported */

Maybe if (!strcmp(...?

[...]
> @@ -2896,6 +2982,10 @@ static void parse_argv(void)
>  		if (*a != '-' || !strcmp(a, "--"))
>  			break;
>  
> +		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
> +			option_cat_blob_fd(a + 2 + 12);
> +		}
> +
>  		if (parse_one_option(a + 2))
>  			continue;

Probably worth mentioning in the manual, under the option command:

  The following command-line option describes the environment
  in which fast-import was executed and may not be passed to
  'option':

   * cat-blob-fd

> @@ -2953,6 +3043,8 @@ int main(int argc, const char **argv)
>  			parse_new_tag();
>  		else if (!prefixcmp(command_buf.buf, "reset "))
>  			parse_reset_branch();
> +		else if (!prefixcmp(command_buf.buf, "cat-blob "))
> +			parse_cat_blob();

Thanks.  That was simple. :)

Tests?

[1] http://thread.gmane.org/gmane.comp.version-control.git/157711
