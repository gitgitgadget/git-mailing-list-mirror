From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] correct type of EMPTY_TREE_SHA1_BIN
Date: Mon, 7 Feb 2011 02:17:27 -0600
Message-ID: <20110207081727.GB2736@elie>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <7v62swwq7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 09:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmMI7-0006e1-TL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 09:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab1BGIRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 03:17:42 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45435 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1BGIRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 03:17:41 -0500
Received: by gwj20 with SMTP id 20so1601959gwj.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SxllaBzthDGERnQmds7y05nrLICWy5yg8q9ohaBGmSY=;
        b=ktGIr0kmOTOdV0UwXLoVEuJQ7Wk/ARZI+yCNa90aixI1IJnycPdsRJsbIljOCfjM9G
         5frGIy71cYlyNMRBhMrNEmPNu4bBiUmKe3Fd8xGBeuK6rDyIeLy2lj9b9Qqevnt0Ut4M
         uZ22uo3YPRomgmsQ/3hZQlgO+5JzBeZL48Opc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SH1+lo0X0XOGQlyCKRkVeQLrdNAsMwOQhIwFGo9Lodqk6KEPNsTAqB/9kPPKmGOsf/
         VEyVWO36vlvfBe9NFi13ZJzZgbwgV+xPl89I3d3+llizuF6xK/FndpLYXQUHsfvci+Qw
         /EIpY4g4SzDcnInb0+DaHU3K2aREvplS/FZMo=
Received: by 10.236.109.146 with SMTP id s18mr30160252yhg.28.1297066661287;
        Mon, 07 Feb 2011 00:17:41 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id g14sm2721387yhd.5.2011.02.07.00.17.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 00:17:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62swwq7s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167257>

Junio C Hamano wrote:

>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -621,9 +621,18 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
>>  			struct tree *subtree = lookup_tree(entry.sha1);
>>  			if (!subtree->object.parsed)
>>  				parse_tree(subtree);
>> +			if (!hashcmp(entry.sha1, (unsigned char *)EMPTY_TREE_SHA1_BIN)) {
>> +				warning("empty tree detected! Will be removed in new commits");
>> +				cnt = -1;
>> +				break;
>> +			}
>
> You shouldn't need the cast (if you did, then hashcmp() macro should be
> fixed so that you don't need to).

Isn't this a bug in the definition of EMPTY_TREE_SHA1_BIN rather than
the signature of hashcmp?

-- 8< --
Subject: correct type of EMPTY_TREE_SHA1_BIN

Functions such as hashcmp that expect a binary SHA-1 value take
parameters of type "unsigned char *" to avoid accepting a textual
SHA-1 passed by mistake.  Unfortunately, this means passing the string
literal EMPTY_TREE_SHA1_BIN requires an ugly cast.  Tweak the
definition of EMPTY_TREE_SHA1_BIN to produce a value of more
convenient type.

In the future the definition might change to

	extern const unsigned char empty_tree_sha1_bin[20];
	#define EMPTY_TREE_SHA1_BIN empty_tree_sha1_bin

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout.c |    2 +-
 cache.h            |    4 +++-
 notes-merge.c      |    2 +-
 sha1_file.c        |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 757f9a0..cd7f56e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -404,7 +404,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 		topts.dir->exclude_per_dir = ".gitignore";
 		tree = parse_tree_indirect(old->commit ?
 					   old->commit->object.sha1 :
-					   (unsigned char *)EMPTY_TREE_SHA1_BIN);
+					   EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		tree = parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
diff --git a/cache.h b/cache.h
index d83d68c..3abf895 100644
--- a/cache.h
+++ b/cache.h
@@ -676,9 +676,11 @@ static inline void hashclr(unsigned char *hash)
 
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
-#define EMPTY_TREE_SHA1_BIN \
+#define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+#define EMPTY_TREE_SHA1_BIN \
+	 ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/notes-merge.c b/notes-merge.c
index 71c4d45..1467ad3 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -615,7 +615,7 @@ int notes_merge(struct notes_merge_options *o,
 	bases = get_merge_bases(local, remote, 1);
 	if (!bases) {
 		base_sha1 = null_sha1;
-		base_tree_sha1 = (unsigned char *)EMPTY_TREE_SHA1_BIN;
+		base_tree_sha1 = EMPTY_TREE_SHA1_BIN;
 		OUTPUT(o, 4, "No merge base found; doing history-less merge");
 	} else if (!bases->next) {
 		base_sha1 = bases->item->object.sha1;
diff --git a/sha1_file.c b/sha1_file.c
index d86a8db..b44fc95 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2048,7 +2048,7 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	EMPTY_TREE_SHA1_BIN,
+	EMPTY_TREE_SHA1_BIN_LITERAL,
 	OBJ_TREE,
 	"",
 	0
-- 
1.7.4
