From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 15:42:47 -0400
Message-ID: <20140310194247.GA24568@sigill.intra.peff.net>
References: <531D9B50.5030404@alum.mit.edu>
 <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
 <20140310155230.GA29801@sigill.intra.peff.net>
 <87k3c2820l.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 20:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN66A-0000lB-DC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbaCJTmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:42:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:36707 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752412AbaCJTmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 15:42:49 -0400
Received: (qmail 17000 invoked by uid 102); 10 Mar 2014 19:42:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 14:42:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 15:42:47 -0400
Content-Disposition: inline
In-Reply-To: <87k3c2820l.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243799>

On Mon, Mar 10, 2014 at 05:14:02PM +0100, David Kastrup wrote:

> [storing refs in sqlite]
>
> Of course, the basic premise for this feature is "let's assume that our
> file and/or operating system suck at providing file system functionality
> at file name granularity".  There have been two historically approaches
> to that problem that are not independent: a) use Linux b) kick Linus.

You didn't define "suck" here, but there are a number of issues with the
current ref storage system. Here is a sampling:

  1. The filesystem does not present an atomic view of the data (e.g.,
     you read "a", then while you are reading "b", somebody else updates
     "a"; your view is one that never existed at any point in time).

  2. Using the filesystem creates D/F conflicts between branches "foo"
     and "foo/bar". Because this name is a primary key even for the
     reflogs, we cannot easily persist reflogs after the ref is removed.

  3. We use packed-refs in conjunction with loose ones to achieve
     reasonable performance when there are a large number of refs. The
     scheme for determining the current value of a ref is complicated
     and error-prone (we had several race conditions that caused real
     data loss).

Those things can be solved through better support from the filesystem.
But they were also solved decades ago by relational databases.

I generally avoid databases where possible. They lock your data up in a
binary format that you can't easily touch with standard unix tools. And
they introduce complexity and opportunity for bugs.

But they are also a proven technology for solving exactly the sorts of
problems that some people are having with git. I do not see a reason not
to consider them as an option for a pluggable refs system. But I also do
not see a reason to inflict their costs on people who do not have those
problems. And that is why Michael's email is about _pluggable_ ref
backends, and not "let's convert git to sqlite".

I do not even know if sqlite is going to end up as an interesting
option. But it will be nice to be able to experiment with it easily due
to git's ref code becoming more modular.

-Peff
