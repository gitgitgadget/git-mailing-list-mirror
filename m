From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v6 0/4] config: add support for http.<url>.* settings
Date: Fri, 19 Jul 2013 05:48:41 -0700
Message-ID: <9a5e7ef2eb19b10b28f154b3d5e03cd@f74d39fa044aa309eaea14b9f57fe79>
Cc: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 14:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0A7I-0007zM-D5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 14:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759544Ab3GSMs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 08:48:56 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42007 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab3GSMsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 08:48:55 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so4399246pab.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JSQGABAHnj/MT4i7icw9WG79nthIBbT1m3rANK3MFMY=;
        b=j5xsMtstwF04ctd8EKIm1Mirw2EpHn+mL20N67tFFhLXZz49ODNVph7v0I5oUQ25PE
         RSZXWQDeMgQmxtvmdgJlretbHY4tsg0coaKgejs3a0XtAJHtL0W41oUsoAC8vAOKFtdV
         qMUL0WChfF4ABMyMJPMwigNWB7k7Lj1nGHR6jHuvMY1TJpDUWuzmZGr3c+LIRBMAwnaI
         vF2kc2wWe8lQOJx9CI5i+ch8MFR+7pGIQgN9jTj6n2xF8xljsSKlCLXThC4CqJsPcUWW
         AKO5JUhc6VghQ99s/vWZmkwbzegmTaJYqYmHuYKxMPRsdRBnlctPsF1NtOSIQdN6FT9d
         J3XA==
X-Received: by 10.68.52.10 with SMTP id p10mr17232770pbo.92.1374238135021;
        Fri, 19 Jul 2013 05:48:55 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ry2sm19426942pbc.41.2013.07.19.05.48.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 05:48:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230800>

NOTE: This patch requires the following preparatory change:

 f1ff763 http.c: fix parsing of http.sslCertPasswordProtected variable

which is currently in pu.


This patch series adds support for http.<url>.* settings.  The patch is
organized as a series of improvements on the functionality:

1/4 - adds basic textual matching support
2/4 - adds URL normalization before matching
3/4 - adds a test for the URL normalization function
4/4 - adds any user matching


With-Feedback-From-jh: Junio C Hamano <gitster@pobox.com>
With-Feedback-From-jk: Jeff King <peff@peff.net>
With-Feedback-From-es: Eric Sunshine <sunshine@sunshineco.com>

Differences from v5:

Dropped the GIT_SSL_CERT_PASSWORD_PROTECTED patch.  It's related to the
http.sslCertPasswordProtected patch, but not required as it touches different
sections of the http.c file.

1/4 - this is identical to v5's 3/5.  Updated from v4's 1/4:

* Added cover comments to log message (feedback-jh)
* Updated help text (feedback-jk)
* Uppercased enum values (feedback-jk)
* Moved #ifdef enum values to end (feedback-jh)
* Renamed check_matched_len to new_match_is_shorter (feedback-jh)
* Removed 1 unnecessary cast (feedback-jk,feedback-jh)
* Based on preparatory http.sslCertPasswordProtected fix (feedback-jh)

2/4 - Updated from v5's 4/5:

* Altered append_normalized_escapes descriptive comments (feedback-es)
* Improved normalization (keep empty user name, strip port leading 0s and
  resolve . and .. in path)

3/4 - Updated from v5's 5/5:

* Add more tests and adjust to improved normalization behavior

4/4 - New code

* Allow a http.<url>.* config item without a user name to match a url passed
  to git that has a user name


Applicable comments from v5 cover:

To better support matching URLs that are equivalent but spelled differently, a
url_normalize function has been added.  Currently this patch leaves it in
http.c as http_options_url_normalize as I am unclear whether it should go into
url.{h,c} at this time since only http.c uses it.

Since the url_normalize function's behavior is non-trivial, it is presented as
a separate patch on top of the basic http.<url>.* settings support.  A new test
for it has also been included as a separate patch.  I am unclear on the proper
number for this test, but have gone ahead and put it with the other http tests
since this patch series places the url_normalize function into http.c.


Kyle J. McKay (4):
  config: add support for http.<url>.* settings
  config: improve support for http.<url>.* settings
  tests: add new test for the url_normalize function
  config: allow http.<url>.* any user matching

 .gitignore               |   1 +
 Documentation/config.txt |  19 ++
 Makefile                 |   5 +
 http.c                   | 675 +++++++++++++++++++++++++++++++++++++++++++++--
 t/t5200-url-normalize.sh | 161 +++++++++++
 test-url-normalize.c     |  62 +++++
 6 files changed, 906 insertions(+), 17 deletions(-)
 create mode 100755 t/t5200-url-normalize.sh
 create mode 100644 test-url-normalize.c

-- 
1.8.3
