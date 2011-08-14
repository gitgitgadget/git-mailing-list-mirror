From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] revert: Allow mixed pick and revert instructions
Date: Sun, 14 Aug 2011 07:12:44 -0500
Message-ID: <20110814121244.GD18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 14:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsZYm-0004gC-RF
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 14:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab1HNMMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 08:12:52 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:41471 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1HNMMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 08:12:51 -0400
Received: by iye16 with SMTP id 16so5404260iye.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 05:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yb7KamFNifGRD0UjigYRosIBk0/UPP7s46P5JC/ypBQ=;
        b=qGOnn5egkNucveSPo8zHAIiK9ZFvQ/hkwiDVk/BI9AhnVEZNZE7cQ/FNn2Fx2rGA+X
         UaO+3gH+mhX3MGJ5wG6xgLoDsJvKwlIWFYGSb7GkcnjbD1uGy7leP8TRjDoZl9fOI2j+
         kEqjEchO2s/JvikKE84NKUK1RuIWYKJFe0X/s=
Received: by 10.231.54.104 with SMTP id p40mr5833961ibg.39.1313323971440;
        Sun, 14 Aug 2011 05:12:51 -0700 (PDT)
Received: from elie.gateway.2wire.net ([68.255.106.30])
        by mx.google.com with ESMTPS id fu7sm3224788ibb.2.2011.08.14.05.12.50
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 05:12:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179321>

Ramkumar Ramachandra wrote:

>  	if (!prefixcmp(start, "pick ")) {
> -		action = CHERRY_PICK;
> +		item->action = REPLAY_PICK;
>  		p += strlen("pick ");
>  	} else if (!prefixcmp(start, "revert ")) {
> -		action = REVERT;
> +		item->action = REPLAY_REVERT;
>  		p += strlen("revert ");
> -	} else
> -		return NULL;
> +	} else {
> +		int len = strchrnul(p, '\n') - p;
> +		if (len > 255)
> +			len = 255;
> +		return error(_("Unrecognized action: %.*s"), len, p);

What happens if the current line has more than INT_MAX characters?

Maybe it would make sense to factor out a function for this
computation, for brevity and so there is just one place to tweak.
