From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 8/8] git-gc --auto: run "repack -A -d -l" as necessary.
Date: Mon, 17 Sep 2007 22:59:26 -0400
Message-ID: <20070918025926.GI3099@spearce.org>
References: <11900186941912-git-send-email-gitster@pobox.com> <1190018716666-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 04:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXTJH-0003Xt-Kg
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 04:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbXIRC7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 22:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbXIRC7b
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 22:59:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42529 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbXIRC7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 22:59:30 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXTIx-00077R-ST; Mon, 17 Sep 2007 22:59:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A1F7120FBAE; Mon, 17 Sep 2007 22:59:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1190018716666-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58523>

Junio C Hamano <gitster@pobox.com> wrote:
> +static int too_many_packs(void)
> +{
> +	struct packed_git *p;
> +	int cnt;
> +
> +	if (gc_auto_pack_limit <= 0)
> +		return 0;
> +
> +	for (cnt = 0, p = packed_git; p; p = p->next) {
> +		char *suffix;
> +		int keep;
> +		if (!p->pack_local)
> +			continue;
> +		suffix = p->pack_name + strlen(p->pack_name) - 5;
> +		if (memcmp(suffix, ".pack", 6))
> +			continue;
> +		memcpy(suffix, ".keep", 6);
> +		keep = access(p->pack_name, F_OK) && (errno == ENOENT);
> +		memcpy(suffix, ".pack", 6);

*rubs eyes* Am I reading that right?  You are modifying pack_name
in the middle of this function?  WHY is pack_name not const char*?
*sigh*.  I'd NEVER consider doing that.  Not in a million years.
Because someday someone is going to make a change that's going to
break that somehow, like by jumping out of this loop early and not
fixing pack_name up first.

Yea, sure, there's no way today that this would fail.  But I like
to think that some poor sap is going to have to read my code after
I write it and that they should not be forced to deal with stuff
like this when such a time comes.

-- 
Shawn.
