From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/8] git-repack --max-pack-size: split packs as asked by write_object/write_one
Date: Tue, 1 May 2007 01:40:34 -0400
Message-ID: <20070501054034.GB5942@spearce.org>
References: <46367AA1.8080009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hil6S-0005Py-Vs
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423778AbXEAFkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbXEAFkl
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:40:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33013 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423778AbXEAFkk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:40:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hil6K-0000ca-Ph; Tue, 01 May 2007 01:40:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 46C3B20FBAE; Tue,  1 May 2007 01:40:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46367AA1.8080009@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45916>

Dana How <danahow@gmail.com> wrote:
> Rewrite write_pack_file() to break to a new packfile
> whenever write_object/write_one request it,  and
> correct the header's object count in the previous packfile.
> Change write_index_file() to write an index
> for just the objects in the most recent packfile.
...
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
...
> @@ -672,74 +673,94 @@ static int adjust_perm(const char *path, mode_t mode);
...
> +		hdr.hdr_signature = htonl(PACK_SIGNATURE);
> +		hdr.hdr_version = htonl(PACK_VERSION);
> +		hdr.hdr_entries = htonl(nr_result);

What about keeping track of how many objects in nr_result that
have been written already in the prior iteration of this do{}
while loop and using that to set hdr_entries?  This way if you are
splitting into multiple packfiles the last packfile won't need to
do a header/footer fixup.

-- 
Shawn.
