From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 10 Jun 2015 14:16:36 -0700
Message-ID: <xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2nMa-00018Q-JK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbbFJVQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:16:41 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:35408 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676AbbFJVQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:16:39 -0400
Received: by iery20 with SMTP id y20so1410878ier.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TzHpsNuJLcPXCmpMsBR6bxiaDK/fyLE72q2jHEQW2YE=;
        b=HTv55tOkRbFrQ5yUSOam/WAgVvQIXRzUOHb98x1wWooDX2Ao9cmS7rg5cMSHuO9+Q4
         +aHP1vWoFKq+MZNP0330Qc7jInPEEpvVcYW9+MFPQDiIvb3OYboThbieQQd287IAX9lF
         LenWVelZgB+A/71DeRolTiDowVzsOtupA6kZuyDGMu/mWh4rwDaub0miRKDyNAjs4Wh3
         sfl3XfY66QudXN4KUshyxCSsXRJYPLOdH4+akezE0+ILZIKYo2p8W+FtxRxKT++P/Jvk
         roGtx31Azg4JmuHaufeqXyqyJFnCrnFvW7WbV/Z+B2bZlKcPWGR3TMhVV2jEL34lCi3v
         jNNg==
X-Received: by 10.107.136.38 with SMTP id k38mr7007524iod.56.1433970998994;
        Wed, 10 Jun 2015 14:16:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id k16sm4018813igf.19.2015.06.10.14.16.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 14:16:37 -0700 (PDT)
In-Reply-To: <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 21:01:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271357>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> -USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
> +USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'

I think this patch makes the whole series go in the right direction.

I wonder if you can skip the "we only support new/old if you are not
doing bog-standard bad/good" step and start from this "bisect terms"
one, though.

Then you do not even have to treat new/old any specially, and do not
even have to list them in the above list.

> @@ -79,9 +81,16 @@ bisect_start() {
>  	orig_args=$(git rev-parse --sq-quote "$@")
>  	bad_seen=0
>  	eval=''
> -	# start_bad_good is used to detect if we did a 
> -	# 'git bisect start bad_rev good_rev'
> -	start_bad_good=0
> +	# terms_defined is used to detect if we did a
> +	# 'git bisect start bad_rev good_rev' or if the user
> +	# defined his own terms with git bisect terms
> +	terms_defined=0

I like this change very much; it removes the mysteriously misnamed
start-bad-good variable (because you do not really _care_ that
'start' was what implicitly decided that good/bad pair is the term
we use in this session; what you care is that the terms are already
known or not).

That is another reason why I think it would be a better organization
for the patch series to do without the intermediate "we now add new/old
as another hardcoded values on top of the traditional bad/good".

That is, I would think a reasonable progression of the series would
look more like these three steps:

 - preliminary clean-up steps (e.g. "correct 'mistook'");

 - use $name_new and $name_old throughout the code, giving them
   'bad' and 'good' as hardcoded values; finally

 - add 'bisect terms' support.

Thanks.
