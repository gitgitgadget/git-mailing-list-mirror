From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 00/20] Refactor rebase
Date: Thu, 25 Nov 2010 20:57:43 +0100
Message-ID: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna3-0001kp-Vn
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab0KZB6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab0KZB6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:06 -0500
Received: by vws3 with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E0PMC7LiFaCDmZKl4JtfCzXpao5NNSi1L7BLS5rz3Qo=;
        b=hOmF0ISHfz4Frbt93Yrr4Rrs26kA3iDEnoB2wop9ZCoTlqIq6FkSQVqly8KMxWh52+
         PPoDTqlFWN6Bb3RMHx/CI0iPafN0y/hDu+eTtY1DUCwxjw+Fl9/UGFWq+NquSBVCqXgg
         44/ruErjX5TWtKg96Hvb8Z/ZgOU43RuyKmIy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Rk7NClt0lcmjQRMctsM6ofqZ/XV9SR4/8eChGii2n7RJIeTKAystC672umFXT/5R7l
         P0ZYT9x6D5UUuVIkXeWPlD7QRchJ9CQkQAvcDWTogn/sJoBIS+UfprzRTDMuUK6JJ3rx
         L4Kke+LW2ZPxCrtFklp5BzsBde6aa4u8cGpMw=
Received: by 10.220.159.196 with SMTP id k4mr353010vcx.196.1290736685086;
        Thu, 25 Nov 2010 17:58:05 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:04 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162160>

This is a first draft of my attempt to refactor the rebase code. I
have tried to refactor it as Hannes suggested, namely "to write a
command line processor, git-rebase.sh, that sets shell variables from
options that it collects from various sources, then dispatches to one
of git-rebase--interactive.sh, git-rebase--merge.sh, or
git-rebase--am.sh (the latter two would be stripped-down copies of the
current git-rebase.sh)."


Patches 01-04 try to make git-rebase.sh more readable and extensible.

Patches 05-16 factor out common code between git-rebase.sh and
git-rebase--interactive.sh.

Patches 17-20 finally achieve, I hope, what Hannes suggested.


I have aligned a lot of the error checking and error messages, but I
still have barely gotten to align any of the command line options
supported by 'git rebase' and 'git rebase -i'. How do you think I
should continue? Some specific questions:

1. What should -v do? Interactive rebase currently prints most
commands it is about to execute, while non-interactive rebase only
prints a header to the diffstat. Is there any reason they should be
different? If not, what should they print?

2. Interactive rebase currently saves most command line options when
the rebase is initiated and then reads then back on '--continue'
etc. Non-interactive rebase does not store any options and allows them
to be passed on the command line when the rebase is continued
instead. Any reason for the difference? What do we want?


All feedback would be greatly appreciated! I'm new to the Git code,
new to development on Linux and even quite new to bash, so please
review very carefully. Thanks!


Martin von Zweigbergk (20):
  rebase: clearer names for directory variables
  rebase: refactor reading of state
  rebase: read state outside loop
  rebase: remove unused rebase state 'prev_head'
  rebase: act on command line outside parsing loop
  rebase: collect check for existing rebase
  rebase: stricter check on arguments
  rebase: align variable names
  rebase: align variable content
  rebase: factor out command line option processing
  rebase -i: remove now unnecessary directory checks
  rebase: reorder validation steps
  rebase: factor out reference parsing
  rebase: factor out clean work tree check
  rebase: factor out call to pre-rebase hook
  rebase -i: support --stat
  rebase: improve detection of rebase in progress
  rebase -m: extract code to new source file
  rebase: extract am code to new source file
  rebase: show consistent conflict resolution hint

 .gitignore                 |    2 +
 Makefile                   |    2 +
 git-rebase--am.sh          |   34 +++
 git-rebase--interactive.sh |  554 ++++++++++++++++----------------------------
 git-rebase--merge.sh       |  154 ++++++++++++
 git-rebase.sh              |  434 ++++++++++++-----------------------
 6 files changed, 538 insertions(+), 642 deletions(-)
 create mode 100644 git-rebase--am.sh
 create mode 100644 git-rebase--merge.sh

-- 
1.7.3.2.864.gbbb96
