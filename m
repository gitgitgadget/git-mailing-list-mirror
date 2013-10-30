From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Wed, 30 Oct 2013 03:27:27 -0400
Message-ID: <20131030072727.GF11317@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060345.GH23098@sigill.intra.peff.net>
 <CACsJy8Cv5WMB=L+fQCj-ZURZC3ZdEqXaqqW_O2ZD-HNcC_V3yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQBw-0005nM-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab3J3H1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:27:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:58256 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751781Ab3J3H1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:27:30 -0400
Received: (qmail 15756 invoked by uid 102); 30 Oct 2013 07:27:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:27:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:27:27 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Cv5WMB=L+fQCj-ZURZC3ZdEqXaqqW_O2ZD-HNcC_V3yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236993>

On Sat, Oct 26, 2013 at 05:14:16PM +0700, Nguyen Thai Ngoc Duy wrote:

> If it's not mentioned yet, maybe you should note that this code
> currently supports only one pack with .bitmap file.

Yes, there's really not any point in having multiple .bitmap files, as
the bitmaps need to be closed over the set of objects. So you would have
one "base" pack with a bunch of bitmaps. But any pack that builds on
that cannot be bitmapped.

JGit has the same restriction, mostly because it keeps the
implementation much saner, and there is not really a good reason to lift
it (if you want more things bitmapped, you probably also want them
packed to share deltas).

I'm happy to mention that somewhere, but I'm not sure where is most
appropriate.

> > diff --git a/khash.h b/khash.h
> [...]
> I notice the line continuations '\' in this file look more aligned if
> tab length is set to 4. No idea how many emacs users out there but it
> probably does not harm to put
> 
> /* -*- mode: c; tab-width: 4; -*- */
> 
> at the beginning of this file? Another option is realign the file,
> which I doubt is good because this file is imported.

Yes, it doesn't follow our normal whitespace guidelines. I refrained
from tweaking it for the reason you mentioned (kwset.c is in a similar
boat).

I'd use:

  /* vim: set ts=4 */

myself. :) We have resisted having such modelines so far, leaving it
instead to developers to configure their editor as appropriate. It is
harder when there is an oddball file like this, though. I don't have a
strong opinion either way.

> I don't see any mechanism to protect us from corrupt .bitmap files. If
> .bitmap is not very large, maybe just check the trailing checksum in
> the file when we open it? Else maybe add a crc32 or something after
> each commit bitmap in .bitmap v2 and only verify the ones we actually
> use?

The .bitmap for the kernel is about 6MB of bitmaps, plus about 12MB for
the name-hash cache. The loading procedure needs to read through the
whole bitmap section, as the records are variable width and there is no
index. But to verify the sha1 we'd have to go through the extra 12MB of
name-hash cache, which we would otherwise not need to touch.

Adding a crc would not be too big a deal. However, I'd really like to
focus first on getting the v1 reader/writer merged. That's set in stone
due to JGit, so anything we do for v2 would want to build on top anyway.

> > +static int open_pack_bitmap(void)
> > +{
> > +       struct packed_git *p;
> > +
> > +       assert(!bitmap_git.map && !bitmap_git.loaded);
> > +
> > +       prepare_packed_git();
> > +       for (p = packed_git; p; p = p->next) {
> > +               if (open_pack_bitmap_1(p) == 0)
> > +                       return 0;
> 
> It maybe a good idea to go on anyway, checking for another .bitmap.
> Just warn the user about that if found.

Yeah, that sounds reasonable. I'll squash this in:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 459b587..078f7c6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -265,6 +265,12 @@ static int open_pack_bitmap_1(struct packed_git *packfile)
 		return -1;
 	}
 
+	if (bitmap_git.pack) {
+		warning("ignoring extra bitmap file: %s", idx_name);
+		close(fd);
+		return -1;
+	}
+
 	bitmap_git.pack = packfile;
 	bitmap_git.map_size = xsize_t(st.st_size);
 	bitmap_git.map = xmmap(NULL, bitmap_git.map_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -325,16 +331,17 @@ char *pack_bitmap_filename(struct packed_git *p)
 static int open_pack_bitmap(void)
 {
 	struct packed_git *p;
+	int ret = -1;
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
-			return 0;
+			ret = 0;
 	}
 
-	return -1;
+	return ret;
 }
 
 int prepare_bitmap_git(void)

-Peff
