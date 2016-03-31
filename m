From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/4] Fix relative path issues in recursive submodules.
Date: Wed, 30 Mar 2016 17:17:33 -0700
Message-ID: <1459383457-6848-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 02:17:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQJ4-00052A-13
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbcCaARp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:17:45 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34444 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbcCaARo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:17:44 -0400
Received: by mail-pa0-f45.google.com with SMTP id fe3so52554916pab.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tNKdZVsXVy5uVytxbOgCkAjelqfVr5NroDHQ4n/uoCU=;
        b=dPWbBJGNhbSdpXivVvCe44M42d7J567CosrOhqY6wIB9NcYYBxmCd+fddaTQQ77pWC
         4SNjLdMCTUfLow+dSmXeeTZf05XVAmuhOwBfhfBBx+8PCMCRHd4FMqq4I/cS2tJj5hzu
         h3FfF42h+c58GjDPH1ZxoUYa/HDF2SaVYm6yilMS1mNS4MMPOstmtztHblub61ESfEwE
         2PDd8OnT3fr27EOhVYjWIbeOC984AOW8h/6pmSDVWnpdJ0BEGixvCuo10/V8JjUIALtS
         5NSjyj6qIQjboR5p7xk+dC1OIoRPSAZoPIj6kYA2cbWe6pZ9dqgf2avUqHEqwB8c3H8s
         VaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tNKdZVsXVy5uVytxbOgCkAjelqfVr5NroDHQ4n/uoCU=;
        b=k1u1WDrodyikGHK6dto5vFXVaI/hutfhYGWusRIz3pqMRVPj310YeL+r9gtlU0wPc5
         915HRAf4Ac9tzAsG8tUkI+yGS2CKygNKoPefV+fNv8mvVpTzjfSjK+t14/OfHkPORwGy
         /9FylFrWtOVg7ZFqM0oFeysuzZxdWxfEgyP1x2+bgU9h7YdVpzBzCtEhcxfNfddmpd/U
         XpjFq7CeGwqLow83+6Q0Q328GA77YM7NR5BSSPGdwiVeTgctu+rLgjAZ1EBHLaiPLpkF
         L/zLn7ji69fzue9SPL1kdxUn6efOXwhFkdhaZoqR7pz94mmWx+cUcHCsdT09MrG4hIiG
         54kA==
X-Gm-Message-State: AD7BkJJSYExv4shfd5E2q/l/Qmb60xQek18Xd4ZAiZUCW8fbp5WGR6vXTZo5vMRNT+dHLkVJ
X-Received: by 10.66.102.37 with SMTP id fl5mr17581478pab.32.1459383463616;
        Wed, 30 Mar 2016 17:17:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id l81sm8518425pfj.21.2016.03.30.17.17.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 17:17:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290358>

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

Stefan Beller (4):
  recursive submodules: test for relative paths
  submodule--helper clone: simplify path check
  submodule--helper clone: remove double path checking
  submodule--helper: use relative path if possible

 builtin/submodule--helper.c | 16 ++++++++--------
 t/t7400-submodule-basic.sh  | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 8 deletions(-)

-- 
2.5.0.264.g4004fdc.dirty
