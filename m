From: Jeffrey Walton <noloader@gmail.com>
Subject: Git configure/make does not honor ARFLAGS
Date: Sun, 30 Aug 2015 17:34:59 -0400
Message-ID: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
Reply-To: noloader@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 23:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWAG7-0000t4-R3
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 23:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbbH3VfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 17:35:11 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34893 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbbH3VfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 17:35:00 -0400
Received: by iog7 with SMTP id 7so16567187iog.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=wn+cTI6qaJF8MRZ0YlMYVnc/41rdS5ZGy9AEtP/VW8M=;
        b=vELOOWVSXvQmg/5HG46O1q1wIQw28NZmL0rGxwe/StFEeHNneE+LxB1/TF3EOPX5NU
         91RfaIL+qu67sOrpLpD0LZf21yqDtmMhvY2HrjpQyFHSzhQEjsXqEM8FnvH9b1stlTAn
         pzrp2XTAsh50DwesO07faWW7f6JBgGjRyqr5CGhhYWSzvm+wTrJ+soyknlNnxkbqBB3B
         sNW+1G8siqBj3IUfX6bEOUx3S09wYMT9JXBJ0ApipW/fMmTw1O1JOc7Lh+Oq1t1jM3ZD
         eImvF89MIZDnPbABQU3ozKbYS/DdkyeOy8aymHaltDL55EeRpLNtkPAWuR9o+sc9dsXJ
         wc9Q==
X-Received: by 10.107.16.139 with SMTP id 11mr27196475ioq.122.1440970499573;
 Sun, 30 Aug 2015 14:34:59 -0700 (PDT)
Received: by 10.36.123.215 with HTTP; Sun, 30 Aug 2015 14:34:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276838>

I'm working on an old OS X machine. I needed to perform:

  AR=libtool
  ARFLAGS="-static -o"
  ...
  make configure
  ./configure ...
  make

However, it appears the Makefile does not respect ARFLAGS:

    $ grep -IR '$(AR)' *
    Makefile:    $(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
    Makefile:    $(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
    Makefile:    $(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^

It was fixed with a quick "sed":

    sed -i "" 's|$(AR) rcs|$(AR) $(ARFLAGS)|g' Makefile

The Makefile might benefit from the following for users who need to
tweak things:

    ARFLAGS ?= rcs
    ...

    $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    ...
