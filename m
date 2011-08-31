From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: Fix race condition in delta_base_cache
Date: Tue, 30 Aug 2011 21:59:36 -0400
Message-ID: <20110831015936.GB2519@sigill.intra.peff.net>
References: <4E5CE982.7080200@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 03:59:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qya5i-0001L1-At
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 03:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab1HaB7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 21:59:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54683
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754707Ab1HaB7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 21:59:41 -0400
Received: (qmail 31973 invoked by uid 107); 31 Aug 2011 02:00:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 22:00:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 21:59:36 -0400
Content-Disposition: inline
In-Reply-To: <4E5CE982.7080200@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180453>

On Tue, Aug 30, 2011 at 03:45:38PM +0200, Nicolas Morey-Chaisemartin wrote:

> According to gdb the problem originate from release_delta_cash (sha1_file.c:1703)
> 		free(ent->data);
> 
> From my analysis it seems that git grep threads do acquire lock before
> calling read_sha1_file but not before calling
> read_object_with_reference who ends up calling read_sha1_file too.

Yeah, I think this is necessary, and the patch looks good.

I notice there are some other code paths that end up in xmalloc without
locking, too (e.g., load_file, and some strbuf_* calls). Don't those
need locking, too, as malloc may try to release packfile memory?

builtin/pack-objects.c dealt with this already by setting a new
"try_to_free" routine that locks[1], which we should also do. It
probably comes up less frequently, because it only happens when we're
under memory pressure.

-Peff

[1] Actually, it looks like the "try_to_free" routine starts as nothing,
    and then add_packed_git sets it lazily to try_to_free_pack_memory.
    But what builtin/pack-objects tries to do is overwrite that with a
    version of try_to_free_pack_memory that does locking. So it's
    possible that we would not have read any packed objects while
    setting up the threads, and add_packed_git will overwrite our
    careful, locking version of try_to_free_pack_memory.

    I _think_ pack-objects is probably OK, because it will have already
    done the complete "counting objects" phase, which would look in any
    packs. But it may be harder for grep.
