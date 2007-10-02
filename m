From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] for-each-ref's new per-atom formatting was failing if there were multiple fields per line
Date: Tue, 2 Oct 2007 12:02:42 +0100
Message-ID: <200710021202.42452.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 13:02:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcfWi-0002lO-4X
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 13:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbXJBLCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 07:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbXJBLCs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 07:02:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:5701 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbXJBLCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 07:02:47 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2877511nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 04:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=RE5gFXUiQJzo5c8Syf8wcWfcu5ittgIqtBL0MfEKhms=;
        b=Rn87s91lLuYGC8SYzbyCOVk2uheSaWN4T7sMBQ68DxmJ4toSGEkYx8wHfsmgabr5a7du2LEPxhm1m5w0b53Woo/kdNFoxhJ+Hwb+p+nQESHvJAtWNMh1U4ulC41L+dZTIqymHNwh80V0ixK8bAbFlbwf4bxLOur42tNeF5CUoOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Dae2svOjfznnGq2dn9qWm5VczLr1uBPdeWKwp/McIqeBdffJcC4gBiDyK/FBicoXv7tT1PczHbNAUOL3IQafB0sOXMU5CpFWOQBwXL/FuCGvwQdF5Nevf6z7svoWGINmistsQum7iEKz230Z5Ukqkvj1Nht7ZPHh++lS+cH6c30=
Received: by 10.65.242.11 with SMTP id u11mr17843148qbr.1191322966730;
        Tue, 02 Oct 2007 04:02:46 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 32sm1633512nfu.2007.10.02.04.02.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Oct 2007 04:02:46 -0700 (PDT)
X-TUID: abedc78dd1643908
X-UID: 344
X-Length: 2869
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59682>

builtin-for-each-ref.c was searching backwards for ":" in the atom searches
performed by parse_atom.  In implementing the format handler I had
assumed that parse_atom was being handed a single atom pointer.  That
was not the case.  In fact the "atom" pointer is just a pointer within
the longer format string, that means that the NUL for the end of the
string is not at the end of the current atom, but at the end of the
format string.

Finding the ":" separating the atom name from the format was done with
strrchr(), which searches from the end of the string.  That would be
fine if it was searching a single atom string, but in the case of:

 --format="%(atom:format) %(atom:format)"

When the first atom is being parsed a backwards search actually finds
the second colon, making the atom name look like:

 "atom:format) %(atom"

Which obviously doesn't match any valid atom name and so exits with
"unknown field name".

The fix is to abandon the reverse search (which was only to allow colons
in atom names, which was redundant as there are no atom names with
colons) and replace it with a forward search.  The potential presence of
a second ":" also requires a check to confirm that the found ":" is
between the start and end pointers, which this patch also adds.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-for-each-ref.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 2ca4fc6..f06d006 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -109,8 +109,8 @@ static int parse_atom(const char *atom, const char *ep)
 		/* If the atom name has a colon, strip it and everything after
 		 * it off - it specifies the format for this entry, and
 		 * shouldn't be used for checking against the valid_atom table */
-		const char *formatp = strrchr(sp, ':' );
-		if (formatp == NULL )
+		const char *formatp = strchr(sp, ':' );
+		if (formatp == NULL || formatp > ep )
 			formatp = ep;
 		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
 			break;
@@ -366,7 +366,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	 * it's not possible that <something> is not ":<format>" because
 	 * parse_atom() wouldn't have allowed it, so we can assume that no
 	 * ":" means no format is specified, use the default */
-	formatp = strrchr( atomname, ':' );
+	formatp = strchr( atomname, ':' );
 	if (formatp != NULL) {
 		formatp++;
 		date_mode = parse_date_format(formatp);
-- 
1.5.3.2.105.gf47f2-dirty
