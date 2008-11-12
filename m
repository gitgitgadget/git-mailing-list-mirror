From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Wed, 12 Nov 2008 11:17:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
References: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Nelson <jnelson@jamponi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 17:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0IR4-0007XT-11
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462AbYKLQRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYKLQRk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:17:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46995 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbYKLQRi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:17:38 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KA8009IQAJTYPN0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Nov 2008 11:16:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100763>

First, pack.packSizeLimit and --max-pack-size didn't use the same base
unit which was confusing.  They both use MiB now.

Also, if the limit was sufficiently low, having a single object written
could bust the limit (by design), but caused the remaining allowed size 
to go negative for subsequent objects, which for an unsigned variable is 
a rather huge limit.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 12 Nov 2008, Jon Nelson wrote:

> I'm using 1.6.0.4 and I've found some weird behavior with
> pack.packSizeLimit and/or --max-pack-size.
> 
> Initially, I thought I could just use pack.packSizeLimit and set it to
> (say) 1 to try to limit the size of individual packfiles to 1MiB or
> less. That does not appear to be working.
> 
> In one case I performed the following set of commands:
> 
> # set pack.packSizeLimit to 20
> git config --global pack.packSizeLimit 20
> 
> # verify that it's 20
> git config --get pack.packSizeLimit # verify it's 20
> 
> # run gc --prune
> git gc --prune
> 
> # show the packfiles
> # I find a *single* 65MB packfile, not a series
> # of 20MB (or less) packfiles.
> ls -la .git/objects/pack/*.pack
> 
> # try repack -ad
> git repack -ad
> 
> # I find a *single* 65MB packfile, not a series
> # of 20MB (or less) packfiles.
> ls -la .git/objects/pack/*.pack
> 
> 
> So it would appear that the pack.packSizeLimit param
> is just being ignored??
> 
> Then I tested using --max-pack-size explicitly. This works, to a degree.
> 
> git repack -ad --max-pack-size 20
> 
> # the following shows *4* pack files none larger
> # than (about) 20MB
> ls -la .git/objects/pack/*.pack
> 
> # try again with 3MB. This also works.
> git repack -ad --max-pack-size 3
> find .git/objects/pack -name '*.pack' -size +3M -ls # nothing
> 
> # try again with 1MB. This does NOT work.
> git repack -ad --max-pack-size 1
> 
> # here, I find a *single* 65MB pack file again:
> find .git/objects/pack -name '*.pack' -size +1M -ls
> 
> Am I doing something completely wrong with pack.packSizeLimit?
> What is going on with --max-pack-size in the 1MB case?

Does this fix it for you?

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 32dcd64..e7808b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1036,9 +1036,9 @@ you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
 the `{asterisk}.idx` file.
 
 pack.packSizeLimit::
-	The default maximum size of a pack.  This setting only affects
-	packing to a file, i.e. the git:// protocol is unaffected.  It
-	can be overridden by the `\--max-pack-size` option of
+	The default maximum size of a pack, expressed in MiB.  This
+	setting only affects packing to a file, i.e. the git:// protocol is
+	unaffected. It can be overridden by the `\--max-pack-size` option of
 	linkgit:git-repack[1].
 
 pager.<cmd>::
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 0c4649c..fdee9c6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -245,8 +245,12 @@ static unsigned long write_object(struct sha1file *f,
 	type = entry->type;
 
 	/* write limit if limited packsize and not first object */
-	limit = pack_size_limit && nr_written ?
-			pack_size_limit - write_offset : 0;
+	if (!pack_size_limit || !nr_written)
+		limit = 0;
+	else if (pack_size_limit <= write_offset)
+		limit = 1;
+	else
+		limit = pack_size_limit - write_offset;
 
 	if (!entry->delta)
 		usable_delta = 0;	/* no delta */
@@ -1844,7 +1848,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 	if (!strcmp(k, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(k, v);
+		pack_size_limit_cfg = git_config_ulong(k, v) * 1024 * 1024;
 		return 0;
 	}
 	return git_default_config(k, v, cb);
