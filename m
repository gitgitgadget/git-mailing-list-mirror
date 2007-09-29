From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/3] Make for-each-ref's grab_date() support per-atom formatting
Date: Sat, 29 Sep 2007 08:39:57 +0100
Message-ID: <200709290839.57507.andyparkins@gmail.com>
References: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 09:40:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbWw6-0005cB-FA
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 09:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbXI2HkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 03:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753475AbXI2HkG
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 03:40:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13431 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbXI2HkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 03:40:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1597068ugc
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 00:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=WB9IfDdtK0T2eiz8PQ6M8E19lWwWYYdT9oXKTLGDEAY=;
        b=M4hYznYb79J6mrkpJN079CVTk2daOobUBs/WKFS6NSLWkhGPYUp583sUh+K5wLliNvzxMIC0XgzSXyFvI9EUjnbyUmYkWC+IAbMwaxtOhX2Ni+wIQpEt8PuVRWdYxYof8gnNGtq0cr5pL4IpGSYrzHgdpZoQRUP0OCtiVtV3yIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=YhxuxJPLs1N7mV+Zxib3TfNzx0HML5QDLdXB+kgwN6swyj20rqNmb8ZLVSmzu8IWPnkJpTTmVJyUEhjY3V+joOmLu/fc9CYP3OJm25W6FGKpAWePNB7N1klSc7IOrPiGRga22O8UkA+lVAqrr2jw9N+e6xHuAfkC+HKWQrN0YPA=
Received: by 10.67.32.14 with SMTP id k14mr690401ugj.1191051602897;
        Sat, 29 Sep 2007 00:40:02 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id s7sm9576188uge.2007.09.29.00.40.01
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Sep 2007 00:40:02 -0700 (PDT)
In-Reply-To: <7v1wcipsn9.fsf@gitster.siamese.dyndns.org>
X-TUID: 8d8711f9127cfe3b
X-UID: 339
X-Length: 4797
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59444>

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
1.5.3.rc5.11.g312e
