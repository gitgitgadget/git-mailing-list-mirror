From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 4/4] Make for-each-ref's grab_date() support per-atom formatting
Date: Fri, 28 Sep 2007 15:17:45 +0100
Message-ID: <200709281517.45133.andyparkins@gmail.com>
References: <200709281516.05438.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:19:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGgb-00022u-AS
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbXI1ORv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbXI1ORv
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:17:51 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:13219 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759362AbXI1ORt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:17:49 -0400
Received: by mu-out-0910.google.com with SMTP id i10so4818999mue
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=ZJ1VXKY0QUmY1rJWzhBCCUvwEcx72x2OMbBQtQcAlYM=;
        b=oU/606lO90rS94qKgLFzOezBAa+oC3GyqEwg6JK3y2SAZgg6tvAATR7tcnwBW0KxcGLSR4Xaxymr3w0of/zgD2rIcTQH5R7XL5BOXWG5mKTnmwRHbdh4N47RQVFqh/j3QJj5AfkMk9IVubTuvpxaOSYPffIYPKg16Vyg9DMCdcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=BIlSTrAAt/F0OZ3CHNH/5U0ut1+n8y9zy9UMpz4Lc9LZaVzKsdMRThnez5WNbl8/FyEtwAZoQkuvHXKS8V2XMN3r2stBg9ySA/iXib1iYPNQNyMpGS6f3hNM7C0a+FLcRiW0WgKrxC8+yBnUy26K1+pfV8rhMygqKPNdtafmwa0=
Received: by 10.82.138.6 with SMTP id l6mr96612bud.1190989067396;
        Fri, 28 Sep 2007 07:17:47 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id 34sm288737nfu.2007.09.28.07.17.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:17:46 -0700 (PDT)
In-Reply-To: <200709281516.05438.andyparkins@gmail.com>
X-TUID: 31ba87348c48c28d
X-UID: 335
X-Length: 4801
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59399>

grab_date() gets an extra parameter - atomname; this extra parameter is
checked to see if it has a ":<format>" extra component in it, and if so
that "<format>" string is passed to parse_date_format() to produce an
enum date_mode value which is then further passed to show_date().

In short it allows the user of git-for-each-ref to do things like this:

 $ git-for-each-ref --format='%(taggerdate:default)' refs/tags/v1.5.2
 Sun May 20 00:30:42 2007 -0700
 $ git-for-each-ref --format='%(taggerdate:relative)' refs/tags/v1.5.2
 4 months ago
 $ git-for-each-ref --format='%(taggerdate:short)' refs/tags/v1.5.2
 2007-05-20
 $ git-for-each-ref --format='%(taggerdate:local)' refs/tags/v1.5.2
 Sun May 20 08:30:42 2007
 $ git-for-each-ref --format='%(taggerdate:iso8601)' refs/tags/v1.5.2
 2007-05-20 00:30:42 -0700
 $ git-for-each-ref --format='%(taggerdate:rfc2822)' refs/tags/v1.5.2
 Sun, 20 May 2007 00:30:42 -0700

The default, when no ":<format>" is specified is ":default", leaving the
existing behaviour unchanged.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-for-each-ref.txt |    5 +++++
 builtin-for-each-ref.c             |   26 +++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6df8e85..f1f90cc 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -100,6 +100,11 @@ In any case, a field name that refers to a field inapplicable to
 the object referred by the ref does not cause an error.  It
 returns an empty string instead.
 
+As a special case for the date-type fields, you may specify a format for
+the date by adding one of `:default`, `:relative`, `:short`, `:local`,
+`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
+`%(taggerdate:relative)`.
+
 
 EXAMPLES
 --------
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 3280516..2ca4fc6 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -353,12 +353,24 @@ static const char *copy_email(const char *buf)
 	return line;
 }
 
-static void grab_date(const char *buf, struct atom_value *v)
+static void grab_date(const char *buf, struct atom_value *v, const char *atomname)
 {
 	const char *eoemail = strstr(buf, "> ");
 	char *zone;
 	unsigned long timestamp;
 	long tz;
+	enum date_mode date_mode = DATE_NORMAL;
+	const char *formatp;
+
+	/* We got here because atomname ends in "date" or "date<something>",
+	 * it's not possible that <something> is not ":<format>" because
+	 * parse_atom() wouldn't have allowed it, so we can assume that no
+	 * ":" means no format is specified, use the default */
+	formatp = strrchr( atomname, ':' );
+	if (formatp != NULL) {
+		formatp++;
+		date_mode = parse_date_format(formatp);
+	}
 
 	if (!eoemail)
 		goto bad;
@@ -368,7 +380,7 @@ static void grab_date(const char *buf, struct atom_value *v)
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, 0));
+	v->s = xstrdup(show_date(timestamp, tz, date_mode));
 	v->ul = timestamp;
 	return;
  bad:
@@ -395,7 +407,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 		if (name[wholen] != 0 &&
 		    strcmp(name + wholen, "name") &&
 		    strcmp(name + wholen, "email") &&
-		    strcmp(name + wholen, "date"))
+		    prefixcmp(name + wholen, "date"))
 			continue;
 		if (!wholine)
 			wholine = find_wholine(who, wholen, buf, sz);
@@ -407,8 +419,8 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 			v->s = copy_name(wholine);
 		else if (!strcmp(name + wholen, "email"))
 			v->s = copy_email(wholine);
-		else if (!strcmp(name + wholen, "date"))
-			grab_date(wholine, v);
+		else if (!prefixcmp(name + wholen, "date"))
+			grab_date(wholine, v, name);
 	}
 
 	/* For a tag or a commit object, if "creator" or "creatordate" is
@@ -428,8 +440,8 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 		if (deref)
 			name++;
 
-		if (!strcmp(name, "creatordate"))
-			grab_date(wholine, v);
+		if (!prefixcmp(name, "creatordate"))
+			grab_date(wholine, v, name);
 		else if (!strcmp(name, "creator"))
 			v->s = copy_line(wholine);
 	}
-- 
1.5.3.2.105.gf47f2-dirty
