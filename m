From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 11/21] pack-objects: use bitmaps when packing objects
Date: Sat, 21 Dec 2013 08:15:03 -0500
Message-ID: <20131221131502.GA10123@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124510.GK10757@sigill.intra.peff.net>
 <87zjock6if.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Dec 21 14:15:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuMOx-0007ui-1C
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab3LUNPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:15:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48428 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUNPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:15:07 -0500
Received: (qmail 4557 invoked by uid 102); 21 Dec 2013 13:15:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:15:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:15:03 -0500
Content-Disposition: inline
In-Reply-To: <87zjock6if.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239589>

On Sat, Dec 07, 2013 at 04:47:20PM +0100, Thomas Rast wrote:

> > +static off_t write_reused_pack(struct sha1file *f)
> > +{
> > +	uint8_t buffer[8192];
> 
> We usually just call this 'unsigned char'.  I can see why this would be
> more portable, but git would already fall apart badly on an architecture
> where char is not 8 bits.

I think it's worth switching just for consistency with the rest of git.
Fixed.

> } +			packfile_size = write_reused_pack(f);
> } +			if (!packfile_size)
> } +				die_errno("failed to re-use existing pack");
> 
> So if you just died here, when the error happens, you could take the
> chance to tell the user _which_ syscall failed.

Yeah, agreed (and especially the fact that we may get bogus errno
values). Fixed.

> Not your fault, but sha1write() is an odd function -- it purportedly is
> 
>   int sha1write(struct sha1file *f, const void *buf, unsigned int count);
> 
> but it can only return 0.  This goes back all the way to c38138c
> (git-pack-objects: write the pack files with a SHA1 csum, 2005-06-26).

It looks like there's exactly one site that checks its return value, and
it's just to die. We should drop the return value from sha1write
entirely to make it clear that it dies on error. But that's orthogonal
to this series.

> > -static int add_object_entry(const unsigned char *sha1, enum object_type type,
> > -			    const char *name, int exclude)
> > +static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
> > +			      int flags, uint32_t name_hash,
> > +			      struct packed_git *found_pack, off_t found_offset)
> [...]
> This function makes my head spin, and you're indenting it yet another
> level.

Yeah. In addition, the use of the "flags" here is somewhat questionable.
We use them for internal values in the call from add_object_entry to
add_object_entry_1. But we also pass the latter as a traversal callback,
meaning that what it would get in "flags" is totally different. It's not
actually a bug in the current code, since the bitmap traversal always
passes empty flags, but it's still rather confusing.

> If it's not too much work, can you split it into the three parts that it
> really is?  IIUC it boils down to
> 
>   do we have this already?
>       possibly apply 'exclude', then return
>   are we coming from a call path that doesn't tell us which pack to take
>   it from?
>       find _all_ instances in packs
>       check if any of them are local .keep packs
>           if so, return
>   construct a packlist entry to taste

I did this split. By itself, I was on the fence, as there are actually
some interdependencies between the three parts that make it hairy.

But then I realized that instead of making the weird relationship
between add_object_entry and add_object_entry_1, we can simply make a
new function that composes the functions differently.

So we get:

+static int add_object_entry_from_bitmap(const unsigned char *sha1,
+					enum object_type type,
+					int flags, uint32_t name_hash,
+					struct packed_git *pack, off_t offset)
+{
+	uint32_t index_pos;
+
+	if (have_duplicate_entry(sha1, 0, &index_pos))
+		return 0;
+
+	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
+
+	display_progress(progress_state, to_pack.nr_objects);
+	return 1;
+}
[...]
+	traverse_bitmap_commit_list(&add_object_entry_from_bitmap);

which makes much more sense.

-Peff
