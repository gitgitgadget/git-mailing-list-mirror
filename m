From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Mon, 23 Sep 2013 14:37:29 -0700
Message-ID: <20130923213729.GE9464@google.com>
References: <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
 <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 23:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODp7-0005hm-4p
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab3IWVhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:37:35 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42161 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434Ab3IWVhe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:37:34 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so3730317pdj.22
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PepJCaPSzTl6+e32lBoUgVntO7UV5FhTsuZT+yVJUZI=;
        b=GbKJXX1ILkrDs8CAtZoX0uGSlKS7vU13Qd4ur2NQwNkgsZIhBU21pJ4ij6qeW3TzKz
         dZuHvOZwtIOkPw/CTwpGovVgOxeW/ZAQ/DLNNi0tJC2HzdMoheLR664mhPDdW00w12M9
         /cT3y3A17mvZwOX52HRJb3eSjljmLGp1sTbOqRRRhz8o6ZERZaZzCUtwucAa4WHv+cmY
         EFrLTzo0H4HPghqIekeo74gmk9oQOHtWtYSjtnGaElORSdy8W7WyJISv+8ekm3gduczC
         WGU3ZH4Wdqh+eoQN9ZuHqBTIP128CwKUAeAARIu6VDC47TYIHqm1Cv7q6AzucBA2FUK7
         ywYg==
X-Received: by 10.68.244.168 with SMTP id xh8mr25142727pbc.3.1379972253133;
        Mon, 23 Sep 2013 14:37:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ar1sm36269721pbc.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:37:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130923210915.GA11202@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235248>

Hi,

Michael S. Tsirkin wrote:
>> On Tue, Sep 17, 2013 at 04:56:16PM -0400, Jeff King wrote:

>>>>> A problem with both schemes, though, is that they are not
>>>>> backwards-compatible with existing git-patch-id implementations.
[...]
>>> It may be esoteric enough not to worry about, though.

Yeah, I think it would be okay.  Details of the diff generation
algorithm have changed from time to time anyway (and broken things,
as you mentioned) and we make no guarantee about this.

[...]
>> patch-id: make it more stable
>>
>> Add a new patch-id algorithm making it stable against
>> hunk reodering:
>> 	- prepend header to each hunk (if not there)
>> 	- calculate SHA1 hash for each hunk separately
>> 	- sum all hashes to get patch id
>>
>> Add --order-sensitive to get historical unstable behaviour.

The --order-sensitive option seems confusing.  How do I use it to
replicate a historical patch-id?  If I record all options that might
have influenced ordering (which are those?) then am I guaranteed to
get a reproducible result?  

So I would prefer either of the following over the above:

 a) When asked to compute the patch-id of a seekable file, use the
    current streaming implementation until you notice a filename that
    is out of order.  Then start over with sorted hunks (for example
    building a table of offsets within the patch for each hunk to
    support this).

    When asked to compute the patch-id of an unseekable file, stream
    to a temporary file under $GIT_DIR to get a seekable file.

 b) Unconditionally use the new patch-id definition that is stable
    under permutation of hunks.  If and when someone complains that
    this invalidates their old patch-ids, they can work on adding a
    nice interface for getting the old-style patch-ids.  I suspect it
    just wouldn't come up.

Of course I can easily be wrong.  Thanks for a clear patch that makes
the choices easy to reasonable about.

Thoughts?
Jonathan
