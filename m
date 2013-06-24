From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 16:51:29 +0200
Message-ID: <vpqhagnv9xq.fsf@anie.imag.fr>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:00:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8FR-00064l-NU
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3FXPAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:00:00 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53123 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab3FXO77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:59:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5OEpSu0030142
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 24 Jun 2013 16:51:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ur877-0006E0-Sl; Mon, 24 Jun 2013 16:51:29 +0200
In-Reply-To: <CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 19:35:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 24 Jun 2013 16:51:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228819>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Matthieu Moy wrote:
>> [...]
>
> Before we begin, let me say that this series is written with the
> emergency-fix mindset, and targets maint.

maint shouldn't be necessary since the breakage hasn't been released. At
worse, we can revert the bad commits now and re-implement them properly
later.

> I didn't spend time thinking about how to do it best or even add
> tests.

No problem.

>> * running the CLI parser after, if --porcelain is given, reset the
>>   effect of the variables. Not very clean because we'd have to reset all
>>   the variables to their default, and there is a risk of forgetting one.
>
> Since it's impossible to determine what effect the CLI parser had on
> various variables (some of which are static global), I'm against this
> approach.

I think you meant "what effect the config parser had". If you meant the
CLI parser, then the guilty commits did not change anything wrt that.

>
>> * Or, running the CLI parser before, but with different variables to
>>   specify what the command-line says and what will actually be done,
>>   with something like
>
> Basically, having the CLI parser and the config parser flip two
> different sets of variables, so we can discriminate who set what.
> What annoys me is that this is the first instance of such a
> requirement.

I don't think it's the first instance, but I can't remember precise
examples.

> The approach I'm currently tilting towards is extending the
> parse-options API to allow parsing one special option early.  I would
> argue that this is a good feature that we should have asked for when
> we saw 6758af89e (Merge branch 'jn/git-cmd-h-bypass-setup',
> 2010-12-10).  What do you think?

That's an option too, yes. But probably not easy to implement :-(.

>>>  builtin/commit.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> No time to contribute one now myself, but this would really deserve a
>> test.
>
> Yeah, will do as a follow-up.  I'm interested in guarding against such
> breakages too :)

Should look like this:

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 498332c..423e8c4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1378,6 +1378,11 @@ test_expect_success '"status.branch=true" weaker than "--no-branch"' '
        test_cmp expected_nobranch actual
 '
 
+test_expect_success '"status.branch=true" weaker than "--porcelain"' '
+       git -c status.branch=true status --porcelain >actual &&
+       test_cmp expected_nobranch actual
+'
+
 test_expect_success '"status.branch=false" same as "--no-branch"' '
        git -c status.branch=false status -s >actual &&
        test_cmp expected_nobranch actual


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
