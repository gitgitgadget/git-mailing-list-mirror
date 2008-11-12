From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Wed, 12 Nov 2008 13:23:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811121255330.27509@xanadu.home>
References: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
 <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
 <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Nelson <jnelson@jamponi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0KP6-0004Sw-Mc
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbYKLSYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYKLSYI
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:24:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64709 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYKLSYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:24:06 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KA800IYEGFY89N0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Nov 2008 13:23:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100800>

First, pack.packSizeLimit and --max-pack-size didn't use the same base
unit which was confusing.  They both use suffixable value arguments now.

Also, if the limit was sufficiently low, having a single object written
could bust the limit (by design), but caused the remaining allowed size
to go negative for subsequent objects, which for an unsigned variable is
a rather huge limit.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 12 Nov 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > First, pack.packSizeLimit and --max-pack-size didn't use the same base
> > unit which was confusing.  They both use MiB now.
> >
> > Also, if the limit was sufficiently low, having a single object written
> > could bust the limit (by design), but caused the remaining allowed size 
> > to go negative for subsequent objects, which for an unsigned variable is 
> > a rather huge limit.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > ---
> 
> > @@ -1844,7 +1848,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
> >  		return 0;
> >  	}
> >  	if (!strcmp(k, "pack.packsizelimit")) {
> > -		pack_size_limit_cfg = git_config_ulong(k, v);
> > +		pack_size_limit_cfg = git_config_ulong(k, v) * 1024 * 1024;
> 
> The fix to tweak the limit for subsequent split pack is a good thing to
> have, but this change would break existing repositories where people
> specified 20971520 (or worse yet "20m") to limit the size to 20MB.
> 
> I think --max-pack-size is what should be fixed to use git_parse_ulong()
> to match the configuration, if you find the discrepancy disturbing.

Fair enough.

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 1c4fb43..d60409a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -104,10 +104,11 @@ base-name::
 	default.
 
 --max-pack-size=<n>::
-	Maximum size of each output packfile, expressed in MiB.
+	Maximum size of each output packfile.
 	If specified,  multiple packfiles may be created.
 	The default is unlimited, unless the config variable
-	`pack.packSizeLimit` is set.
+	`pack.packSizeLimit` is set. The size can be suffixed with
+	"k", "m", or "g".
 
 --incremental::
 	This flag causes an object already in a pack ignored
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 0c4649c..9c4333b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -75,7 +75,7 @@ static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
 static int window = 10;
-static uint32_t pack_size_limit, pack_size_limit_cfg;
+static unsigned long pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
 static int delta_search_threads = 1;
 static int pack_to_stdout;
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
@@ -2103,11 +2107,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!prefixcmp(arg, "--max-pack-size=")) {
-			char *end;
-			pack_size_limit_cfg = 0;
-			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
-			if (!arg[16] || *end)
+			if (!git_parse_ulong(arg+16, &pack_size_limit))
 				usage(pack_usage);
+			else
+				pack_size_limit_cfg = 0;
 			continue;
 		}
 		if (!prefixcmp(arg, "--window=")) {
