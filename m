From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:42:50 -0700
Message-ID: <20150828184250.GD8165@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOc5-0007LB-S9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbbH1Smy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:42:54 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33619 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbH1Smx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:42:53 -0400
Received: by padfo6 with SMTP id fo6so32340377pad.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NQc5UxeVYwMKGIy7QekrdtrB8gv8/pheOmXUQZIokgE=;
        b=UdSthcpoB0q1ci8lnkeRvYajS+VGB9D87TLcvqhVeHgxcpmjFYuVO5Rw0ZLhYYpiQF
         WrT+kJJAUzt0gwqK6Fab3V1IID+Kypwqq2Kz21jfHu0iON0K8rk0Q+EggUyLYveYH/sE
         gQilf7PB6SoeDmhbK5qEyOYVOeqW26iZiB71/Fc91cddyRfjLzSKmEDPXKKsy+k/ktuQ
         Qp1J4oc9IcMe/21qH1ZPXk4XVB+tfSAs/mrDODa5xUP87X5Iv02XZMWgpQL0FI7Y2QR9
         F8ExbQyiSSOkMW8pbC6LvV34ATZMsBkYA26H6MNMPOxShKrMtTcIsmP47R3LZfDLuW94
         0CPA==
X-Received: by 10.66.253.170 with SMTP id ab10mr17538600pad.135.1440787372451;
        Fri, 28 Aug 2015 11:42:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id hg3sm6476824pbb.52.2015.08.28.11.42.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Aug 2015 11:42:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276751>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  remote: Finding sources:  11% (18/155)           \r
>>  remote: Finding sources:  12% (19/155)           \r
>>
>> With multiple commands producing such output, they will overwrite each
>> other's lines, producing a mixture that is confusing and unuseful.
>
> That example also illustrates why it is not a useful to buffer all
> of these lines and showing them once.

I don't completely follow.  Are you referring to the wasted memory to
store the line that is going to be written and rewritten or some other
aspect?

Today (without parallelism), if I clone a repository with multiple
submodules and walk away from the terminal, then when I get back I see

	Cloning into 'plugins/cookbook-plugin'...
	remote: Counting objects: 36, done
	remote: Finding sources: 100% (36/36)
	remote: Total 1192 (delta 196), reused 1192 (delta 196)
	Receiving objects: 100% (1192/1192), 239.46 KiB | 0 bytes/s, done.
	Resolving deltas: 100% (196/196), done.
	Checking connectivity... done.
	Submodule path 'plugins/cookbook-plugin': checked out 'b9d3ca8a65030071e28be19296ba867ab424fbbf'
	Cloning into 'plugins/download-commands'...
	remote: Counting objects: 37, done
	remote: Finding sources: 100% (37/37)
	remote: Total 448 (delta 46), reused 448 (delta 46)
	Receiving objects: 100% (448/448), 96.13 KiB | 0 bytes/s, done.
	Resolving deltas: 100% (46/46), done.
	Checking connectivity... done.
	Submodule path 'plugins/download-commands': checked out '99e61fb06a4505a9558c23a56213cb32ceaa9cca'
	...

The output for each submodule is in one chunk and I can understand what
happened in each.

By contrast, with inter-mixing the speed of output tells you something
about whether the process is stalled while you stare at the screen and
wait for it to finish (good) but the result on the screen is
unintelligible when the process finishes (bad).

Showing interactive output for one task still provides the real-time
feedback about whether it is completely stuck and needs to be cancelled.
It is easier to make sense of even from the point of view of real-time
progress than the intermixed output.

What problem is the intermixed output meant to solve?

In other words, what is your objection about?  Perhaps there is a way to
both satisfy that objection and to have output clumped per task, but it
is hard to know without knowing what the objection is.

Hope that helps,
Jonathan
