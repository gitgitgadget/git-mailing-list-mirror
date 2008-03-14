From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] merge-recursive: handle file mode and links similarly
	to file content
Date: Fri, 14 Mar 2008 11:13:49 +0100
Message-ID: <20080314101349.GB23145@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <alpine.LSU.1.00.0803140039250.4174@racer.site> <20080314092105.GA18683@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 11:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja6wR-0006nK-Po
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbYCNKOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 06:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYCNKOK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:14:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:55067 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbYCNKOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:14:09 -0400
Received: by mu-out-0910.google.com with SMTP id i10so9467213mue.5
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=KsyoK3DLb+wHS/Ibr5kP8eCBCEY7EFfz1IVVupCk1Qs=;
        b=pICMgbmXU+DBj3b8oLOS6yg/Qflne+gXA5lFGQ1cF0zjt2lWeUsDG2Se5p1dpfZ7hiW0ocPsbKRu1SWkK+6e+df+deTSjeBFjr6DlDea3N9ctCpvVH19wypGIL6UbVqn4L83Y07deuiarulkWf6FKLaXkt1e8cJImNaXv5KQ57A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=wiVq5+0LP65EAAnO+raXjPmqQPGz80OJAwhVWBuE18zRVsCfJy5y0kYb+GPpk0e0Hyx0hkF1wfSnCpviAoPbonGY/2LmgXEv3NE7vey//6m1eMhPz/LYmYX+eijPs+1U9jZZsm7Ss4t6w/c4VFW5oxfd7BoNXGPb7YfggbcnprM=
Received: by 10.78.182.17 with SMTP id e17mr29979176huf.26.1205489647217;
        Fri, 14 Mar 2008 03:14:07 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.115.33])
        by mx.google.com with ESMTPS id c24sm8811886ika.10.2008.03.14.03.13.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 03:14:04 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja6v7-00065w-9y; Fri, 14 Mar 2008 11:13:49 +0100
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080314092105.GA18683@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77199>

On Fri, Mar 14, 2008 at 10:21:05AM +0100, Clemens Buchacher wrote:
> @@ -1051,14 +1066,11 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
>  
>  			free(result_buf.ptr);
>  			result.clean = (merge_status == 0);
> -		} else if (S_ISGITLINK(a->mode)) {
> +			result.merge = 1;
> +		} else if (S_ISGITLINK(a->mode) || S_ISLNK(a->mode)) {
> +			hashcpy(result.sha, b->sha1);
>  			result.clean = 0;
> -			hashcpy(result.sha, a->sha1);
> -		} else if (S_ISLNK(a->mode)) {
> -			hashcpy(result.sha, a->sha1);
> -
> -			if (!sha_eq(a->sha1, b->sha1))
> -				result.clean = 0;
> +			result.merge = 1;

To clarify: The above two cases don't need to be handled separately any
more, because equal sha1s are already handled above.

Clemens
