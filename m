From: Jeff King <peff@peff.net>
Subject: Re: git rev-list %an, %ae, %at bug in v1.7.10.1 and beyond
Date: Tue, 22 May 2012 00:32:21 -0400
Message-ID: <20120522043221.GA6859@sigill.intra.peff.net>
References: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue May 22 06:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWglw-0001sW-8I
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab2EVEc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 00:32:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51427
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685Ab2EVEcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 00:32:24 -0400
Received: (qmail 12156 invoked by uid 107); 22 May 2012 04:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 00:32:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 00:32:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGyf7-G3nNTTP1bKdd9HLKEn-8+LoxCeY2R08x9gKZwS0L_N6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198170>

On Mon, May 21, 2012 at 06:01:50PM +1000, Bryan Turner wrote:

> Note that the author name, e-mail and timestamp values are all missing
> (the three |'s in a row at the end).
> [...]
> Built from 0dbe6592ccbd1a394a69a52074e3729d546fe952, the parent of
> 4b340cf, and in previous versions of git (1.7.10 and earlier), I got
> output like this:
> [...]
> Note that the author name, e-mail and timestamp are all present. The
> "a" appears as ASCII here, but it's actually a UTF-16LE character (the
> terminal on the Mac is being "helpful").

I'm not too surprised this is broken (in fact, I'm surprised it ever
really worked). UTF-16, especially representing pure ascii characters,
will have embedded NULs. Most of the code assumes that things like names
and emails are NUL-terminated and ascii-compatible (so ascii, or some
ascii-superset encoding like utf8, iso8859-1, etc). You can store a
commit message (and name) in utf-16 if you tell git that you are doing
so, but we should be re-encoding it before handling it.

> ================================ Output =====================================
> aphrael:qa-resources.git bturner$ git cat-file -p
> 5c1ccdec5f84aa149a4978f729fdda70769f942f
> tree dd173cb70baaac07bdf405f4e3db110e7fafd180
> parent 02c78bc39ac6192623bf080e3e2ac892a4f5764c
> author a <farmas@atlassian.com> 1327876222 +1100
> committer a <farmas@atlassian.com> 1327876222 +1100
> 
> commit with unicode name
> ================================ End ========================================

There's no encoding header, so having a utf-16 character there is wrong.
How did you make such a commit in the first place, though? I believe
that git-commit treats the name as a string and would terminate on a NUL
(or am I wrong in thinking that this "a" is really U+0061, and is
actually some other unicode character that _looks_ like "a", but doesn't
contain a NUL?).

Did you create it by piping straight to git-hash-object? What does
piping the above through "xxd" or "cat -A" show?

-Peff
