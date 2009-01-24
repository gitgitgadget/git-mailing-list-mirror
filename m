From: Jeff King <peff@peff.net>
Subject: Re: read-only working copies using links
Date: Sat, 24 Jan 2009 14:34:22 -0500
Message-ID: <20090124193422.GB18010@coredump.intra.peff.net>
References: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com> <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com> <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Tim 'Mithro' Ansell <tansell@google.com>, git@vger.kernel.org
To: Chad Dombrova <chadrik@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQoII-0002DN-LP
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155AbZAXTe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbZAXTeZ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:34:25 -0500
Received: from peff.net ([208.65.91.99]:37805 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbZAXTeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:34:24 -0500
Received: (qmail 19265 invoked by uid 107); 24 Jan 2009 19:34:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 24 Jan 2009 14:34:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jan 2009 14:34:22 -0500
Content-Disposition: inline
In-Reply-To: <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106996>

On Sat, Jan 24, 2009 at 10:39:46AM -0800, Chad Dombrova wrote:

>> I think Tim Ansell (cced) was talking about this at the gittogether
>> (storing the metadata seperately), as it would benefit sparse/narrow
>> checkout, another advantage supporting his case?
>
> what's the case against it, other than the obvious, that it will take  
> more work?

I'm not sure this is actually the same as Tim's proposal. Tim wanted to
store the commit and tree information separately from the blob
information (since his use case was that blobs are enormous, but the
rest is reasonable).

AIUI, Chad's proposal is about storing the actual blob data itself
separate from the blob object's metadata (i.e., its object type and
length headers). Which means that the normal loose object format is not
acceptable, and you would end up with something like (for example):

  .git/objects/pack/pack-full-of-your-regular-stuff.{pack,idx}
  .git/objects/[0-9a-f]{2}/[0-9a-f]{38}/header
  .git/objects/[0-9a-f]{2}/[0-9a-f]{38}/data

or something similar. Then you could hardlink directly to the 'data'
portion. So you would need:

  - to teach everything that ever looks for loose objects how to read
    this new format. In theory, it's all nicely encapsulated in
    sha1_file.c

  - to teach checkout routines to hardlink such a case instead of
    copying the file

The obvious downsides that I can think of are:

  - it has the potential to make object reading, which is a core part of
    git (read: very performance- and correctness- sensitive) a lot more
    complex. But maybe the implementation would not be that painful;
    somebody would have to look very closely to see.

  - it interacts badly with smudge/clean filters and crlf conversion.
    In those cases you can't hardlink. If you treat this like an
    optimization, though, it's not so bad: we only do the optimization
    when we _can_, and fall back to regular checkout if those other
    options are in effect.

  - it's somewhat dangerous to your repository's health. Git's model is
    that object files are immutable (since they are, after all, named
    after their contents). But now you are linking them into your
    working tree, which makes them susceptible to some third party tool
    munging them. So yes, most tools will probably behave, but any tool
    that misbehaves will actually corrupt your repository.

-Peff
