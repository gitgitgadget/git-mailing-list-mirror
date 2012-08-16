From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] index-pack: produce pack index version 3
Date: Wed, 15 Aug 2012 22:42:54 -0700
Message-ID: <7vmx1v2y01.fsf@alter.siamese.dyndns.org>
References: <1344772889-8978-1-git-send-email-pclouds@gmail.com>
 <7vtxw8exii.fsf@alter.siamese.dyndns.org>
 <7vlihjgaaj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CNp2w6PsMSrQ4aFBwHKbOGid4pVHUhE4xgmTatrnEepQ@mail.gmail.com>
 <7v8vdjfddk.fsf@alter.siamese.dyndns.org>
 <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 07:43:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1srJ-0001F9-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 07:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab2HPFm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 01:42:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab2HPFm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 01:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F96360D9;
	Thu, 16 Aug 2012 01:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=czrbaza4mePaI06PfNlz4HXKlPY=; b=HceV5R
	ZaSo9iHD3+K3735aFgwnPjLdjYdugK+G9wzzfciOak/pUNAvpihBPpF4O5OlHgcv
	ZHSHOGWTEr96uuQSodSAU2KhbETn/tQzhd76TJiP72Q+Aawaov+HguvwUtnAQ+OV
	uGzLtGWs5WZXxptaXuzsX6srxW6DtKQ+h5HAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IO6vOm4WTxdvbI06VcMRIReQl3S2p9fR
	f0XkwGrytIngrR6yQ2PitxhR8SawFiuQy/5jJLUedNz09QnCNKfaVFk32udBTwZO
	N5X2PJvHuFNLL2ZESoBtEOW+ogKkHh0KxD+Kf1p5CdlXUJi/1mVNQNsZ+8KSg8Vw
	9AxKIJOiclM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D43A60D8;
	Thu, 16 Aug 2012 01:42:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5545960D7; Thu, 16 Aug 2012
 01:42:56 -0400 (EDT)
In-Reply-To: <CAJo=hJtwS=fdjTCVsEQHdVn9p+_2k-wJ_W_zLtZkWGO+M4suNQ@mail.gmail.com> (Shawn
 Pearce's message of "Mon, 13 Aug 2012 17:46:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AE42180-E765-11E1-93DE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> ... But I think its worth giving
> him a few weeks to finish getting the code ready, vs. rushing
> something in that someone else thinks might help. We have waited more
> than 6 years or whatever to improve packing. Colby's experiments are
> showing massive improvements (40s enumeration cut to 100ms) with low
> disk usage increase (<10%) and no pack file format changes.

No matter what you do, you would be saving the bitmap somewhere
outside the *.pack file, yes?  Will it be in some extended section
of the new *.idx file?

With the bitmap, your object enumeration phase may go very fast, and
you would be able to figure out, in response to a fetch request "I
have these tips of refs; please update me with these refs of yours",
the set of objects you would need to pack (i.e. the ones that are
reachable from your refs that were asked for, but that are not
reachable from the refs the requestor has).  

Among these objects, there will be ones that are expressed as a
delta against what you are going to send, or as a delta against what
you know the recipient must already have (if you are using thin pack
transfer) in the packfiles you have, and you can send these deltas
as-is without recomputation.

But there will be ones that are either expressed as a base in your
packfile, or as a delta against something you are not going to send
and you know that the recipient does not have.  In order to turn
these objects into deltas, it may be necessary to have a way to
record which "delta chain" each object belongs to, and if you are
introducing the mechanism to have extended sections in the new *.idx
file, that may be a good place to do so.  When you need to express
an object that your bitmap told you to send (as opposed to rev-list
walking told you with the paths to the objects), you can find other
objects that belong to the same "delta chain" and that you know are
available to the recipient when it starts to fixing the thin pack
using that extra piece of information, in order to find the optimal
delta base to encode such an object against.

Just for fun, I applied the attached patch and repacked the history
leading to v1.7.12-rc3 with the default depth/window:

  git rev-list --objects --all |
  git pack-objects \
      --no-reuse-delta --no-reuse-object --delta-base-offset \
      [--no-namehash] pack

with and without the experimental --no-namehash option.  The result
is staggering.  With name-hash to group objects from the same path
close together in the delta window, the resulting pack is 33M.
Without the name-hash hint, the same pack is 163M!  Needless to say,
keeping the objects that should be hashed together inside a delta
window is really important.

An obvious way to record the "delta chain" is to simply keep the
name_hash of each object in the pack, which would need 2 bytes per
object in the pack, that would bloat pack_idx_entry size from 32
bytes to 34 bytes per entry.  That way, after your bitmap discovers
an object that cannot reuse existing deltas, you can throw it, other
such objects with the same name-hash, and then objects that you know
will be available to the recipient (you mark the last category of
objects as "preferred base"), into the delta_list so that they are
close together in the delta window.

And here is a patch to experiment the name-hash based grouping
heuristics.

 builtin/pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git c/builtin/pack-objects.c w/builtin/pack-objects.c
index 782e7d0..a2dd67b 100644
--- c/builtin/pack-objects.c
+++ w/builtin/pack-objects.c
@@ -67,6 +67,7 @@ static int keep_unreachable, unpack_unreachable, include_tag;
 static unsigned long unpack_unreachable_expiration;
 static int local;
 static int incremental;
+static int use_name_hash = 1;
 static int ignore_packed_keep;
 static int allow_ofs_delta;
 static struct pack_idx_option pack_idx_opts;
@@ -863,7 +864,7 @@ static unsigned name_hash(const char *name)
 {
 	unsigned c, hash = 0;
 
-	if (!name)
+	if (!name || !use_name_hash)
 		return 0;
 
 	/*
@@ -2468,6 +2469,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			  "limit pack window by memory in addition to object limit"),
 		OPT_INTEGER(0, "depth", &depth,
 			    "maximum length of delta chain allowed in the resulting pack"),
+		OPT_BOOL(0, "namehash", &use_name_hash,
+			 "assign name hint to each path"),
 		OPT_BOOL(0, "reuse-delta", &reuse_delta,
 			 "reuse existing deltas"),
 		OPT_BOOL(0, "reuse-object", &reuse_object,
