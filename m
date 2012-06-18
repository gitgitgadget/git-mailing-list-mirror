From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Mon, 18 Jun 2012 13:51:51 -0400
Message-ID: <CAFouetjkSQuY6pyFdiVsM5tUnEiFK6uWTqDO38uhwUjaDVre1w@mail.gmail.com>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
	<7vzk849zxg.fsf@alter.siamese.dyndns.org>
	<20120615193724.GB26473@sigill.intra.peff.net>
	<CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
	<7vipes9w0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 19:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgg7K-00007c-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 19:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2FRRvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jun 2012 13:51:55 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56579 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2FRRvy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jun 2012 13:51:54 -0400
Received: by ghrr11 with SMTP id r11so3904670ghr.19
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Sw8MKKKh3kLkw9fVcvXBrwn2SAyaN0VgrIcR2j5HD24=;
        b=s/QKY3Mo63bqbmTplzP1R35V2OkNMIejZqwvHT8juDBa/5JG0gkuPsidM9bwX4WeE/
         +arogzAW2yNXkA8uFlilyoFSk75wbihFcwmXDp41cL42nh9bVefzvFQAGAC6P9PTRnsH
         TOxGyFEMydfZ16ZZbjs5kQlJYiPbv0qTYhxcaUL7muAM30wJOhVR/TAhdVFZW7cc1xSJ
         tmGS85EO0fBSxv5ZRv3OTQ4q869rqMbLfySQbxXtb6onXJbqA0JiF9Rc6fxE5UqFEe2H
         FbsU8SBu9pVNehHWwENXbDZNG+/4Cvec0JRy/IYbFHjWkr2MigquuAWh5UYJ3ePGRFWy
         Cyig==
Received: by 10.50.236.71 with SMTP id us7mr1496646igc.16.1340041911928; Mon,
 18 Jun 2012 10:51:51 -0700 (PDT)
Received: by 10.231.84.147 with HTTP; Mon, 18 Jun 2012 10:51:51 -0700 (PDT)
In-Reply-To: <7vipes9w0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200151>

On Fri, Jun 15, 2012 at 4:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> I will send v2 with the change to 'diff-no-index.c' suggested by
>> Junio. =C2=A0I will also include the 'test_expect_code' improvement
>> suggested by Jeff.
>
> Also the test script shouldn't be just testing a simplest case, I
> would think.
>
> For example, comparing two files with "a b c" and "a =C2=A0b c" in th=
em
> with "--quiet" should yield "They are different!" while running the
> same comparison with "--quiet -w" should say "They are the same!",
> no?

To obtain full coverage, it seems we need to test:
    1) git diff --quiet <file in repo> <file outside repo>
    2) git diff --quiet <file outside repo> <file outside repo>

for each of the following options:
    a) no additional options
    b) --ignore-space-at-eol
    c) --ignore-all-space

These seem like the only diff options that should be tested...am I
missing anything?

Because some of the tests require one directory that is a repo and one
directory that is not, it seems best to create a new test file with
$TEST_NO_CREATE_REPO set.  Then the setup function can create both the
repo and the plain directory.

So, I am thinking of adding 't/t4054-diff-outside-repo.sh' that does
the following:

  1) setup (includes a cd into the repo directory)
  2) git diff --quiet, one outside repo, matching files
  3) git diff --quiet, one outside repo, different files
  4) git diff --quiet, one outside repo, ignore trailing whitespace
  5) git diff --quiet, one outside repo, ignore all whitespace
  6) git diff --quiet, both outside repo, matching files
  7) git diff --quiet, both outside repo, different files
  8) git diff --quiet, both outside repo, ignore trailing whitespace
  9) git diff --quiet, both outside repo, ignore all whitespace
  10) cleanup (cd back to $HOME test directory)

Does this sound reasonable?
