From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tree_entry_interesting: Only recurse when the pathspec
 is a leading path component
Date: Wed, 01 Apr 2009 21:32:05 -0700
Message-ID: <7vbprfn0ai.fsf@gitster.siamese.dyndns.org>
References: <20090331094107.GC3307@atjola.homenet>
 <20090331150501.GA11446@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Anton Gyllenberg <anton@iki.fi>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 06:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpEcj-0004fJ-Ua
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbZDBEcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 00:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZDBEcQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 00:32:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZDBEcP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 00:32:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5BB50A63A0;
	Thu,  2 Apr 2009 00:32:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AB7BEA639E; Thu,
  2 Apr 2009 00:32:07 -0400 (EDT)
In-Reply-To: <20090331150501.GA11446@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Tue, 31 Mar 2009 17:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3CF0E4FA-1F3F-11DE-9751-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115439>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Previously the code did a simple prefix match, which means that it
> treated for example "foo/" as a subdirectory of "f".
>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
> I'm not exactly happy with the commit message, but that's the best I
> could come up with. Probably shows how little I know about that code =
:-/
> The test suite still passes and I'll try to provide a new testcase
> tonight or tommorow.

I'm planning to queue this.

=46rom: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Date: Tue, 31 Mar 2009 17:05:01 +0200
Subject: [PATCH] tree_entry_interesting: a pathspec only matches at dir=
ectory boundary

Previously the code did a simple prefix match, which means that a
path in a directory "frotz/" would have matched with pathspec "f".

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4010-diff-pathspec.sh |    8 ++++++++
 tree-diff.c              |   12 +++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index ad3d9e4..4c4c8b1 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -62,4 +62,12 @@ test_expect_success \
     'git diff-index --cached $tree -- file0/ >current &&
      compare_diff_raw current expected'
=20
+test_expect_success 'diff-tree pathspec' '
+	tree2=3D$(git write-tree) &&
+	echo "$tree2" &&
+	git diff-tree -r --name-only $tree $tree2 -- pa path1/a >current &&
+	>expected &&
+	test_cmp expected current
+'
+
 test_done
diff --git a/tree-diff.c b/tree-diff.c
index 9f67af6..b05d0f4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -118,10 +118,16 @@ static int tree_entry_interesting(struct tree_des=
c *desc, const char *base, int
 				continue;
=20
 			/*
-			 * The base is a subdirectory of a path which
-			 * was specified, so all of them are interesting.
+			 * If the base is a subdirectory of a path which
+			 * was specified, all of them are interesting.
 			 */
-			return 2;
+			if (!matchlen ||
+			    base[matchlen] =3D=3D '/' ||
+			    match[matchlen - 1] =3D=3D '/')
+				return 2;
+
+			/* Just a random prefix match */
+			continue;
 		}
=20
 		/* Does the base match? */
