From: Emil Sit <sit@emilsit.net>
Subject: Regression in git log with multiple authors
Date: Thu, 26 Aug 2010 13:39:45 -0400
Message-ID: <AANLkTikONxneEgF5m+m6100pwzThTnaiAB+OFzYufcC2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 19:39:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OogQc-00026i-G3
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 19:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab0HZRjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 13:39:49 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33551 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825Ab0HZRjr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 13:39:47 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3BBA63B2;
	Thu, 26 Aug 2010 13:39:47 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 26 Aug 2010 13:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=mime-version:date:message-id:subject:from:to:cc:content-type; s=smtpout; bh=I/HuGH83UEccZQBU2yQCIdpqU6c=; b=od/2cn513OXffTRjyN6BLz3sYsFZyrQQj1UTYocTRnnyGL4UW4Ijoy6jrerLC2NAhC4xtEG3QaFq3IzzLACj3y//qFe174mnWM9JyMxr+I8QHsD1rkC8KhlghqlapwS5cptDhr2U9wvO8bJqj5a3qH2p2Y+77f/W5xxvd4QPdiE=
X-Sasl-enc: Q7F9I64AqADwy34kNIcxYoQqV4SuJw7UKPqqY7GlJDEV 1282844387
Received: from mail-bw0-f46.google.com (mail-bw0-f46.google.com [209.85.214.46])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DE90F5E2669
	for <git@vger.kernel.org>; Thu, 26 Aug 2010 13:39:46 -0400 (EDT)
Received: by bwz11 with SMTP id 11so1279183bwz.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 10:39:46 -0700 (PDT)
Received: by 10.204.102.141 with SMTP id g13mr6410290bko.200.1282844385961;
 Thu, 26 Aug 2010 10:39:45 -0700 (PDT)
Received: by 10.204.114.140 with HTTP; Thu, 26 Aug 2010 10:39:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154549>

Commit 80235ba79ef43349f455cce869397b3e726f4058 introduced a
regression in a corner case for git log --author when multiple authors
are specified.  Prior to 1.7.0.3, if I wanted to find all commits done
by a series of authors, I could simply specify "git log --author=a1
--author=a2" to get all commits done by a1 and a2.  However, in the
latest releases, this finds nothing.

Here's a simple test case that demonstrates this:

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 023f225..587069c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -372,6 +372,14 @@ test_expect_success 'log --grep --author
implicitly uses all-match' '
        test_cmp expect actual
 '

+test_expect_success 'log --author --author matches both authors' '
+       # author matches only initial and third
+       # frotz matches only second
+       git log --author="A U Thor" --author="frotz\.com>$"
--format=%s >actual &&
+        ( echo third ; echo second ; echo initial ) >expect &&
+       test_cmp expect actual
+'
+
 test_expect_success 'grep with CE_VALID file' '
        git update-index --assume-unchanged t/t &&
        rm t/t &&

This fails against master, but if you revert 80235ba, this will pass
(whereas obviously 'log --grep --author implicitly uses all-match'
will then fail).

It doesn't seem like I can work-around this with 'git log --author a1
--or --author a2'.  Is there some other way to find commits by a set
of authors? I don't think it makes sense to treat multiple --author
flags with "and' logic since a commit can only have one author.  So
maybe all --authors should be grouped with ors and then anded against
all --committers?

-- 
Emil Sit / http://www.emilsit.net/
