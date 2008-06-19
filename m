From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with	inline
 environment variables
Date: Thu, 19 Jun 2008 13:07:09 -0500
Message-ID: <frLVfPcFTL8gWg3cEzx3q-MMBWxW3Ts2EnBH2U39k5_QFQTfThtN-A@cipher.nrlssc.navy.mil>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil> <20080619173932.GA32593@glandium.org> <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil> <20080619175639.GA1604@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9OZK-0003QT-1p
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYFSSH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYFSSH4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:07:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52481 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbYFSSHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:07:55 -0400
Received: by mail.nrlssc.navy.mil id m5JI7Ai7015676; Thu, 19 Jun 2008 13:07:10 -0500
In-Reply-To: <20080619175639.GA1604@glandium.org>
X-OriginalArrivalTime: 19 Jun 2008 18:07:09.0942 (UTC) FILETIME=[4AC38160:01C8D237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85501>

Mike Hommey wrote:
> On Thu, Jun 19, 2008 at 12:44:23PM -0500, Brandon Casey wrote:
>> Mike Hommey wrote:
>>> On Thu, Jun 19, 2008 at 12:32:02PM -0500, Brandon Casey wrote:
>>>> -	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
>>>> +	# We intentionally do not use test_must_fail on the next line since the
>>>> +	# mechanism does not work when setting environment variables inline
>>>> +	! GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
>>> Doesn't GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" test_must_fail git commit
>>> work ?
>> That leaves GIT_EDITOR set to the new value after the command completes.
> 
> It really shouldn't.

The change you suggested is also what I tried first. Looks like it depends on the
shell. On my system /bin/sh is a symlink to /bin/bash and that is the behavior
I observed. On other shells the assignment is not passed to the environment of
the called procedure at all.

Here is an example script:

	#!/bin/sh
	test_must_fail () {
		"$@"
		test $? -gt 0 -a $? -le 129
	}
	foo='wo adrian'
	foo='yo adrian' test_must_fail sh -c 'echo foo: $foo'
	echo "foo: $foo"

When /bin/sh is a symlink to bash, I get:

foo: yo adrian
foo: yo adrian

If I change #!/bin/sh to #!/bin/bash I get what is expected:

foo: yo adrian
foo: wo adrian

#!/bin/ksh
foo:
foo: yo adrian

#!/bin/dash

foo:
foo: yo adrian


-brandon
