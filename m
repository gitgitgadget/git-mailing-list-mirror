From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Fri, 17 Apr 2015 10:03:15 -0400
Message-ID: <20150417140315.GA13506@peff.net>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 16:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj6re-0001py-4O
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934049AbbDQODV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:03:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:46699 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbbDQODT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 10:03:19 -0400
Received: (qmail 1968 invoked by uid 102); 17 Apr 2015 14:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 09:03:17 -0500
Received: (qmail 2107 invoked by uid 107); 17 Apr 2015 14:03:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 10:03:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 10:03:15 -0400
Content-Disposition: inline
In-Reply-To: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267355>

On Fri, Apr 17, 2015 at 05:30:22PM +1000, Stefan Saasen wrote:

> The merge is created in a temporary location that uses alternates. The
> temporary repository is on a local disk, the alternate object database
> on an NFS mount.

Is the alternate writeable? If we can't freshen the object, we fall back
to storing the object locally, which could have a performance impact.
But it looks from your tables below like the utime() call is succeeding,
so that is probably not what is happening here.

> My current hypothesis is that the additional `access`, but more
> importantly the additional `utime` calls are responsible in the
> increased merge times that we see.

Yeah, that makes sense from your tables. The commit in question flips
the order of the loose/packed check, and the packed check should be much
faster on your NFS mount. Can you try:

diff --git a/sha1_file.c b/sha1_file.c
index 88f06ba..822aaef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3014,7 +3014,7 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
 		hashcpy(returnsha1, sha1);
-	if (freshen_loose_object(sha1) || freshen_packed_object(sha1))
+	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
 }

I think that should clear up the access() calls, but leave the utime()
ones.

> Looking at the detailed strace shows that utime will be called
> repeatedly in same cases (e.g.
> https://bitbucket.org/snippets/ssaasen/oend shows an example where the
> same packfile will be updated more than 4000 times in a single merge).
> 
> http://www.spinics.net/lists/git/msg240106.html discusses a potential
> improvement for this case. Would that be an acceptable avenue to
> improve this situation?

I think so. Here's a tentative patch:

diff --git a/cache.h b/cache.h
index 3d3244b..72c6888 100644
--- a/cache.h
+++ b/cache.h
@@ -1174,6 +1174,7 @@ extern struct packed_git {
 	int pack_fd;
 	unsigned pack_local:1,
 		 pack_keep:1,
+		 freshened:1,
 		 do_not_close:1;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
diff --git a/sha1_file.c b/sha1_file.c
index 822aaef..f27cbf1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2999,7 +2999,11 @@ static int freshen_loose_object(const unsigned char *sha1)
 static int freshen_packed_object(const unsigned char *sha1)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e) && freshen_file(e.p->pack_name);
+	if (!find_pack_entry(sha1, &e))
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	return freshen_file(e.p->pack_name);
 }
 
 int write_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *returnsha1)


If it's not a problem, I'd love to see timings for your case with just
the first patch, and then with both.

You may also be interested in:

  http://thread.gmane.org/gmane.comp.version-control.git/266370

which addresses another performance problem related to the
freshen/recent code in v2.2.

-Peff
