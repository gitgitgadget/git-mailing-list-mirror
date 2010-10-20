From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] fast-import: do not clear notes in do_change_note_fanout()
Date: Wed, 20 Oct 2010 15:25:58 -0500
Message-ID: <20101020202558.GA1151@burratino>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20101011063429.GA32034@burratino>
 <20101018010005.GA25524@burratino>
 <20101018010338.GB25524@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8fIC-00088f-VX
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514Ab0JTU3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:29:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59438 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0JTU3n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:29:43 -0400
Received: by iwn7 with SMTP id 7so2665749iwn.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E/nA2moiC8V4Cceki5cEMvkpkjDECvmMUlpj4vn5lhQ=;
        b=hbGCAt0VaI6EIjit5X7rCFWmLWJT1MNcgNxhSnyMpdxyS56I8X59je/Ruc3LQbtm05
         9VDcjB5Q+Qb9HBTRCFRUepvtUQmR28rLZMllRLe/x0KDsIy3xvWb3r98o+HNYgqk8r5+
         4C0nV2+HTXKaeZ28x3+Pdbf5AgZc5JeJmOXMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oHQ+lfqwa46EAd2QHUyDx8oHZ8XlaKGIMS5eoiIn/Qn58Gqp94Aj3+BvTpJN1k1oc0
         CHESIDTU1BC0+GdyO7f0jJJMOes1SbTmZZRjgemHq98oNn2hAr/aEqwrJx5OJEmjW78W
         U73BB5MObi9swfaXg4h0qoAay3wKUMMCTT8dU=
Received: by 10.231.192.80 with SMTP id dp16mr65585ibb.39.1287606582686;
        Wed, 20 Oct 2010 13:29:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d12sm253502vcn.38.2010.10.20.13.29.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:29:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018010338.GB25524@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159437>

Commit 5edde51 (fast-import: filemodify after M 040000 <tree> ""
crashes, 2010-10-17) taught fast-import to load trees from the
object db as needed when it is time to access them.

But it went too far.  In change_note_fanout(), an empty,
not-loaded tree is not meant to destroy notes, so calling
load_tree() at that point is exactly the wrong thing to do.

Kudos to Johan Herland for t9301, which caught this failure.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[cleared cc list.]

Jonathan Nieder wrote:

> +++ b/fast-import.c
[...]
> @@ -2056,13 +2065,16 @@ static uintmax_t do_change_note_fanout(
>  		char *fullpath, unsigned int fullpath_len,
>  		unsigned char fanout)
>  {
> -	struct tree_content *t = root->tree;
> +	struct tree_content *t;
>  	struct tree_entry *e, leaf;
>  	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
>  	uintmax_t num_notes = 0;
>  	unsigned char sha1[20];
>  	char realpath[60];
>  
> +	if (!root->tree);
> +		load_tree(root);
> +	t = root->tree;
>  	for (i = 0; t && i < t->entry_count; i++) {

Oops.  The !t case is normal here and certainly is not a request
to turn t into an empty tree.  Here's a minimal fix.

 fast-import.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index aaf47c5..d2458ea 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2065,16 +2065,13 @@ static uintmax_t do_change_note_fanout(
 		char *fullpath, unsigned int fullpath_len,
 		unsigned char fanout)
 {
-	struct tree_content *t;
+	struct tree_content *t = root->tree;
 	struct tree_entry *e, leaf;
 	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	unsigned char sha1[20];
 	char realpath[60];
 
-	if (!root->tree);
-		load_tree(root);
-	t = root->tree;
 	for (i = 0; t && i < t->entry_count; i++) {
 		e = t->entries[i];
 		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
-- 
1.7.2.3
