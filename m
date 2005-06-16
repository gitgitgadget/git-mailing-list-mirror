From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list problem with --max-age and --merge-order
Date: Fri, 17 Jun 2005 02:06:28 +1000
Message-ID: <2cfc4032050616090632f10b2e@mail.gmail.com>
References: <17073.29462.564422.743677@cargo.ozlabs.ibm.com>
	 <2cfc40320506160745411858f1@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 18:02:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiwoI-0007lS-5T
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 18:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVFPQGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVFPQGn
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 12:06:43 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:57480 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261770AbVFPQG2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 12:06:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so372783rne
        for <git@vger.kernel.org>; Thu, 16 Jun 2005 09:06:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Othtnbz0zwrPWr4AsCM6sS5RBEIgk8PWlVx7DRLw+JE65SSq7n3ol1hifPPmb5YnAb4Q9Rmvy2QT/uwhulZhFsEU+mXulRD3tPl37HEJhND4Tdo/5s4U3LreBa9oFUmFkqP1Jxw2tpbfvT7U5FJwYpx2bX8nj05N7CJaQN/5P4Q=
Received: by 10.38.181.14 with SMTP id d14mr636988rnf;
        Thu, 16 Jun 2005 09:06:28 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 16 Jun 2005 09:06:28 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <2cfc40320506160745411858f1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

G'day Paul,

I think I know why this is happening and I think it has a relatively
trivial fix, but I need to confirm this tomorrow after the effects of
several schooners of Toohey's Old have worn off.

The current logic is to stop after one commit is found with an age
greater than the maximum age. This doesn't work as expected if a
"right" branch has an "old" commit since, by being a right branch,
this commit will appear at the start of the merge-order list and the
output of any commits in the left branch will be suppressed by this
logic.

I think the --merge-order logic should be altered as follows:
    - stop at the first epoch boundary with an age greater than the maximum age 
      but filter out (from display) any commits older than the maximum
age prior to that boundary.

This will still omit commits in the case that either the epoch
boundary or a commit beyond the epoch boundary have timestamps that
don't match the merge order, but that should be a relatively
infrequent occurrence.

I'll create a patch for the current Linus HEAD later today.

jon.
