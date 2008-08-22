From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t9301-fast-export: move unset of config variable into
   its own test function
Date: Fri, 22 Aug 2008 11:02:11 +0200
Message-ID: <48AE8093.4070609@viscovery.net>
References: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org> <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil> <7vbpzlbgyl.fsf@gitster.siamese.dyndns.org> <7v7ia9bgqc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 11:03:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWSYO-0008TZ-FW
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 11:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbYHVJC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 05:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbYHVJC3
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 05:02:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7805 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYHVJC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 05:02:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KWSXB-00027M-I1; Fri, 22 Aug 2008 11:02:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 13DD769F; Fri, 22 Aug 2008 11:02:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v7ia9bgqc.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93277>

Junio C Hamano schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> For this particular case, what we are interested in testing is not that
>> "config --unset" exits with 0 status.  We are however interested in making
>> sure that i18n.commitencoding is not set when the body of #12 runs.
>>
>> So I think a more appropriate change would be something like this for this
>> particular case.
> 
> Having said that, we may want to have an easier way to exclude certain
> classes of pieces, and also encourage test writers to group pieces that
> are related to these classes together.
> 
> For example, this introduces a new environment you can set,
> GIT_SKIP_TEST_CLASS, which is a space separated list of classes of
> features that you would want to exclude from the test.
> test_expect_success/failure can now take an optional "class token" as the
> first parameter (they traditionally took only two parameters, but with
> class token, they take three).

Nice idea. Another class would be the tests that depend on that the
filesystem supports symbolic links.

> -test_expect_success 'iso-8859-1' '
> +test_expect_success I18N 'iso-8859-1' '

How do the tests look like if this token is the *last* argument?

To continue the idea, please look into t5302-pack-index.sh: We skip some
tests if we don't have support for 64bit file offsets. Making these tests
a "static" class would not be appropriate because the condition whether
64bit support is present is derived dynamically by the testsuite. What if
we could write tests like this:

test_expect_success \
    'index v2: verify a pack with some 64-bit offsets' \
    'git verify-pack -v "test-3-${pack3}.pack"' \
    'test "$have_64bits"'

i.e. the 3rd argument is a condition that tells whether the test should be
run. And in other cases the 3rd argument is the token that you propose:

test_expect_success 'iso-8859-1' '

     ...test goes here...

' I18N

Hm?

-- Hannes
