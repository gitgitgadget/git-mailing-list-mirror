From: Sergio <sergio.callegari@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 28 Mar 2012 11:33:29 +0000 (UTC)
Message-ID: <loom.20120328T131530-717@post.gmane.org>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 13:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCr8V-00039O-47
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 13:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab2C1Ldu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 07:33:50 -0400
Received: from plane.gmane.org ([80.91.229.3]:57664 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285Ab2C1Ldt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 07:33:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SCr8K-00030a-94
	for git@vger.kernel.org; Wed, 28 Mar 2012 13:33:48 +0200
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:33:44 +0200
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 13:33:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:11.0) Gecko/20100101 Firefox/11.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194120>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> 
> On Wed, Mar 28, 2012 at 11:38 AM, Bo Chen <chen <at> chenirvine.org> wrote:
> > Hi, Everyone. This is Bo Chen. I am interested in the idea of "Better
> > big-file support".
> >
> > As it is described in the idea page,
> > "Many large files (like media) do not delta very well. However, some
> > do (like VM disk images). Git could split large objects into smaller
> > chunks, similar to bup, and find deltas between these much more
> > manageable chunks. There are some preliminary patches in this
> > direction, but they are in need of review and expansion."
> >
> > Can anyone elaborate a little bit why many large files do not delta
> > very well?
> 
> Large files are usually binary. Depends on the type of binary, they
> may or may not delta well. Those that are compressed/encrypted
> obviously don't delta well because one change can make the final
> result completely different.

I would add that the larger a file, the larger the temptation to use a
compressed format for it, so that large files are often compressed binaries.

For these, a trick to obtain good deltas can be to decompress before splitting
in chunks with the rsync algorithm. Git filters can already be used for this,
but it can be tricky to assure that the decompress - recompress roundtrip
re-creates the original compressed file.

Furhermore, some compressed binaries are internally composed by multiple streams
(think of a zip archive containing multiple files, but this is by no means
limited to zip). In this case, it is frequent to have many possible orderings of
the streams. If so, the best deltas can be obtained by sorting the streams in
some 'canonical' order and decompressing. Even without decompressing, sorting
alone can obtain good results as long as changes are only due to changes in a
single stream of the container. Personally, I know no example of git filters
used to perform this sorting which can be extremely tricky in assuring the
possibility of recovering the file in the original stream order.

Maybe (but this is just speculation), once the bup-inspired file chunking
support is in place, people will start contributing filters to improve the
management of many types of standard files (obviously 'improve' in terms of
space efficiency as filters can be quite slow).

Sergio
