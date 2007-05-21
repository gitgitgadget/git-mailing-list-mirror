From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 02:20:05 -0400
Message-ID: <20070521062005.GK3141@spearce.org>
References: <20070520154227.GG5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 08:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq1Fp-0005W4-N4
	for gcvg-git@gmane.org; Mon, 21 May 2007 08:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbXEUGUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 02:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbXEUGUS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 02:20:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56744 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbXEUGUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 02:20:16 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hq1FX-0005Zv-SQ; Mon, 21 May 2007 02:20:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2BFF320FBAE; Mon, 21 May 2007 02:20:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070520154227.GG5412@admingilde.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47968>

> @@ -574,6 +575,21 @@ static void update_file_flags(const unsigned char *sha,
>  		void *buf;
>  		unsigned long size;
>  
> +		if (S_ISDIRLNK(mode)) {
> +			/* defer dirlinks to another process, don't try to */
> +			/* read the object "sha" here */
> +			const char *dirlink_checkout[] = {
> +				"dirlink-checkout", path, sha1_to_hex(sha), NULL
> +			};
> +			struct child_process cmd = {
> +				.argv = dirlink_checkout,
> +				.git_cmd = 1,
> +			};

My Solaris 9 system cannot compile this syntax, even though it is
a clean way to initalize the child_process.  That's why I've always
used something more like:

	struct child_process cmd;
	memset(&cmd, 0, sizeof(cmd));
	cmd.argv = dirlink_checkout;
	cmd.git_cmd = 1;

and actually that raises another point, does the compiler 0 fill
the stack-allocated struct that is initalized like you write, or
does it avoid filling the other fields that aren't mentioned in
the initialization?

> +	status = read(cmd.out, hex, sizeof(hex));
> +	if (status != 40) return status;

OK, this is probably just never trusting the OS, but shouldn't that
read be wrapped up in a loop, like our read_in_full?  We want 40
bytes here, and expect it, and the read call is allowed to return
as few as 1 byte....

-- 
Shawn.
