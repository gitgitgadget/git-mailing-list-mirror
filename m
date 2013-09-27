From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] for-each-ref: introduce %(upstream:track[short])
Date: Fri, 27 Sep 2013 15:18:45 -0700
Message-ID: <20130927221845.GO9464@google.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com>
 <1380283828-25420-4-git-send-email-artagnon@gmail.com>
 <52459570.4030301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Sep 28 00:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPgNB-0005BF-M2
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 00:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab3I0WSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 18:18:50 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38751 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab3I0WSt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 18:18:49 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so3087576pbc.25
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w8Itx7ZdMXSIvvxbdR3M8WTlWvGXgZPJjIocMxWa4UY=;
        b=laJsKj6DKfL4FwnoS0vJq+UXDME9FTAtz1jffuIpPyqFUM5jCKu0I7I/5hyJtcK9z/
         hwjS8AKTi1a68g6AbokG7i40yQGx/QyUxrmY9z2e/P8Y4tzq92P4YiHUZiAD7dZoYoXX
         HO6V8n99TSWhi4cbPcPbY219uR4J+Emagq1iSH4BmRfU93jafcKfP2G5sP6rqz6WhpSW
         eWEEYs/8daxTJQpm3z0RQ5lZJWnTWYzxkqluUlc7phZxpqrkaq0BHXZKQJkjCIDTMDJX
         eJQIFDr5e1clX1t9TQJsaOJdzJC8h//nzAQGIxDfvSHr7xP6gKjxMuTfAOe4UNH9Ud3i
         s1sQ==
X-Received: by 10.68.228.230 with SMTP id sl6mr9846015pbc.98.1380320328905;
        Fri, 27 Sep 2013 15:18:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 7sm15053254paf.22.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 15:18:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52459570.4030301@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235477>

Johannes Sixt wrote:
> Am 9/27/2013 14:10, schrieb Ramkumar Ramachandra:

>> +					v->s = xstrdup(buf);
>> +				}
>
> These strdupped strings are leaked, right?

The convention seems to be that each refinfo owns its atom_value,
which owns its string that is kept on the heap.  Except when it isn't
(e.g., "v->s = typename(obj->type);").  So at least this patch doesn't
make the muddle any worse. ;-)

A nice followup would be to consistently allocate atom_value.s on the
heap, check for a GIT_FREE_AT_EXIT envvar, and free the refinfos
if that envvar is set at exit.  That would make sure that the code is
careful enough with memory to some day free some refinfo earlier when
there are many refs.  Until that's ready, I think continuing to mix
and match like this (constant strings left as is, dynamically
generated strings on the heap) is the best we can do.

Thanks,
Jonathan
