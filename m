From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revision.c: Remove unneeded check for NULL
Date: Tue, 30 Jun 2015 15:48:14 -0700
Message-ID: <20150630224814.GB4865@google.com>
References: <1435347619-29410-1-git-send-email-sbeller@google.com>
 <20150627060710.GA9353@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:48:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA4KG-0000zR-I4
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 00:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbbF3WsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 18:48:21 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36521 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbF3WsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 18:48:18 -0400
Received: by iecvh10 with SMTP id vh10so22847449iec.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mGdfb4bZsFvq+jsJ7m4hKRqDQesdNg2/iXgLB8BIoqw=;
        b=LuL0uQc85WmymsXntCHQ0Xru3YsAiYw/+l3ClyQfbtVi7xqrgabk70Gf4cBlSyNRgK
         Vij/DPGnpb5oBCAMnUaiRxnQt1DC3yAhYwens699vzx22mRwi2s197LWEq0Ztc93ZvCI
         ioL80lhNC2ps9GAfbtQwNz0uA+auNNwlNvetA9ks+r99T3UBN/SSPx8ByGYtQ7ccoSDZ
         rqKiEB2bpVBFdB+ernz+tE+n0zhP9Kzq7c+xGOaU9ucjJgkYw7CX68eDBxO5QVlJxe4i
         piBuDED2z8t1NuK8TAXlqWESaoywZfX6YuJR7wtPF/emn5oEHE9XzGg2pzGJ3MNd+sP6
         wxsg==
X-Received: by 10.50.59.211 with SMTP id b19mr27070197igr.42.1435704497408;
        Tue, 30 Jun 2015 15:48:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:3519:ee81:ec83:ee3d])
        by mx.google.com with ESMTPSA id 140sm31043457ion.16.2015.06.30.15.48.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 15:48:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150627060710.GA9353@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273110>

Jeff King wrote:
> On Fri, Jun 26, 2015 at 12:40:19PM -0700, Stefan Beller wrote:

>>> This code seems to be underdocumented.
>>
>> I am not a expert in this area of the code, so I hoped Peff
>> would document it if he feels like so.
>
> I kind of thought that the explanation in b6e8a3b covered this code.
> Does it not, or did people not read it?

I know that "tl;dr" is the last thing anyone who has written a clear
description of something wants to read, but I fear it applies here.  I
tried to skim that commit message to get a gist of what the
still_interesting variable is supposed to hold and I failed.

I think part of the problem was that that commit message doesn't give
a specific example early on to motivate the problem and fix[*].

More to the point, someone interested in that specific variable
doesn't need to necessarily understand the optimization that motivated
it.  Instead, they'd want to know what invariants to expect and
preserve: what value does it start with, what does its value mean, are
there some forbidden values, etc.

Is the idea that it represents a commit from the queue which is still
interesting, and that it saves us from looping through the queue to
find a still-interesting commit as long as mark_parents_uninteresting
has not marked this one uninteresting yet?  What does it mean when it
is NULL?

Thanks,
Jonathan

[*] I.e., what command do I run to get quadratic behavior?

The message starts with a diagnosis --- "When we are limiting a
rev-list traversal due to UNINTERESTING refs, we have to walk down the
tips" --- without introducing what problem is being diganosed.

The problem being solved might have been something like "When we call
'git rev-list $commits --not --all' in check_everything_connected
after a fetch, if we fetched something much older than most of our
refs, and if we have a large number of refs, the operation is slow ---
quadratic in the number of refs.  This hasn't been a problem in the
past because people did not use so many refs, but now as the number of
refs in a typical repository grows, it is becoming more noticeable."
Even after re-reading the message more carefully, I'm not sure.  I
assume there was a report motivating the change, which might have been
useful for putting the explanation in context for the reader.
Alas, git://repo.or.cz/git/trast.git branch notes/gmane doesn't have any
annotations for that commit to find the context.

The commit message then goes on to explain how the patch solves that
problem, but without an example to put that explanation in context, it
is hard to follow.  What linear search is the explanation talking
about?  What is the interesting commit we find?  I couldn't tell without
looking at the code.
