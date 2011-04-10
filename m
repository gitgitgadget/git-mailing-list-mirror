From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 00/11] Sequencer Foundations
Date: Sun, 10 Apr 2011 20:41:46 +0530
Message-ID: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:13:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wK2-0007yV-JA
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab1DJPNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:13:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58633 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab1DJPNA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:13:00 -0400
Received: by iwn34 with SMTP id 34so4864294iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=3nslRyvy4p/mWinuV8qPdoUBegWZHKYZArm9tcERWLI=;
        b=OozMzk/VNONs5FHA4UfqrIFaW7O6QEuq0VaLtTkdA4sg1InkpEgVb9Ga6NVXyyh9D5
         SeH1CcWoi+nir9RJZYBTZm1jFOxVNmQxvB7DnkDhBWzBFmPWAw1m0iVWGDBLMBrub4hv
         DHqnfU3XcXthMzMhP/q2/A5eVBOvabA5zmyH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=c9UJuvdYBTS55OzPcR/Z74Uu4lBG3UlQIbgs/b48aZCwQj8TN5XI31/Jmexy0943W6
         oSQxGAL1gWELqtPpChxI1xc+TvjHaOXLH11hjrfAc4w8hufYGo0hHqGfHeVjp3SwQ3qQ
         hhdMGvu48BUUrsjCZwIY1zPqbAbPthcmK2bNE=
Received: by 10.42.144.131 with SMTP id b3mr1569429icv.13.1302448379735;
        Sun, 10 Apr 2011 08:12:59 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.12.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:12:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171255>

Hi,

I've started working on building a sequencer for Git.  While the
outline is described in [1], I'd like some additional clarifications.
A big thanks to Christian's series [2] for the valuable roadmap.

Please note that 10/11 is not related to this series, but seems to be
a minor nit that's required to make all existing tests pass.

0. Is the general flow alright?

1. Is it okay to use this kind of adaptive error handling (calling
'die' in some places and returning error in other places), or should
it be more uniform?

2. In 11/11, I've used cmd_revert and cmd_rerere.  This is highly
inelegant, mainly because of the command-line argument parsing
overhead.  Re-implementing it using more low-level functions doesn't
seem to be the way to go either: for example, 'reset --hard' has some
additional logic of writing HEAD and ORIG_HEAD, which I don't want to
duplicate.  Should I work on reworking parts of 'rerere.c' and
'revert.c', or is there some other way?

3. From the format of the TODO and DONE files, one more thing should
be clear- I'm trying to stick to a slight variation of the 'rebase -i'
format.  This part will go into the sequencer.  Then I'll use a
cherry-pick specific file to keep the command-line options.  Yes, I'm
trying to work on Daniel's idea [3] from the very start.  Is this a
good idea?

4. I have a feeling that I've broken translation strings.  Is there a
README, plus a bunch of tests I can run to make sure that I've not
broken anything?

Thanks for reading.

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170908
[2]: http://thread.gmane.org/gmane.comp.version-control.git/162183
[3]: http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170834

Ramkumar Ramachandra (11):
  revert: Avoid calling die; return error instead
  revert: Lose global variables "commit" and "me"
  revert: Introduce a struct to parse command-line options into
  revert: Separate cmdline argument handling from the functional code
  revert: Catch incompatible command-line options early
  revert: Implement parsing --continue, --abort and --skip
  revert: Handle conflict resolutions more elegantly
  usage: Introduce error_errno correspoding to die_errno
  revert: Write head, todo, done files
  revert: Give noop a default value while argument parsing
  revert: Implement --abort processing

 advice.c          |   14 ++
 advice.h          |    1 +
 builtin/revert.c  |  454 ++++++++++++++++++++++++++++++++++++++---------------
 git-compat-util.h |    2 +
 usage.c           |   34 ++++
 5 files changed, 381 insertions(+), 124 deletions(-)

-- 
1.7.4.rc1.7.g2cf08.dirty
