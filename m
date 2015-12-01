From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 0/8] Untracked cache improvements
Date: Tue,  1 Dec 2015 21:31:31 +0100
Message-ID: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:32:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbF-0007tR-Bf
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547AbbLAUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33611 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbbLAUc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:28 -0500
Received: by wmuu63 with SMTP id u63so5077908wmu.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Sunf2ofvN7SjmkMpXgkwZ9bS2wkphW8onB5DoxMEoZg=;
        b=p+qcpC2WQBWqQoJhQbvL0qt+9iaWY6uWEwHM+bRpKiLU7NrzEdBBIugIdV2d2Yp0mq
         JmmeWR+DItfvgOh6nh/RsMtJZ7eSoFcd6pg3BmKrkuKrL3hDM/5P78tQZz4pQp6dcFqu
         rmZ5sRFCzHEC910YH/2hCD+IIkUDZCObrnGicZcCm1mI777hcjd6GQGwzLz1h9KN3pmJ
         n9ObG39ShGDHZGz/ZznNbDScddyE2bHVnoUTrCS+bK8Yz0fcK95eOABuzDuHPRtm8YZM
         Qa/4HVSxzZD2CERsguge9hD9RXlHAfCtMFIu+yh7DnmjNp+RLluduhJmJ4UJeR8mDcCO
         9Z3A==
X-Received: by 10.28.177.11 with SMTP id a11mr101183wmf.92.1449001946936;
        Tue, 01 Dec 2015 12:32:26 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:25 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281844>

Following the discussions on the "config: add core.trustmtime"
patch I previously sent, here is a patch series that tries to
improve the untracked cache feature.

This patch series implements core.untrackedCache instead of
core.trustmtime. core.untrackedCache is more complex because
basically when it's set to true git should always try to use
the untracked cache, and when set to false git should never
use it.

Patchs 1/8 and 2/8 add some features that are missing.
Patchs 3/8, 4/8 and 5/8 are some refactoring to prepare for
patch 6/8 which implements core.untrackedCache.

Up to patch 6/8 backward compatibility is preserved.
Patchs 7/8 and 8/8 are trying to improve usability by making
the untracked cache cli and config options more in line with
other git cli and config options, but this sacrifies some
backward compatibility.

Christian Couder (8):
  update-index: add untracked cache notifications
  update-index: add --test-untracked-cache
  update-index: move 'uc' var declaration
  dir: add add_untracked_cache()
  dir: add remove_untracked_cache()
  config: add core.untrackedCache
  update-index: prevent --untracked-cache from performing tests
  update-index: make core.untrackedCache a bool

 Documentation/config.txt               | 10 +++++++++
 Documentation/git-update-index.txt     | 30 +++++++++++++++++++-------
 builtin/update-index.c                 | 39 ++++++++++++++++------------------
 cache.h                                |  1 +
 config.c                               |  4 ++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 22 ++++++++++++++++++-
 dir.h                                  |  2 ++
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      |  2 +-
 wt-status.c                            |  9 ++++++++
 11 files changed, 90 insertions(+), 31 deletions(-)

-- 
2.6.3.391.g95a3a5c
