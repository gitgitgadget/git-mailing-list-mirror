From: Jeff King <peff@peff.net>
Subject: Re: "git grep" parallelism question
Date: Tue, 30 Apr 2013 11:59:39 -0400
Message-ID: <20130430155939.GA31881@sigill.intra.peff.net>
References: <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
 <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
 <20130429161814.GJ472@serenity.lan>
 <877gjldxid.fsf@hexa.v.cablecom.net>
 <20130429180857.GK472@serenity.lan>
 <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
 <20130430080848.GP472@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 30 17:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXCy5-0004fM-UW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 17:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758699Ab3D3P7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 11:59:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:39207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758281Ab3D3P7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 11:59:42 -0400
Received: (qmail 8543 invoked by uid 102); 30 Apr 2013 15:59:56 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Apr 2013 10:59:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2013 11:59:39 -0400
Content-Disposition: inline
In-Reply-To: <20130430080848.GP472@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222940>

On Tue, Apr 30, 2013 at 09:08:49AM +0100, John Keeping wrote:

> > With your patch, doesn't "tXXXX-*.sh --root $there" automatically
> > use the fast $there temporary location as the result depot, too?
> 
> No, the current code uses:
> 
>     $TEST_OUTPUT_DIRECTORY/$root/trash\ directory.tXXXX
> 
> where we don't prepend $TEST_OUTPUT_DIRECTORY/ if $root is absolute.
> 
> > If it doesn't with the current code, shouldn't it?
> 
> I think the current behaviour is fine and the two options complement
> each other.
> 
> TEST_OUTPUT_DIRECTORY is something you set once and forget about which
> says "all of the test output should go over here", whereas --root is
> passed to a specific test and says "put your output here" but does not
> affect the result aggregation which is not specific to that test.

The original intent of "--root" (and how I use it) is to set and forget
it, too, via GIT_TEST_OPTS. I intentionally didn't move test results
with it, because to me the point was a pure optimization: put the trash
directories on a faster disk, and leave everything else identical.  With
"--root", any scripts which later want to look at test-results will find
them in the usual place.

Your patch updates all of the in-tree spots which look at the results,
but any third-party scripts would need to take it into account, too
(though I have no idea if any such scripts even exist).

I'm curious if there is a good reason to want to move the results. Some
possibilities I can think of are:

  1. More optimization, as results are written to the faster filesystem.
     I doubt this is noticeable, though, as the amount of data written
     is relatively small compared to the tests themselves (which are
     constantly creating and deleting repos).

  2. You can run tests in a read-only git checkout. I'm not sure how
     useful that is, though, since you would already need to compile
     git.

  3. You could have multiple sets of test results to keep or compare.
     I'd think you'd want to keep the built versions of git around, too,
     though. Which would mean that a full checkout like git-new-workdir
     would be a much simpler way to accomplish the same thing.

So I'm not against TEST_OUTPUT_DIRECTORY as a concept, but I'm having
trouble seeing how it is more useful than "--root".

> Note that setting TEST_OUTPUT_DIRECTORY in config.mak affects all tests
> no matter how you run them (via make or as ./tXXXX-yyyy.sh) whereas
> setting --root=... in GIT_TEST_OPTS only affect tests run via make.

I actually consider that a feature of "--root". When I run "make test"
everything happens fast. When I run the script manually (which is
usually because I'm debugging), the trash directory appears in the
current directory, so I can easily investigate it. And if you are
running a single test, the performance impact is usually negligible
(where you really notice it is when running "make -j32 test").

-Peff
