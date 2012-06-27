From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH/RFC v2 0/3] fast-import: disallow empty branches as parents
Date: Wed, 27 Jun 2012 23:40:22 +0600
Message-ID: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 19:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjwDW-0000nZ-Lf
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 19:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154Ab2F0Rjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 13:39:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47318 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2F0Rjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 13:39:45 -0400
Received: by lbbgm6 with SMTP id gm6so1909447lbb.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=SjvBlksg+AhS3NowroRGIiPKYAvbsC3YgKn2hvnoqEQ=;
        b=l1eCe1o27WLu6FPQO3aCElGVAwfvXbdCgcst9WyTV9CUvYyMuyzDsMRQyVpf/cluUI
         CFHlDxx0gX8rC8hQFnpYAfPA9v28Mu3Zgd5TFFgVA5sAql+y7YqFArp5ZAlhb/E6c/GG
         sIyVs8CGRLqAu5NwqEM9j1Eu2yzcsG0fEzGHoIk6UbXrtDmKU2045iN60aVesyHf1GZO
         JvzOJfpeCgM93qh9qzq0G0pG4at8p563Kfd/XZ3EXuo9RGfRR0ACmL9AxKt+S0k9Rix/
         SNJnOH8ma7pWajuB9aEoTw03P3Am3DFsyypUC/bBc5pskmk07FJDnZaxKCI4OZ23W6dU
         6ltw==
Received: by 10.152.144.168 with SMTP id sn8mr21659146lab.1.1340818784301;
        Wed, 27 Jun 2012 10:39:44 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id pp2sm84780930lab.3.2012.06.27.10.39.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 10:39:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200730>

This is a rewrite of [1].

First of all the patch is split into several parts now.

1/3 prevents writing invalid commit objects (with null_sha1 parents)

For 2/3 and 3/3 I've changed my mind almost completely. The commands
in question are:
A 'from null_sha1'
B 'from empty_branch'
C 'from itself'
D 'merge null_sha1'
E 'merge empty_branch'
F 'merge itself'

Currently C is disallowed, D and E lead to 1/3 bug, F looks broken, A and B are allowed.

In [1] I kept A allowed, but made B, C, D, E disallowed and "fixed" F.
The idea was too keep A as legacy, fix F as it may have applications and disallow others
as they look like errors in import stream.

This time I keep A and B allowed, allow D and E, disallow F.
Now I think of null_sha1 as of a special feature, empty_branch things as a mix of legacy
and this feature (one can 'reset' branch to null_sha1, then use it's name and expect it
to work as if null_sha1 was used, and null_sha1 is allowed). "Fix" for F is dropped for
now and will later go separately with it's own set of tests and a new discussion I guess.

[1] http://thread.gmane.org/gmane.comp.version-control.git/200339

Dmitry Ivankov (3):
  fast-import: do not write null_sha1 as a merge parent
  fast-import: allow "merge $null_sha1" command
  fast-import: disallow "merge $itself" command

 fast-import.c          |   29 +++++++++++++++++++----------
 t/t9300-fast-import.sh |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 10 deletions(-)

-- 
1.7.3.4
