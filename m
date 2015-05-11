From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/18] t1404: new tests of ref D/F conflicts within transactions
Date: Mon, 11 May 2015 12:37:22 -0700
Message-ID: <xmqqlhgu3nyl.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 21:37:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrtW5-0001s8-CS
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 21:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbbEKThZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 15:37:25 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37193 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbbEKThY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 15:37:24 -0400
Received: by igbsb11 with SMTP id sb11so81162929igb.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TrX7k8TWnh6cgR0ydKAGI4P47q+AAYdVFlIIXpuAJic=;
        b=0Lc/q7PfViMUAE2el/QGEKnUj7fA7nDsdrSKhUguTsDqMSYMJqnQe4GZAl4o1uhmdB
         XD2RVwXcL2RgB8m3agBJNdSxf6kDObNCrprgIBEOyRR7nRGGXoMksO/2+uthTWDFsOHH
         XUeW897ycOJ+SQwctbJmbGlFiCxbX++avFLjdotBgiUBlDtcmiBdzFEeJ7n0z47IFlQG
         Qt5PIkxv/gkl6qfIBJ/3CfbQO9JQ8EgA0iLSL/eQU0rbyLJRNJSKcmQHpk0juposODEw
         O4vXJWfE3Lsvsc7d5AI0SeeaXfyZZQGt0NlJtatBIWrLPsakZvv/Ani1c71G/B+xzo4M
         Znmg==
X-Received: by 10.43.40.130 with SMTP id tq2mr12829344icb.46.1431373043728;
        Mon, 11 May 2015 12:37:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id e69sm10343633ioe.11.2015.05.11.12.37.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 12:37:23 -0700 (PDT)
In-Reply-To: <1431357920-25090-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268818>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> +test_update_rejected () {
> +	prefix="$1" &&
> +	before="$2" &&
> +	pack="$3" &&
> +	create="$4" &&
> +	error="$5" &&
> +	printf "create $prefix/%s $C\n" $before |
> +	git update-ref --stdin &&
> +	git for-each-ref $prefix >unchanged &&
> +	if $pack
> +	then
> +		git pack-refs --all
> +	fi &&
> +	printf "create $prefix/%s $C\n" $create >input &&
> +	test_must_fail git update-ref --stdin <input 2>output.err &&
> +	grep -F "$error" output.err &&

I am not 100% confident that "grep -F" is the right thing to use
here.  I checked all the error message these tests are expecting and
none seems to go through _(), but is it fundamental that these
errors should not be translated?
