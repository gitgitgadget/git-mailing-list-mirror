From: Jeff King <peff@peff.net>
Subject: Re: Bug in default commit hook (improperly forbidding a single blank
 line at EOF)
Date: Tue, 8 Sep 2015 00:55:04 -0400
Message-ID: <20150908045504.GA26331@sigill.intra.peff.net>
References: <55EE3BD9.7020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Raymond Jennings <shentino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 06:55:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZAw5-0001E1-AO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 06:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbbIHEzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 00:55:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:56094 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306AbbIHEzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 00:55:07 -0400
Received: (qmail 10650 invoked by uid 102); 8 Sep 2015 04:55:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Sep 2015 23:55:07 -0500
Received: (qmail 19015 invoked by uid 107); 8 Sep 2015 04:55:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 00:55:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 00:55:04 -0400
Content-Disposition: inline
In-Reply-To: <55EE3BD9.7020707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277484>

On Mon, Sep 07, 2015 at 06:37:29PM -0700, Raymond Jennings wrote:

> Please see https://bugs.gentoo.org/show_bug.cgi?id=559920 for further
> details.
> 
> Files *should* have a single blank line at the end, because a line should
> always have a newline at the end.

I'm not sure I follow. Lines should have a newline at the end, but there
is no need to start a _new_ blank line. So a file with zero bytes has no
lines (and no newline).

A file that contains a single line, like "one\n", has each line end in a
newline, and the file ends in a newline. There is no blank line.

A file like "one\n\n" has two lines: one with text, and a blank line at
the end.

Can you clarify (preferably by showing a byte sequence of the file in
question) what file you are feeding to the hook, what output you get,
and what output you expect?

> Adding a newline to the end of a file whose last line doesn't have one
> should be legal...as long as you don't create empty lines at the end.

If you mean turning "foo" (a file with no newline!) into "foo\n", I
agree that is legal, and does not create an empty blank line at the end.
But I don't think the hook complains about that.

E.g., we can create a sequence of file content:

  git init

  echo -n one >file
  git add file
  git commit -m 'no newline'

  echo >>file
  git add file
  git commit -m 'complete line'

  echo >>file
  git add file
  git commit -m 'add a blank line'

and run "log --check", which runs the same code that the pre-commit hook
does:

  git log --check

Git complains only about the final, which looks right to me. If you want
to redefine git's idea of which whitespace is worth complaining about,
try:

  git config core.whitespace -blank-at-eof

See the description of core.whitespace in "git help config" for the
complete list.  You can also set it per-file using gitattributes. See
"git help attributes", section "Checking whitespace errors".

-Peff
