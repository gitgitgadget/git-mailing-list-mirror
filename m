From: Nicolas Pitre <nico@cam.org>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 07 Jun 2009 16:48:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906071637530.3906@xanadu.home>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
 <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
 <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:49:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDPIw-0003dB-DX
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbZFGUtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZFGUtN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:49:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59407 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbZFGUtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:49:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKV00362Z5CAP60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Jun 2009 16:48:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80906071155g5530ccdel286907b7c6022838@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121003>

On Sun, 7 Jun 2009, Nick Edelen wrote:

> how does this look?

Comments below.

> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> 
> ---
>  t/t5530-upload-pack-error.sh |    2 +-
>  upload-pack.c                |   50 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
> index f5102b9..26bcd1e 100755
> --- a/t/t5530-upload-pack-error.sh
> +++ b/t/t5530-upload-pack-error.sh
> @@ -51,7 +51,7 @@ test_expect_success 'fsck fails' '
>  test_expect_success 'upload-pack fails due to error in rev-list' '
> 
>  	! echo "0032want $(git rev-parse HEAD)
> -00000009done
> +0034shallow $(git rev-parse HEAD^)00000009done

Why did you modify this?

>  0000" | git upload-pack . > /dev/null 2> output.err &&
>  	grep "waitpid (async) failed" output.err
>  '
> diff --git a/upload-pack.c b/upload-pack.c
> index edc7861..c8f2dca 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -29,6 +29,7 @@ static unsigned long oldest_have;
>  static int multi_ack, nr_our_refs;
>  static int use_thin_pack, use_ofs_delta, use_include_tag;
>  static int no_progress;
> +static int shallow_nr;
>  static struct object_array have_obj;
>  static struct object_array want_obj;
>  static unsigned int timeout;
> @@ -107,8 +108,6 @@ static int do_rev_list(int fd, void *create_full_pack)
>  	struct rev_info revs;
> 
>  	pack_pipe = fdopen(fd, "w");
> -	if (create_full_pack)
> -		use_thin_pack = 0; /* no point doing it */
>  	init_revisions(&revs, NULL);
>  	revs.tag_objects = 1;
>  	revs.tree_objects = 1;
> @@ -155,13 +154,22 @@ static void create_pack_file(void)
>  	const char *argv[10];
>  	int arg = 0;
> 
> -	rev_list.proc = do_rev_list;
> -	/* .data is just a boolean: any non-NULL value will do */
> -	rev_list.data = create_full_pack ? &rev_list : NULL;

I'm glad you got rid of that.

> -	if (start_async(&rev_list))
> -		die("git upload-pack: unable to fork git-rev-list");
> +	if (shallow_nr) {
> +		rev_list.proc = do_rev_list;
> +		rev_list.data = 0;
> +		if (start_async(&rev_list))
> +			die("git upload-pack: unable to fork git-rev-list");
> +		argv[arg++] = "pack-objects";
> +	} else {
> +		argv[arg++] = "pack-objects";
> +		argv[arg++] = "--revs";
> +		argv[arg++] = "--include-tag";

Why this unconditional --include-tags here?  Isn't it handled already a 
couple lines down already?

> +		if (create_full_pack)
> +			argv[arg++] = "--all";
> +		if (use_thin_pack)
> +			argv[arg++] = "--thin";

Please turn this "if (use_thin_pack)" into an "else if (use_thin_pack)" 
instead.  No point using --thin for a full pack.

The rest looks fine to me.


Nicolas
