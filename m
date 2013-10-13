From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] mv: Fix spurious warning when moving a file in presence
 of submodules
Date: Sun, 13 Oct 2013 20:37:28 +0200
Message-ID: <525AE868.9050207@web.de>
References: <vpq38o7nao9.fsf@anie.imag.fr> <52583B00.8040700@web.de>	<525A8965.3040407@web.de> <vpqr4bp6wkh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 13 20:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVQXz-0002GA-2O
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 20:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab3JMShg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 14:37:36 -0400
Received: from mout.web.de ([212.227.17.11]:59823 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab3JMShf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 14:37:35 -0400
Received: from [192.168.178.41] ([91.3.134.25]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MWNHW-1VFNxO2meQ-00XZV7 for <git@vger.kernel.org>;
 Sun, 13 Oct 2013 20:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <vpqr4bp6wkh.fsf@anie.imag.fr>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:P5RKDBwKhPbu/33jxgH6yKJ6sXS+i4Z31d3As0dDi3w0PBANoGt
 1IHdm61coJEIGkExUJ7yeAjJxjFAQOK0aDlnXrPHX8o2ElwAPEhOA0iZJ4pRs3h+Qn8IeTO
 MPOv/uBjP1BowUecR04DA69A7O+W7JLFyiobaes4jhj1r4fWAODuUYkGnmKO15LPlY4cQL7
 qG0NPdEGt26/LBdp0Faew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236078>

Am 13.10.2013 17:05, schrieb Matthieu Moy:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>  static struct lock_file lock_file;
>> +#define SUBMODULE_WITH_GITDIR ((const char *)1)
> 
> I don't like very much hardcoded addresses like this. Are you 100% sure
> address 1 will never be returned by xstrdup on any platform? The risk is
> small if not negligible, but I'm unconfortable with this. Isn't there an
> alternative (NULL, or empty string) that is guaranteed to never happen?

All alternatives I could think of would require an extra array storing
that information, which I dismissed for performance and memory footprint
reasons (NULL is already taken for not being a submodule). I think 1 is
one of the safest hard coded addresses as on sane systems accessing the
zeropage will trigger a segfault. And if someday someone wants to free
the memory I expect the special casing of 1 to be rather obvious. But
I'm open to alternatives and would change that if people disagree.

>> +test_expect_success 'git mv moves a submodule with a .git directory and .gitmodules' '
> 
> This doesn't seem to test the problem I was having (move a file, not a
> submodule). Is this intentional?

Yes. The first idea was to simply move the update_path_in_gitmodules()
into the "if (submodule_gitfile[i])"-block, but that would have resulted
in not updating .gitmodules for submodules with a .git directory, which
I would consider a bug. So I thought this was worth an extra test case,
while I wasn't sure testing mv of a regular file to not issue a warning
is a very useful test case in submodule context.

> In any case, this fixes my problem, thanks!

Sure, glad to help and thanks for testing!
