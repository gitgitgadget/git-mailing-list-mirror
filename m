From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH v2 0/2] Git config cache & special querying api utilizing the cache
Date: Mon,  2 Jun 2014 07:47:38 -0700
Message-ID: <1401720460-6525-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 16:48:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrTXZ-0007GE-UF
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 16:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbaFBOsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 10:48:41 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39313 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbaFBOsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 10:48:41 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so3498194pdb.38
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ybas+6m76ce7ujsnd+NFo6JA3kr5JzehZ1WauAIHeok=;
        b=R/nkCCvT9UD6hGUopq4YRZ/AuYqZ89SkCccUNXF4Y8RqZI5wLP6+t34FTpDGuPKTS8
         oz8fg4AaxJvJ1WnmlWwFYCPBzCMtaIDkUzWH16EfmcrWElZG+8bV0ydYEGy+wr5U4ShF
         KsbO85BP0PO0O1LhfUiNFkfFsbzJ+tX1hxMfsnPwn4wWQDeFBukMFgq3lij2k+5twdjA
         pEj3imk/VULbFcYlNkpfvgaFMqTKGBPRT/yoLY4Q+eGI+MonkH3rNZbFH64NoK/JhEvW
         VbzqY6jjLB+0f6kv6UQMt+LZBn1MySwctm5SK4frrId/lprMF4aG8/FQnWZZuw0aoHSD
         0d9A==
X-Received: by 10.66.190.167 with SMTP id gr7mr40157466pac.75.1401720520719;
        Mon, 02 Jun 2014 07:48:40 -0700 (PDT)
Received: from localhost.localdomain ([117.254.216.65])
        by mx.google.com with ESMTPSA id ja8sm20927802pbd.3.2014.06.02.07.48.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 07:48:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250566>

Hi,

[V2]: Improved according to the suggestions by Eric Sunshine and Torsten Bogershausen.
      Added cache invalidation when config file is changed.
      I am using git_config_set_multivar_in_file() as an update hook.

This is my first patch series for this year's GSoC. My project is
"Git Config API improvements". The link of my proposal is appended below [1].

The aim of this patch series is to generate a cache for querying values from
the config files in a non-callback manner as the current method reads and
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

1. Metadata about the variables and values. I have added only the file
   from each variable value pair comes in an upcoming series.

What else should I add or implement ;is my approach right? 

[1] https://drive.google.com/file/d/0B4suZ-aHqDcnSUZJRXVTTnZUN1E/edit?usp=sharing

Cheers,
Tanay Abhra.

Tanay Abhra (2):
  config: Add hashtable for config parsing & retrieval
  config: Add new query functions to the api docs

 Documentation/technical/api-config.txt |  18 +++++
 cache.h                                |   2 +
 config.c                               | 118 +++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)

-- 
1.9.0.GIT
