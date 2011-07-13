From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 5/6] check commit generation cache validity against
 grafts
Date: Wed, 13 Jul 2011 15:35:09 -0400
Message-ID: <20110713193509.GC31965@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070616.GE18566@sigill.intra.peff.net>
 <4E1DAB14.5040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 21:35:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh5DL-0006VI-8K
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 21:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab1GMTfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 15:35:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40541
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab1GMTfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 15:35:11 -0400
Received: (qmail 28206 invoked by uid 107); 13 Jul 2011 19:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 15:35:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 15:35:09 -0400
Content-Disposition: inline
In-Reply-To: <4E1DAB14.5040001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177072>

On Wed, Jul 13, 2011 at 10:26:28AM -0400, Eric Sunshine wrote:

> On 7/13/2011 3:06 AM, Jeff King wrote:
> >+void metadata_graph_validity(unsigned char out[20])
> >+{
> >+	git_SHA_CTX ctx;
> >+
> >+	git_SHA1_Init(&ctx);
> >+
> >+	git_SHA1_Update(&ctx, "grafts", 6);
> >+	commit_graft_validity(&ctx);
> >+
> >+	git_SHA1_Update(&ctx, "replace", 7);
> >+	replace_object_validity(&ctx);
> 
> The implementation of metadata_graph_validity() makes it clear that
> commit_graft_validity() and replace_object_validity() are computing
> checksums in aid of validity-checking of the generations cache.
> However, the naive reader seeing the names commit_graft_validity()
> and replace_object_validity() in the API is likely to assume that
> these functions are somehow checking validity of the grafts and
> replace-refs themselves, which is not the case. Perhaps better names
> would be commit_graft_checksum() and replace_object_checksum()?

Agreed. The term "validity" is a bit funny, and I think checksum is
better.

> The name metadata_graph_validity() also suffers from this
> shortcoming. The actual validity check is performed by
> check_cache_header(), whereas metadata_graph_validity() is merely
> computing a checksum.

Yeah. I had originally called it metadata_validity_graph() with the
assumption that the metadata-cache would provide a collection of
commonly-used validity functions. That didn't seem quite right, so I
switched the two words around to emphasize that it was about the graph.
But this function really has nothing to do with the metadata-cache at
all (except that validity tokens are a good place to use the result). It
really belongs to the commit subsystem, because it is about the shape of
the history graph.

So here's what I've done for the next iteration:

  1. metadata_graph_validity is now:

      void commit_graph_checksum(unsigned char out[20]);

     and lives in commit.[ch].

  2. commit_graft_validity is now commit_graft_checksum, and is static
     inside commit.c.

  3. replace_object_validity is now replace_objects_checksum. It must
     remain non-static because it lives in replace-object.c. I
     pluralized the "objects" to make it more clear it was not about
     checksumming a single replace_object, but rather all of them.

So now the only two warts I see are:

  1. Some of the *_checksum functions return a 20-byte sha1, and some
     are just meant to stir their contents into a SHA_CTX. I can live
     with that. You can tell which is which by looking at their
     signatures.

  2. The name "replace_object_checksum" can be read as "checksum the
     replace-objects" or as "replace this object's checksum". But the
     ambiguous verb in the name of the subsystem is not a problem I am
     introducing. The "replace-object" subsystem should perhaps have
     been called "replacement-object" from the beginning to make this
     more clear.

Thanks for the suggestions (I also took the suggestions from your other
email for improving the commit message).

-Peff
