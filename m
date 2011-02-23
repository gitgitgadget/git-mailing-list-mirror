From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line
 subject.
Date: Wed, 23 Feb 2011 03:08:54 -0500
Message-ID: <20110223080854.GB2724@sigill.intra.peff.net>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
 <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 09:09:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps9mP-0000Pc-IX
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 09:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab1BWII4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 03:08:56 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45463 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1BWII4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 03:08:56 -0500
Received: (qmail 10049 invoked by uid 111); 23 Feb 2011 08:08:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 08:08:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 03:08:54 -0500
Content-Disposition: inline
In-Reply-To: <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167676>

On Tue, Feb 22, 2011 at 12:43:40PM -0800, Junio C Hamano wrote:

> So the general idea of this change (I am thinking aloud what should be in
> the updated commit log message as the problem description) is that:
> 
>  - We currently give an entire multi-line paragraph string to the
>    add_rfc2047() function to be formatted as the title of the commit;
> 
>  - The add_rfc2047() functionjust passes "\n" through, without making it a
>    folding whitespace followed by a newline, to help callers that want to
>    use this function to produce a header line that is rfc 2822 conformant;
> 
>  - The patch introduces a new function add_rfc2047_multiline() that splits
>    its input and performs line folding for such a caller (namely, the
>    pp_title_line() function);
> 
>  - Another caller of add_rfc2047(), pp_user_info, is not changed, and it
>    won't fold the name of the user that appear on the From: line.
> 
> It is unclear if the last point is really the right thing to do, though.
> It is not a new problem that an author name that has a "\n" in it would
> break the output, but we probably would want to fix that case too here?

Yeah, I think the best path forward is:

  1. Stop feeding "pre-folded" subject lines to the email formatter.
     Give it the regular subject line with no newlines.

  2. rfc2047 encoding should encode a literal newline. Which should
     generally never happen, but is probably the most sane thing to do
     if it does.

  3. rfc2047 should fold all lines at some sane length. As it is now, we
     may sometimes generate long lines in headers (though in practice, I
     doubt this is much of a problem).

I started to work on this, but got stuck on (3). Our existing wrap
functions want NUL-terminated strings, and we are operating on a
substring. I tried converting the wrap functions to handle lengths, but
it got way uglier than I had hoped. I think just strdup'ing the subject
temporarily is probably fine, though. Let me see what I can come up
with.

-Peff
