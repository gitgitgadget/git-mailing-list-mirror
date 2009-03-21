From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Sat, 21 Mar 2009 14:00:31 -0700
Message-ID: <7vab7eegls.fsf@gitster.siamese.dyndns.org>
References: <200903181448.50706.agruen@suse.de>
 <20090318182603.GM8940@machine.or.cz>
 <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
 <20090320004029.GX23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 21 22:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8Ke-00059X-Mn
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZCUVAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbZCUVAr
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:00:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZCUVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:00:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BE42809C;
	Sat, 21 Mar 2009 17:00:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 942E9809B; Sat,
 21 Mar 2009 17:00:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58429DB2-165B-11DE-BECF-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114056>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Fri, 20 Mar 2009, Johannes Schindelin wrote:
>> 
>> > Just try this:
>> > 
>> > 	$ git checkout -b %helloworld
>> 
>> It gets worse.  Much worse.
>> 
>> Try this (triggered by a comment by Ilari on IRC):
>> 
>> 	$ git checkout -b '@{1}'
>> 
>> That _works_! WTH?
>
> '@' is not reserved.  Neither is '{' or '}'.  Neither is
> the combination.
>
> Waaaaaay back when I added reflog query syntax I tried to use only
> '@', people with branch names like 'foo@bar' made a point that they
> didn't want to reserve it.  We stuck the {} in as a "highly unlikely
> to conflict with a branch name" and others pointed out most shells
> will do fun things with those, but we kept it to avoid ambiguous
> meanings of "foo@noon" when foo@noon is already a branch.

Let's do something along this line.

-- >8 --
Subject: [PATCH] check_ref_format(): tighten refname rules

Yes, I know that tightening rules retroactively is bad, but this changes
the rules for refnames to forbid:

 (1) a refname that ends with a dot.

     We already reject a path component that begins with a dot, primarily
     to avoid ambiguous range interpretation.  If we allowed ".B" as a
     valid ref, it is unclear if "A...B" means "in dot-B but not in A" or
     "either in A or B but not in both".

     But for this to be complete, we need also to forbid "A." to avoid "in
     B but not in A-dot".  This was not a problem in the original range
     notation, but we should have added this restriction when three-dot
     notation was introduced.

     Unlike "no dot at the beginning of any path component" rule, this
     rule does not have to be "no dot at the end of any path component",
     because you cannot abbreviate the tail end away, similar to you can
     say "dot-B" to mean "refs/heads/dot-B".

 (2) a refname that contains "@{" in it.

     Some people and foreign SCM converter may have named their branches
     as frotz@243 and we still want to keep supporting it, but "git branch
     @{1}" is a disaster.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 8d3c502..abd5623 100644
--- a/refs.c
+++ b/refs.c
@@ -693,7 +693,7 @@ static inline int bad_ref_char(int ch)
 
 int check_ref_format(const char *ref)
 {
-	int ch, level, bad_type;
+	int ch, level, bad_type, last;
 	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
@@ -717,19 +717,23 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 		}
 
+		last = ch;
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			bad_type = bad_ref_char(ch);
-			if (bad_type) {
+			if (bad_type)
 				return CHECK_REF_FORMAT_ERROR;
-			}
 			if (ch == '/')
 				break;
-			if (ch == '.' && *cp == '.')
+			if (last == '.' && ch == '.')
+				return CHECK_REF_FORMAT_ERROR;
+			if (last == '@' && ch == '{')
 				return CHECK_REF_FORMAT_ERROR;
 		}
 		level++;
 		if (!ch) {
+			if (ref <= cp - 2 && cp[-2] == '.')
+				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
 			return ret;
-- 
1.6.2.1.299.gda643a
