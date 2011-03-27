From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] tests: use the --long-tests facility to toggle some slow
 tests
Date: Sun, 27 Mar 2011 18:00:25 -0500
Message-ID: <20110327230025.GD27445@elie>
References: <4D8FAAAC.3050905@web.de>
 <20110327213756.GD25927@elie>
 <4D8FB995.20001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 28 01:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3yxx-0002Re-OC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 01:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1C0XBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 19:01:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39143 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1C0XAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 19:00:34 -0400
Received: by iyb14 with SMTP id 14so2501891iyb.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pQy+SBrzQ/nIk2Raw1XtcRkfrH2YjD9weFGFEb1E4Ks=;
        b=uHvsdTjSIurYasY2bkjNACMixzwOmg4bq9Zyx+Aj+RBv1vRxUJg2GM7Z7L4k7dkqb1
         A7gBIorvhhVbW6y3vP33Rr/er6H9+xhYIpc1ZgEOu9E/6saylBax51w/XtOjL7XGbzJo
         R7q14FsUHyA7Ym/VbM9dvuUi4ZWqUvGkwLWHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vVYwhGigDCCewsgBVnUFyoq7FDZmhrLV4g2uwqO8xLvDjkEvo9qyqkd10deb9VX+w/
         ykSNVx6+SWTHploLDeihAmwID0uGFcOFhFFhoL/ewOV2LtOAfOVdWSpezFF3fnM0mApj
         hg5OccyZF3Am6JUh9O82K4nAhv2G6vMeMawwo=
Received: by 10.42.156.70 with SMTP id y6mr5119747icw.524.1301266833592;
        Sun, 27 Mar 2011 16:00:33 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id jv9sm2380414icb.13.2011.03.27.16.00.31
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 16:00:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8FB995.20001@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170093>

The GIT_TEST_LONG facility (v1.6.0-rc0~246, 2008-06-17) was added to
support tests for a gitweb caching engine that was never merged.
So --long-tests has been a no-op for years.

Since then, some other expensive tests have sprouted up that fit its
description pretty well, namely:

 - GIT_NOTES_TIMING_TESTS
 - GIT_PATCHID_TIMING_TESTS
 - GIT_REMOTE_SVN_TEST_BIG_FILES

All of these are not part of the default test run because they are
expensive.  Let's replace their existing, undocumented triggers with
GIT_TEST_LONG, so now you can do

 sh t3302-notes-index-expensive.sh -l -v

to get a sanity check for notes lookup performance scalability.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jens Lehmann wrote:

> Right you are, this version includes those too (but - except once for
> GIT_VALGRIND_OPTIONS - none of them are mentioned in t/README, that's why
> I managed to miss them ... maybe they should be documented there?).

Good idea.  See below for a possible sneaky way to document three of
them.

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -46,7 +46,7 @@ unset VISUAL
>  unset EMAIL
>  unset $(perl -e '
>  	my @env = keys %ENV;
> -	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP)/, @env);
> +	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP|NOTES_TIMING_TESTS|PATCHID_TIMING_TESTS|PROVE_OPTS|REMOTE_SVN_TEST_BIG_FILES|SKIP_TESTS|TEST|VALGRIND_OPTIONS)/, @env);

My poor terminal. :)  I sent a possible more invasive change that
breaks this into multiple lines but it looks like our mails crossed.
Anyway, I have no serious complaint; it might be that this one is the
best way to go.  

 t/t0081-line-buffer.sh           |    2 +-
 t/t3302-notes-index-expensive.sh |    2 +-
 t/t3419-rebase-patch-id.sh       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 1dbe1c9..099abe0 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -12,7 +12,7 @@ correctly.
 "
 . ./test-lib.sh
 
-test -n "$GIT_REMOTE_SVN_TEST_BIG_FILES" && test_set_prereq EXPENSIVE
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 generate_tens_of_lines () {
 	tens=$1 &&
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index e35d781..62820d0 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,7 +8,7 @@ test_description='Test commit notes index (expensive!)'
 . ./test-lib.sh
 
 test_set_prereq NOT_EXPENSIVE
-test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 create_repo () {
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index bd8efaf..0419e81 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -5,7 +5,7 @@ test_description='git rebase - test patch id computation'
 . ./test-lib.sh
 
 test_set_prereq NOT_EXPENSIVE
-test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
+test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 count()
-- 
1.7.4.2
