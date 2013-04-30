From: John Keeping <john@keeping.me.uk>
Subject: Re: "git grep" parallelism question
Date: Tue, 30 Apr 2013 17:12:08 +0100
Message-ID: <20130430161207.GQ472@serenity.lan>
References: <CA+55aFw+6pL5DoEPsPZpJCAbqEGaWYYKcdjZzbsHVzSSMrQmww@mail.gmail.com>
 <7vip39w14d.fsf@alter.siamese.dyndns.org>
 <CA+55aFx1t_MT+20Bbkse-wHeLz8E06yqaOhbb12GzHNDrE2tWA@mail.gmail.com>
 <CALkWK0k6Gi_J6nDbrGPxDMmWC73CHXdj7a5ugC15YVrrycP=hA@mail.gmail.com>
 <20130429161814.GJ472@serenity.lan>
 <877gjldxid.fsf@hexa.v.cablecom.net>
 <20130429180857.GK472@serenity.lan>
 <7v1u9tgeov.fsf@alter.siamese.dyndns.org>
 <20130430080848.GP472@serenity.lan>
 <20130430155939.GA31881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:12:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDAQ-0007t9-6g
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761067Ab3D3QMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:12:24 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:35530 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761010Ab3D3QMU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:12:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E0FCA60651A;
	Tue, 30 Apr 2013 17:12:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9JHIH48NYbkH; Tue, 30 Apr 2013 17:12:19 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4B3B1606515;
	Tue, 30 Apr 2013 17:12:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130430155939.GA31881@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222943>

On Tue, Apr 30, 2013 at 11:59:39AM -0400, Jeff King wrote:
> On Tue, Apr 30, 2013 at 09:08:49AM +0100, John Keeping wrote:
> 
> > > With your patch, doesn't "tXXXX-*.sh --root $there" automatically
> > > use the fast $there temporary location as the result depot, too?
> > 
> > No, the current code uses:
> > 
> >     $TEST_OUTPUT_DIRECTORY/$root/trash\ directory.tXXXX
> > 
> > where we don't prepend $TEST_OUTPUT_DIRECTORY/ if $root is absolute.
> > 
> > > If it doesn't with the current code, shouldn't it?
> > 
> > I think the current behaviour is fine and the two options complement
> > each other.
> > 
> > TEST_OUTPUT_DIRECTORY is something you set once and forget about which
> > says "all of the test output should go over here", whereas --root is
> > passed to a specific test and says "put your output here" but does not
> > affect the result aggregation which is not specific to that test.
> 
> The original intent of "--root" (and how I use it) is to set and forget
> it, too, via GIT_TEST_OPTS. I intentionally didn't move test results
> with it, because to me the point was a pure optimization: put the trash
> directories on a faster disk, and leave everything else identical.  With
> "--root", any scripts which later want to look at test-results will find
> them in the usual place.
> 
> Your patch updates all of the in-tree spots which look at the results,
> but any third-party scripts would need to take it into account, too
> (though I have no idea if any such scripts even exist).
> 
> I'm curious if there is a good reason to want to move the results. Some
> possibilities I can think of are:
> 
>   1. More optimization, as results are written to the faster filesystem.
>      I doubt this is noticeable, though, as the amount of data written
>      is relatively small compared to the tests themselves (which are
>      constantly creating and deleting repos).
> 
>   2. You can run tests in a read-only git checkout. I'm not sure how
>      useful that is, though, since you would already need to compile
>      git.
> 
>   3. You could have multiple sets of test results to keep or compare.
>      I'd think you'd want to keep the built versions of git around, too,
>      though. Which would mean that a full checkout like git-new-workdir
>      would be a much simpler way to accomplish the same thing.
> 
> So I'm not against TEST_OUTPUT_DIRECTORY as a concept, but I'm having
> trouble seeing how it is more useful than "--root".

I think the original intent of TEST_OUTPUT_DIRECTORY was to allow other
users of the test framework (in contrib/ or the performance tests) to
put their output in a sensible place for those tests, like you describe
below.

The patch being discussed here [1] just makes sure that it applies
to everything - previously it was applied to test-results/
inconsistently; test-lib.sh used TEST_OUTPUT_DIRECTORY but the makefile
didn't.  So we haven't actually changed where test-results/ live as a
result of this change, just where the makefile looks in order to display
the aggregate results and clean them up.

> > Note that setting TEST_OUTPUT_DIRECTORY in config.mak affects all tests
> > no matter how you run them (via make or as ./tXXXX-yyyy.sh) whereas
> > setting --root=... in GIT_TEST_OPTS only affect tests run via make.
> 
> I actually consider that a feature of "--root". When I run "make test"
> everything happens fast. When I run the script manually (which is
> usually because I'm debugging), the trash directory appears in the
> current directory, so I can easily investigate it. And if you are
> running a single test, the performance impact is usually negligible
> (where you really notice it is when running "make -j32 test").

This confirms to me that the patch as it currently stands is correct: we
have made TEST_OUTPUT_DIRECTORY consistent and --root still works as
before.

[1] http://article.gmane.org/gmane.comp.version-control.git/222555
