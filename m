From: Jeff King <peff@peff.net>
Subject: Re: Signinig a commit with multiple signatures
Date: Tue, 19 Aug 2014 04:05:11 -0400
Message-ID: <20140819080510.GC7712@peff.net>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
 <20140817075250.GH23808@peff.net>
 <DED50992A39F4A07ACD997A65602991E@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJeRR-0004ge-JF
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 10:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaHSIFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 04:05:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:54736 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbaHSIFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 04:05:13 -0400
Received: (qmail 21001 invoked by uid 102); 19 Aug 2014 08:05:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Aug 2014 03:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2014 04:05:11 -0400
Content-Disposition: inline
In-Reply-To: <DED50992A39F4A07ACD997A65602991E@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255448>

On Sun, Aug 17, 2014 at 09:30:47AM -0400, Jason Pyeron wrote:

> I am working on an open source project right now where we are looking
> to enforce a N of M audit approval process. It turns out that git
> supports verifying multiple signatures because gpg supports signature
> merging.

In the scheme you propose, the commit object is actually rewritten. So
whoever made and signed it first will then need to rebase on top of the
rewritten multi-signed version.

Is there a reason not to use detached signatures, and let each person
add them after the fact? You can store them in git-notes and then push
them along with the other commits (you can even check in a pre-receive
hook that the commits meet your N of M criteria, as long as everybody
has pushed up their signature notes).

> $ cat write-commit.ruby
> #!/usr/bin/irb
> require 'fileutils'
> file = File.open(ARGV[0], "rb")
> content = file.read
> header = "commit #{content.length}\0"
> store = header + content
> require 'digest/sha1'
> sha1 = Digest::SHA1.hexdigest(store)
> require 'zlib'
> zlib_content = Zlib::Deflate.deflate(store)
> path = '.git/objects/' + sha1[0,2] + '/' + sha1[2,38]
> FileUtils.mkdir_p(File.dirname(path))
> File.open(path, 'w') { |f| f.write zlib_content }

I think this is just "git hash-object -w -t commit <file>", isn't it?

-Peff
