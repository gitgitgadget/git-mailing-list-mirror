From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v1] Git config cache & special querying api utilizing the cache
Date: Mon,  9 Jun 2014 05:49:05 -0700
Message-ID: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 14:50:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtz2G-0000NI-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 14:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbaFIMup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 08:50:45 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53085 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbaFIMuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 08:50:44 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so4868831pbb.31
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bGOqw9d15mbquNiu3BtjV6HvuxQVfhHDE+7JYwvHhuc=;
        b=QCogIpUrIypFS+7XdOvMN054bUv+iGnrBaDcybGrgXWggvk/vM98xMflIvWmDNoXjB
         LL6c/SISBIRFuo7EJn3w+/0dy5JCqqJtNRUc4yse3qjcOr6MMvnU13CWTOgIj75+HV3Y
         KKTmqjWJPedvtnaJkvg8q2QVpCxoezTy8dx5KGFCedB1fwJ/GjXslVLZ9gv1JVzGj1yw
         Mpp0zfqPJnkNtUnrsECsyL9HMEnETsC/V3C5O8rjRDRhygiM6oeN4NP+8nn6+ofe1HOH
         fp+30QgyDKhYguUwMDPZpSL5gNAtfVrD2OUYZSNoVLOesKF8C3ScTmWueF7hzN4F+b4o
         XjFQ==
X-Received: by 10.66.65.225 with SMTP id a1mr3661458pat.139.1402318243629;
        Mon, 09 Jun 2014 05:50:43 -0700 (PDT)
Received: from localhost.localdomain ([117.254.220.136])
        by mx.google.com with ESMTPSA id qw8sm63962212pbb.27.2014.06.09.05.50.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 05:50:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251073>

Hi,

I am taking this patch out of RFC.

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

I have run the tests and debug the code using custom functions and it works
fine.

[1] http://marc.info/?t=140172066200006&r=1&w=2
[2] http://git.661346.n2.nabble.com/RFC-PATCH-0-2-Git-config-cache-amp-special-querying-api-utilizing-the-cache-td7611691.html
[3] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing

Cheers,
Tanay Abhra.

Tanay Abhra (1):
  config: Add hashtable for config parsing & retrival

 Documentation/technical/api-config.txt |  18 +++++
 cache.h                                |   2 +
 config.c                               | 122 +++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)

-- 
1.9.0.GIT
