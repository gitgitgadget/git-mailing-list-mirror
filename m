From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 13:21:48 +0200
Message-ID: <517911CC.2060902@drmicha.warpmail.net>
References: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net> <51790C9D.8080901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 25 13:21:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKFK-00036F-3c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab3DYLVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:21:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48035 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756038Ab3DYLVp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 07:21:45 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EE63C20B48;
	Thu, 25 Apr 2013 07:21:44 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 25 Apr 2013 07:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=56U/ocTBhEbVd3ynVR+6qs
	BJyHw=; b=ZNRt5JBwZG8SAF+2Gvp87EJtQ6Ghy7i2PQHLJaiLV4eqziVj5CxzH0
	oRpIq/c0bqUKNoLyTBR7A+5Sp8uVWyItf8KF3IZZ5AVTnLYCcYPqjWBIHJEXm9wf
	Ifc2GjX32i4JjXxUR/p9lzIfClZBxpBeOSzPA7DZq5rZEx8cObAs4=
X-Sasl-enc: pvHfXHhneJoPMpc+ebASsLtRhSB8WGVOk82Gz3n3rDmw 1366888904
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D1E52001A6;
	Thu, 25 Apr 2013 07:21:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <51790C9D.8080901@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222367>

Johannes Sixt venit, vidit, dixit 25.04.2013 12:59:
> Am 4/25/2013 12:09, schrieb Michael J Gruber:
>> fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
>> test which was meant to skip the test unless the test shell is bash.
>> Unfortunately, it tests for the availability of bash only. But users can
>> opt to use a different shell (using SHELL_PATH) for the tests even though
>> bash is available.
> 
> After my patch this morning ("avoid process substitution"), there is not
> much bashism left in git-remote-testgit:

Is that a patch you submitted?

> diff --git a/git-remote-testgit b/git-remote-testgit
> index e99d5fa..178d030 100755
> --- a/git-remote-testgit
> +++ b/git-remote-testgit
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env bash
> +#!/bin/sh
>  # Copyright (c) 2012 Felipe Contreras
>  
>  alias=$1
> @@ -23,7 +23,6 @@ then
>  	testgitmarks="$dir/testgit.marks"
>  	test -e "$gitmarks" || >"$gitmarks"
>  	test -e "$testgitmarks" || >"$testgitmarks"
> -	testgitmarks_args=( "--"{import,export}"-marks=$testgitmarks" )
>  fi
>  
>  while read line
> @@ -70,7 +69,10 @@ do
>  		fi
>  
>  		echo "feature done"
> -		git fast-export "${testgitmarks_args[@]}" $refs |
> +		git fast-export \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			$refs |
>  		sed -e "s#refs/heads/#${prefix}/heads/#g"
>  		echo "done"
>  		;;
> @@ -89,7 +91,10 @@ do
>  
>  		before=$(git for-each-ref --format='%(refname) %(objectname)')
>  
> -		git fast-import "${testgitmarks_args[@]}" --quiet
> +		git fast-import \
> +			${testgitmarks:+"--import-marks=$testgitmarks"} \
> +			${testgitmarks:+"--export-marks=$testgitmarks"} \
> +			--quiet
>  
>  		# figure out which refs were updated
>  		git for-each-ref --format='%(refname) %(objectname)' |
> 
> What's left is to take care of the shbang line, remove the bash
> check from t5801, make a proper commit from this patch. But I leave
> that to the interested reader. :-)
> 

No, the problem (that I'm adressing) is not git-remote-testgit which
uses bash unconditionally, independent of SHELL_PATH.

The problem is bashism(s) in t5801 itself. That is completely orthogonal
to your (non-) patch.

Michael
