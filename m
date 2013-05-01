From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 1 May 2013 12:31:53 +0400
Message-ID: <1409591910.20130501123153@gmail.com>
References: <1438528085.20130501090926@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Ray Chen <rchen@cs.umd.edu>,
	Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 10:33:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXSTt-0007yA-1B
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 10:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab3EAIdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 04:33:37 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:51885 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3EAIde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 04:33:34 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so1166449lab.29
        for <git@vger.kernel.org>; Wed, 01 May 2013 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=5r6P8hJWdePij4V9d8txGjEpbwX4lGH1iXRd1WwO5AE=;
        b=Sd+q4e2l3cXPXoyoRLTw4JEvnXiTurjdqb0PdeHUxxGHgqiXEHYUbY2rc4QCQ9wRJy
         3Ctbg4D5ja44OO1tyBopj8302StbCiPJrQZD+G9afcS63A3mWE1oWA/mH//dFNOf8wBo
         L964ClbRE1nxcrHY6bUKZNlKYz7s9VHIW3V7ayaSlSmcbbU2QHyULF3mCZfXj/S3k3k/
         XN4nAospzFPPh2Gg5yhTNRSaEFPt3JxI7EkKSuBwlAUngObe6KO0DUupDJurle+oFGwq
         xhTgh1zfKFebjDpXe3H6a/ux18kzu5m6U+208Ie1X6G4WDIxEaE26u2LSYVHHvlUxA4G
         58TQ==
X-Received: by 10.112.5.137 with SMTP id s9mr859437lbs.68.1367397213008;
        Wed, 01 May 2013 01:33:33 -0700 (PDT)
Received: from [192.168.0.78] (92-100-238-23.dynamic.avangarddsl.ru. [92.100.238.23])
        by mx.google.com with ESMTPSA id l20sm855023lbv.9.2013.05.01.01.33.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 01:33:31 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <1438528085.20130501090926@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223075>

IB> In my repo the placeholders change too often (in 1/4 commits). I'm
IB> thinking of using:
IB> 'git config --unset "svn-remote.$repo_id.added-placeholder" path_regex'
IB> instead of full rewrite.

I need your help. There are still problems:

    $ grep "define MAX_MATCHES" ~/builds/git/git-git/config.c
    #define MAX_MATCHES 8192

    $ grep added-placeholder .git/config | wc -l
    4430

1/4 commits change the list of placeholders, usually 1 folder changes.
Clearing and re-adding the entries to the config takes ~1 minute.
Pressing Ctrl-C at this time makes the list incomplete.

Re-adding all entries using 'config --add' is slow.
Does Git::config package have tools to modify multiple entries at once?
I wonder why 'git config --get-all' is used instead of some
Git::config routine.

Otherwise, to make this atomic, I think, the modification should be made
to a backup config file, then it should replace .git/config (or
rewrite it with signals blocked).

How to determine GIT_DIR from Fetcher.pm?

maybe I can simply append a duplicate section
'[svn-remote "svn"]'. But then I would need to escape the values
myself.

Also, git --unset-all leaves one empty section: '[svn-remote "svn"]'
Is it a bug?

-- 
