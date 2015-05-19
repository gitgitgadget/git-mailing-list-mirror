From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Tue, 19 May 2015 15:00:44 -0700
Message-ID: <xmqqzj505isz.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
	<1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
	<1432068269-14895-2-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupZD-0006Wt-Mk
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbbESWAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:00:47 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35569 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbbESWAq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:00:46 -0400
Received: by iesa3 with SMTP id a3so25237544ies.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1vf/+lBrIuA3woDldIrQqoiWJkZVNCF8fIR/IMKZvCY=;
        b=xBNd7BMyGpH6DGPG/YFWKKsOTRYnwjpjwImrmxB/5B5BZ8GS0SHGxjndS1vdIL3q7z
         QLtBs5LVB4pl7k5qPjT+t9kGHCwKAmlkhi2AmfPIGxcpmvzfhWLM4O7tTScNNoZDKRSq
         x0hzO27jftB4totaYQ+JUA93LsedlJg47LpYAXnvJpz1KSC5v3kIAb8agYPZbaTmH7cu
         qNscLyvEtfzKBMhL4K6nMH3/kpZqIyzfh93WMzGgr6NkbwbCbMl3RfIGi4ji0wEDr63i
         Ebb79o5IKbSC2it08+WEMyrZ4PpkzLfRf+XV5i/8BmV/Ie9Lhx0PJbSpZ82AEWarWXOm
         KneA==
X-Received: by 10.43.63.76 with SMTP id xd12mr43880243icb.11.1432072845823;
        Tue, 19 May 2015 15:00:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id h128sm10899330ioh.38.2015.05.19.15.00.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 15:00:45 -0700 (PDT)
In-Reply-To: <1432068269-14895-2-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Tue, 19 May 2015 22:44:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269413>

Fredrik Medley <fredrik.medley@gmail.com> writes:

>  static int upload_pack_config(const char *var, const char *value, void *unused)
>  {
> -	if (!strcmp("uploadpack.allowtipsha1inwant", var))
> -		allow_tip_sha1_in_want = git_config_bool(var, value);
> -	else if (!strcmp("uploadpack.keepalive", var)) {
> +	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
> +		if (git_config_bool(var, value))
> +			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;

Doesn't this change break the behaviour?

Shouldn't you be able to say

	[uploadpack]
        	allowTipSHA1InWant = false

in a higher-precedence configuration file to override the same
variable in other files in the configuration chain that may set it
to true?

> +	} else if (!strcmp("uploadpack.keepalive", var)) {
>  		keepalive = git_config_int(var, value);
>  		if (!keepalive)
>  			keepalive = -1;
