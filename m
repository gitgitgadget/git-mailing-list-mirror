From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Fri, 27 May 2011 14:13:21 -0400
Message-ID: <20110527181321.GB29119@sigill.intra.peff.net>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
 <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
 <20110516103829.GA23889@sigill.intra.peff.net>
 <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
 <20110516120825.GA24418@sigill.intra.peff.net>
 <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at>
 <20110516145535.GA25930@sigill.intra.peff.net>
 <20110527180045.GA29119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Fri May 27 20:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ1XM-00028P-PP
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 20:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab1E0SNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 14:13:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab1E0SNX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 14:13:23 -0400
Received: (qmail 25655 invoked by uid 107); 27 May 2011 18:13:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 May 2011 14:13:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 May 2011 14:13:21 -0400
Content-Disposition: inline
In-Reply-To: <20110527180045.GA29119@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174636>

On Fri, May 27, 2011 at 02:00:45PM -0400, Jeff King wrote:

>   1. We load the index, and for each entry, insert it into the index's
>      name_hash. In addition, if ignorecase is turned on, we make an
>      entry in the name_hash for the directory (e.g., "contrib/"), which
>      uses the following code from 5102c61's hash_index_entry_directories:
> 
>         hash = hash_name(ce->name, ptr - ce->name);
>         if (!lookup_hash(hash, &istate->name_hash)) {
>                 pos = insert_hash(hash, &istate->name_hash);
>                 ce->next = *pos;
>                 *pos = ce;
>         }

Urgh, sorry, I was looking at this on one of my topic branches which
tweaked the calling convention of the hash code. All of my analysis is still
valid, but the code in question actually looks like this:

          hash = hash_name(ce->name, ptr - ce->name);
          if (!lookup_hash(hash, &istate->name_hash)) {
                  pos = insert_hash(hash, ce, &istate->name_hash);
                  if (pos) {
                          ce->next = *pos;
                          *pos = ce;
                  }
          }

And therefore my patch needs tweaked slightly, too. Updated version is below.

diff --git a/cache.h b/cache.h
index 009b365..54f8c05 100644
--- a/cache.h
+++ b/cache.h
@@ -153,6 +153,7 @@ struct cache_entry {
 	unsigned int ce_flags;
 	unsigned char sha1[20];
 	struct cache_entry *next;
+	struct cache_entry *dir_next;
 	char name[FLEX_ARRAY]; /* more */
 };
 
diff --git a/name-hash.c b/name-hash.c
index c6b6a3f..225dd76 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -57,12 +57,10 @@ static void hash_index_entry_directories(struct index_state *istate, struct cach
 		if (*ptr == '/') {
 			++ptr;
 			hash = hash_name(ce->name, ptr - ce->name);
-			if (!lookup_hash(hash, &istate->name_hash)) {
-				pos = insert_hash(hash, ce, &istate->name_hash);
-				if (pos) {
-					ce->next = *pos;
-					*pos = ce;
-				}
+			pos = insert_hash(hash, ce, &istate->name_hash);
+			if (pos) {
+				ce->dir_next = *pos;
+				*pos = ce;
 			}
 		}
 	}
@@ -166,7 +164,10 @@ struct cache_entry *index_name_exists(struct index_state *istate, const char *na
 			if (same_name(ce, name, namelen, icase))
 				return ce;
 		}
-		ce = ce->next;
+		if (icase && name[namelen - 1] == '/')
+			ce = ce->dir_next;
+		else
+			ce = ce->next;
 	}
 
 	/*
-- 
1.7.5.3.12.g99e25.dirty
