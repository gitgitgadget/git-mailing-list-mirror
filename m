From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 0/3] Handle signed tags with 'export' remote helpers
Date: Sun, 14 Apr 2013 11:57:05 +0100
Message-ID: <cover.1365936811.git.john@keeping.me.uk>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 12:57:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URKcl-0002X8-PS
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 12:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab3DNK51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 06:57:27 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:48137 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3DNK50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 06:57:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 251C16064DD;
	Sun, 14 Apr 2013 11:57:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6z3UPzAPyo6e; Sun, 14 Apr 2013 11:57:25 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 38ACD6064E1;
	Sun, 14 Apr 2013 11:57:17 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221092>

On Sun, Apr 07, 2013 at 05:02:48PM -0700, Sverre Rabbelier wrote:
> On Sun, Apr 7, 2013 at 2:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > The remote helper infrastructure is certainly being unhelpful here.  I
> > wonder if transport-helper should just pass --signed-tag=strip and be
> > done with it (leaving open the possibility of a capability to switch
> > to --signed-tag=verbatim when someone wants to teach the testgit
> > helper to support that).  What do you think?
> 
> I think that's (at least for now) the right thing to do. Passing
> anything but signed-tag=strip should be triggered by a capability from
> the helper, since most helpers won't know how to deal with signed
> tags.

I don't like the idea of silently stripping tags, so how about this?

Patch 1 adds a new 'warn-strip' mode to 'fast-export --signed-tags=...'
which strips tags but issues a warning when doing so.  Then we make
transport-helper use that before finally adding a new capability to
allow a remote helper to change '--signed-tags=warn-strip' into
'--signed-tags=verbatim'.

John Keeping (3):
  fast-export: add --signed-tags=warn-strip mode
  transport-helper: pass --signed-tags=warn-strip to fast-export
  transport-helper: add 'signed-tags' capability

 Documentation/git-fast-export.txt   | 10 ++++++----
 Documentation/gitremote-helpers.txt |  4 ++++
 builtin/fast-export.c               |  8 +++++++-
 git-remote-testgit                  |  1 +
 t/t5801-remote-helpers.sh           | 20 ++++++++++++++++++++
 t/t9350-fast-export.sh              |  6 ++++++
 transport-helper.c                  |  7 ++++++-
 7 files changed, 50 insertions(+), 6 deletions(-)

-- 
1.8.2.694.ga76e9c3.dirty
