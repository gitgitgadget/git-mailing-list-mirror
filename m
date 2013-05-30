From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>
Subject: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 11:38:32 +0100
Message-ID: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 12:38:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui0Fk-0007SJ-P9
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 12:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556Ab3E3Kif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 06:38:35 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36056 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030549Ab3E3Kid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 06:38:33 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so161156obb.28
        for <git@vger.kernel.org>; Thu, 30 May 2013 03:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:x-gm-message-state;
        bh=q85I+gZwjwe7FjxI8S/zNrZY+4MWwPZJXYq8lHWpiLw=;
        b=UuMnEtqrhI14E1iuXajOikvvu1jSAvsADJsbU7pFIwqmGpuIz6B/KRhqajkH6IW0mH
         prOJACumYwipt827wIaS65sRlVe3vx8K0P6oBq18Uz9QJc1YnV5DolQPuu29P4grMu9i
         JrJMn1obWSr17qZXVhV1CbCTzhjy3vFa35hLo1ASzja1aG3GG7QrtjhCWI9HpFUavoZo
         lkgmcqZf3/OLJrtxqaFUoDWir/W/A7TzdwQfTn2pBrFFnOC5e2FUob2LyucdiGOxVfT4
         be77AVq1QQ0FY5jXDqbA0H0wDldoil7lSpR51PW/C62NmdDdGqYQiRfosdGYCw5hakCL
         phUw==
X-Received: by 10.182.81.34 with SMTP id w2mr3830224obx.8.1369910312714; Thu,
 30 May 2013 03:38:32 -0700 (PDT)
Received: by 10.76.98.137 with HTTP; Thu, 30 May 2013 03:38:32 -0700 (PDT)
X-Google-Sender-Auth: gJgX8_EMug6Rl3WRuNys6h9UDFo
X-Gm-Message-State: ALoCoQnJ17CnHUi3IFPwcE61vlhPCnnY9dWIJXIcfGuMQ+++FChGDQhAAJWc96SzRHnYbcb+ORNU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225955>

Hi,

I'm a fairly heavy user of the magit Emacs extension for interacting
with my git repos. However I've noticed there are some cases where lag
is very high. By analysing strace output of emacs calling git I found
two commands that where particularly problematic when interrogating
the repo:

11:00 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --long --tags
ajb-build-test-5224-10-gfa296e6

real    0m5.016s
user    0m4.364s
sys     0m0.444s

11:34 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --contains HEAD
fatal: cannot describe 'fa296e61f549a1252a65a13b2f734d7afbc7e88e'

real    0m4.805s
user    0m4.388s
sys     0m0.400s

Running with first command with the --debug flag on gives:

11:34 ajb@sloy/x86_64 [work.git] >time /usr/bin/git --no-pager
describe --long --tags --debug
searching to describe HEAD
 lightweight       10 ajb-build-test-5224
 lightweight       41 ajb-build-test-5222
 annotated        146 vnms-2-1-36-32
 annotated        155 vnms-2-1-36-31
 annotated        174 vnms-2-1-36-30
 annotated        183 vnms-2-1-36-29
 lightweight      188 vnms-2-1-36-28
 annotated        193 vnms-2-1-36-27
 annotated        206 vnms-2-1-36-26
 annotated        215 vectastar-4-2-83-5
traversed 223 commits
more than 10 tags found; listed 10 most recent
gave up search at 2b69df72d47be8440e3ce4cee91b9b7ceaf8b77c
ajb-build-test-5224-10-gfa296e6

real    0m4.817s
user    0m4.320s
sys     0m0.464s

Which has only traversed 223 before coming to a decision. This seems
like a very low number of commits given the time it's spent doing
this.

One factor might be the size of my repo (.git is around 2.4G). Could
this just be due to computational cost of searching through large
packs to walk the commit chain? Is there any way to make this easier
for git to do?


-- 
Alex, homepage: http://www.bennee.com/~alex/
