From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Fixes for the parallel processing
Date: Mon, 19 Oct 2015 11:24:41 -0700
Message-ID: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7C-0007Ru-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbbJSSYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:24:54 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36294 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbJSSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:24:53 -0400
Received: by pacfv9 with SMTP id fv9so102542053pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XvWJfo4hDHYm/l6ROOt2kp+A9NUGguUkPWA7tLXipFM=;
        b=kWLvxUTLNYGx6tIZVayXg/W5YJibVARLz8V3HMZe/PCiLDe0TUnM6zOac4uKzt8/R1
         neidqnww9/7VvD/1NuTkwjnTyeL8khqAJwpUAA9xS4wME7dGRfjX+m1HNMKS8MpWcQOP
         7WNSroINOa/bRO71fVgdy+kvRkfffVzwDu3MtryQQiVNDlFybJR1r4lsK29vZXFlqqBF
         zwzj8CuEPGAZQ4VAp1P0quTEa8VMKlnmQugaHxsRpry3QwsiJUQhI45ilWtoEJVTbPS7
         U2J799zAYKsiNgej5ia4nbtp3VgtfDZBQF/IGAubtbMrhO3nKmPE1tEnqmOtBIu1DgtB
         0ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XvWJfo4hDHYm/l6ROOt2kp+A9NUGguUkPWA7tLXipFM=;
        b=LbQVfflV0zf8IYo0d3qTwNx5EbcEjREkw8aJSA7Z0DkUGSl/LbEKVXicjDK41/HWkB
         uKIPSoyMV/8wvdFCZgCOLiDVmErfJ17P8/adf2s2smDdIMC4SzYc0/scHNsiBlViqHlJ
         3Vxojk96DLD8UI0h6I4QgofdIR8RabAvvp78IWgHoPE6FEfe7Njx0wd/PEcDudw95W6h
         9WQ+qcuEF6dWhF9VMyaFaBFgGd8SejoOAOTMGBdYLhXNCyOpY9yUCgEQ1f6AIv39LBg9
         z7ebd2Bz70Ws2XK1DR9BIZOcrH2P5qWKwa4wZu1TdzIwRyfYtoI/xZooiw3fXFhwwgOe
         /gRw==
X-Gm-Message-State: ALoCoQlawku71W9n7Kdgc2q4VxygXs2EZlYGwBp+fYp+UGvW3m3Nxr+gmSx3RpXXRMhJSp6UPSrg
X-Received: by 10.66.186.141 with SMTP id fk13mr35847894pac.7.1445279093100;
        Mon, 19 Oct 2015 11:24:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id qd2sm5717870pbb.68.2015.10.19.11.24.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:52 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279879>

I noticed a problem with the gracefully abortion in the parallel processing,
that is fixed in patch 1.

Patch 2 makes the API more maintainable/usable (the caller may forget to
call child_process_init and only fill in fields which the callback is
interested in)

Patch 3 is another fixup. It actually initializes the shutdown flag properly.
(Apparently it had the right value so far)

Patches 4 and 5 add more tests both for the gracefully aborting case as well
as the standard use case.

This applies on top of sb/submodule-parallel-fetch which is already in next.
Junio, do you want me to reroll that series with these patches squashed in
appropriately, or just put it on top of that series ?

Thanks,
Stefan

Stefan Beller (5):
  run-command: Fix early shutdown
  run-command: Call get_next_task with a clean child process.
  run-command: Initialize the shutdown flag
  test-run-command: test for gracefully aborting
  test-run-command: Increase test coverage

 run-command.c          |  5 ++++-
 t/t0061-run-command.sh | 28 ++++++++++++++++++++++++++--
 test-run-command.c     | 22 ++++++++++++++++++++--
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.5.0.285.g8fe9b61.dirty
