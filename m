From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 1 Dec 2008 12:44:15 -0500
Message-ID: <20081201174414.GA22185@coredump.intra.peff.net>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com> <1228140775-29212-2-git-send-email-gitster@pobox.com> <1228140775-29212-3-git-send-email-gitster@pobox.com> <1228140775-29212-4-git-send-email-gitster@pobox.com> <1228140775-29212-5-git-send-email-gitster@pobox.com> <1228140775-29212-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:45:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Cpy-00064t-HV
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYLARoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbYLARoR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:44:17 -0500
Received: from peff.net ([208.65.91.99]:1553 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbYLARoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:44:17 -0500
Received: (qmail 27752 invoked by uid 111); 1 Dec 2008 17:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 12:44:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 12:44:15 -0500
Content-Disposition: inline
In-Reply-To: <1228140775-29212-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102070>

On Mon, Dec 01, 2008 at 06:12:54AM -0800, Junio C Hamano wrote:

> +			packet_write(1, "%s %s%c%s%c%s\n", sha1_to_hex(sha1), refname,
> +				     0, capabilities, 0, target);

Yuck. My two complaints are:

  (1) this implicitly handles only the HEAD symref. I don't think any
      others are in common use, but the rest of git handles arbitrary
      symrefs just fine. It would be a shame to needlessly limit the
      protocol. Can we at least make it <ref>:<ref> to allow later
      expansion to other symrefs?

      (1a) As a follow-on to that, because the client is not requesting
      anything, how would we ask for other symrefs if we want to do so
      later?  I think it would be nice to eventually allow copying of
      arbitrary symrefs within the refs/* hierarchy (e.g.,
      project-specific branch aliases). Sending all symrefs right off
      the bat is potentially large and wasteful.

  (2) You've used up the first such expansion slot forever. Now it's "if
      I want to tell you the symref, there is an extra slot, and
      otherwise none". But if we ever want to use the _next_ slot, then
      you will always have to send this slot (blank, I guess?). It gets
      even more complicated if you ever want to an arbitrary number of
      symref mappings. Maybe a short header to say "this slot contains a
      symref target"?

So (1) and (2) together would make it something like:

   <capabilities>\0
   symref HEAD:refs/heads/master\0
   symref refs/heads/alias:refs/heads/branch\n

which would make adding any new features in the expansion slots easier.
But that still doesn't address (1a). I really like the other proposal a
lot better.

-Peff
