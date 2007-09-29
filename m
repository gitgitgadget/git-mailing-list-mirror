From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/3] Make for-each-ref allow atom names like "<name>:<something>"
Date: Sat, 29 Sep 2007 08:39:52 +0100
Message-ID: <200709290839.52436.andyparkins@gmail.com>
References: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 09:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbWvn-0005X0-4F
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 09:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbXI2Hj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbXI2Hj7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 03:39:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13431 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbXI2Hj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 03:39:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1597068ugc
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=ps73exqBwQlVgdBhztkbV9t4xx8Qh35WYg7BTCg4kfI=;
        b=kWMZttaGt/72/JpVjmuA+CmLUILTHwHsKsnO/rK291xIcj6l5XgwOkrL44R6LQKB8yjwLUwKGb4b1S3AwE6bmZYT9gUedWJooMGTK30CNp8H9oopLY7e+6HjgO9bCfTAeeBThkAxxd1Iu7uOSOu1TngjJ2BTtCUVtyfEYSaIbvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=hsc/KEX2VLAEcnl3hOOZWLYwdzia0TwzWq3XuqBDDfos3VmHIZ1BiuUR33xIHkCgTzGbBa11wdkpTO8/X2QGUWVeU7bPxTWbU12/txJ+DPuD/CfncF732qvXkBquF6oqc/xV2IV6UobEVeXkt2rvCWah5Kc0FsV64KDGe6HFw0w=
Received: by 10.67.119.15 with SMTP id w15mr6068494ugm.1191051597087;
        Sat, 29 Sep 2007 00:39:57 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id j34sm3568953ugc.2007.09.29.00.39.56
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Sep 2007 00:39:56 -0700 (PDT)
In-Reply-To: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
X-TUID: d664b3fb4f6b04c4
X-UID: 338
X-Length: 1833
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59443>

In anticipation of supplying a per-field date format specifier, this
patch makes parse_atom() in builtin-for-each-ref.c allow atoms that have
a valid atom name (as determined by the valid_atom[] table) followed by
a colon, followed by an arbitrary string.

The arbitrary string is where the format for the atom will be specified.

Note, if different formats are specified for the same atom, multiple
entries will be made in the used_atoms table to allow them to be
distinguished by the grab_XXXX() functions.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-for-each-ref.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 0afa1c5..3280516 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -106,7 +106,13 @@ static int parse_atom(const char *atom, const char *ep)
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
-		if (len == ep - sp && !memcmp(valid_atom[i].name, sp, len))
+		/* If the atom name has a colon, strip it and everything after
+		 * it off - it specifies the format for this entry, and
+		 * shouldn't be used for checking against the valid_atom table */
+		const char *formatp = strrchr(sp, ':' );
+		if (formatp == NULL )
+			formatp = ep;
+		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
-- 
1.5.3.rc5.11.g312e
