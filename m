From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git hang with corrupted .pack
Date: Wed, 14 Oct 2009 07:23:51 -0700
Message-ID: <20091014142351.GI9261@spearce.org>
References: <20091014042249.GA5250@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Andy Isaacson <adi@hexapodia.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4wo-0000pr-RC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbZJNOY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756579AbZJNOY3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:24:29 -0400
Received: from george.spearce.org ([209.20.77.23]:59295 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbZJNOY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:24:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E739A381FE; Wed, 14 Oct 2009 14:23:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091014042249.GA5250@hexapodia.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130294>

Andy Isaacson <adi@hexapodia.org> wrote:
> We're looping in unpack_compressed_entry, adding a fprintf immediately
> after the call to git_inflate() shows:

Thanks, that was really quite helpful.  Junio/Nico, I think we can
just apply this patch to maint and include it in the next release:

--8<--
[PATCH] sha1_file: Fix infinite loop when pack is corrupted

Some types of corruption to a pack may confuse the deflate stream
which stores an object.  In Andy's reported case a 36 byte region
of the pack was overwritten, leading to what appeared to be a valid
deflate stream that was trying to produce a result larger than our
allocated output buffer could accept.

Z_BUF_ERROR is returned from inflate() if either the input buffer
needs more input bytes, or the output buffer has run out of space.
Previously we only considered the former case, as it meant we needed
to move the stream's input buffer to the next window in the pack.

We now abort the loop if inflate() returns Z_BUF_ERROR without
consuming the entire input buffer it was given, or has filled
the entire output buffer but has not yet returned Z_STREAM_END.
Either state is a clear indicator that this loop is not working
as expected, and should not continue.

This problem cannot occur with loose objects as we open the entire
loose object as a single buffer and treat Z_BUF_ERROR as an error.

Reported-by: Andy Isaacson <adi@hexapodia.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4ea0b18..4cc8939 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1357,6 +1357,8 @@ unsigned long get_size_from_delta(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
+		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
+			break;
 		curpos += stream.next_in - in;
 	} while ((st == Z_OK || st == Z_BUF_ERROR) &&
 		 stream.total_out < sizeof(delta_head));
@@ -1594,6 +1596,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
+		if (st == Z_BUF_ERROR && (stream.avail_in || !stream.avail_out))
+			break;
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
-- 
1.6.5.52.g0ff2e

-- 
Shawn.
