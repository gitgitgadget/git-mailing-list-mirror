From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 19 Apr 2012 10:09:14 -0700
Message-ID: <xmqqbomnsl6t.fsf@junio.mtv.corp.google.com>
References: <4F5F53CA.7090003@seap.minhap.es>
	<20120413205649.GC7919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 19:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKurC-000566-5B
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002Ab2DSRJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 13:09:17 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:34172 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab2DSRJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 13:09:16 -0400
Received: by eaaq10 with SMTP id q10so423573eaa.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NbMmR9b/HX5V+RviKwAWNtUPxXQv9qjGCE4Iz3mqYBE=;
        b=Y0QkSLIznRpbS0tBNMU2si3/TbrfPLHAcpZLyrQg5XYfxpvcdtttKFN8p+pZeB+EE8
         Sgu1QXhOcvyE7p01oVRrNsr3VKGt+KQPCd/uAcGuPYa6ADAEQKLe2bAlThQVsB5WD9i1
         4CbE3Mo4vAVWfQdu/3TJwXFku4+1y/QShtbzzKWdHiUpvl15XajBiJ0nwlkvlMjJmhEv
         XtBxtioUXTxm5cHzctYSdhCIp3VtO7QwOPnzdV+BtAHZqKSKDhr+/FwlPOuajkq6LNJT
         lJT2zIQZ3ARy8J6r4FfUu8y0ugsXGwFBVUv2oDsm/ZECMmbx+97f0+bQ6AE13vDiUFga
         lYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=NbMmR9b/HX5V+RviKwAWNtUPxXQv9qjGCE4Iz3mqYBE=;
        b=C0O8LBtucDH7N8t6NXmsn9boz2n0bVzYHM6At8FGRRj9M+OoVSFn9H8BMhRM3JrIuK
         5vwW1CrK2WsWaEU/yK4/l25KRKZGE3KmLkPavEfakxBLNQxMvjs21XtKHNnDHpTMrwig
         YIK2Bjc5LTif83F8OVx3EmIH+L6gbrfzqhQhw1+RRYbvZl7QdXhhE7L/oFpPeKd1R1Tb
         XpmlV1Xv8FZqQwemFlORFgBusKspSV14FjvHL1Jt9G0Ev/UMoxGi859pRBnhMZxqyDvz
         TTUXoK7VebNIH1SilW0iHDw4RDrGOP9eQzSrLIgpgnHMSiV3mq1j05Gkah7PY07gJPKC
         CzsA==
Received: by 10.213.21.8 with SMTP id h8mr272308ebb.11.1334855355182;
        Thu, 19 Apr 2012 10:09:15 -0700 (PDT)
Received: by 10.213.21.8 with SMTP id h8mr272293ebb.11.1334855355035;
        Thu, 19 Apr 2012 10:09:15 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si2675746eei.3.2012.04.19.10.09.15
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 10:09:15 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id D06AA20004E;
	Thu, 19 Apr 2012 10:09:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 2BA15E554F; Thu, 19 Apr 2012 10:09:14 -0700 (PDT)
In-Reply-To: <20120413205649.GC7919@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Apr 2012 16:56:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlfg09skViIGDfYlejEh3IUZGHpOoOJfREn4Q5AKaPK6xrr5iy8eH8qf5Htr5uoSX0FtZethzS/6L+lfN41YakxcsBPcMc6gY4C3/oogV6W/6nfzyyLoAXBcWog18deKJ+U7IbXKNbp5RRA6pwYBuFuFwqu2W7Jh6BGMTXDfIl5uFGzWwY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195953>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 13, 2012 at 03:03:54PM +0100, Nelson Benitez Leon wrote:
>
>> Also take care that CURLOPT_PROXY don't include username or
>> password, as we now set them in the new set_proxy_auth() function
>> where we use their specific cURL options.
>
> Did you test that this is necessary? We don't do it for the regular URL
> case, and it makes the code much simpler if we can avoid munging what we
> hand to curl.
>
>> +static void set_proxy_auth(CURL *result)
>> +{
>> +	if (proxy_auth.username && proxy_auth.password) {
>> +#if LIBCURL_VERSION_NUM >= 0x071901
>> +		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME, proxy_auth.username);
>> +		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD, proxy_auth.password);
>> +#else
>
> Is that version check right? You are giving a hexadecimal number, so
> 7.19.1 would be 071301.

I notice that I missed this comment, and I think the version queued in
'pu' still has this incorrect.  

CURLOPT_PROXYUSERNAME is marked as Introduced at 7.19.1 in

   https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions

so I agree that the above would need to be 0x071301.
