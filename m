From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 0/4] Handling unmerged files with merged entries
Date: Wed, 20 Aug 2014 13:25:59 +0200
Message-ID: <cover.1408533065.git.jsorianopastor@gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK43M-0004yh-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 13:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaHTL1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 07:27:03 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37180 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaHTL1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 07:27:02 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so6901871wiv.17
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o0Flmn5w4XNhU4E1Hen4V5OdKbSlzUOqm7yZ9MUXdL0=;
        b=yiPwNSPyknrkkOSrFtejZk+em7CWSkbRK+iaMASopr1NAKAAl9NO0t/5X39tut6ikE
         Uv2kKjhVYeqokSYqE+xwUQPoUkZ0Yr4lr8ln9JTTvj9tzjWoZD2R1ke5tZCSsFETTNfH
         Qr2Tt76EE4lOiLJvki+gPzPkVjvybzk0SaM9xWoDK78iSkqn+8FPWF6mlGLnRdpuN74p
         AFiw1nGuuKTuRyLCQE+TSh4PondioSBeAGnd+OX2mCsRalegdFAU0O1DjQBwGU4kg60r
         C5jHOKPfUkuKaEb70QR8JqebLV3fgM0OfE58cs61Jjr1ruICQ0FdEuyGm4kduBOTVLW3
         OpVA==
X-Received: by 10.180.218.4 with SMTP id pc4mr12518537wic.15.1408534020313;
        Wed, 20 Aug 2014 04:27:00 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id je17sm8301873wic.22.2014.08.20.04.26.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 04:26:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.4.gaf54b2b
In-Reply-To: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255568>

New approach for the case of finding unmerged files with merged entries
in the index.
After some discussion the solution tries to:
- Avoid the problems with infinite loops in this case.
- Provide better information to the user in the commands affected.
- Make sure there are ways to clean the index.
- Provide also a way to specifically recover each one of the files with
  this problem.

With these patches the behaviour of these commands (for this case) change:
- git reset is able to finish, cleaning the index, but warning out the
  information about the removed stages.
- git merge is able to finish, reporting that there is a merge in progress as
  usual, it also warns about the unmerged files with merged entries.
- git add fails when this case happens, telling the user to check the state
  with 'git ls-files -s', before, it did nothing. The same with git commit -a.
- git update-index --cacheinfo can be used to select an specific staged
  version to resolve the conflict, without the need of reseting the working
  copy. It did nothing before.

Tests added for these cases. Rest of the tests remain unchanged and pass too.

Jaime Soriano Pastor (4):
  read_index_unmerged doesn't loop forever if merged stage exists for
    unmerged file
  Error out when adding a file with merged and unmerged entries
  Added tests for the case of merged and unmerged entries for the same
    file
  git update-index --cacheinfo can be used to select a stage when there
    are merged and unmerged entries

 builtin/update-index.c                     |  1 +
 cache.h                                    |  1 +
 read-cache.c                               | 36 ++++++++++--
 t/t9904-unmerged-file-with-merged-entry.sh | 94 ++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 5 deletions(-)
 create mode 100755 t/t9904-unmerged-file-with-merged-entry.sh

-- 
2.0.4.4.gaf54b2b
