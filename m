X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: sizeof(struct ...)
Date: Thu, 23 Nov 2006 10:16:09 +0000
Message-ID: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 10:16:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32134>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBcY-0005LV-8F for gcvg-git@gmane.org; Thu, 23 Nov
 2006 11:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757328AbWKWKPv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 05:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757330AbWKWKPv
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 05:15:51 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:45545 "HELO
 a.mx.smarden.org") by vger.kernel.org with SMTP id S1757328AbWKWKPu (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 05:15:50 -0500
Received: (qmail 1712 invoked by uid 1000); 23 Nov 2006 10:16:09 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi, I don't think we can rely on sizeof(struct ...) to be the exact size
of the struct as defined.  As the selftests show, archive-zip doesn't
work correctly on Debian/arm

 http://buildd.debian.org/fetch.cgi?&pkg=git-core&ver=1%3A1.4.4-1&arch=arm&stamp=1164122355&file=log

It's because sizeof(struct zip_local_header) is 32, zip_dir_header 48,
and zip_dir_trailer 24, breaking the zip files.  Compiling with
-fpack-struct seemed to break other things, so I for now I ended up with
this (not so nice) workaround.

Regards, Gerrit.


diff --git a/archive-zip.c b/archive-zip.c
index ae5572a..4fcda44 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -211,7 +211,7 @@ static int write_zip_entry(const unsigne
 	}
 
 	/* make sure we have enough free space in the dictionary */
-	direntsize = sizeof(struct zip_dir_header) + pathlen;
+	direntsize = 46 + pathlen;
 	while (zip_dir_size < zip_dir_offset + direntsize) {
 		zip_dir_size += ZIP_DIRECTORY_MIN_SIZE;
 		zip_dir = xrealloc(zip_dir, zip_dir_size);
@@ -234,8 +234,8 @@ static int write_zip_entry(const unsigne
 	copy_le16(dirent.attr1, 0);
 	copy_le32(dirent.attr2, attr2);
 	copy_le32(dirent.offset, zip_offset);
-	memcpy(zip_dir + zip_dir_offset, &dirent, sizeof(struct zip_dir_header));
-	zip_dir_offset += sizeof(struct zip_dir_header);
+	memcpy(zip_dir + zip_dir_offset, &dirent, 46);
+	zip_dir_offset += 46;
 	memcpy(zip_dir + zip_dir_offset, path, pathlen);
 	zip_dir_offset += pathlen;
 	zip_dir_entries++;
@@ -251,8 +251,8 @@ static int write_zip_entry(const unsigne
 	copy_le32(header.size, uncompressed_size);
 	copy_le16(header.filename_length, pathlen);
 	copy_le16(header.extra_length, 0);
-	write_or_die(1, &header, sizeof(struct zip_local_header));
-	zip_offset += sizeof(struct zip_local_header);
+	write_or_die(1, &header, 30);
+	zip_offset += 30;
 	write_or_die(1, path, pathlen);
 	zip_offset += pathlen;
 	if (compressed_size > 0) {
@@ -282,7 +282,7 @@ static void write_zip_trailer(const unsi
 	copy_le16(trailer.comment_length, sha1 ? 40 : 0);
 
 	write_or_die(1, zip_dir, zip_dir_offset);
-	write_or_die(1, &trailer, sizeof(struct zip_dir_trailer));
+	write_or_die(1, &trailer, 22);
 	if (sha1)
 		write_or_die(1, sha1_to_hex(sha1), 40);
