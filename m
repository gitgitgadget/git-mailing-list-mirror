From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/8] Fixes for the parallel processing engine and git submodule update
Date: Tue, 20 Oct 2015 15:43:42 -0700
Message-ID: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:45:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoff5-0003KE-S9
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbbJTWpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:45:22 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33773 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbbJTWn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:43:57 -0400
Received: by pabrc13 with SMTP id rc13so33821376pab.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NLTuxYFbvhL9/hmOCXPCSwkqBgEemS7ihphUxes+Oyw=;
        b=PCZMPEptBbc1WUuCsNY/ybDQSKLWRc8gWdDisBTrFmQZFLiJSqEZdqiK4nslMFZ0IE
         BIfSyquASPoWTlIc/ICgxDA71Tj+KJ6WXX5cfypeGOY8SW4V+fcOcP0b0QsyuDRcu+bg
         ZliRDUP6LX06RWjkv34V1D3b5HfkAZ/VBosoft/vOv8IxcMjEG+Tj1kakMyX0Nd0iNT2
         LI31BnMiBI7Z4ZRxQNaOvJ2xZIi5kLSNV1LxyuEs4AJ2w8V4fjI71IhXvpiHy3q8nsn9
         jBoayfw8u/Nbyyas6w/XB8pkS5CG7ziu+JaOLTUm77YOzKiHYsFlgBvS/TXCSHL3R3ba
         yCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NLTuxYFbvhL9/hmOCXPCSwkqBgEemS7ihphUxes+Oyw=;
        b=V+rY9XYBLExC/Xs7k2SLOQvo55GFs+Q7pYMyjmmWUZ28AnfOK+Lj2cIPIeirTQvkn0
         pG/cYoPP/etzpM5OEb5av9VVcA7EsEettnio1Jco/KU9IQfHC6gYHiWkEuGR246RfrdJ
         OiuDR4+M+rL/DbAgsjuk0QCWl6d1dl7qrvCtsardEBzEWz8JTaEK5KdorAiuRqRw0jBK
         ua7G0M9yxmuwYQ02Tmi8Gw7HOHuKpc6VKnH34NmZg0rtBRW/BHspOYdwneZvUiOIX7v8
         9OPy5lIK7gecY2VVB2akHXTR7HUdJ9fLigLQ2/pRYbmNPO0J5QAeRBD6YAJfu/UM3g+g
         NqSQ==
X-Gm-Message-State: ALoCoQlACom3ZS2kod9jdkoXMiepFbTX8F9ccsFDvAmhE4uW3X5BkI7RuCIQoklsveeF2re08jCM
X-Received: by 10.66.216.101 with SMTP id op5mr6626499pac.51.1445381036791;
        Tue, 20 Oct 2015 15:43:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id pk2sm5607307pbb.21.2015.10.20.15.43.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:43:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279955>

Patches 1-6 replace the last 6 patches of sb/submodule-parallel-fetch
(Patch 1,2 changed code, 3,4 stayed as is, 5 has more commit message, 
Patch 6 is the same again)

Patches 7,8 are new in the series .
Patch 7 keeps the update strategy in the cached submodue structs around,
Patch 8 rewrites some small part of the git submodule update script in C
by having another larger helper function in builtin/submodule--helper.c
which takes care of the cloning new submodules without having all the
intermediate steps as in previous versions of this series.

The patch 8 is just a rewrite/translation without enabling the parallel
processing though. This will be done in a later patch once we have
bike shedded enough how to name the user facing option for that.
(I guess the CLI option would be --jobs again, but I'd rather hint at
the config option)

This supersedes 
[RFC PATCHv1 00/12] git submodule update in C with parallel cloning

Any feedback welcome!
Thanks,
Stefan

Stefan Beller (8):
  run-command: Fix early shutdown
  run-command: Call get_next_task with a clean child process.
  run-command: Initialize the shutdown flag
  test-run-command: Test for gracefully aborting
  test-run-command: Increase test coverage
  run-command: Fix missing output from late callbacks
  submodule config: Keep update strategy around
  git submodule update: Have a dedicated helper for cloning

 builtin/submodule--helper.c | 222 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  45 +++------
 run-command.c               |  27 +++++-
 submodule-config.c          |  11 +++
 submodule-config.h          |   1 +
 t/t0061-run-command.sh      |  37 +++++++-
 t/t7400-submodule-basic.sh  |   4 +-
 test-run-command.c          |  37 +++++++-
 8 files changed, 340 insertions(+), 44 deletions(-)

-- 
2.5.0.275.gbfc1651.dirty
