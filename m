From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] reflog_expire(): never update a reference to null_sha1
Date: Mon,  2 Mar 2015 10:29:57 +0100
Message-ID: <1425288597-20547-8-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:37:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMnI-0001gH-UF
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbCBJhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:37:41 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59000 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbbCBJhk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:37:40 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2015 04:37:40 EST
X-AuditID: 1207440c-f79376d00000680a-22-54f42db2bcf0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B4.DD.26634.2BD24F45; Mon,  2 Mar 2015 04:30:26 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5Ha008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:24 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLtJ90uIQfcndYuuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLX609DBb9PZ9YrXYvLmdxeLMm0ZGB06Pv+8/MHnsnHWX3WPBplKP
	Z717GD0uXlL2WPzAy+PzJrkA9ihum6TEkrLgzPQ8fbsE7ozDO5qYCm7xVqyc18HUwPiOq4uR
	k0NCwERiz4cdzBC2mMSFe+vZuhi5OIQELjNKHPv1kAXCOcYk0blgESNIFZuArsSinmYmEFtE
	QE1iYtshFhCbWeAHk8ShFbVdjBwcwgJ+Emtn1YOYLAKqEi92SoJU8Aq4SJz/uJ0RYpecxPnj
	P8H2cgq4Svz81cgOYgsB1cy6vpp5AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5
	mSV6qSmlmxghgcizg/HbOplDjAIcjEo8vAvmfQ4RYk0sK67MPcQoycGkJMp7XOdLiBBfUn5K
	ZUZicUZ8UWlOavEhRgkOZiUR3tfyQDnelMTKqtSifJiUNAeLkjiv6hJ1PyGB9MSS1OzU1ILU
	IpisDAeHkgRvMMhQwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBcxBcDIwMkxQO0
	9y5IO29xQWIuUBSi9RSjopQ4rxNIQgAkkVGaBzcWll5eMYoDfSnMWwFSxQNMTXDdr4AGMwEN
	vqUINrgkESEl1cDoW3l2avxNtab8jH+9Z3l9mda+ypO4bCgjNEttU/T5yVf2KabefKO4JOGh
	TM8Jjt3L2u/uatonJ86U3b7jL/f0i7pRAe8/xnUqNVT+iDbeXOw/f6vwnt95nUyn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264588>

Currently, if --updateref is specified and the very last reflog entry
is expired or deleted, the reference's value is set to 0{40}. This is
an invalid state of the repository, and breaks, for example, "git
fsck" and "git for-each-ref".

The only place we use --updateref in our own code is when dropping
stash entries. In that code, the very next step is to check if the
reflog has been made empty, and if so, delete the "refs/stash"
reference entirely. Thus that code path ultimately leaves the
repository in a valid state.

But we don't want to the repository in an invalid state even
temporarily, and we don't want to leave an invalid state if other
callers of "git reflog expire|delete --updateref" don't think to do
the extra cleanup step.

So, if "git reflog expire|delete" leaves no more entries in the
reflog, just leave the reference unchanged.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index bd47d23..f6b04d9 100644
--- a/refs.c
+++ b/refs.c
@@ -4078,10 +4078,13 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		/*
 		 * It doesn't make sense to adjust a reference pointed
 		 * to by a symbolic ref based on expiring entries in
-		 * the symbolic reference's reflog.
+		 * the symbolic reference's reflog. Nor can we update
+		 * a reference if there are no remaining reflog
+		 * entries.
 		 */
 		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			!(type & REF_ISSYMREF);
+			!(type & REF_ISSYMREF) &&
+			!is_null_sha1(cb.last_kept_sha1);
 
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
-- 
2.1.4
