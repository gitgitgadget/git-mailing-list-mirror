From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 0/3] git config cache & special querying api utilizing the cache
Date: Mon, 23 Jun 2014 03:11:37 -0700
Message-ID: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:13:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1FT-0001oB-Mk
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbaFWKNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:13:12 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52273 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaFWKNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:13:11 -0400
Received: by mail-pb0-f54.google.com with SMTP id un15so5732227pbc.27
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hHBVFc2Ou+zSA2KO1I5oyh2kKlI0/aYJoS67uDPpdIk=;
        b=gT3/sbLk91VhoEv2gNmD6SY01ZryK94J7sQXI6Flajo+i+t3dJ4redBIwbSbk7ZOh1
         0r1belw8fELfnFCNDZKfhiWhHEYVUJn+TOQytp6Rf6jgjWcDo/xiykGUFejLFrngqA7l
         mpF/0ll6qTyrh4DCqRR3s+fwraYLj45ECAkvQAb15qeYl5EOggoveK9JooaNcmqZq30F
         dJABC1QoVeX7bCH3T8CvFM+Qt8N/MzXXUNCqQkWLYMOUagWPCOr7PfB80mre462nNKXG
         uVoyrUpo5PsxHUIX4zXuwAZEJSUPPBZsMa7RNClENgAmKgBF525NATnMn5Ar0ZjpbIkz
         ejPg==
X-Received: by 10.66.147.99 with SMTP id tj3mr27973994pab.47.1403518390320;
        Mon, 23 Jun 2014 03:13:10 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id io8sm26085321pbc.96.2014.06.23.03.13.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:13:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252329>

Hi,

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
[5] http://thread.gmane.org/gmane.comp.version-control.git/251704/

Tanay Abhra (3):
  string-list: Add string_list initializer helper functions
  config: Add hashtable for config parsing & retrieval
  test-config

 .gitignore                             |   1 +
 Documentation/technical/api-config.txt |  26 ++++++
 Makefile                               |   1 +
 cache.h                                |   2 +
 config.c                               | 144 +++++++++++++++++++++++++++++++++
 string-list.c                          |  18 +++++
 string-list.h                          |   3 +
 test-config.c                          |  93 +++++++++++++++++++++
 8 files changed, 288 insertions(+)
 create mode 100644 test-config.c

-- 
1.9.0.GIT
