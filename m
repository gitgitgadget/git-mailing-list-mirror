From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Wed, 18 May 2011 02:41:58 -0400
Message-ID: <20110518064158.GB27482@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 08:42:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMaSQ-0003Bd-I5
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 08:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab1ERGmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 02:42:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222Ab1ERGmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 02:42:04 -0400
Received: (qmail 2321 invoked by uid 107); 18 May 2011 06:44:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 02:44:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 02:41:58 -0400
Content-Disposition: inline
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173850>

On Sun, May 15, 2011 at 05:30:20PM -0700, Junio C Hamano wrote:

> Interested parties may want to measure the performance impact of the last
> three patches. The series deliberately ignores core.bigfileThreashold and
> let small and large blobs alike go through the streaming_write_entry()
> codepath, but it _might_ turn out that we would want to use the new code
> only for large-ish blobs.

Hmm.

  $ cd compile/linux-2.6
  $ rm -rf *
  $ time git.v1.7.5 checkout -f
  real    0m4.405s
  user    0m3.592s
  sys     0m0.804s

  $ rm -rf *
  $ time git.jch.streaming checkout -f
  real    0m7.062s
  user    0m5.188s
  sys     0m1.776s

(Actually those times are best-of-5 in each case). So there is
definitely some slow-down for the non-huge case. Bisection points to
your cd36b7b (streaming_write_entry(): use streaming API in
write_entry()).

According to perf, though, it's not the increased writes; the slowdown
is actually from create_pack_revindex, in this call chain:

 create_pack_revindex
 find_pack_revindex
 packed_object_info_detail
 sha1_object_info_extended
 istream_source
 open_istream
 streaming_write_entry

-Peff
