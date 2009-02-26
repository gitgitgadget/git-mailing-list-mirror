From: Deskin Miller <deskinm@umich.edu>
Subject: [RFC PATCH 0/4] git log -g --pretty=format: learns about reflog
Date: Wed, 25 Feb 2009 23:44:03 -0500
Message-ID: <cover.1235622145.git.deskinm@umich.edu>
Cc: trast@student.ethz.ch, Deskin Miller <deskinm@umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 05:46:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcY8J-0000kl-WA
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 05:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbZBZEoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 23:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbZBZEoS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 23:44:18 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:61492 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZBZEoS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 23:44:18 -0500
Received: by gxk22 with SMTP id 22so939871gxk.13
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 20:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=HF0coXacTtvoWWhydwMVkNRa49syU9w7ZIsDS4HrXrM=;
        b=Borz9jR05qCbWQiSgW4ow9s+xKk4CYIQ51KgH/Nge/7R8n/vlvHRDWTECOuUetx0M/
         rrthciHRbdOF72rEqb/bE62eANazXezlDky5v/scKaW7dSDFgd+Gb0P5YWy85XiTWCTD
         zsC0yUyb5W6CjdvKiTFFp08xjzDOms7rlwC4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=ALSn8m2gGziysgpRlza3cESu35Y2b5bJmzHcdQEog/Srj/a9kibk1P2zOewbhg4sLJ
         /W0vi0kosmJvxnjY8PzjC3IItsbhi+xszsGCWTG55QBhyLuGsNMnwptsBxrSD3hFwdh9
         av1s2LOPiYPU8VaC5JOaRWRYR7vpiw+OJWOqs=
Received: by 10.231.30.67 with SMTP id t3mr1365373ibc.21.1235623455394;
        Wed, 25 Feb 2009 20:44:15 -0800 (PST)
Received: from localhost.localdomain (67-194-38-22.wireless.umnet.umich.edu [67.194.38.22])
        by mx.google.com with ESMTPS id s35sm3517319qbs.6.2009.02.25.20.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 20:44:14 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.90.g0753
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111524>

This series exposes reflog information to the pretty-printer when using
--pretty=format: to git log -g and git rev-list --walk-reflogs, through
similar format codes as are used currently.

Thomas Rast mentioned almost as an aside that this would be useful in 

http://article.gmane.org/gmane.comp.version-control.git/108009

and I've wanted to hack this series for a long time, even before that
comment, but my first attempts broke stash horribly.  Hopefully this
version fares better.

I'm a little leery of using commit->util to carry the reflog info, but I
didn't see a much better way, without altering the signature of
pretty_print_commit to take an optional reflog parameter.  The code
checks that util is not being used before assigning the reflog to it, so
it shouldn't break any existing uses of util of which I am unaware.  I
confess to having not done an appropriate amount of research into
whether my use of util will actually break anything.  For what it's
worth this patch series doesn't break any existing tests.

One of the things I was hoping to do in the unsuccessful version was to
allow the revision walker to use the reflog, but let the commit
structures retain their real parents.  That way, one could still obtain
meaningful information from %p even when walking reflogs, which would be
distinct from %rp.  It is primarily with this in mind that %rp exists at
all.  However, as I mentioned, my attempt to change the revision walker
broke existing tests, and I didn't have the wherewithal to discover how
to correct it.  It's possible with the current series that one could
simply try to re-parse the commit, but I haven't investigated the
feasibility of doing that.

I strongly suspect that there's a cleaner way to do this, but don't
really know what that would be, so any comments regarding alternate
approaches would be very appreciated.  Also, I'm more than happy to
write testcases and documentation once there is some agreement about
what the preferred implementation is.

Deskin Miller (4):
  Expose reflog_info struct in header
  Add attach_reflog_info
  Attach reflog to commit prior to pretty-printing
  Teach pretty-printer new reflog format codes

 list-objects.c |    3 +++
 log-tree.c     |    3 +++
 pretty.c       |   38 ++++++++++++++++++++++++++++++++++++++
 reflog-walk.c  |   26 +++++++++++++++++++-------
 reflog-walk.h  |   12 ++++++++++++
 5 files changed, 75 insertions(+), 7 deletions(-)
