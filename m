From: Nicolas Pitre <nico@cam.org>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Fri, 05 Jun 2009 12:51:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: sam@vilain.net, Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcdX-0007R0-Sf
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbZFEQvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZFEQvN
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:51:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17243 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbZFEQvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:51:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKR00HBTYT8KLR0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 Jun 2009 12:51:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120808>

On Fri, 5 Jun 2009, sam@vilain.net wrote:

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

What's that?  Where did you get that?

The way to not generate a thin pack is to not specify --thin to 
pack-objects.  If you get a thin pack without specifying --thin then 
this is a bug that needs to be fixed first.

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

Shouldn't this be specified only if corresponding capability was 
provided by the client?


Nicolas
