From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 09/14] rebase: add t3426 for submodule updates
Date: Tue, 17 Jun 2014 19:41:26 +0200
Message-ID: <53A07DC6.3080406@web.de>
References: <539DD029.4030506@web.de>	<539DD19B.6000504@web.de> <CAPig+cSU_8USZu3cr=aaOun07jE2BhgLt7yu9ix_AikUpK+pJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 19:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwxO9-0002ry-S8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 19:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbaFQRli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 13:41:38 -0400
Received: from mout.web.de ([212.227.17.12]:55425 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296AbaFQRlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 13:41:37 -0400
Received: from [192.168.178.41] ([84.132.188.209]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MTuQz-1X5vWw1wET-00QgeK; Tue, 17 Jun 2014 19:41:27
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cSU_8USZu3cr=aaOun07jE2BhgLt7yu9ix_AikUpK+pJQ@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:LdOD7AjSikm4uivDqmxHx/XYPtC7trmlqCbwRTqgmUplegSstu4
 2ubOo6FTswK5d92eliRLu98y3l7ds2BjbH8G44U4yyTlk/G0I9kIQmgSFLEGb9CxF1z6cr8
 6dLiuJgBRhonQ/3DvdiO0fVQa+l3bHiNVyx7W0nTPfZHNqNwbYWnN9YjwFBgFei9BEfoHOt
 vUdMRBpgAWssGgk3NatCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251928>

Am 16.06.2014 11:57, schrieb Eric Sunshine:
> On Sun, Jun 15, 2014 at 1:02 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Test that the rebase command updates the work tree as expected for
>> changes which don't result in conflicts. To make that work add two
>> helper functions that add a commit only touching files and then
>> revert it. This allows to rebase the target commit over these two
>> and to compare the result.
>>
>> Set KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR to
>> document that "replace directory with submodule" fails for an
>> interactive rebase because a directory "sub1" already exists.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>  t/t3426-rebase-submodule.sh | 46 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>  create mode 100755 t/t3426-rebase-submodule.sh
>>
>> diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
>> new file mode 100755
>> index 0000000..019ce52
>> --- /dev/null
>> +++ b/t/t3426-rebase-submodule.sh
>> @@ -0,0 +1,46 @@
>> +#!/bin/sh
>> +
>> +test_description='rebase can handle submodules'
>> +
>> +. ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-submodule-update.sh
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +git_rebase () {
>> +       git status -su >expected &&
>> +       ls -1pR * >>expected &&
>> +       git checkout -b ours HEAD &&
>> +       echo x >>file1 &&
>> +       git add file1 &&
>> +       git commit -m add_x &&
>> +       git revert HEAD &&
>> +       git status -su >actual &&
>> +       ls -1pR * >>actual &&
>> +       test_cmp expected actual &&
>> +       git rebase "$1"
>> +}
>> +
>> +test_submodule_switch "git_rebase"
>> +
>> +git_rebase_interactive () {
>> +       git status -su >expected &&
>> +       ls -1pR * >>expected &&
>> +       git checkout -b ours HEAD &&
>> +       echo x >>file1 &&
>> +       git add file1 &&
>> +       git commit -m add_x &&
>> +       git revert HEAD &&
>> +       git status -su >actual &&
>> +       ls -1pR * >>actual &&
>> +       test_cmp expected actual &&
>> +       set_fake_editor &&
>> +       echo "fake-editor.sh" >.git/info/exclude
> 
> Broken &&-chain.

Thanks for spotting!

>> +       git rebase -i "$1"
>> +}
>> +
>> +KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
>> +# The real reason "replace directory with submodule" fails is because a
>> +# directory "sub1" exists, but we reuse the suppression added for merge here
>> +test_submodule_switch "git_rebase_interactive"
>> +
>> +test_done
>> --
>> 2.0.0.275.gc479268
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
