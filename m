From: Brian Norris <computersforpeace@gmail.com>
Subject: git-fetch: default globally to --no-tags
Date: Tue, 18 Nov 2014 19:05:23 -0800
Message-ID: <20141119030523.GO22361@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Norris <computersforpeace@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 04:05:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqvaN-0007y1-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 04:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbaKSDF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 22:05:28 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33471 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbaKSDF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 22:05:27 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so6986040pab.20
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 19:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=6MWvcTpcmy/SYfmrAubnezJ7M5ORt3F2DOlGnZU8RiM=;
        b=RTYxjTHCL11YKVAJfsJ35OrgHkHlMp8NbG/J4fBdRkq4lEIFtZHpNvq8v83NNAFCQJ
         GUP+H9qBKIsGmOwYf6lp4rg1yVelFmIQW10sHwjzx+NzmN302P4woTpXNhxwkKO6tPEi
         KyEW4FwGPt46HvX2rmaagun4MQVHZ+9qbD5i377J1U8uwlL6AQCqk3+G1FXVkeDIU1Tt
         7dRMrf/6xZhSpmneEaPxBmgVErsU6WO7QAsNrWU1ax3PdDTABM7B6zvC+WcjB5kpTHio
         HmrAikswRekOcPlmvfH5gbcdiiQpv4/+FUiqWQy691O8KEcuNoJfK7RK+3VlafP8BCTV
         VE1g==
X-Received: by 10.66.222.41 with SMTP id qj9mr41467361pac.21.1416366327131;
        Tue, 18 Nov 2014 19:05:27 -0800 (PST)
Received: from norris-Latitude-E6410 (cpe-76-173-170-164.socal.res.rr.com. [76.173.170.164])
        by mx.google.com with ESMTPSA id wl10sm316431pbc.58.2014.11.18.19.05.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 19:05:26 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have one main concern, and I can envision a few ways that git could
solve it. I also see that there has been some previous discussion on
reltaed topics over the years, but as far as I can tell, nothing has
actually been implemented to address my concern.

--- My concern ---

When I fetch from a remote repository, the only ways to
prevent fetching tags are:

  1) git fetch --no-tags <name>

  2) git config remote.<name>.tagopt --no-tags; git fetch <name>

The former requires extra typing for a case that (arguably) should be
the default. The latter requires configuration for each repository. This
doesn't scale well, if a user desires this behavior on all repositories
they use.

I'd prefer something like this, to change the default tag-fetching
behavior globally:

  git config --global remote.tagopt --no-tags

The closest I see is that I can disable tag-fetching globally on a
per-remote name basis:

  git config --global remote.<name>.tagopt --no-tags

This brings me to a potential bug report:

--- Bug ---

When trying to use the remote.<name>.tagopt configuration option
globally, I get something like this:

  $ git config --global remote.test.tagopt --no-tags
  $ git remote update
  ...
  Fetching test
  fatal: 'test' does not appear to be a git repository
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.
  error: Could not fetch test
  ...

Expected behavior: if the local repository does not have a remote named
'test', then no additional output should be printed. If the local
repository has a remote named test, then it should be fetched with the
--no-tags option.

Actual behavior: git prints warnings about the 'test' remote, just
because there is no remote named 'test.'

--- Motivations ---

This is all motivated by the fact that tag namespacing is completely
broken in git. Tags are globally namespaced, and in a true DVCS
environment, any particular developer has no control over another
developer's tag naming conventions. So this namespace can easily become
polluted, reducing the usefulness of tags as a whole [1]. This problem
seems to have been acknowledged, and proposals appeared a few years ago
[2]. But I don't see any solution for tag namespacing.

So, my current approach is to try to limit the damage done by
accidentally fetching tags. Unfortunately, I can't find any good
supported mechanisms to help me in the previous two sections.

--- TL;DR ---

My email boils down to two questions:

  (A) Has there been progress on implementing a proposal like in [2]?

  (B) Can we allow disabling (auto)tag-fetching globally? Like:

        git config --global remote.tagopt --no-tags

Thanks,
Brian

[1] I could elaborate with some horror stories, to describe how this
    becomes a day-to-day nuisance in using git for me, but I'll avoid
    the details for now. Please accept that this is a usability bug.

[2]
    http://article.gmane.org/gmane.comp.version-control.git/165799
    http://article.gmane.org/gmane.comp.version-control.git/165885
