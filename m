From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Signinig a commit with multiple signatures
Date: Tue, 19 Aug 2014 09:09:36 -0400
Organization: PD Inc
Message-ID: <FC21F8BBC6EF41E1952CA340138A50D2@black>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com> <20140817075250.GH23808@peff.net> <DED50992A39F4A07ACD997A65602991E@black> <20140819080510.GC7712@peff.net>
Reply-To: "Jeff King" <peff@peff.net>, "GIT" <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Jeff King'" <peff@peff.net>, "'GIT'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:09:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJjAV-00031G-7v
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 15:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbaHSNJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 09:09:39 -0400
Received: from mail.pdinc.us ([67.90.184.27]:43442 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbaHSNJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2014 09:09:38 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s7JD9apQ013843;
	Tue, 19 Aug 2014 09:09:36 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140819080510.GC7712@peff.net>
Thread-Index: Ac+7hHnEQxCFnRVjQ2ewf2ySRR48DQAJ1+sg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255459>

> -----Original Message-----
> From: Jeff King
> Sent: Tuesday, August 19, 2014 4:05
> 
> On Sun, Aug 17, 2014 at 09:30:47AM -0400, Jason Pyeron wrote:
> 
> > I am working on an open source project right now where we 
> are looking
> > to enforce a N of M audit approval process. It turns out that git
> > supports verifying multiple signatures because gpg supports 
> signature
> > merging.
> 
> In the scheme you propose, the commit object is actually rewritten. So
> whoever made and signed it first will then need to rebase on 
> top of the
> rewritten multi-signed version.

Not exactly. A known and shared commit is used as the parent of an empty, no changes commit. The "no changes" commit object is taken and passed around before being added into the repository. There is no need for a rebase.

But my scheme uses out-of-band process to accomplish this. The idea of using git to "distribute" the conflict resolution seemed like a valid use case of sharing a working copy state for a distributed commit, just like this. [1][2]

> 
> Is there a reason not to use detached signatures, and let each person

Yes. The embeded signatures provides the best user experience (UX) for verification.

> add them after the fact? You can store them in git-notes and then push
> them along with the other commits (you can even check in a pre-receive
> hook that the commits meet your N of M criteria, as long as everybody
> has pushed up their signature notes).
> 
> > $ cat write-commit.ruby
> > #!/usr/bin/irb
> > require 'fileutils'
> > file = File.open(ARGV[0], "rb")
> > content = file.read
> > header = "commit #{content.length}\0"
> > store = header + content
> > require 'digest/sha1'
> > sha1 = Digest::SHA1.hexdigest(store)
> > require 'zlib'
> > zlib_content = Zlib::Deflate.deflate(store)
> > path = '.git/objects/' + sha1[0,2] + '/' + sha1[2,38]
> > FileUtils.mkdir_p(File.dirname(path))
> > File.open(path, 'w') { |f| f.write zlib_content }
> 
> I think this is just "git hash-object -w -t commit <file>", isn't it?

Let me find the most complicated way of saying this, yes. I feel silly for that.

-Jason

[1]: http://git.661346.n2.nabble.com/Sharing-a-massive-distributed-merge-td6178696.html
[2]: http://git.661346.n2.nabble.com/Sharing-merge-conflict-resolution-between-multiple-developers-td7616700.html
