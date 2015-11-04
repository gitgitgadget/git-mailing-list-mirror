From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 00/11]  Expose the submodule parallelism to the user
Date: Tue,  3 Nov 2015 16:37:03 -0800
Message-ID: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm4s-0002d9-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbbKDAhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:20 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35555 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701AbbKDAhS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:18 -0500
Received: by pasz6 with SMTP id z6so34260447pas.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=K8qzuAZWBfi9nL+nZJGnbJ9bAjmS+xqBti4XwuPol2k=;
        b=d15oGHYHAGRayYDU7Ax3w86xD8h7HngB8BAwtrmAN358fHvXy0ee96HcXd1ZduIycv
         4WpRDiC/msE9IrkIaszPde1l4y0joyMgP2ydOHLZ7oF9XchbdaBeniBy1ezFkSagqrfZ
         Y8RjNOYVhl+afjGE4R5e0bc+KsXXcB+T+FsJKuJTRFYD25/Kr15PFjVe/eqbo80X6H3F
         OOspDebdylIjUBLBfse1m6KYWk4ILKDyrIeWVtPGwp2+SmkWoZgVRy6FDprqFQQSTt7N
         Z4qxtawUd6PnpjTbG9II1Xv0SsqR9QeM1YpjfPqjp9oOebkZsTX11hehx6tJQGNxoi94
         HceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K8qzuAZWBfi9nL+nZJGnbJ9bAjmS+xqBti4XwuPol2k=;
        b=kHLmCPdM4qh7fBElTdrjVGGLH9CN6tko+s0I1QnXwpJRf/uBnqV02So8x00BGHmRCd
         gahwaW1TW0UCEGloOBCW0TatLEKj9iA39NBEctsPtZ+dByhOKO4ppFQMruPUYAnKfZ5l
         ws5e2he5kpAz58AnTqb/ursR3QiT8GvqbK2PIVIWozBYVc5n8hSK+OCs42DCsuGqUC6Q
         kVQFBELpuQat3XjUACkfTg0N0LyN1FfAbziFje1z7aYFchQs//YsIjhs7dbQwoOvd7YK
         aQ8zZfQ+mgaPM6pWdgKtaIOONACL7DQ9TjQXwhu45liV5DG8XuBy7KYIxZMvt7tqyJTJ
         tVjQ==
X-Gm-Message-State: ALoCoQl+KrN5l0U4TDn3UFySDcM7RfAm3niFeQhHsX92YERZKgZntoQP0K4BdPUS2MoPsZd4ph+/
X-Received: by 10.68.172.2 with SMTP id ay2mr36895745pbc.88.1446597438177;
        Tue, 03 Nov 2015 16:37:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id ve8sm31648240pbc.48.2015.11.03.16.37.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:17 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280833>

Where does it apply?
---
This series applies on top of d075d2604c0f92045caa8d5bb6ab86cf4921a4ae (Merge
branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update) and replaces
the previous patches in sb/submodule-parallel-update

What does it do?
---
This series should finish the on going efforts of parallelizing
submodule network traffic. The patches contain tests for clone,
fetch and submodule update to use the actual parallelism both via
command line as well as a configured option. I decided to go with
"submodule.jobs" for all three for now.

What's new in v3?
---

 * 3 new patches (make it compile in Windows, better warnings in posix environment
   for setting fds to non blocking, drop check against NULL)
 * adressed reviews by Eric for readability. :) 
 * addressed Junios comments for the new clone helper function

Stefan Beller (11):
  run_processes_parallel: delimit intermixed task output
  run-command: report failure for degraded output just once
  run-command: omit setting file descriptors to non blocking in Windows
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  submodule-config: remove name_and_item_from_var
  submodule-config: introduce parse_generic_submodule_config
  fetching submodules: respect `submodule.jobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 run-command.c                   |  26 ++++-
 submodule-config.c              | 109 +++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 433 insertions(+), 89 deletions(-)

-- 
2.6.1.247.ge8f2a41.dirty
