From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] Allow Overriding GIT_BUILD_DIR
Date: Thu, 01 Mar 2012 21:51:35 -0600
Message-ID: <87fwdrk6d4.fsf@smith.obbligato.org>
References: <87vcmu5psm.fsf@smith.obbligato.org>
	<7vpqd1dyq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 04:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3JZg-0004E2-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 04:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476Ab2CBDy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 22:54:26 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53994 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321Ab2CBDyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 22:54:25 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1S3Jae-0001zq-Ok; Thu, 01 Mar 2012 21:55:33 -0600
In-Reply-To: <7vpqd1dyq7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 26 Feb 2012 14:19:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > Ok, this is getting
    closer. We use GIT_BUILD_DIR to find out crucial bits > of the build environment
    in order to run tests, like the binaries being > tested that are in $GIT_BUILD_DIR/bin-wrappers,
    but we set GIT_BUILD_DIR > always to one level above where the test script
    being run is (because they > are typically t/t1234-name.sh). By making them
    able to name GIT_BUILD_DIR > directly to a place that is different from a
    level above "$TEST_DIRECTORY", > a test script can live  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191995>

Junio C Hamano <gitster@pobox.com> writes:

> Ok, this is getting closer. We use GIT_BUILD_DIR to find out crucial bits
> of the build environment in order to run tests, like the binaries being
> tested that are in $GIT_BUILD_DIR/bin-wrappers, but we set GIT_BUILD_DIR
> always to one level above where the test script being run is (because they
> are typically t/t1234-name.sh).  By making them able to name GIT_BUILD_DIR
> directly to a place that is different from a level above "$TEST_DIRECTORY",
> a test script can live anywhere.

Right.

> There are two more things that worries me a bit.
>
> One is what TEST_DIRECTORY should mean in the new world order.  

That and its interaction with GIT_BUILD_DIR really confused me when I
was trying to get the subtree tests to work.  I think they could use
either a bit more documentation or a bit more separation of purpose.
I'm not sure which.

> We use it to find where the test-lib.sh and other lib-*.sh helper
> definitions are, also we use it to find large-ish test vectors like
> t3900/ and t4013/.  If an external test script t1234-git-subtree.sh
> wants to use a separate file to keep its own helper definitions, how
> should it name it?  It cannot be relative to TEST_DIRECTORY that is
> typically "t/".  It cannot be relative to "../" as TRASH_DIRECTORY
> where the script runs, as the --root option may move it elsewhere on
> the filesystem (and is the reason TEST_DIRECTORY variable exists in
> the first place).

I must admit I am still confused about what these variables do even
after reading this explanation several times.  I have a pretty good
idea what TRASH_DIRECTORY is.

> And how well does an external test script work with the --root option that
> moves the TEST_DIRECTORY?

I have no idea.  I didn't even know about --root and I still don't know
what it does.  It would be helpful to have some commentary about
options.

I am willing to add comments (as a separate patch?) as I figure out what
these things do.  Perhaps I'll write up a patch and get feedback to spur
discussion so I can come to better understanding.  :)

>> @@ -55,6 +55,7 @@ unset $(perl -e '
>>  		.*_TEST
>>  		PROVE
>>  		VALGRIND
>> +                BUILD_DIR
>
> A funny    indentation found here.

Will fix.

>> +if test -z "$GIT_BUILD_DIR"
>> +then
>> +	# We allow tests to override this, in case they want to run tests
>> +	# outside of t/, e.g. for running tests on the test library
>> +	# itself.
>
> # For in-tree test scripts, this is one level above the TEST_DIRECTORY
> # (t/), but a test script that lives outside t/ can set this variable to
> # point at the right place so that it can find t/ directory that house
> # test helpers like lib-pager*.sh and test vectors like t4013/.

This is good commentary.  Will add.

                                -Dave
