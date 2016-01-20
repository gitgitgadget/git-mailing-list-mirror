From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v5 1/1] contrib/subtree: Add a test for subtree rebase that loses commits
Date: Tue, 19 Jan 2016 22:10:51 -0600
Message-ID: <87wpr4ubzo.fsf@waller.obbligato.org>
References: <CAPig+cS6ouc+kdJaz10M2AApPoDODDcgDX9Azz8ih=4zxxD2zg@mail.gmail.com>
	<3eb25268597083cdb10303e3d5790302e719a803.1453172369.git.greened@obbligato.org>
	<xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	davidw@realtimegenomics.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 05:11:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLk6r-0007R5-LA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 05:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934098AbcATELB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 23:11:01 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:34565 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933267AbcATEK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 23:10:59 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aLk8D-0001Gp-FU; Tue, 19 Jan 2016 22:12:29 -0600
In-Reply-To: <xmqqsi1tbh68.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jan 2016 09:41:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Thanks, both.
    Will queue. > > I have a couple of questions and comments, though. > >> +test_expect_success
    'setup' ' >> + test_commit README && >> +... >> + tree=$(git write-tree)
   && >> + head=$(git rev-parse HEAD) && >> + rev=$(git rev-parse --verify files-master^0)
    && >> + commit=$(git commit-tree -p $head -p $rev -m "Add subproject master"
    $tree) && > > I think at this point, your index and working tree states match
    that > of $commit. So the next command ... > >> + git reset $commit && >
   > ... 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284426>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, both.  Will queue.
>
> I have a couple of questions and comments, though.
>
>> +test_expect_success 'setup' '
>> +	test_commit README &&
>> +...
>> +	tree=$(git write-tree) &&
>> +	head=$(git rev-parse HEAD) &&
>> +	rev=$(git rev-parse --verify files-master^0) &&
>> +	commit=$(git commit-tree -p $head -p $rev -m "Add subproject master" $tree) &&
>
> I think at this point, your index and working tree states match that
> of $commit.  So the next command ...
>
>> +	git reset $commit &&
>
> ... made me wonder what its significance was.  I think you are doing
> this solely to move the HEAD pointer to point at $commit, but then
> it would be much better and more readable to use update-ref, i.e.
> making this line to:
>
> 	git update-ref HEAD $commit &&
>
> instead, as "write-tree && commit-tree && update-ref" is a familiar
> pattern to reimplement "git commit" using the plumbing.  Ending that
> three-command sequence with "reset" breaks the pattern.

Ok, that makes sense.

>> +	(
>> +		cd files_subtree &&
>> +		test_commit master4
>> +	) &&
>> +	test_commit files_subtree/master5
>
> I understand that you are creating these two commits both in the
> top-level repository (the one the history initially created in
> "files" repository gets merged into), but you are creating them
> slightly differently.  Is that significant?  I am not complaining
> about the style of writing tests, but I am wondering if having these
> two commits created differently has any effect on the bug you
> observed, which may be a good starting point for anybody who wants
> to fix it to start digging from.  IOW, would the resulting history
> different if you did this instead?
>
> 	test_commit files_subtree/master4 &&
> 	test_commit files_subtree/master5

That is a good question.  I originally created the test to see if making
these two commits differently would cause any problems with
git-subtree's split command.  Obviously, I didn't get that far.  :)

So I think it makes sense for me to at least test and see what happens.
I will add another test to this set if it makes a difference.

> I also notice that files_subtree/master4 does not appear in any of
> the verification in the three tests that use the history being
> prepared here, i.e. if master4 is silently dropped while master5 is
> kept, such a bug won't be caught by them.

Ah, good catch.  I should add a test for that.

Let me do a re-roll of this since I think you bring up some excellent
points.  Might be a few days due to work obbligations.

                        -David
