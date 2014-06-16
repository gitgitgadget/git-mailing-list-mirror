From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 0/2] Git config cache & special querying api utilizing the cache
Date: Mon, 16 Jun 2014 01:27:10 -0700
Message-ID: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 10:28:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwSHY-00052Q-4w
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 10:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbaFPI2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 04:28:44 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:45908 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbaFPI2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 04:28:43 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so4222256pdi.9
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=mlTfPgR/YvA+VDCJ8Vvl5M/5BoMvrG/L8T7LlZtWGQM=;
        b=NwQDGL/1b5YiqsA4/Cp242laQ4wW8y3ZqcY4gM9Q8UMefzbk3aaQpe3Tij7Pna3RNC
         pnG7rRlBvolGUW9rmIrho8JFEJQo306UwYfY1lhaCRlwRaZmTZHsOblzLQ6GRKZbWJQS
         LjngeX0wBOT+6Wi33DLxF8HRyeEheXmZm7bCk7we1UZtpL9CH7Q+gkuXccrGdZNy+x1k
         tk9uXuJ9J6tpGNUw2EX4Y98TLxjDTWzJ7/DM6+Wq3D/ykHkVL0dK+As7cb6ItLmkbfXy
         gmLF9sLtMavaxImhVrn+LCKSXLrKgMr346bk/7C9tGLHZbQg1v9zMUShnJw9pRie8Bvm
         cRgw==
X-Received: by 10.66.219.6 with SMTP id pk6mr22620487pac.9.1402907322738;
        Mon, 16 Jun 2014 01:28:42 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.96])
        by mx.google.com with ESMTPSA id ja8sm17290853pbd.3.2014.06.16.01.28.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 01:28:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251704>

Hi,

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

This is my first patch for this year's GSoC. My project is
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

Cheers,
Tanay Abhra.


Tanay Abhra (2):
  string-list: Add string_list initializer helper functions
  config: Add hashtable for config parsing & retrieval

 Documentation/technical/api-config.txt |  17 +++++
 cache.h                                |   2 +
 config.c                               | 123 +++++++++++++++++++++++++++++++++
 string-list.c                          |  18 +++++
 string-list.h                          |   3 +
 5 files changed, 163 insertions(+)

-- 
1.9.0.GIT
