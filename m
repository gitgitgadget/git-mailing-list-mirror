From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/5] Fix relative path issues in recursive submodules.
Date: Thu, 31 Mar 2016 14:04:35 -0700
Message-ID: <1459458280-17619-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, jacob.keller@gmail.com,
	norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 31 23:04:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljlr-0008PQ-FX
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 23:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbcCaVEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 17:04:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34134 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbcCaVEo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 17:04:44 -0400
Received: by mail-pa0-f41.google.com with SMTP id fe3so74150004pab.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7ZwLmjgmALNoNLZRD/FWubFVp8H80yt/3qC0GQI8Pt8=;
        b=p1ffhrXW8NvunqWahFbAtnR5ruWAFFX4arbMSs/dB+/KXHW5MAsS1FZZxut/KEHWbP
         s/RU3KwX5r2zG+CnWY7nmT8JQ9HCxux4XHVW5s4uBSlpH1vc/ejkAcMs3yDugdnUZwAX
         hgsocCH/pJ0YRdux1J0g9SKEqTD7Svlo8YCC9m3nrDqngS5nGZzOQ42nU36IZ1I8Du59
         GwZ1UbOThu37NZShAoUxvBwsL2U+IphX3lIUP7EbCqxKADbjPSffoLBJaxT7zi9WqjM/
         0n9tNPUmrRARsE55JGjTZ0HoLMcvXb76WYfl5lAh7V0N4U2V8znAzLCAOH0SPGl6rzpL
         iyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ZwLmjgmALNoNLZRD/FWubFVp8H80yt/3qC0GQI8Pt8=;
        b=IB60t8AINDiTz0fPdY3OCLtDn/oMFnhlFrWwthCwQHMV7yzwFySu7qN2JW7onU8Fuo
         +X35Td6ZJ0TCOzLBdcH0Sa3wEzw4hveWNKuhIONDSBbS8LVldHoJLJBEfz2ZrqPYzOqQ
         eb92piTbcX6n5b+4I64zsfnXtqsSSsxe4QMojH4sZ9oTU5ubRwTFQT34RAt7UCrWgfcZ
         iU59M9jS25lxDdHTJ56YmliB8K8w9HzyPWAfcox6aojsliLjd5lKvB+O1/MwA7DCg3It
         dOxo1PEr632GIwexVm6XcRXFZ+fCwrx/cT+bH/yFnP4H/0ZDah5iiTA2LzHTftXw1uan
         /CjQ==
X-Gm-Message-State: AD7BkJI1v0FtCwxoIYf2Nx8IWa3+FunahEweQx+CNHwPmxoaIBP/+G9i2uhcB/25pvMf2cG7
X-Received: by 10.66.121.165 with SMTP id ll5mr25151071pab.14.1459458283126;
        Thu, 31 Mar 2016 14:04:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id n74sm15488123pfa.45.2016.03.31.14.04.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 14:04:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g39f00fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290469>

Thanks Junio, Eric and Jacob for review!

v2:
 * reworded commit message for test (Thanks Junio!)
 * instead of "simplifying" the path handling in patch 2, we are prepared
   for anything the user throws at us (i.e. instead of segfault we
       die(_("submodule--helper: unspecified or empty --path"));
   (Thanks Eric, Jacob for pushing back here!)
 * reword commit message for patch 3 (safe_create_leading_directories_const is
   not a check, Thanks Junio!)
 * patch 4 (the fix): That got reworked completely. No flow controlling
   conditions in the write out phase!
 * patch 5 is a bonus! (replace fprintf by fprintf_or die) When implementing
   that I wondered if we also have close_or_die and open_or_die, but that doesn't
   seem to be the case.
   
Thanks,
Stefan

v1:

It took me longer than expected to fix this bug.

It comes with a test and minor refactoring and applies on top of
origin/sb/submodule-helper, such that it can be merged into 2.7, 2.8 as well
as master.

Patch 1 is a test which fails; it has a similar layout as the
real failing repository Norio Nomura pointed out, but simplified to the
bare essentials for reproduction of the bug.

Patch 2&3 are not strictly necessary for fixing the isseu, but it removes
stupid code I wrote, so the resulting code looks a little better.

Patch 4 fixes the issue by giving more information to relative_path,
such that a relative path can be found in all cases.

Thanks,
Stefan

Stefan Beller (5):
  recursive submodules: test for relative paths
  submodule--helper clone: simplify path check
  submodule--helper clone: remove double path checking
  submodule--helper, module_clone: always operate on absolute paths
  submodule--helper, module_clone: catch fprintf failure

 builtin/submodule--helper.c | 52 +++++++++++++++++++++++++--------------------
 t/t7400-submodule-basic.sh  | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 23 deletions(-)

-- 
2.5.0.264.g39f00fe
