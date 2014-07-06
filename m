From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v5 0/3] git config cache & special querying api utilizing the cache
Date: Sun,  6 Jul 2014 00:19:20 -0700
Message-ID: <1404631162-18556-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 09:21:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3gl8-0004of-US
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 09:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbaGFHVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 03:21:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55832 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaGFHVE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 03:21:04 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so3800204pad.35
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mwnnBFCDwxwCr4zLRVP7wq3AWBdZdiG4Ar8EhXNjqUs=;
        b=U6Sb1s40jlydVsA57Lcx7pdgA7OOsa6+h1SnSIpIqil3MvAKR+wgaPAax/FS2uXY90
         6aHwkecC5eeEjT9WaA0JNz9VFD8YhpDMBCwaWVs8rprvI5YqNVMTy6P+nALjhb+HpDWs
         nYjjRiE0CJY6zOOmruLnWTJeSSPsq9aVzrndPdRj/hSP8oRMUk3N9/DTvk4sqO7P58YV
         RcVtYxLaqKMOxRAqZGn9ek03gYoZYkwbbR3RJZc+4Bz0pBEGMWRprjHFM4GFZyY77SeV
         8+qL1m474UJZshpeIqyBmyUrMG0D/eGQI4ccxJXg6lFL7PNcNWLzuArw7+1ZFYNKI7+c
         zvuw==
X-Received: by 10.66.149.102 with SMTP id tz6mr21325150pab.76.1404631263616;
        Sun, 06 Jul 2014 00:21:03 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.206])
        by mx.google.com with ESMTPSA id ix7sm48970544pbd.36.2014.07.06.00.20.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Jul 2014 00:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252928>

Hi,

[PATCH V5]: `config_set` now uses a single hashmap. Corrected style nits raised in
			the thread[7]. Thanks to Junio and Matthieu for their suggestions.

[PATCH v4]: Introduced `config_set` construct which points to a ordered set of
	config-files cached as hashmaps. Added relevant API functions. For more
	details see the documentation. Rewrote the git_config_get* family to use
	`config_set` internally. Added tests for both config_set API and git_config_get
	family. Added type specific API functions which parses the found value and
	converts it into a specific type.
	Most of the changes implemented are the result of discussion in [6].
	Thanks to Eric, Ramsay, Junio, Matthieu & Karsten for their suggestions
	and review.

[PATCH v3]: Added flag for NULL values that were causing segfaults in some cases.
	Added test-config for usage examples.
	Minor changes and corrections. Refer to discussion thread[5] for more details.
	Thanks to Matthieu, Jeff and Junio for their valuable suggestions.

[PATCH v2]:Changed the string_list to a struct instead of pointer to a struct.
	Added string-list initilization functions.
	Minor mistakes corrected acoording to review comments[4]. Thanks to
	Eric and Matthieu for their review.

[PATCH V1]:Most of the invaluable suggestions by Eric Sunshine, Torsten Bogershausen and
	Jeff King has been implemented[1]. Complete rewrite of config_cache*() family
	using git_config() as hook as suggested by Jeff. Thanks for the review.

[RFC V2]: Improved according to the suggestions by Eric Sunshine and Torsten Bogershausen.
	Added cache invalidation when config file is changed.[2]
	I am using git_config_set_multivar_in_file() as an update hook.

This is patch is for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [3].

The aim of this patch series is to generate a cache for querying values from
the config files in a non-callback manner as the current method reads and
parses the config files every time a value is queried for.

The cache is generated from hooking the update_cache function to the current
parsing and callback mechanism in config.c. It is implemented as an hashmap
using the hashmap-api with variables and its corresponding values list as
its members. The values in the list are sorted in order of increasing priority.
The cache is initialised the first time when any of the new query functions is
called. It is invalidated by using git_config_set_multivar_in_file() as an
update hook.

We add two new functions to the config-api, git_config_get_string() and
git_config_get_string_multi() for querying in a non callback manner from
the cache.

[1] http://marc.info/?t=140172066200006&r=1&w=2
[2] http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html
[3] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing
[4] http://thread.gmane.org/gmane.comp.version-control.git/251073/focus=251369
[5] http://thread.gmane.org/gmane.comp.version-control.git/251704/
[6] http://thread.gmane.org/gmane.comp.version-control.git/252329/
[7] http://marc.info/?t=140428115200001&r=1&w=2


Tanay Abhra (2):
  config-hash.c
  test-config

 .gitignore                             |   1 +
 Documentation/technical/api-config.txt | 134 +++++++++++++++
 Makefile                               |   2 +
 cache.h                                |  34 ++++
 config-hash.c                          | 297 +++++++++++++++++++++++++++++++++
 config.c                               |   3 +
 t/t1308-config-hash.sh                 | 187 +++++++++++++++++++++
 test-config.c                          | 127 ++++++++++++++
 8 files changed, 785 insertions(+)
 create mode 100644 config-hash.c
 create mode 100755 t/t1308-config-hash.sh
 create mode 100644 test-config.c

-- 
1.9.0.GIT
