From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC db/text-delta 0/4] vcs-svn: avoid hangs for corrupt deltas
Date: Fri, 27 May 2011 06:08:28 -0500
Message-ID: <20110527110828.GA7972@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri May 27 13:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPuuI-0001XG-AN
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 13:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1E0LIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 07:08:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41953 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1E0LIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 07:08:36 -0400
Received: by iyb14 with SMTP id 14so1281368iyb.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wpybnBcaRug77BNS0nCtQCvB7WMschBpN2uypRkHEGU=;
        b=nxcFst6xp1cfK36Tn7ncokmo0Na6uLMYYOcV6PXtlfJ7wn+J+RD2YxkXxI+CirZNQn
         GBt9wR/xEaNgxlKOSXlFtWdMXHLIkeAYxpulZZvmu6+kdnf2aFY6LmyjLmUjtuur1yvj
         u7ytv/YviZ0z9qqxWI+YFFe2FNyPsLu8hjZIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=f78gYHjYxEQZHa2zEFfPlDqFP8xIURpFFHuUKwFh9bRorE9vyOhO+ryd5eqrh4YSEZ
         EmMYk/DhkxNSiK7/vuezHGmlRvSOdsvdSaBc9/MVTxzRpA4y9FHVKTC6GKqbKYQKw4w2
         HMaKpEzjLzI7OOIw3wgsyK+X7K4OqoKtyfRKc=
Received: by 10.231.114.41 with SMTP id c41mr2110270ibq.112.1306494515834;
        Fri, 27 May 2011 04:08:35 -0700 (PDT)
Received: from elie ([69.209.65.98])
        by mx.google.com with ESMTPS id w11sm489713ibw.41.2011.05.27.04.08.34
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 04:08:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174605>

Hi,

As promised, here's a quick series to stop a too-greedy delta from
causing svn-fe deadlock.  It took longer than I thought it would,
mostly because I started too late.

If I remember correctly, this first showed up as a theoretical
possibility when chatting with Ram and later showed up in practice due
to a bug in a test script or something like that.  I don't remember
the details but luckily it is not hard to make up a delta exhibiting
the problem.  See the test script in patch 4 for details.

After review, I'd like to push this to the main svn-fe branch and ask
Junio to pull it so text delta support can be rolled out.  There's
just no reason not to, except for the obvious ones:

 - less pleasant raw UI for svn-fe
 - losing support for non-git fast-import backends that don't
   support cat-blob yet

Waiting for those would be to put the cart before the horse (how can
people experiment with making something better if they haven't
experienced what we have now?).  Review of the pending patches at

 git://repo.or.cz/git/jrn.git svn-fe-next

to find missed details or other things that would be nice to get
taken care of toward that end would be very welcome.

As for this series: hopefully it's simple but it's perfectly
possible I got something terribly wrong.  Thoughts welcome, as
always.

Thanks to David and Ram for some useful discussions on irc, including
those that led to these patches.

Jonathan Nieder (4):
  test-svn-fe: split off "test-svn-fe -d" into a separate function
  vcs-svn: cap number of bytes read from sliding view
  vcs-svn: guard against overflow when computing preimage length
  vcs-svn: avoid hangs from corrupt deltas
