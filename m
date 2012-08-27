From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] optimize fast-forward checks
Date: Mon, 27 Aug 2012 16:11:58 -0700
Message-ID: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Tg-0007JL-Hh
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab2H0XMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0F459159;
	Mon, 27 Aug 2012 19:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=nhzXVS2LLgkbEvIUKuYCLK1ck4M
	=; b=L+ESCS4OZhoMeSCufFegXi+YAGgDI+Hu+Hcn4xXTCwoQvaQiGWMIl9SHy/t
	GYkU7PU58VBN0+ECrJkNJrh6vfmMuGk4ktnX23pVXZTGLBqlvOavYpcftdm5NWZv
	fc0T81tHw9fQaLvu7bJi+lpjNvqLv+PeuPbZU6e/0QoOTBJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=WYWnnJhdZF9TAyltDf4PX
	S63sDwnx/Rmia8MMfYcJi/gPEtx8p2ijiyZGpP+dXfebnFBL+hII921Uc8W415Q/
	ZK7tT94+LM/uC2WSzgkJkFVRedyNjcuyZgZN6GrjmHrXgcvapQ7BrkMUTkSTFW27
	c2ekLG59pMQ4db9wuIHLpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7AB29158;
	Mon, 27 Aug 2012 19:12:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 297359157; Mon, 27 Aug 2012
 19:12:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
X-Pobox-Relay-ID: 9DDB233E-F09C-11E1-A554-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204386>

This is a follow-up to $gmane/204149; somehow the discussion petered
out, but I think this topic (and also "tag --contains" that was not
really discussed) needs to be looked into.  Here is a first baby
step.

 - The first one is an obvious simplification; we never supported
   more than one "reference" commits and no caller had to invent a
   loop around it to emulate multi-reference in_merge_base().

 - The two patches that follow are the uses of get_merge_bases()
   where in_merge_bases() is sufficient.  These callers are not
   interested in the merge bases between the two points; they only
   want to know if one point is an ancestor of the other.

 - The next one [4/5] should be identical to Thomas's patch.

 - The last one attempts to reduce the cost of postprocessing from
   N*(N-1) to N, but it somehow breaks 6010. I haven't looked into
   why.  They say all bugs are shallow given enough eyeballs, so I
   am sending it out to see if that is true ;-)


Junio C Hamano (5):
  in_merge_bases(): support only one "other" commit
  receive-pack: use in_merge_bases() for fast-forward check
  http-push: use in_merge_bases() for fast-forward check
  in_merge_bases(): omit unnecessary redundant common ancestor
    reduction
  (BROKEN) get_merge_bases_many(): walk from many tips in parallel

 builtin/branch.c                       |  4 +--
 builtin/fetch.c                        |  2 +-
 builtin/receive-pack.c                 |  8 +----
 commit.c                               | 60 ++++++++++++++++++++--------------
 commit.h                               |  2 +-
 contrib/examples/builtin-fetch--tool.c |  2 +-
 fast-import.c                          |  2 +-
 http-push.c                            |  3 +-
 submodule.c                            | 12 +++----
 9 files changed, 49 insertions(+), 46 deletions(-)

-- 
1.7.12.116.g31e0100
