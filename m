From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 18:56:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>  <m3y6siboij.fsf@localhost.localdomain>  <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>  <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>  <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
  <20090527215314.GA10362@coredump.intra.peff.net>  <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain> <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Alan Manuel Gloria <almkglor@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 03:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9UsU-0005d0-TC
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 03:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbZE1B5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 21:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756426AbZE1B5k
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 21:57:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48473 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755689AbZE1B5i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 21:57:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4S1upro008999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 18:56:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4S1unKA008783;
	Wed, 27 May 2009 18:56:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120131>



On Thu, 28 May 2009, Alan Manuel Gloria wrote:
> 
> If you'd prefer someone else to hack it, can you at least give me some
> pointers on which code files to start looking?  I'd really like to
> have proper large-file-packing support, where large file is anything
> much bigger than a megabyte or so.
> 
> Admittedly I'm not a filesystems guy and I can just barely grok git's
> blobs (they're the actual files, right? except they're named with
> their hash), but not packs (err, a bunch of files?) and trees (brown
> and green stuff you plant?).  Still, I can try to learn it.

The packs is a big part of the complexity.

If you were to keep the big files as unpacked blobs, that would be 
fairly simple - but the pack-file format is needed for fetching and 
pushing things, so it's not really an option.

For your particular case, the simplest approach is probably to just 
limit the delta search. Something like just saying "if the object is 
larger than X, don't even bother to try to delta it, and just pack it 
without delta compression". 

The code would still load that whole object in one go, but it sounds like 
you can handle _one_ object at a time. So for your case, I don't think you 
need a fundamental git change - you'd be ok with just an inefficient pack 
format for large files that are very expensive to pack otherwise.

You can already do that by using .gitattributes to not delta entries 
by name, but maybe it's worth doing explicitly by size too.

I realize that the "delta" attribute is apparently almost totally 
undocumented. But if your big blobs have a particular name pattern, what 
you should try is to do something like

 - in your '.gitattributes' file (or .git/info/attributes if you don't 
   want to check it in), add a line like

	*.img !delta

   which now sets the 'delta' attribute to false for all objects that 
   match the '*.img' pattern.

 - see if pack creation is now acceptable (ie do a "git gc" or try to push 
   somewhere)

Something like the following may also work, as a more generic "just don't 
even bother trying to delta huge files".

Totally untested. Maybe it works. Maybe it doesn't.

		Linus

---
 Documentation/config.txt |    7 +++++++
 builtin-pack-objects.c   |    9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2c03162..8c21027 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1238,6 +1238,13 @@ older version of git. If the `{asterisk}.pack` file is smaller than 2 GB, howeve
 you can use linkgit:git-index-pack[1] on the *.pack file to regenerate
 the `{asterisk}.idx` file.
 
+pack.packDeltaLimit::
+	The default maximum size of objects that we try to delta.
++
+Big files can be very expensive to delta, and if they are large binary
+blobs, there is likely little upside to it anyway. So just pack them
+as-is, and don't waste time on them.
+
 pack.packSizeLimit::
 	The default maximum size of a pack.  This setting only affects
 	packing to a file, i.e. the git:// protocol is unaffected.  It
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9742b45..9a0072b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -85,6 +85,7 @@ static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
 
+static unsigned long pack_delta_limit = 64*1024*1024;
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = 0;
 static unsigned long cache_max_small_delta_size = 1000;
@@ -1270,6 +1271,10 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (trg_entry->type != src_entry->type)
 		return -1;
 
+	/* If we limit delta generation, don't even bother for larger blobs */
+	if (pack_delta_limit && trg_entry->size >= pack_delta_limit)
+		return -1;
+
 	/*
 	 * We do not bother to try a delta that we discarded
 	 * on an earlier try, but only when reusing delta data.
@@ -1865,6 +1870,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		pack_size_limit_cfg = git_config_ulong(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.packdeltalimit")) {
+		pack_delta_limit = git_config_ulong(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
