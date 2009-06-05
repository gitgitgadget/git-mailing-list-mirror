From: Sam Vilain <sam@vilain.net>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Fri, 05 Jun 2009 17:46:16 +1200
Message-ID: <4A28B128.6040709@vilain.net>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 07:46:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSG8-0001tN-Cy
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 07:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbZFEFqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 01:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbZFEFqW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 01:46:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57290 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbZFEFqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 01:46:21 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 53AC521C3F4; Fri,  5 Jun 2009 17:46:23 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 9AEC421C3EA;
	Fri,  5 Jun 2009 17:46:16 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120749>

Sorry, stuffed up the headers on this one, too - that should have been
me in the "From:" of the e-mail, but it is Nick's work...

Sam.

Nick Edelen wrote:
> instead of using the internal revision walker and piping object refs
> to pack-objects this patch passes only the revs to pack-objects, which
> in turn handles both enumeration and packing.
>
> Signed-off-by: Sam Vilain <sam@vilain.net>
> ---
>   Submitted on behalf of Nick in order to get wider feedback on this.
>   This version passes the test suite.
>
>  upload-pack.c |   54 +++++++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 45 insertions(+), 9 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index edc7861..7eda8fd 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -155,13 +155,27 @@ static void create_pack_file(void)
>  	const char *argv[10];
>  	int arg = 0;
>  
> -	rev_list.proc = do_rev_list;
> -	/* .data is just a boolean: any non-NULL value will do */
> -	rev_list.data = create_full_pack ? &rev_list : NULL;
> -	if (start_async(&rev_list))
> -		die("git upload-pack: unable to fork git-rev-list");
> -
> -	argv[arg++] = "pack-objects";
> +	/* sending rev params to pack-objects directly is great, but unfortunately pack-objects 
> +	 * has no way of turning off thin pack generation.  this would be a relatively simple 
> +	 * addition, but as we also have to deal with shallow grafts and all it's simplest to 
> +	 * just resort to piping object refs.
> +	 */
> +	if (!use_thin_pack) {
> +		rev_list.proc = do_rev_list;
> +		/* .data is just a boolean: any non-NULL value will do */
> +		rev_list.data = create_full_pack ? &rev_list : NULL;
> +		if (start_async(&rev_list))
> +			die("git upload-pack: unable to fork git-rev-list");
> +		
> +		argv[arg++] = "pack-objects";
> +	} else {
> +		argv[arg++] = "pack-objects";
> +		argv[arg++] = "--revs";
> +		argv[arg++] = "--include-tag";
> +		if (create_full_pack)
> +			argv[arg++] = "--all";
> +	}
> +	
>  	argv[arg++] = "--stdout";
>  	if (!no_progress)
>  		argv[arg++] = "--progress";
> @@ -172,7 +186,7 @@ static void create_pack_file(void)
>  	argv[arg++] = NULL;
>  
>  	memset(&pack_objects, 0, sizeof(pack_objects));
> -	pack_objects.in = rev_list.out;	/* start_command closes it */
> +	pack_objects.in = !use_thin_pack ? rev_list.out : -1;
>  	pack_objects.out = -1;
>  	pack_objects.err = -1;
>  	pack_objects.git_cmd = 1;
> @@ -181,6 +195,28 @@ static void create_pack_file(void)
>  	if (start_command(&pack_objects))
>  		die("git upload-pack: unable to fork git-pack-objects");
>  
> +	/* pass on revisions we (don't) want 
> +	 * (do we need to check the validity of pack_objects.in?)
> +	 */
> +	if (use_thin_pack) {
> +		FILE *pipe_fd = fdopen(pack_objects.in, "w");
> +		if (!create_full_pack) {
> +			int i;
> +			for (i = 0; i < want_obj.nr; i++) {
> +				fprintf(pipe_fd, "%s\n", sha1_to_hex(want_obj.objects[i].item->sha1));
> +			}
> +			fprintf(pipe_fd, "--not\n");
> +			for (i = 0; i < have_obj.nr; i++) {
> +				fprintf(pipe_fd, "%s\n", sha1_to_hex(have_obj.objects[i].item->sha1));
> +			}
> +		}
> +		
> +		fprintf(pipe_fd, "\n");
> +		fflush(pipe_fd);
> +		fclose(pipe_fd);
> +	}
> +
> +
>  	/* We read from pack_objects.err to capture stderr output for
>  	 * progress bar, and pack_objects.out to capture the pack data.
>  	 */
> @@ -276,7 +312,7 @@ static void create_pack_file(void)
>  		error("git upload-pack: git-pack-objects died with error.");
>  		goto fail;
>  	}
> -	if (finish_async(&rev_list))
> +	if (!use_thin_pack && finish_async(&rev_list))
>  		goto fail;	/* error was already reported */
>  
>  	/* flush the data */
>   
