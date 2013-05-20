From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: log --cherry and merges (was [RFC/PATCH 0/2] merge-base: add
 --merge-child option)
Date: Sun, 19 May 2013 23:43:43 -0700
Message-ID: <20130520064343.GC2919@elie.Belkin>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
 <20130512162823.GK2299@serenity.lan>
 <20130512163317.GL2299@serenity.lan>
 <518FCDDE.9040707@bracey.fi>
 <7vwqr3u9c5.fsf@alter.siamese.dyndns.org>
 <5190F806.6040207@bracey.fi>
 <5190FC97.6020800@drmicha.warpmail.net>
 <20130519124059.GJ27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 20 08:43:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeJp3-0003DF-J4
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 08:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab3ETGnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 02:43:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40583 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3ETGns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 02:43:48 -0400
Received: by mail-pd0-f179.google.com with SMTP id q11so4681pdj.38
        for <git@vger.kernel.org>; Sun, 19 May 2013 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1AgUay4dyagTyMc0JQFJ4qhC1gk9lJWfD+za5EUqhjk=;
        b=p86eg7M2hx+OZkWEOHXywPG56DacM7uX2sdklIhskH9m6emdktw7dzSpafya2cgZS2
         8fg4IWX6VGWo0lwYUNsrlGhUcs/pxisY5UJdbfeaFVrYxNbwHe06vmUCe/qPkUfvU428
         t3yGAVA6uRpjt/qEI6/eJYbkksv1ea+n/DstImOz/1J5Z5PzpnGDQFiGkFJaDjfjn7A1
         NuP09Ao5b6foSo8tgTyyDE6kF8EYJPmyIRfasv8K5MgOCzW71ydYG61y/kKaGGTxWZPS
         knjQklB+ecpEDOCOcTOTUPxnT1HtlfQywYu0RfSVKZv3xRksF2DF6n2y6Rh5ZYtbFRd9
         pOGw==
X-Received: by 10.66.119.103 with SMTP id kt7mr8386625pab.125.1369032227996;
        Sun, 19 May 2013 23:43:47 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id do4sm22824824pbc.8.2013.05.19.23.43.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 23:43:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130519124059.GJ27005@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224941>

John Keeping wrote:

> The following patch makes the revision cherry machinery ignore merges
> unconditionally.  With it applied, there's not noticeable difference in
> speed between "git cherry" and "git log --cherry".
>
> -- >8 --
> diff --git a/revision.c b/revision.c
> index a67b615..19d0683 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -640,6 +640,11 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
>  
>  		if (flags & BOUNDARY)
>  			continue;
> +
> +		/* Patch ID is meaningless for merges. */
> +		if (commit->parents && commit->parents->next)
> +			continue;
> +

I guess merges should be skipped in the left-vs-right tally earlier,
too?

		if (flags & BOUNDARY)
			;
		else if (commit->parents && commit->parents->next)
			;
		else if (flags & SYMMETRIC_LEFT)
			left_count++;
		else
			right_count++;

With that tweak (or without it --- a sloppy count is fine), this
patch makes sense to me.  I guess some tests would be useful to
demonstrate that --cherry doesn't notice duplicate first-parent
diffs in merges.

Thanks,
Jonathan
