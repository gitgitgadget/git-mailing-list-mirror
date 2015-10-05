From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 05 Oct 2015 16:10:10 -0400
Organization: Twitter
Message-ID: <1444075810.5158.7.camel@twopensource.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
	 <1441073591-639-3-git-send-email-dturner@twopensource.com>
	 <5611E7B1.3090001@alum.mit.edu>
	 <xmqqd1wtz0w2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjC5y-0007tt-12
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbJEUKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:10:17 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35402 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbJEUKN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:10:13 -0400
Received: by qgt47 with SMTP id 47so160176357qgt.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rle1RyqzbkF70lQILd2/Z7nWlH7gYmgyMw6OoZ4BusM=;
        b=KRZFX8Herzj+DKXTjUUpWIPwf1nQhnL20LRNjWMO0iflWBv/4VcXyAT7NMRfwch+vC
         Sa94jIhWL7Ua5GNQlgmSAd3jMVN6VAWmrSEGJbGoGW5700xJqijtJmt7ZVKV5xymO3ex
         nYyf4lHKPYAtx6AEqz8Bb2pSzopRTZHfiirwOmhqxA01PoRAL9ehzSsnTi0J+PCsENsZ
         PTD1Gyafum3XZgJB/GxBrUee4oKUsRLzhAdhNDDViiM6cYlX7Q1MRWTcnSli3xqi/R8U
         jeaukcp0f6n/TqRZiIbQliBxKhIYvDBZ/SG7YsGomj8VAmHQJXq/3O1zRutwekOLsRgq
         RBpA==
X-Gm-Message-State: ALoCoQlpubSZkyd7tWndfySQ63z95R40yKzk1UnW5m+JiSDKDVLFq234eCOr/vyIgrAdTwh+lWty
X-Received: by 10.140.92.233 with SMTP id b96mr40603007qge.104.1444075812356;
        Mon, 05 Oct 2015 13:10:12 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 18sm12097061qgg.39.2015.10.05.13.10.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 13:10:11 -0700 (PDT)
In-Reply-To: <xmqqd1wtz0w2.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279073>

On Mon, 2015-10-05 at 10:22 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > For this particular application, where we only have 19 strings to store,
> > I suppose we could tolerate the use of approximately 64k of RAM to store
> > 174 characters worth of strings *if* it would bring us big time savings.
> > But I think we need some evidence of the time savings.
> >
> > If this lookup is really a bottleneck, I bet there are other
> > alternatives that are just as fast as this trie and use less code,
> > especially given that there are only 19 strings that need checking.
> 
> Very good point.  I agree that we need to know that the dumb linear
> scan in the original is on the bottleneck and that any replacement
> is an improvement.

Just did a tiny bit of microbenchmarking:

The trie code is indeed somewhat faster, but it's not the bottleneck in
the git_path family of functions.  The sprintf stuff takes way more
time.  Most callers don't need this functionality (an append would do).

But this is a benchmark of just git_path.  I don't happen to see any
cases where git_path is taking up an appreciable amount of runtime.

I only added this because Junio requested a speedup.  So I am perfectly
happy to drop this patch from the series.  
