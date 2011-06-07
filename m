From: Jamey Sharp <jamey@minilop.net>
Subject: Re: What's cooking in git.git (Jun 2011, #01; Sun, 5)
Date: Tue,  7 Jun 2011 11:21:21 -0700
Message-ID: <1307470885-4018-1-git-send-email-jamey@minilop.net>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 20:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0uo-0003Lr-N9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 20:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805Ab1FGSVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 14:21:48 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:41134 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916Ab1FGSVr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 14:21:47 -0400
Received: by pxi2 with SMTP id 2so3878962pxi.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 11:21:46 -0700 (PDT)
Received: by 10.68.5.234 with SMTP id v10mr307134pbv.132.1307470906506;
        Tue, 07 Jun 2011 11:21:46 -0700 (PDT)
Received: from oh.minilop.net (host-246-101.pubnet.pdx.edu [131.252.246.101])
        by mx.google.com with ESMTPS id i7sm298252pbj.26.2011.06.07.11.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 11:21:45 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QU0uO-00013T-Ci; Tue, 07 Jun 2011 11:21:44 -0700
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175247>

On Sun, Jun 05, 2011 at 11:29:13PM -0700, Junio C Hamano wrote:
> * js/ref-namespaces (2011-06-05) 4 commits
>  - ref namespaces: documentation
>  - ref namespaces: support remote repositories via upload-pack and receive-pack
>  - ref namespaces: infrastructure
>  - Fix prefix handling in ref iteration functions
> 
> Fairly involved feature enhancement, and breaks tests when merged to 'pu'.
> Not urgent. Will not merge before 1.7.6.

We tracked down the test failure.  t5501 detects that pushing into a
repository with an alternate fails to make use of the alternate to avoid
extra objects.  This failure occurs with the first patch in the series,
"Fix prefix handling in ref iteration functions".  We added some
debugging code which revealed the cause:

DEBUG: Ignoring ref ".have" due to base "refs/"

So, the suggested change to actually use "refs/" as a filter caused this
failure.  Based on this, we'd tend to suggest that we should go back to
the version which preserved the existing behavior, to avoid breaking
assumptions like this; that seems preferable to tracking down all the
places that would break due to this new ref filtering.  Adding that
filtering and fixing all the resulting breakage seems like an entirely
separate change.

This patch series takes that approach.

Josh Triplett and Jamey Sharp (4):
  Fix prefix handling in ref iteration functions
  Add infrastructure for ref namespaces
  Support ref namespaces for remote repositories via upload-pack and
    receive-pack
  Add documentation for ref namespaces

 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    8 +++
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-upload-pack.txt      |    4 ++
 Documentation/git.txt                  |   13 +++++-
 Documentation/gitnamespaces.txt        |   75 ++++++++++++++++++++++++++++++++
 builtin/receive-pack.c                 |   34 ++++++++++++---
 cache.h                                |    3 +
 contrib/completion/git-completion.bash |    3 +-
 environment.c                          |   41 +++++++++++++++++
 git.c                                  |   18 +++++++-
 refs.c                                 |   33 ++++++++++++--
 refs.h                                 |    3 +
 upload-pack.c                          |   15 +++---
 14 files changed, 230 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

-- 
1.7.5.3
