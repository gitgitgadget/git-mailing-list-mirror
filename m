From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 2/7] add tests for rebasing with patch-equivalence present
Date: Wed, 29 May 2013 22:30:49 -0700
Message-ID: <CANiSa6joMXeh7HoGAFXskdXaPZjN+0uHrtN7V85FyQHTGCwZMQ@mail.gmail.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-1-git-send-email-martinvonz@gmail.com>
	<1369809572-24431-3-git-send-email-martinvonz@gmail.com>
	<51A5A992.306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 30 07:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhvRw-0001Le-1D
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 07:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966975Ab3E3Fax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 01:30:53 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64786 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3E3Fav (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 01:30:51 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so6895807wgg.28
        for <git@vger.kernel.org>; Wed, 29 May 2013 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X1fO0aTMOjE7qpx14v/IubZA1uOiYE3C68+Pfs3oV1A=;
        b=ecleonF0+MieMxmesu1QrntjP8DwL2GY4ox5KTqloEwhAai6flh+zX8Kz0kZ6n4p3F
         Z6NZKAaPg1Npd0Pm+gc8V9TISPSFpwJQd+ktO8EmxI3WGRYqTf07ONXAm41gL4mRa+65
         ZTb/A+y4uYr+K8Ig0tGhrJ0Vz9EWv+HepnU5+VTlWomS5LymBcJQEo2EcqI5+5gpavz/
         kKfXQKYizFrg8c6cX1LgQV4yVOcW0XjLT78uuXnMKG3R4sXkuXgTE9hzLaeQKbn4EV5K
         5dLXlwreHvhPPBfzBITcLbXkY3ILazLUHepZ9Wt0SjUv0+mp+7LuHRatRe8ukDNityGu
         m/jg==
X-Received: by 10.180.108.3 with SMTP id hg3mr2886517wib.17.1369891849964;
 Wed, 29 May 2013 22:30:49 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Wed, 29 May 2013 22:30:49 -0700 (PDT)
In-Reply-To: <51A5A992.306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225925>

On Wed, May 29, 2013 at 12:09 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/29/2013 8:39, schrieb Martin von Zweigbergk:
>> +#       f
>> +#      /
>> +# a---b---c---g---h
>> +#      \
>> +#       d---G---i
> ...
>> +test_run_rebase () {
>> +     result=$1
>> +     shift
>> +     test_expect_$result "rebase $* --onto drops patches in onto" "
>> +             reset_rebase &&
>> +             git rebase $* --onto h f i &&
>> +             test_cmp_rev h HEAD~2 &&
>> +             test_linear_range 'd i' h..
>
> Isn't this expectation wrong? The upstream of the rebased branch is f, and
> it does not contain G. Hence, G should be replayed. Since h is the
> reversal of g, the state at h is the same as at c, and applying G should
> succeed (it is the same change as g). Therefore, I think the correct
> expectation is:
>
>                 test_linear_range 'd G i' h..

Good question! It is really not obvious what the right answer is. Some
arguments in favor of dropping 'G':

1. Let's say origin/master points to 'b' when you start the 'd G i'
branch. You then send the 'G' patch to Junio who applies it as 'g'
(cherry-picking direction is reversed compared to figure, but same
effect). You then "git pull --rebase" when master on origin points to
'h'. Because of the cleverness in 'git pull --rebase', it issues 'git
rebase --onto h b i'. In this case it's clearly useful to have the
patch dropped.

2. In the test a little before the above one, we instead do 'git
rebase --onto f h i' and make sure that the 'G' is _not_ lost. In that
case it doesn't matter what's in $branch..$upstream. Do we agree that
$branch..$upstream should never matter (instead, $upstream is only
used to find merge base with $branch)? Do we also agree that 'git
rebase a b' should be identical to 'git rebase --onto a a b'? Because
'git rebase h i' should clearly drop 'G', then so should 'git rebase
--onto h h i'. Then, if we agreed that $branch..$upstream doesn't
matter, 'git rebase --onto h f i' should behave the same, no?


The set of commits to rebase that I was thinking of using was
"$upstream..$branch, unless equivalent with patch in $branch..$onto".
But I'm not very confident about my conclusions above :-)


Martin
