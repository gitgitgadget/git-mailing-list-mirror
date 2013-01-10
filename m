From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Wed, 9 Jan 2013 16:18:44 -0800
Message-ID: <20130110001844.GC21054@google.com>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5rS-0001oX-H4
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 01:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab3AJASu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 19:18:50 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38481 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3AJASt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 19:18:49 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so1273680pbc.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 16:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aC2sxDC6mPTLLVafNGr1BXXE+9gcsQuj/X8S+WwA78c=;
        b=mIU0jH8r0aTQ1AGO3+HmH9exeyw0CwbC4w8grLPWm1tzV+KPbNXcSA1bDaABmLO7J2
         FYa8H9D1XNGqVZlOLcrtWhhtvcH5ZLEYigucEgEAymc4FozLQlKvvEuomwYzS+1Ug6LJ
         gSlTpIiL2/FTe57OoRyIXNtTA5cF54/h9SML+7BIAe+Bv7YdXKDKteMlZAyNgY2eUZHs
         D49K236cIJMhpP/otzmrA9BdhmFjKXbNCnOd5ndkRNd1SKebBRn7yD+QDiIeYAXUkBe1
         YXb62M1G5glOZHj9AhqogJAMq3+CzkdyHSwq8EH5y6bzT+/0Geb9AFGAi2betPtKXAR2
         elpg==
X-Received: by 10.66.88.164 with SMTP id bh4mr52375803pab.41.1357777129076;
        Wed, 09 Jan 2013 16:18:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ug6sm42470614pbc.4.2013.01.09.16.18.46
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 16:18:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213115>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

>> But we still say "error: ... died of signal 13", because that comes from
>> inside wait_or_whine. So it is a separate issue whether or not
>> wait_or_whine should be silent on SIGPIPE (we already are on SIGINT and
>> SIGQUIT, as of some recent patches).
>>
>> The upside is that it is noise in this case that we would no longer see.
>> The downside is that we may be losing a clue when debugging server
>> problems, which do not expect to die from SIGPIPE.  Should it be an
>> optional run-command flag?
>
> Do we know if we are upstream of a pager that reads from us through
> a pipe (I think we should, especially in a case where we are the one
> who processed the "git -p $alias" option)?  Is there any other case
> where we would want to ignore child's death by SIGPIPE?

When we die early by SIGPIPE because output was piped to "head", I
still think the early end of output is not notable enough to complain
about.

I'm not sure whether there are SIGPIPE instances we really don't want
to be silent about, though.  I suspect not. ;-)

Compare <http://thread.gmane.org/gmane.comp.version-control.git/2062>,
<http://thread.gmane.org/gmane.comp.version-control.git/48469/focus=48665>.

Thanks,
Jonathan
