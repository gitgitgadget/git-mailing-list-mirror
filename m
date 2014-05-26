From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH 0/2] Git config cache & special querying api utilizing the cache
Date: Mon, 26 May 2014 10:33:19 -0700
Message-ID: <1401125601-18249-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 19:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoyoP-00049j-Da
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 19:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbaEZRfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 13:35:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47600 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaEZRfo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 13:35:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7906207pbb.5
        for <git@vger.kernel.org>; Mon, 26 May 2014 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lTLkx5ZGX6sfuSPhLhym1bhKcyfru3SbSkyEdUc5r7U=;
        b=kojhOf3nsuFVcma1A5+A6BZbjjHbzUxbsCyCYJcXU/beTc4pjnYyv2SxrDi/NBr30u
         nXvOU4OhcRjQSuo+NMLkxYNenAfQvoO3jXN3Pe+SvO+MMhQWZmqZjmwNvQyVD6Q5Trfq
         xacVjz12Zm+wcY07gHsZuepz6qXBbmbRHydPlx5Ghx7beYsbK6WM20L6t1j942qMKSGB
         0uKqxqopGgP3yr7JKJqO90icF/LsPqz6zxHr4S9KaQIRCQ5LXjUl9hTB4gclBUBzJ5Aw
         brD4EmlddOrEHSXB/a8Eqglx7FaAGpLFPlq5107ikXv+Evq69rOzLOxf6oLn1SObr3Cs
         IIAA==
X-Received: by 10.66.136.103 with SMTP id pz7mr30179751pab.140.1401125743970;
        Mon, 26 May 2014 10:35:43 -0700 (PDT)
Received: from localhost.localdomain ([117.254.217.73])
        by mx.google.com with ESMTPSA id sh5sm19261135pbc.21.2014.05.26.10.35.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 10:35:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250108>

Hi,

This is my first patch series for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [1].

The aim of this patch series is to generate a cache for querying values from
the config files in a non callback manner as the current method reads and
parses the config files every time a value is queried for.

The cache is generated from hooking the update_cache function to the current
parsing and callback mechanism in config.c. It is implemented as an hashmap
using the hashmap-api with variables and its corresponding values list as
its members. The values in the list are sorted in order of increasing priority.
The cache is initialised in git_config_early() as it is the first time a `git_config`
function is called during program startup. setup_git_directory_gently() calls
git_config_early() which in turn reads every config file (local, user and
global config files).

get_value() in config.c feeds variable and values into the callback function.
Using this function as a hook, we update the cache. Also, we add two new
functions to the config-api git_config_get_string() and
git_config_get_string_multi() for querying in a non callback manner from
the cache.

I have run the tests and debug the code and it works, but I have to add a
few things,

1. Invalidity check: if a config file is written into, update the cache.
   I am using git_config_set_multivar_in_file() as an update hook.

2. Metadata about the variables and values. I have added only the file
   from each variable value pair comes in an upcoming series.

What else should I add or implement ;is my approach right? 

[1] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing

Cheers,
Tanay Abhra.

Tanay Abhra (2):
  config: Add cache for config value querying
  config: Add new query functions to the api

 Documentation/technical/api-config.txt |  19 ++++++
 cache.h                                |   2 +
 config.c                               | 105 +++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)

-- 
1.9.0.GIT
