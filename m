From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [RFC] hash-object --no-filters
Date: Thu, 31 Jul 2008 23:09:49 +0400
Message-ID: <20080731190949.GI7008@dpotapov.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807311243.35219.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 21:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdY9-0007B5-H1
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbYGaTJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbYGaTJ4
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:09:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:3405 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbYGaTJz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 15:09:55 -0400
Received: by nf-out-0910.google.com with SMTP id d3so307789nfc.21
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FjZ4bJQ8QkgJxKD2ThrPNFZFvjy6/pNZYfoIvrbazP0=;
        b=KF001tXs/jHVTW5rJ3NOKNcOiEmV3T0bK6NmfsZ9js+wcE9oGKP8RVKJ+hyMZHMKba
         1cr0bAabMvh5gDajPiJI7k/g92jx1nGqw521Ptpq2l/oHS1yPdjEi8v01E4sZxwtWZRd
         EpZDzZmRJGTqpNPvI9EgwKLtxOGBifxXQt+QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SLmFSqBOhzwhCKY3c7PQO2qUInLTDgcZ68xtdRe1Z6hLOo60XJlNmPI/h4k/EVIPH5
         a3b7tuooBxna6E6pG0otyT1wo2adF8rDb1HQ+DmZufLUsXvp4C0OAyGoflR8h+uxtXZc
         JObakzYhsUebX7l9Q6xUR3lLhJB4BFKR6OOOw=
Received: by 10.210.71.13 with SMTP id t13mr11449392eba.42.1217531394156;
        Thu, 31 Jul 2008 12:09:54 -0700 (PDT)
Received: from localhost ( [85.141.239.143])
        by mx.google.com with ESMTPS id 34sm1116887nfu.24.2008.07.31.12.09.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 12:09:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080731104529.GE7008@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90968>

Hi All,

I am tryint to add the --no-filters option. It is useful for git-svn
and other importers that want to add file as-is without being affected
by any filter (in particular, autocrlf). Though, the patch below works,
I am not happy with the hackish way of passing no-filter requirement
to the index_fd() function. So, I wonder what would be preferable:
- to change 'write_object' to be flags (bit 0: write_object,
  bit 1: no-filters )
- to add some global the no_filters flag to environment.c, which can
  be checked inside of convert_to_git(), so it may be used in the
  future in some other cases (though I don't see where else it can
  be useful).

Another question: currently git hash-object --input imply no filters.
I don't know if it was done intentionally (it can be argued in both
ways). I don't think it is reasonable now to change this behavior,
so I want to add just one line to documentation, so there will be
no surprise among users.

Dmitry

-- 8< --
From: Dmitry Potapov <dpotapov@gmail.com>
Date: Thu, 31 Jul 2008 21:10:26 +0400
Subject: [PATCH] hash-object --no-filters

The --no-filters option makes git hash-object to work as there were no
input filters. This option is useful for importers such as git-svn to
put new version of files as is even if autocrlf is set.
---
 Documentation/git-hash-object.txt |    6 ++++++
 hash-object.c                     |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index ac928e1..69a17c7 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -35,6 +35,12 @@ OPTIONS
 --stdin-paths::
 	Read file names from stdin instead of from the command-line.
 
+--no-filters::
+	If this option is given then the file is hashed as is ignoring
+	all filters specified in the configuration, including crlf
+	conversion. If the file is read from standard input then no
+	filters is always implied.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/hash-object.c b/hash-object.c
index 46c06a9..1e7fe8a 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,6 +8,8 @@
 #include "blob.h"
 #include "quote.h"
 
+static unsigned no_filters;
+
 static void hash_object(const char *path, enum object_type type, int write_object)
 {
 	int fd;
@@ -16,7 +18,8 @@ static void hash_object(const char *path, enum object_type type, int write_objec
 	fd = open(path, O_RDONLY);
 	if (fd < 0 ||
 	    fstat(fd, &st) < 0 ||
-	    index_fd(sha1, fd, &st, write_object, type, path))
+	    ((no_filters ? st.st_mode &= ~S_IFREG : 0),
+	     index_fd(sha1, fd, &st, write_object, type, path)))
 		die(write_object
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
@@ -104,6 +107,8 @@ int main(int argc, char **argv)
 					die("Multiple --stdin arguments are not supported");
 				hashstdin = 1;
 			}
+			else if (!strcmp(argv[i], "--no-filters"))
+				no_filters = 1;
 			else
 				usage(hash_object_usage);
 		}
-- 
1.6.0.rc1.32.gc84cb
