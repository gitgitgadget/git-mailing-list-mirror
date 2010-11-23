From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] fast-import: insert new object entries at start of hash
 bucket
Date: Tue, 23 Nov 2010 01:53:48 -0600
Message-ID: <20101123075348.GA10367@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 08:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKnhd-00088M-Ji
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 08:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0KWHyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 02:54:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65430 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab0KWHyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 02:54:01 -0500
Received: by gyb11 with SMTP id 11so1879511gyb.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 23:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=0dYod89Ox+8cL+tuMZD+9nI4kk5DNkrF4pAYVXtWlCc=;
        b=aHsDpvdqCfom8rmEm8Nwi4uU1CGBYEWt6DifluiE89eqcDLHb68AFhSEJq7irFa4Ew
         eJOF/BNy8Qcezkjhsy9DZw29w4YUW/92p0/L3vCa+x4Jkm3ENo8cUP1dFeYtnJZDQ/rI
         ON/I+dvQ/aF5upPzR86nDYcTryOpk843AhGBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=nguD86fqk43iffeTGYAHvRIdFhWQ4AowCBH7Os1rKjsaY4ZURuED+3YqkrFa5SWlyg
         MirleOsfFHRmiLW6rImMD8FfVcN0vHdjPMF2RYNg1l4j7XXSXaoEev6LrM2rRiTPvo39
         WdqMBR2eTasZISwqH9YdTX6x6Gi8ktk3oKQ4U=
Received: by 10.100.105.16 with SMTP id d16mr4822162anc.219.1290498840286;
        Mon, 22 Nov 2010 23:54:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m5sm548087anb.0.2010.11.22.23.53.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 23:53:59 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161931>

From: David Barr <david.barr@cordelta.com>

More often than not, find_object is called for recently inserted objects.
Optimise for this case by inserting new entries at the start of the chain.
This doesn't affect the cost of new inserts but reduces the cost of find
and insert for existing object entries.

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

After importing the first 500000 revs or so of the ASF repo with
svn-fe, it seems that fast-import gets a bit sluggish because its
object table fills up.  David noticed that one can get a bit of a
speed-up by noticing that objects are likely to be accessed soon after
they are inserted in this workflow.  (The basis for most svn deltas
comes from the revision just dumped.)

I would guess other workflows would display the same tendency if any;
at least, the same blob is likely to come up repeatedly in a few revs
and then not be mentioned for a while.  Though maybe there is some
reason to make the opposite assumption that I have not thought of.
Shawn?

A more dramatic improvement comes from increasing the size of the hash
table; in particular, David noticed it allows the CPU usage to
increase from ~60% to 100% of one core.  So presumably we should make
the size of the hash table dynamic.

Other aspects to investigate: choice of hash function; is it worth
moving accessed entries to the front of hash chains when they already
exist?

Timings in interesting workflows would also be nice.

Regardless, this seems like a good change on its own, especially
because it simplifies the code.

Thoughts?
Jonathan

 fast-import.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 77549eb..e2f4874 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -539,22 +539,17 @@ static struct object_entry *insert_object(unsigned char *sha1)
 {
 	unsigned int h = sha1[0] << 8 | sha1[1];
 	struct object_entry *e = object_table[h];
-	struct object_entry *p = NULL;
 
 	while (e) {
 		if (!hashcmp(sha1, e->idx.sha1))
 			return e;
-		p = e;
 		e = e->next;
 	}
 
 	e = new_object(sha1);
-	e->next = NULL;
+	e->next = object_table[h];
 	e->idx.offset = 0;
-	if (p)
-		p->next = e;
-	else
-		object_table[h] = e;
+	object_table[h] = e;
 	return e;
 }
 
-- 
1.7.2.3
