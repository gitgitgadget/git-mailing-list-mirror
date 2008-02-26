From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git to
 test
Date: Tue, 26 Feb 2008 12:22:30 -0800
Message-ID: <7vpruj4ge1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org>
 <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261242210.19024@iabervon.org>
 <7v63wb5zec.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261350510.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6Kk-00043a-RT
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 21:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbYBZUWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 15:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYBZUWq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 15:22:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40055 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYBZUWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 15:22:45 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A1782801;
	Tue, 26 Feb 2008 15:22:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 56D662800; Tue, 26 Feb 2008 15:22:38 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802261350510.19024@iabervon.org> (Daniel
 Barkalow's message of "Tue, 26 Feb 2008 14:16:13 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75168>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> I did not mean to imply I was presenting the whole solution; I
>> was trying to hint at a different direction which may or may not
>> work.  I did not look at what test_create_repo() actually did
>> when I wrote the message, but you are right.  It too needs to
>> be made conditional, and when trying an installed version, it
>> should not do the "template" dance but let the installed "git init"
>> figure it out.
>
> Does it need to be conditional, or is simply "git init" right (where we've 
> already set environment variables for the local stuff if applicable)?

I suspect "uninstalled" cases (both "here" and "elsewhere")
needs to do the template magic, while "installed" case should be
just "git init".

>> > There's additionally the problem that things which are built for testing 
>> > in the git directory won't be installed anywhere.
>> 
>> To test without installing, in order to make them call out their
>> siblings, I have this piece that I source to a new shell:
>> 
>>         GIT_EXEC_PATH=`pwd`
>>         PATH=`pwd`:/usr/bin:/bin
>>         GITPERLLIB=`pwd`/perl/blib/lib
>>         export GIT_EXEC_PATH PATH GITPERLLIB
>
> Might be nice to have a "sgitpath" (on the model of sg or su) in t/, since 
> this is handy in general.

I have them in ./+denv and after building if I want to see it
work in real repo elsewhere I do:

	: gitster; sh
        $ . ./+denv
        $ cd ../elsewhere.git
        $ do the real workload trial
        $ ^D

> You understood correctly the first time; I was unclear the second time. 
> The problem here is that, in order to run tests, we call 
> "test-absolute-path", "test-genrandom", etc., and we can't use these from 
> the user's $PATH because, being only for testing, they don't get installed 
> there. We need to get git-remote (for example) from $PATH, but 
> test-genrandom from $(pwd)/.. in order to make the tests run.

Ok, so even "installed" case need to rely on "test-blah" we build.

> That sounds good (although only (2) is on my current path), but I also 
> need a prerequisite patch for both, I believe, for simply making test 
> helpers available independant of actual build products.

Yeah, sounds like it.
