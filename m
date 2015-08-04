From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] fix repo name when cloning a server's root
Date: Tue,  4 Aug 2015 13:29:51 +0200
Message-ID: <1438687797-14254-1-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQG-0006q8-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933170AbbHDLaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:13 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56440 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933034AbbHDLaL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id F34FE20C93
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:10 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 04 Aug 2015 07:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Ltgc
	hFib61yZKSdb/yoeP5EUr2c=; b=deSRU7uruwXDr+jt+hhOXCbJE3byoHSE+4ht
	ysPE+T+YreyktsQKO+hyfUyQFOC1p2EIOY1954wpRFSCGLAoMTyD3uKCeYqRib9f
	baL2YMDwaWlPgQ9EVvdhAI2vw9KjHuFiDHKexNSuAK0kUyPzMLD/9iXF7D1q0LV3
	dvTeDEY=
X-Sasl-enc: 01H28qT1r8sYZlhqcAztA8bbw+cuddVM2KASbkK7i2VV 1438687810
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 777CA68015D;
	Tue,  4 Aug 2015 07:30:10 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1437997708-10732-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275243>

This is the third version of this patch series. It aims to
improve guessing directory names such that we do not include
authentication data and port numbers in them.

This version drops the patches exposing 'parse_connect_url()' and
instead does the stripping of authentification data and port
inside the URI in 'guess_dir_name()'.

Actually I'm not that happy with the patch as it currently stands
as it requires a lot of complexity to correctly strip the URI
such that we do not mishandle several corner cases. At least I
didn't find any shorter way of doing what I want without breaking
backwards compatibility. I'll try to explain why the more complex
ways of handling the URI are required:

 - The naive way of just adding '@' as path separator would break
   cloning repositories like '/foo/bar@baz.git' (which would
   currently become 'bar@baz' but would become 'baz' only).

 - Skipping the scheme initially is required because without it we
   wouldn't be able to scan until the next dir separator in the
   host part when stripping authentication information.

 - First checking for '/' in the current stripped URI when we
   want to remove the port is required because we do not want to
   strip port numbers when cloning from something like
   '/foo/bar:2222.git' (which would currently become '2222' but
   would then be stripped of the ':2222' part and instead become
   'bar'). Still, this breaks on cloning a bare repository in the
   current dir (e.g. cloning 'bar:2222.git', which should become
   '2222' because it is not a port number but would become
   'bar').

As you can see, there is a lot of complexity in there and I'm not
convinced this is better than just exposing
'parse_connect_url()', which already handles everything for us.
Maybe I'm just being blind for the obvious solution here, though.

Patrick Steinhardt (6):
  tests: fix broken && chains in t1509-root-worktree
  tests: fix cleanup after tests in t1509-root-worktree
  clone: do not include authentication data in guessed dir
  clone: do not use port number as dir name
  clone: abort if no dir name could be guessed
  clone: add tests for cloning with empty path

 builtin/clone.c          | 67 ++++++++++++++++++++++++++++++++++++++++--------
 t/t1509-root-worktree.sh | 51 +++++++++++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 15 deletions(-)

-- 
2.5.0
