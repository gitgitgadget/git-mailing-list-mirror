From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Thu, 13 Mar 2014 13:55:15 -0400
Message-ID: <20140313175515.GA18897@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqha73jb6q.fsf@gitster.dls.corp.google.com>
 <877g7yipf9.fsf@fencepost.gnu.org>
 <xmqq4n32j8i7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 18:55:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9qn-0006PG-W6
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 18:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbaCMRzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 13:55:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:38948 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754213AbaCMRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 13:55:17 -0400
Received: (qmail 2962 invoked by uid 102); 13 Mar 2014 17:55:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 12:55:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 13:55:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n32j8i7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244041>

On Thu, Mar 13, 2014 at 10:47:28AM -0700, Junio C Hamano wrote:

> >> --- a/builtin/cat-file.c
> >> +++ b/builtin/cat-file.c
> >> @@ -82,7 +82,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> >>  				enum object_type type;
> >>  				unsigned long size;
> >>  				char *buffer = read_sha1_file(sha1, &type, &size);
> >> -				if (memcmp(buffer, "object ", 7) ||
> >> +				if (!starts_with(buffer, "object ") ||
> >
> > [...]
> >
> >> The original hunks show that the code knows and relies on magic
> >> numbers 7 and 8 very clearly and there are rooms for improvement.
> >
> > Like: what if the file is empty?
> 
> Yes.

I think this one is actually OK. The result of read_sha1_file is
NUL-terminated, and we know that starts_with reads byte-by-byte (the
prior memcmp is wrong, but only if you care about accessing bytes past
the end of the NUL).

That whole piece of code seems silly, though, IMHO. It should be using
parse_tag or peel_to_type.

-Peff
