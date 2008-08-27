From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] add a pre-merge hook
Date: Wed, 27 Aug 2008 22:05:45 +0200
Message-ID: <48B5B399.6090407@gnu.org>
References: <E1KW9NC-0003mM-6F@fencepost.gnu.org> <E1KYK3t-0000ZX-3b@fencepost.gnu.org> <7v63pmqqtx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRI6-0000kl-1F
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbYH0UFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYH0UFu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:05:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYH0UFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:05:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so57830fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=hBeR7oaxpFutAeicMxnqe/9/DPk3ZMRxRcLgh1CZPyw=;
        b=hV8IIDqLnb2H+GltteEnCYn3i+euXiDZdZwdcE3iRPOzzuGRTB17PWeTSjHLvPOHHn
         v2a+gHV9OxGEqLX4UT/LWwBo6jK0Mucz6cAEtHS+t0ytKJYGmQEsglc/kO2qsYK6GKZK
         ZyYWYBfLZy4oEWbW1lQ7l9ZE+VTbNTxBsU6TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=XuZjTr4sAqztPJn4+hRSD8w/YlLzQWrODBjuHzDZL3gr+FrnFGQRiG2Z+0KEm54Spt
         lxbggv3dsxsf8UTzntnhnoeviAF3tTw1JE+CL/k1+3+QI4/Yu2Jf7IqjYb8tACyzFT0f
         Q0dV8m9w2rAo4bUvhH+qodEMP/L7AZ+orgoJc=
Received: by 10.86.1.11 with SMTP id 11mr382328fga.27.1219867547537;
        Wed, 27 Aug 2008 13:05:47 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d4sm227396fga.5.2008.08.27.13.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 13:05:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7v63pmqqtx.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93937>


> I think we should have done something like this for post_merge, not just
> "1/0 to show if it is a squash" which was an ill-thought-out hack.  Is
> there a clean way to fix the interface without breaking existing
> post_merge hooks in people's repositories?

Well, you can add this argument as a second argument to post-merge.
Shall I do it?

> Please call whatever you install from template/hooks--* a "sample", not
> "default".

Ok.

> If it is primarily a hack to support calling post-merge with an non-object
> name "0" or "1"

It is to support not appending the commit list to the arguments of
post-merge.

>> +static int run_pre_merge_hook(const char *kind)
>> +{
>> +	return run_hook("pre-merge", remoteheads,
>> +			squash ? "squash" : kind, "--", NULL);
>>  }
> 
> remoteheads is a commit_list, you have the name of the hook and kind, so
> this extra "--" is only for run_hook() hackery to distinguish between the
> callers to post-merge and the callers to new pre-merge?

No, absolutely.  The "--" separator is for future extension, in case we
want to add other arguments before the head list.

run_hook does not care about what it receives in its varargs part.  It
is copied verbatim until the NULL.  Then it adds a "--" and the heads
argument if requested (which is not the case for post-merge).  The fact
that I had to specify a "--" here though is fishy.  Maybe I have a
off-by-one somewhere that, if fixed, can simplify the code somehow.

I'll take a look tomorrow, thanks for the review.

Paolo
