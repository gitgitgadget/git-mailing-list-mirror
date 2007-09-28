From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/4] Make for-each-ref allow atom names like "<name>:<something>"
Date: Fri, 28 Sep 2007 15:17:39 +0100
Message-ID: <200709281517.39245.andyparkins@gmail.com>
References: <200709281516.05438.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGfB-0001MF-Fl
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759474AbXI1ORq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbXI1ORp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:17:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:8085 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759454AbXI1ORo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:17:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2522948nfb
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=lMZT/mK73Y2FoaAr1dEB7xz1N/O//FkvTUn99l28dls=;
        b=NBohhKl2LCOWAd5o0K4Dh64stUI/hj4t8//TlLwpEdDmjRVeTjh4BEklO+J36+R/QfMfV11XDjqHyVbBp3L/tvvpJISUYfaX4Sw7gdVN5jmEL841VUwpprwqN8RdtR7byY1iXHJZqKIlsnu5HOZTHDBqbKS+KjZNqPVSLA3Tspk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=PZw037MFqXktmh6W0E6ks/TiW+jsNAgoO//Z0YN4jGZ1W70N9i1Cd1DewTOzHpp+bTVKySuirPfjstVc/91dMAjVF0RqOlwxEHPTA78qOBwEJBLFeu1+ymWDbsJuit0BFUrWAG812IRRBICcmNGARCNh6QSQEOlFMT14zqeIgCs=
Received: by 10.78.157.19 with SMTP id f19mr3170002hue.1190989062009;
        Fri, 28 Sep 2007 07:17:42 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id g12sm3947507nfb.2007.09.28.07.17.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:17:41 -0700 (PDT)
In-Reply-To: <200709281516.05438.andyparkins@gmail.com>
X-TUID: 315de3e2e1a75854
X-UID: 334
X-Length: 1837
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59396>

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
1.5.3.2.105.gf47f2-dirty
