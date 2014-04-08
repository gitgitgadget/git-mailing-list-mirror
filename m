From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Race condition with git-status and git-rebase
Date: Tue, 8 Apr 2014 21:44:21 +0300
Message-ID: <20140408184421.GD5208@abyss.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 20:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXb0j-0003z4-NP
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbaDHSob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 14:44:31 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34965 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757654AbaDHSo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 14:44:28 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so1017284eek.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=+cUVlsPWOXpmWkPjRdXM+eXHZZ2I9dJZJx34s2RK56s=;
        b=pdjzpyZ/Fpwk4hIgmD7OdRR1lxvXyylUkP/RsKdgpmwMnfw8wbtpf+l23ZUAIAXiK4
         GiP9PyZEBUQ4sOZnCsONmc8qxdEFNG0EFbF2DqqlHBTP7Gn9heqw6FXFWND+hI1MZ3QP
         9JztFGaA7vR2gfNLd/x4eAaG6SZI+C1x8s+u1OPitpX89XlycB3jk2Bl7FwyAPDjgjPV
         DLfcBDXqZ7twzMxT5v9wepFfQ/BIYfakHDkJGiK7HzOtWSY0nkJbqLCSuL16LTTiTE9Y
         P03Tbs4myT3T8OP8VvmFByPkiwf5zps0JdX6TbRERpiFKg/b/FafJKUUsL14RBd9KXt5
         fhkw==
X-Received: by 10.14.115.195 with SMTP id e43mr4150341eeh.76.1396982666782;
        Tue, 08 Apr 2014 11:44:26 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id x45sm6269865eef.15.2014.04.08.11.44.24
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Apr 2014 11:44:26 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245946>

Hi,

Since I don't know how to fix it, this is my bug report:

git-status reads the index file then holds the `index.lock', it writes
the updated index in `index.lock' and renames the `index.lock' to
`index', but if it used with git-rebase then there is a (rare) race
condition.

I reproduce this at my work under the following conditions:
1) The repository is very big
2) I can reproduce it only in Windows. I can not reproduce it in Linux
   (my Linux machine has faster CPU and SSD drive.)

I saw this race condition at my coworkers when they use two instances
(in the same repository) of Git-Extensions GUI, and when they use one
instance of Git-Extensions and at the same time they rebase from
terminal. This race condition happens because Git-Extensions monitors
the directory of the repository and when a file is accessed it calls
git-status.

Since I can not share the repository, I decided to trace down the
problem. I came up with the following:

process A calls git-rebase
process A applies the 1st commit
process B calls git-status
process B calls read_cache() (status_init_config() -> gitmodules_config() -> read_cache())
process A applies the 2nd commit
process B holds the index.lock
process B writes back the old index (the one that was read from read_cache())
process A applies the 3rd commit (now the 3rd commit contains also a revert of the 2nd)

The content of the files of the working directory is correct (i.e. as
it should be if the race condition didn't happen). But git-status
shows that the files of the 2nd commit are modified, the git-diff show
the exact patch of the 2nd commit.

So, in this case process B must avoid calling write_index(). Maybe
something is missing from update_index_if_able()? Maybe git should
check the state before proceeding to write_index() (for example that
we are in rebase)?

Something else that I noticed is that when the race condition happens
the istate->cache_changed is 0 and has_racy_timestamp(istate) is 1, so
the if statement in update_index_if_able() continues to write_index().

I didn't check if there are other similar race conditions.

Regards,
Yiannis.

PS: I tried to move hold_locked_index() above status_init_config() but
this cause other problems.
