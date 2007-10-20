From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 09/14] Use the asyncronous function infrastructure in builtin-fetch-pack.c.
Date: Fri, 19 Oct 2007 22:53:52 -0400
Message-ID: <20071020025352.GA6569@spearce.org>
References: <1192823286-9654-1-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-2-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-3-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-4-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-5-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-6-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-7-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-8-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-9-git-send-email-johannes.sixt@telecom.at> <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Oct 20 04:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij4TY-00013c-Qt
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 04:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbXJTCx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 22:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbXJTCx5
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 22:53:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41459 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbXJTCx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 22:53:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij4T8-0002lt-AD; Fri, 19 Oct 2007 22:53:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F366420FBAE; Fri, 19 Oct 2007 22:53:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192823286-9654-10-git-send-email-johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61777>

I've gone through this entire series and am quite happy with it.
Except one bug in this particular patch.

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> We run the sideband demultiplexer in an asynchronous function.
...
> diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
> index 871b704..51d8a32 100644
> --- a/builtin-fetch-pack.c
> +++ b/builtin-fetch-pack.c
> @@ -457,42 +457,37 @@ static int everything_local(struct ref **refs, int nr_match, char **match)
>  	return retval;
>  }
>  
> -static pid_t setup_sideband(int fd[2], int xd[2])
> +static int sideband_demux(int fd, void *data)
>  {
> -	pid_t side_pid;
> +	int *xd = data;
>  
> +	close(xd[1]);

If this is a threaded start_async() system this close is going
to impact the caller.

>  	close(xd[0]);
> -	close(fd[1]);
> +	fd[0] = demux->out;
>  	fd[1] = xd[1];

Which is relying on xd[1] right here in the caller.  Therefore you
cannot actually use this code with a start_async() implementation
that isn't fork() based.  Isn't that going to cause you trouble in
the msysGit tree?

-- 
Shawn.
