From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Fri, 24 Feb 2012 02:54:25 -0500
Message-ID: <20120224075425.GA18688@sigill.intra.peff.net>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
 <7vr4xk28z0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 08:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0pzD-0005RN-9e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 08:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab2BXHya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 02:54:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55376
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab2BXHy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 02:54:28 -0500
Received: (qmail 21722 invoked by uid 107); 24 Feb 2012 07:54:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 02:54:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 02:54:25 -0500
Content-Disposition: inline
In-Reply-To: <7vr4xk28z0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191415>

On Thu, Feb 23, 2012 at 07:42:11PM -0800, Junio C Hamano wrote:

> It is a bit curious that anything filtered even goes to the streaming
> codepath, given this piece of code in write_entry() in entry.c:
> 
> 	if (ce_mode_s_ifmt == S_IFREG) {
> 		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
> 		if (filter &&
> 		    !streaming_write_entry(ce, path, filter,
> 					   state, to_tempfile,
> 					   &fstat_done, &st))
> 			goto finish;
> 	}
> 
> and get_stream_filter() in convert.c has an explicit exception for this
> case at the very beginning:

I think it is because we don't follow that code path at all. The stack trace
for "git add" looks on a large file looks like:

#0  stream_to_pack (...) at bulk-checkin.c:101
#1  deflate_to_pack (...) at bulk-checkin.c:219
#2  index_bulk_checkin (...) at bulk-checkin.c:258
#3  index_stream (...) at sha1_file.c:2712
#4  index_fd (...) at sha1_file.c:2726
#5  index_path (...) at sha1_file.c:2742
#6  add_to_index (...) at read-cache.c:644
#7  add_file_to_index (...) at read-cache.c:673
#8  add_files (...) at builtin/add.c:363
#9  cmd_add (...) at builtin/add.c:474
#10 run_builtin (...) at git.c:324
#11 handle_internal_command (...) at git.c:484
#12 run_argv (...) at git.c:530
#13 main (...) at git.c:605 

Isn't write_entry the _other_ side of things. I.e., checking out, not
checking in? That side works fine (making the large file handling
for git-add even more odd. We will fail to apply the "clean" filter when
adding it, but we will apply the smudge filter when we write it out).

-Peff
