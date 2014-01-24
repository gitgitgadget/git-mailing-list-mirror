From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 0/3] merge-recursive: Avoid diagnostic on empty work tree
Date: Fri, 24 Jan 2014 10:01:00 -0500
Message-ID: <cover.1390574980.git.brad.king@kitware.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
Cc: gitster@pobox.com, newren@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 16:00:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6iFN-0005JE-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 16:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbaAXPAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 10:00:37 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59096 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752613AbaAXPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 10:00:35 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 8D8F39FBA3; Fri, 24 Jan 2014 10:01:03 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241009>

On 01/23/2014 07:24 PM, Elijah Newren wrote:
> Two options are just doing a stat to determine whether the file
> is present (which means we'll be stat'ing the file multiple times
> in these cases, which feels wasteful), or perhaps writing a
> modified make_cache_entry() with the behavior we want
> (seems like ugly code duplication).  Suggestions?

Perhaps we can thread enough information through the make_cache_entry
signature to allow the caller to know when lstat reported ENOENT.
Here is a series that takes such an approach.

* Patch 1 is the original test case from $gmane/240853.

* Patch 2 extends the make_cache_entry signature to return lstat errno.

* Patch 3 uses this information to silence the add_cacheinfo diagnostic

-Brad

Brad King (3):
  t3030-merge-recursive: Test known breakage with empty work tree
  read-cache.c: Thread lstat error through make_cache_entry signature
  merge-recursive: Tolerate missing file when HEAD is up to date

 builtin/apply.c            |  2 +-
 builtin/checkout.c         |  2 +-
 builtin/reset.c            |  2 +-
 cache.h                    |  2 +-
 merge-recursive.c          | 22 ++++++++++++++--------
 read-cache.c               | 12 +++++++-----
 resolve-undo.c             |  2 +-
 t/t3030-merge-recursive.sh | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 73 insertions(+), 18 deletions(-)

-- 
1.8.5.2
