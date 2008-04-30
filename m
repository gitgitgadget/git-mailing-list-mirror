From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: git-diff silently fails when run outside of a repository
 (v1.5.4.2)
Date: Tue, 29 Apr 2008 18:28:40 -0700
Message-ID: <7vwsmg2ks7.fsf@gitster.siamese.dyndns.org>
References: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
 <7vabjc5l3r.fsf@gitster.siamese.dyndns.org>
 <3c6c07c20804291603q4fbe957eq3e3da39d4a2e29c0@mail.gmail.com>
 <7vskx444h5.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804300155320.17469@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 30 03:29:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr18f-0005E5-TA
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 03:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbYD3B2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 21:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbYD3B2y
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 21:28:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbYD3B2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 21:28:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D303D2349;
	Tue, 29 Apr 2008 21:28:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E66F72348; Tue, 29 Apr 2008 21:28:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804300155320.17469@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 30 Apr 2008 01:56:39 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA53327A-1654-11DD-93D6-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80779>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Even so, this seems like a bug.  If I do this:
>> >
>> >     $ cd /
>> >     $ git-diff
>> >
>> > there is no error message and no error status.  A diagnostic would be
>> > very helpful.
>> 
>> Ah, that indeed is not very helpful.
>> 
>> Unfortunately, every time I look at this hack, I seem to find an unrelated
>> bug in it.  Here is today's.
>> 
>> 	$ for i in 1 2 3; do >/var/tmp/$i; done
>>         $ cd /
>>         $ git diff /var/tmp/1
>>         Segmentation Fault
>> 
>> When nongit is true, we know the user has to be asking --no-index diff, so
>> perhaps we can fix it by doing something like this?
>> 
>> diff --git a/diff-lib.c b/diff-lib.c
>> index 069e450..cfd629d 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -264,6 +264,9 @@ int setup_diff_no_index(struct rev_info *revs,
>>  			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
>>  			break;
>>  		}
>> +	if (nongit && argc != i + 2)
>> +		die("git diff [--no-index] takes two paths");
>> +
>>  	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
>>  				!is_outside_repo(argv[i], nongit, prefix)))
>>  		return -1;
>
> That looks to me as if the second if() should have triggered, and the 
> caller of setup_diff_no_index() should have errored out.

I think the above three-liner fix is something we should have done when we
added --no-index codepath.  Before the --no-index hack was introduced, we
did not even got this far to the place the caller of this function is, if
we are outside a repository.  By returning -1 from here instead of dying,
this code is driving the codepath that has always expected to already be
in a repository into a nonrepository, causing them to segfault because
there is no git-dir or work-tree set up done yet as they expect.
