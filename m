From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v10 00/14] interactive git-clean
Date: Thu, 16 May 2013 17:53:31 +0800
Message-ID: <cover.1368696028.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 11:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucust-0000ZI-OP
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab3EPJx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:53:59 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:52176 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3EPJx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:53:58 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so2196599pde.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=fPLJgUcYZSP29IDaovqBuyz19EsoSSSyUuzu6jKNCwk=;
        b=gLBoUbZth9/YtLUfw2vGxFLpY2W5Dj4w5tm1+gxNLJ0+KIELIysWhN5gIWoVTK8R/9
         hZnWEybo0XV4jzDGTyOwq4QH4tS6MW8ecV4hPX4AwEFf3lVYLE5pG7SPCDLECP0KsQWm
         2xgLb6om+t5ADyas7OPAB0ePW4RwlnHg6EJo3ncm1fjfO2Iw7iyed58Qgl6pY/nTbpc9
         MGAh5IOyZCxLIeBT1QJIq5UBufZN/WtZLYxd7Qs522aPucg4NSeDTjWmhKzm5ogK1BjB
         r5l0QGMJvzfPylsfRunysADUoQA1Ik/JvsR/BNda+2L9IZfxxdRAyQBiN0NqB9p51wyP
         HOKQ==
X-Received: by 10.68.237.74 with SMTP id va10mr42632394pbc.76.1368698037946;
        Thu, 16 May 2013 02:53:57 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id cd2sm6183092pbd.35.2013.05.16.02.53.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 02:53:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.407.g762149a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224528>

Updates since v9:

 * Patch 01-04: refactor relative_path() in path.c, and reused it in
   quote.c and clean.c.

 * Patch 14: add testcases as t7301, and catch two bugs by running
   testcases.

 * Bugfix: when select by number, range like "5-" does not select
   last entry.

     @@ -485,7 +443,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
      			bottom = atoi((*ptr)->buf);
      			/* a range can be specified like 5-7 or 5- */
      			if (!*(strchr((*ptr)->buf, '-') + 1)) {
     -				top = menu_stuff->nr - 1;
     +				top = menu_stuff->nr;
      			} else {
      				top = atoi(strchr((*ptr)->buf, '-') + 1);
      			}
     
 * For the "ask each" action, confirmation other than "yes" should not
   delete files.

     @@ -772,7 +730,7 @@ static int ask_each_cmd(void)
      				eof = 1;
      			}
      		}
     -		if (!confirm.len || !strncasecmp(confirm.buf, "no", confirm.len)) {
     +		if (!confirm.len || strncasecmp(confirm.buf, "yes", confirm.len)) {
      			*item->string = '\0';
      			changed++;
      		}


Jiang Xin (14):
  path.c: refactor relative_path(), not only strip prefix
  quote.c: remove path_relative, use relative_path instead
  Refactor quote_path_relative, remove unused params
  Refactor write_name_quoted_relative, remove unused params
  git-clean: refactor git-clean into two phases
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean: add documentation for interactive git-clean
  test: add t7301 for git-clean--interactive

 Documentation/config.txt     |  21 +-
 Documentation/git-clean.txt  |  71 +++-
 builtin/clean.c              | 771 +++++++++++++++++++++++++++++++++++++++++--
 builtin/grep.c               |   5 +-
 builtin/ls-files.c           |  16 +-
 cache.h                      |   2 +-
 path.c                       | 112 +++++--
 quote.c                      |  65 +---
 quote.h                      |   7 +-
 setup.c                      |   5 +-
 t/t7301-clean-interactive.sh | 439 ++++++++++++++++++++++++
 wt-status.c                  |  17 +-
 12 files changed, 1380 insertions(+), 151 deletions(-)
 create mode 100755 t/t7301-clean-interactive.sh

-- 
1.8.3.rc1.407.g762149a
