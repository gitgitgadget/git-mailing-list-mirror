From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Tue, 06 Mar 2012 14:37:13 -0800
Message-ID: <7v7gyxqrty.fsf@alter.siamese.dyndns.org>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
 <1330903437-31386-2-git-send-email-greened@obbligato.org>
 <87aa3vzdoc.fsf@thomas.inf.ethz.ch> <nngy5re29zn.fsf@transit.us.cray.com>
 <878vje86cy.fsf@thomas.inf.ethz.ch> <87mx7tiyhh.fsf@smith.obbligato.org>
 <7vaa3ttvj1.fsf@alter.siamese.dyndns.org>
 <87hay1fkfk.fsf@smith.obbligato.org>
 <7vboo9qskb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David A. Greene" <dag@cray.com>, Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 23:37:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S530V-0001RF-PT
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 23:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286Ab2CFWhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 17:37:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965280Ab2CFWhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 17:37:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673DE5E6D;
	Tue,  6 Mar 2012 17:37:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OSZLTXY0Z9vUhH4e4Lj1CCzkEO0=; b=N9EYv6
	Z89eTiYrYxpTexrWKGNWpFcVxQ5wya0kd3vF+yzwNYs8/3+2yEp2SAwA7e+Kzv6Y
	vQ/ModYX2VqnFuD3pKHoco7IkEtYr1j7vIeSuvQ9Pgr4wo/kzr82j+juQP8ugkB4
	9JDsZjB+oSQc3DlO+2WUPA/mZ3xWOQ1PyJ0qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cXRZ6qWHtYncmD9kAK4qcWu2otqPdUI8
	cAIMcmyo2t1B2U7hbVw3yLXo6blt4OGTU3BYxZmB6i2W+7LfkVpWWZv9EtVsFz37
	jGq2o1i658sbhE/5iYrbJEmf/q2YfT6CTL2LD21GWDg2NV9dFUONMY49L0Tn5YUy
	+RfMTPG8MjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E2445E6C;
	Tue,  6 Mar 2012 17:37:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDB995E6A; Tue,  6 Mar 2012
 17:37:14 -0500 (EST)
In-Reply-To: <7vboo9qskb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 06 Mar 2012 14:21:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC0C8ECE-67DC-11E1-9E4E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192407>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <dag@cray.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>>> Could it be that the reason for the breakage is because you are
>>> setting TEST_DIRECTORY to the directory that contains out-of-tree
>>> tests, instead of $GIT_BUILD_DIR/t/ directory?
>> ...
>>> Shouldn't TEST_DIRECTORY merely a short-hand for GIT_BUILD_DIR/t?
>>> What do you find relative to $TEST_DIRECTORY that cannot be found
>>> relative to GIT_BUILD_DIR/t?
>> ...
>>
>> Thanks for clarifying!
>
> Not so fast. The questions in the message you are responding to were
> not rhetorical.

So I ended up looking at t/test-lib.sh, sigh...

We have this bit from 62f5390 (test-lib: Allow overriding of
TEST_DIRECTORY, 2010-08-19):

   # Test the binaries we have just built.  The tests are kept in
   # t/ subdirectory and are run in 'trash directory' subdirectory.
   if test -z "$TEST_DIRECTORY"
   then
           # We allow tests to override this, in case they want to run tests
           # outside of t/, e.g. for running tests on the test library
           # itself.
           TEST_DIRECTORY=$(pwd)
   fi
   GIT_BUILD_DIR="$TEST_DIRECTORY"/..

that says "As a side benefit this change also makes it easy for us
to move the t/*.sh tests into subdirectories if we ever want to do
that."

This expects that an out-of-tree test script is expected to set
TEST_DIRECTORY before dot-sourcing test-lib.sh, e.g.

	#!/bin/sh
	TEST_DIRECTORY=/srv/project/git/git.git/t
        test_description='an out-of-tree test'
        . "$TEST_DIRECTORY/test-lib.sh"

which in turn lets the test framework to learn GIT_BUILD_DIR.  From
there, 'git' will be found in GIT_BUILD_DIR/bin-wrappers and the
valgrind variants are found in a similar way.

One thing that is potentially missing is a way for such an out-of-tree
test scripts to ship with supporting material in a separate file,
relative to the test script.  The in-tree t/t4013-diff-various.sh
has its test vectors kept in t/t4013/ directory and finds them by
doing

	expect="$TEST_DIRECTORY/t4013/diff.$test"

This is because the working directory after test-lib comes back to
us may not be "trash" directory under TEST_DIRECTORY, and ../t4013/
is not the right way to find it.  If an out-of-tree test t9999 wants
to do something similar, it needs to do something like:

	#!/bin/sh
        HERE=$(PWD)
	TEST_DIRECTORY=/srv/project/git/git.git/t
        test_description='an out-of-tree test'
        . "$TEST_DIRECTORY/test-lib.sh"

and find it relative to $HERE, e.g. "$HERE/../t9999/diff.$test"

Of course, it would be nice to use a name better than $HERE for such
a purpose ;-)
