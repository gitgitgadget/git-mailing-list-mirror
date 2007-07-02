From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Bug: segfault during git-prune
Date: Mon, 2 Jul 2007 11:00:15 +0100
Message-ID: <200707021100.16610.andyparkins@gmail.com>
References: <200706281134.58453.andyparkins@gmail.com> <200706282321.44244.andyparkins@gmail.com> <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 12:00:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Ihl-0007DR-En
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 12:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXGBKAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 06:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbXGBKAX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 06:00:23 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:31731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbXGBKAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 06:00:22 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2297352mue
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 03:00:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EIswrD7Ydcevf1xj6YHcjVWyWxTUiaAlczjKlU2Evg95xV8XcBzANaLKpitrpWpjHny5j+f8+BZmaN9909tnQwfbMWLX+voVdgW15valtJ3+LA1AF2pYy+HHoCGUvZRS0kv/Y2Z6DjG+KKj5c87EM4nPufAYpxu+8F+/wNvbvRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rg8hXaTglnpv1+tzrAA3iRazk8yRMMfo+ZoLKzz3hVTEtMnqxFTybTvDlc/d1B53H9SI3M1DbspOWbYldsH72IoflSJii5d5yozlFkZUbBLZCQmOeNdluHLvZaU5f0VqXL8gIpp4tC+9vxygW6U4ax59xTjATOMDa9Pmf67M9ak=
Received: by 10.82.183.19 with SMTP id g19mr12561645buf.1183370420274;
        Mon, 02 Jul 2007 03:00:20 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b36sm14553226ika.2007.07.02.03.00.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 Jul 2007 03:00:19 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0706281525460.8675@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51348>

On Thursday 2007 June 28, Linus Torvalds wrote:

> Anyway, if that patch works for you, I'd suggest you just pass it on to
> Junio (and feel free to add my "Signed-off-by:" on it - but conditional on
> you having actually tested it).

Okay; tested with this patch, but no change in behaviour.

$ git-prune
error: Object 228f8065b930120e35fc0c154c237487ab02d64a is a blob, not a commit
Segmentation fault (core dumped)

Looking at your patch: is it possible that S_ISDIR() is true for gitlinks as 
well as S_ISGITLINK()?  S_ISDIR() is from unistd.h; and is presumably 
something like:
 
 S_ISDIR() { return mode & S_IFDIR; }

Given the GITLINK mode is S_IFLINK | S_IFDIR; then S_ISDIR() will be true and

        if (S_ISDIR(entry.mode))
            process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
+       else if (S_ISGITLINK(entry.mode))
+           process_gitlink(entry.sha1, p, &me, entry.path);
        else
            process_blob(lookup_blob(entry.sha1), p, &me, entry.path);

will never get to the process_gitlink() call.

However; I tried fixing this by swapping the order of the tests and the 
problem hasn't gone away.  I'm not sure that it's even getting as far as 
process_tree().  (incidentally I think the same fault exists in 
list-objects.c's process_tree).

Given the hints you gave me in your previous reply, I've looked at the 
backtrace again and understood more what's happening.

 - mark_reachable_objects() calls add_cache_refs()
 - which uses lookup_blob() to mark every hash in the index as an OBJ_BLOB 
   type of hash; including the GITLINK entries.
 - mark_reachable_objects() calls add_one_ref() for_each_ref(), which finds
   a ref pointing to one of the GITLINK entries, and via 
   parse_object_buffer(), tries to lookup_commit(), which finds the GITLINKed
   object using lookup_object() only it is not an OBJ_COMMIT, it's an OBJ_BLOB
 - all hell breaks loose

I think the fault is in add_cache_refs() which assumes that every hash in the 
index is an OBJ_BLOB.  I think that add_cache_refs() shouldn't be calling 
lookup_blob() for S_ISGITLINK() index entries.  Therefore I think this patch 
is the right one; what do you reckon?

diff --git a/reachable.c b/reachable.c
index ff3dd34..ffc8d0a 100644
--- a/reachable.c
+++ b/reachable.c
@@ -21,6 +21,15 @@ static void process_blob(struct blob *blob,
    /* Nothing to do, really .. The blob lookup was the important part */
 }
 
+static void process_gitlink(const unsigned char *sha1,
+               struct object_array *p,
+               struct name_path *path,
+               const char *name)
+{
+   /* I don't think we want to recurse into this, really. */
+}
+
+
 static void process_tree(struct tree *tree,
             struct object_array *p,
             struct name_path *path,
@@ -45,7 +54,9 @@ static void process_tree(struct tree *tree,
    init_tree_desc(&desc, tree->buffer, tree->size);
 
    while (tree_entry(&desc, &entry)) {
-       if (S_ISDIR(entry.mode))
+       if (S_ISGITLINK(entry.mode))
+           process_gitlink(entry.sha1, p, &me, entry.path);
+       else if (S_ISDIR(entry.mode))
            process_tree(lookup_tree(entry.sha1), p, &me, entry.path);
        else
            process_blob(lookup_blob(entry.sha1), p, &me, entry.path);
@@ -159,6 +170,16 @@ static void add_cache_refs(struct rev_info *revs)
 
    read_cache();
    for (i = 0; i < active_nr; i++) {
+       /*
+        * The index can contain blobs and GITLINKs, GITLINKs are hashes
+        * that don't actually point to objects in the repository, it's
+        * almost guaranteed that they are NOT blobs, so we don't call
+        * lookup_blob() on them, to avoid populating the hash table
+        * with invalid information
+        */
+       if (S_ISGITLINK(ntohl(active_cache[i]->ce_mode)))
+           continue;
+
        lookup_blob(active_cache[i]->sha1);
        /*
         * We could add the blobs to the pending list, but quite

If you think I'm on the right lines with this, I'll make better patches for 
Junio.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
