From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Add a --dateformat= option to git-for-each-ref
Date: Wed, 26 Sep 2007 10:09:18 +0100
Message-ID: <200709261009.18777.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 11:09:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaSti-0006Kw-Uj
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 11:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbXIZJJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185AbXIZJJ1
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 05:09:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:62882 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbXIZJJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 05:09:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1900490nfb
        for <git@vger.kernel.org>; Wed, 26 Sep 2007 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=u4KYukYJPC3hafoNZtqMoTbTRQFzN7FrB9prBx9uH90=;
        b=U8T3axbbUmx5h5yVCNHQsJr5DjqPbdzg+yX37OV2pr6TZDfrtdcGi6K2WVUyGL6uHpp/1kpfmHABhXui+Z4Jpv65I7ymPbr4VDSCN1HuE8DX2wQ0fwutj5+mi6e7v6mANGUefE62Z9V8cbMwzjepf4XE0JK7G09ecmhvL6QjQo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=pcU03qFUCAy/YlcYpQB8VG/iRQKGKpN73u0umdeQMzHSa+bJjpzDoTYncRA56Ee+k/13W9BrrCrcqufULxaj0gW6/6HLUq0eEGqRYr77D+c2N2pfLqxemDgdMxiGPts7XBCoKtbQ9zDAvi+eSs2xxJqrI8ggrXRaRbIJgkDl6BE=
Received: by 10.78.175.14 with SMTP id x14mr270044hue.1190797763379;
        Wed, 26 Sep 2007 02:09:23 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c4sm2074235nfi.2007.09.26.02.09.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Sep 2007 02:09:22 -0700 (PDT)
X-TUID: 6ae3cdd2f31346f8
X-UID: 331
X-Length: 3716
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59220>

I wanted to get date information in RFC2822 format out of a tag using
git-for-each-ref; but there was no way to specify that.  This patch
addresses that omission by adding a --dateformat option.

For example (I'm in BST, +0100 at present):

 $ git-for-each-ref --dateformat=normal --format='%(taggerdate)' refs/tags/v1.5.2
 Sun May 20 00:30:42 2007 -0700
 $ git-for-each-ref --dateformat=relative --format='%(taggerdate)' refs/tags/v1.5.2
 4 months ago
 $ git-for-each-ref --dateformat=short --format='%(taggerdate)' refs/tags/v1.5.2
 2007-05-20
 $ git-for-each-ref --dateformat=local --format='%(taggerdate)' refs/tags/v1.5.2
 Sun May 20 08:30:42 2007
 $ git-for-each-ref --dateformat=iso8601 --format='%(taggerdate)' refs/tags/v1.5.2
 2007-05-20 00:30:42 -0700
 $ git-for-each-ref --dateformat=rfc2822 --format='%(taggerdate)' refs/tags/v1.5.2
 Sun, 20 May 2007 00:30:42 -0700

The default is to use 'normal', which leaves existing behaviour
unchanged.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-for-each-ref.txt |    6 ++++++
 builtin-for-each-ref.c             |   18 +++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6df8e85..1b8fdb8 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git-for-each-ref' [--count=<count>]\*
                    [--shell|--perl|--python|--tcl]
+                   [--dateformat=normal|relative|short|local|iso8601|rfc2822]
                    [--sort=<key>]\* [--format=<format>] [<pattern>]
 
 DESCRIPTION
@@ -58,6 +59,11 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
+--dateformat::
+	If given, all timestamp fields will be output in the specified
+	format.  This is only really relevant for innvocations using the
+	--format option with a `%(date)`-type field.
+
 
 FIELD NAMES
 -----------
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 0afa1c5..80e58fc 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -80,6 +80,7 @@ static struct {
 static const char **used_atom;
 static cmp_type *used_atom_type;
 static int used_atom_cnt, sort_atom_limit, need_tagged;
+static enum date_mode date_mode = DATE_NORMAL;
 
 /*
  * Used to parse format string and sort specifiers
@@ -362,7 +363,7 @@ static void grab_date(const char *buf, struct atom_value *v)
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, 0));
+	v->s = xstrdup(show_date(timestamp, tz, date_mode));
 	v->ul = timestamp;
 	return;
  bad:
@@ -870,6 +871,21 @@ int cmd_for_each_ref(int ac, const char **av, const char *prefix)
 			sort->atom = parse_atom(arg, arg+len);
 			continue;
 		}
+		if (!prefixcmp(arg, "--dateformat=")) {
+			arg += 13;
+			if (!prefixcmp(arg,"relative")) {
+				date_mode = DATE_RELATIVE;
+			} else if (!prefixcmp(arg,"short")) {
+				date_mode = DATE_SHORT;
+			} else if (!prefixcmp(arg,"local")) {
+				date_mode = DATE_LOCAL;
+			} else if (!prefixcmp(arg,"iso8601")) {
+				date_mode = DATE_ISO8601;
+			} else if (!prefixcmp(arg,"rfc2822")) {
+				date_mode = DATE_RFC2822;
+			}
+			continue;
+		}
 		break;
 	}
 	if (quote_style < 0)
-- 
1.5.3.1.5.g4e560-dirty
