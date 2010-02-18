From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/10] teach --progress to transport-related builtins
Date: Thu, 18 Feb 2010 20:37:01 +0800
Message-ID: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5dW-0003oa-1V
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135Ab0BRMhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:37:36 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:64363 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758099Ab0BRMhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:37:35 -0500
Received: by gxk27 with SMTP id 27so2566099gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hSqHjD9t3xAmDJlpAUbh8bUkWpIeYoYmP4o/hJj1dgw=;
        b=JGkyKSf3ZCT/iMD9iMSTprKjk6MYQzWT8cCAvF1WQ5SNIvCAfbV092qZ7hz0pVCfYw
         Zjpu3FueqJz6PKn2IGm9FtD7FN33zC8DwRseaHimZswarj3ctj7dMncSKSOBcOGLUrC8
         8OhnLpbx66pFyVyEF5waTA0nGMivOmMBAY2Xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Y1MFd5BMn1SNceDbllLU+4+bhJhb/BreY/lvgFNkPDw+PA2sB9K1wTFd9Pl2DINsU2
         skiFTKm2S92E/8w1O+IdQqYwbQbd8NpnQG/4yzuN9MEMasKIFd19lkCzAwnw/robTffi
         LkxQmtt7bmLrBWVKOi8m5pFgQhjCO0tD/LGJo=
Received: by 10.150.48.19 with SMTP id v19mr7795326ybv.172.1266496653865;
        Thu, 18 Feb 2010 04:37:33 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.37.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:37:33 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140323>

This patch series adds --progress to:

  - git-fetch
  - git-pull
  - git-push

I suspect the most contentious issue in this patch series would be the
logic that determines whether progress reporting is done. This is found
in patch 6 for transport.c::transport_set_verbosity().

As a guide, I used Jeff's message (gmane#121065). The rules used are as
follows (processing aborts when a rule is satisfied):

  1. Report progress, if force_progress is 1 (ie. --progress).
  2. Don't report progress, if verbosity < 0 (ie. -q/--quiet).
  3. Report progress if isatty(2) is 1.

This changes the current implementation such that if both --progress
and --quiet are specified, progress is reported. I don't think this is
a very significant change, but I think it makes sense, since I expect
--progress to be mostly used by script writers or IDE integrators (to
force progress reporting even if stderr is not a terminal).

Contents:

[PATCH 01/10] Documentation/git-pull.txt: mention --quiet and --verbose for fetching
[PATCH 02/10] Documentation/git-push.txt: put --quiet before --verbose
[PATCH 03/10] fetch: refactor verbosity option handling into transport.[ch]
[PATCH 04/10] push: support multiple levels of verbosity
[PATCH 05/10] clone: support multiple levels of verbosity
[PATCH 06/10] transport->progress: use flag authoritatively
[PATCH 07/10] push: learn --progress
[PATCH 08/10] fetch: learn --progress
[PATCH 09/10] pull: learn --progress
[PATCH 10/10] transport: update flags to be in running order

 Documentation/fetch-options.txt |   11 ++++++++---
 Documentation/git-push.txt      |   15 +++++++++++----
 builtin-clone.c                 |   19 ++++++-------------
 builtin-fetch.c                 |    7 +++----
 builtin-push.c                  |   11 ++++++++---
 git-pull.sh                     |    6 ++++--
 transport-helper.c              |    4 +---
 transport.c                     |   31 ++++++++++++++++++++++++++-----
 transport.h                     |   15 ++++++++++-----
 9 files changed, 77 insertions(+), 42 deletions(-)

--
Cheers,
Ray Chuan
