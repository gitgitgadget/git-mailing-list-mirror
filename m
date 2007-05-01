From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 8/8] git-repack --max-pack-size: add option parsing to enable feature
Date: Tue, 1 May 2007 01:45:28 -0400
Message-ID: <20070501054528.GC5942@spearce.org>
References: <46367ADC.2090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:45:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HilBA-0006hq-H5
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423800AbXEAFpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423801AbXEAFpd
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:45:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33064 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423800AbXEAFpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:45:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HilB3-0000w3-Fl; Tue, 01 May 2007 01:45:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3556A20FBAE; Tue,  1 May 2007 01:45:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46367ADC.2090704@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45918>

Dana How <danahow@gmail.com> wrote:
> Add --max-pack-size parsing and usage messages.
> Upgrade git-repack.sh to handle multiple packfile names.
...
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
...
> +		if (!prefixcmp(arg, "--max-pack-size=")) {
> +			char *end;
> +			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
> +			if (!arg[16] || *end)
> +				usage(pack_usage);
> +			no_reuse_delta = 1;

Wow, are you serious?  This entire change is about making repack
automatically split large projects into multiple packfiles.  If
that happens are you intending that the caller will mark all of
those packfiles with .keep files immediately after repacking them?
If you want users to create .keep files, can git-repack.sh do that
for them when more than one packfile was output?

Because otherwise a "quick" git-gc will not be quick because the
reuse delta feature (which is a massive performance improvement for
repack/gc) will always be disabled.  But odds are a future repack
of the same project will generally keep things that are in the
same packfile already in the same packfile again, so delta reuse is
actually possible for most objects.  I think you should find a way
to make this change work without needing to force no_reuse_delta
just because this limit was added.

> diff --git a/git-repack.sh b/git-repack.sh
...
> +names=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
>  	exit 1
> -if [ -z "$name" ]; then
> +if [ -z "$names" ]; then
>  	echo Nothing new to pack.
> -else
> +fi
> +for name in $names ; do

I think this particular change needs to either preceed the prior
commit, or be part of it.  If someone tries to bisect this patch
series with a large enough project that multiple packfiles are being
produced then you run into some ugly problems in this repack script.

-- 
Shawn.
