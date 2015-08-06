From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 0/4] parallel fetch for submodules
Date: Thu,  6 Aug 2015 10:35:20 -0700
Message-ID: <1438882524-21215-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, hvoigt@hvoigt.net, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 19:36:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNP64-0002gs-Bt
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 19:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbbHFRfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 13:35:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33669 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbbHFRfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 13:35:33 -0400
Received: by pabyb7 with SMTP id yb7so35377327pab.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KWhleTeY0sLYybTtyrvtA0ztNJModRHqS/NK9Z4lOGo=;
        b=JVqdENuh1+Og/DYgJa6thSXy8t3vGf4SLnPRTl2Mzg8LZK1Q6woz4fn1ZFrg2IvVuD
         ZcRu61oVY/lhmrX5RToTyiZ9Bqymsj1HKpD+L7tfChnNxUVHHY7znSXj6yGJIaZJ0lFC
         epQGYgXnLujkdHdZDOp2dszmcivmvELuo5FK8+FRfZoxCkp7TOpaSyoaqqeXEaxDeowX
         Wwl7Xfd4AI+uTwkOi+JIDh6GCf8UR6ltSM/oaic7ZDb+vxhPV6MhqdZ1ptSxOnzchY5p
         FhGakTxp8AacYhAP+Rk9gXglbDkQ/EYhmjSbbkfIic471LogPQjtkx7UxcTM2lhvbEK5
         FWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KWhleTeY0sLYybTtyrvtA0ztNJModRHqS/NK9Z4lOGo=;
        b=U09W3XWMA1dTNMITxVEpkI58f51//eIP/83q4jdbAEZXuzzn87nNcZSh8pG3EW0n78
         k40/05rAOWjNGbHmGlaTOS2bF9E7qyYf697ai9cXIWqqTp/wFi3DBEgUj6Y3wMqytkwW
         2KMQ3aUg/r9HBDoOgHarU5S7rppYTRWFLHUzjfT/vnJBMjwpguqOs2pPPpabJBxm2Wg5
         oBi5mNjEI/RxJiWG2lJLs/vP8gSCpQEELyyiVp4CZMvTUrq8jedwafODEUcbTMlfLMS+
         Qzc2+ROSwpDmj1qKkPJSIbSDMISdxf8AJA66EsYQxBGgY37KlfGtIrXPwfD409yy4Xgm
         Dxdg==
X-Gm-Message-State: ALoCoQmfwuGaRhPgHJ/jwELYvdtuOboMQOGkCfJEl4OsXy24zv+wGh5SHq/TQIlYNphAP6kklr5y
X-Received: by 10.68.241.103 with SMTP id wh7mr5556935pbc.88.1438882532415;
        Thu, 06 Aug 2015 10:35:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8060:d893:ee2c:36a5])
        by smtp.gmail.com with ESMTPSA id qb10sm7271912pab.39.2015.08.06.10.35.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 10:35:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.239.g9728e1d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275429>

When I was looking at the branches of Jens for work done on submodules
not yet upstream I found a commit "WIP threaded submodule fetching[1],
and I was side tracked wanting to present a different approach to that.

The first patch is a bit unrelated as it relates to the rewrite of git-submodule.sh
but also has code in submodule.c and the following patches modify code just around
that, so I did not remove that patch from this series. It is the same I sent 
yesterday.

The next patch 2/4 presents a framework for parallel threaded work.
It allows to setup a worker pool of <n> threads and then have a queue
of tasks which are worked on by the threads. The patch is a the one which
I'd request most comments on as I think that can be reused in a variety of
situations (parallel checkout of files, parallel fetch of different remotes,
or such).

I consider the third patch farely boring as it adds argv_array_copy, so I
would not expect much discussion there.

The last patch 4/4 presents the new workdispatcher from 2/4 in use
with just one unsolved problem of how to handle the output of the
parallel commands to stdout and stderr. It may be useful to put
handling of parallel outputs into the work dispatcher.

[1] https://github.com/jlehmann/git-submod-enhancements/commit/47597753206d40e234a47392e258065c9489e2b3

This series applies on top of origin/sb/submodule-helper (d2c6c09ac819,
submodule: implement `module_list` as a builtin helper) and can also be found
at https://github.com/stefanbeller/git/tree/parallel-submodule-fetch

Stefan Beller (4):
  submodule: implement `module_name` as a builtin helper
  Add a workdispatcher to get work done in parallel
  argv_array: add argv_array_clone to clone an existing argv array
  submodule: add infrastructure to fetch submodules in parallel

 Makefile                    |   1 +
 argv-array.c                |  13 ++++
 argv-array.h                |   1 +
 builtin/fetch.c             |   3 +-
 builtin/submodule--helper.c |  23 ++++++
 git-submodule.sh            |  32 ++------
 submodule.c                 |  92 ++++++++++++++++------
 submodule.h                 |   3 +-
 workdispatcher.c            | 184 ++++++++++++++++++++++++++++++++++++++++++++
 workdispatcher.h            |  29 +++++++
 10 files changed, 332 insertions(+), 49 deletions(-)
 create mode 100644 workdispatcher.c
 create mode 100644 workdispatcher.h

-- 
2.5.0.239.g9728e1d.dirty
