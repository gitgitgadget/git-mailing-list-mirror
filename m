From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Thu, 4 Dec 2014 18:19:31 -0800
Message-ID: <20141205021931.GA29570@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
 <20141205002331.GJ16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:19:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwiUb-0002v9-7p
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 03:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933536AbaLECTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 21:19:33 -0500
Received: from mail-pd0-f201.google.com ([209.85.192.201]:32917 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933398AbaLECTc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 21:19:32 -0500
Received: by mail-pd0-f201.google.com with SMTP id ft15so2631531pdb.2
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s9v/eJIOKgM2QR+l5AnXMLoywoCo2pymwqIa5Tx2Ad8=;
        b=NgxWX6WiN2yYYzQi3WIJbuYvvrXLg/45Mh++D+GefVDxBGEfGqo/HxejmvRnH/pblJ
         STa+dAEmJ+2BtbuBHQjSw1jI1i0N6t+HghvGpTscq8ElFkaPtuAMOFDREVKQQjZ7nLGf
         GaH33IRIobNhRKjYqPMEkq2somct4/kGHK7t46N0kPtnJT6B3fn8xMHvC//5uzwJJ8YE
         04Q1bGTvhSyt2hMjZPPN4vYvBDPzduFAdk4+XUCCkv0ClP6pyu/lOupqYNl1gW7b0osH
         KVM6IM+NPLY2kqpj67IlucEQP+qYumoAAk164GKP+Usq+tqJIJyFdAKIMOSSRyLeC9Oz
         OpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=s9v/eJIOKgM2QR+l5AnXMLoywoCo2pymwqIa5Tx2Ad8=;
        b=gV6j+3dLHJPkh7hdKWQ6LmPNtXzYPXhp0glYnAHz/bOP4Fo1vJv49IW9btrianpJ0s
         zu8F8hK+GawMLGHmRO8j5Tbdq4GY1/PL07rsLohgcXZ76v5rgaA5z233ByRy0jyouK60
         p+fse87znHFT1HmhooghHk8SHtxYizsFb+SjVLjiy0gEfizjl3CsU0Ohm/flzXxySzXq
         HxO40av5BceGpEdK130dPZlgb1x5c1cEIk38VoChSSfbhM4ycef+fy+HMDYHconZJ4fQ
         tbbYOi2+dutkDVKumXdqAKFRIvxaNxetazTrDQO/eMA6oLptxQcNgG0QNjKICbbsqVaS
         tfbA==
X-Gm-Message-State: ALoCoQnsiE0Oa3oZKo65xtD6wKuJtNsbezO+wzUpP3FEKk2ayqyzVZlXYsi6CDfXSNkWhk/DMkwA
X-Received: by 10.68.203.170 with SMTP id kr10mr16122186pbc.0.1417745972490;
        Thu, 04 Dec 2014 18:19:32 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si1219774yhf.0.2014.12.04.18.19.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Dec 2014 18:19:32 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id GELZq1gJ.1; Thu, 04 Dec 2014 18:19:32 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 788FE140B6E; Thu,  4 Dec 2014 18:19:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141205002331.GJ16345@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260853>

On Thu, Dec 04, 2014 at 04:23:31PM -0800, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
> > We don't actually need the locking functionality, because we already
> > hold the lock on the reference itself, which is how the reflog file is
> > locked. But the lock_file code still does some of the bookkeeping for
> > us and is more careful than the old code here was.
> 
> As you say, the ref lock takes care of mutual exclusion, so we do not
> have to be too careful about compatibility with other tools that might
> not know to lock the reflog.  And this is not tying our hands for a
> future when I might want to lock logs/refs/heads/topic/1 while
> logs/refs/heads/topic still exists as part of the implementation of
> "git mv topic/1 topic".
> 
> Stefan and I had forgotten about that guarantee when looking at that
> kind of operation --- thanks for the reminder.

I did not forget about it, I did not know about that in the first hand.
We don't seem to have documentation on it?

So sorry for heading in a direction, which would have been avoidable.

Thanks,
Stefan
