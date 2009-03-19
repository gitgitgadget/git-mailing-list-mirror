From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Produce a nicer output in case of sha1_object_info
	failures in ls-tree -l
Date: Thu, 19 Mar 2009 23:54:29 +0100
Message-ID: <20090319225429.GC8433@blimp.localdomain>
References: <20090319203002.GA31014@blimp.localdomain> <7v4oxp89eb.fsf@gitster.siamese.dyndns.org> <20090319220020.GA8433@blimp.localdomain> <7vmybh6u15.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:56:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkR9f-0003tR-HI
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757852AbZCSWyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbZCSWyh
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:54:37 -0400
Received: from mout0.freenet.de ([195.4.92.90]:56898 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434AbZCSWyg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:54:36 -0400
Received: from [195.4.92.27] (helo=17.mx.freenet.de)
	by mout0.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #79)
	id 1LkR8C-00087u-S1; Thu, 19 Mar 2009 23:54:32 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:53926 helo=tigra.home)
	by 17.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LkR8C-0000yn-J1; Thu, 19 Mar 2009 23:54:32 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 5BD51277D8;
	Thu, 19 Mar 2009 23:54:30 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 0BE3C36D27; Thu, 19 Mar 2009 23:54:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmybh6u15.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113853>

An error message is already printed by sha1_object_info itself, and
the failed entries are additionally marked in the listing.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Thu, Mar 19, 2009 23:13:10 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Junio C Hamano, Thu, Mar 19, 2009 22:55:56 +0100:
> >> Alex Riesen <raa.lkml@gmail.com> writes:
> >> > @@ -91,6 +90,7 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
> >> >  	if (!(ls_options & LS_NAME_ONLY)) {
> >> >  		if (ls_options & LS_SHOW_SIZE) {
> >> >  			if (!strcmp(type, blob_type)) {
> >> > +				unsigned long size = 0;
> >> >  				sha1_object_info(sha1, &size);
> >> >  				printf("%06o %s %s %7lu\t", mode, type,
> >> >  				       abbrev ? find_unique_abbrev(sha1, abbrev)
> >> 
> >> Hmm, shouldn't you be checking the return value from sha1_object_info()
> >> and skipping the printf() altogether instead?
> >
> > But then I cannot know the name of the failed tree entry.
> 
> Why?
> 
> 	if (sha1_object_info() == OBJ_BAD)
> 		die("object recorded at tree entry %s is bad", pathname);
> 	printf ...

Tried. Makes exactly this code much uglier, and the pathname is
printed nicely quoted after the outer if() is closed. And I don't like
the idea of dying here: it'll take longer to collect all the needed
entry names for later recovery (that's how it came to the change,
AFAIR).

How about this patch instead? I chose "BAD" for the marker, as any
automatic processing trying blindly to convert it into a number will
get a 0, which seems safe to me.

 builtin-ls-tree.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index fca4631..22008df 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -60,7 +60,6 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 {
 	int retval = 0;
 	const char *type = blob_type;
-	unsigned long size;
 
 	if (S_ISGITLINK(mode)) {
 		/*
@@ -90,17 +89,20 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {
+			char size_text[24];
 			if (!strcmp(type, blob_type)) {
-				sha1_object_info(sha1, &size);
-				printf("%06o %s %s %7lu\t", mode, type,
-				       abbrev ? find_unique_abbrev(sha1, abbrev)
-				              : sha1_to_hex(sha1),
-				       size);
+				unsigned long size;
+				if (sha1_object_info(sha1, &size) == OBJ_BAD)
+					strcpy(size_text, "BAD");
+				else
+					snprintf(size_text, sizeof(size_text),
+						 "%lu", size);
 			} else
-				printf("%06o %s %s %7c\t", mode, type,
-				       abbrev ? find_unique_abbrev(sha1, abbrev)
-				              : sha1_to_hex(sha1),
-				       '-');
+				strcpy(size_text, "-");
+			printf("%06o %s %s %7s\t", mode, type,
+			       abbrev ? find_unique_abbrev(sha1, abbrev)
+				      : sha1_to_hex(sha1),
+			       size_text);
 		} else
 			printf("%06o %s %s\t", mode, type,
 			       abbrev ? find_unique_abbrev(sha1, abbrev)
-- 
1.6.2.1.237.g7206c6
