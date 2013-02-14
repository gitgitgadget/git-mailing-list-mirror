From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Thu, 14 Feb 2013 13:55:01 +0100
Message-ID: <vpq7gmbdpi2.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu> <vpqtxpgb6ue.fsf@grenoble-inp.fr>
	<511C08AF.7090502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 14 13:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5yLo-0006Wb-2h
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 13:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760157Ab3BNMzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 07:55:20 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58122 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759807Ab3BNMzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 07:55:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1ECt02g005757
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2013 13:55:00 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U5yL7-0003ie-Pt; Thu, 14 Feb 2013 13:55:01 +0100
In-Reply-To: <511C08AF.7090502@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 13 Feb 2013 22:42:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Feb 2013 13:55:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1ECt02g005757
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361451308.19658@xsFOGWFy4l8KwyWz+3zZ5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216306>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/13/2013 03:56 PM, Matthieu Moy wrote:
>
>> Installation troubles:
>> 
>> I had an old python installation (Red Hat package, and I'm not root),
>> that did not include the email.utils package, so I couldn't use my
>> system's python. I found no indication about python version in README,
>> so I installed the latest python by hand, just to find out that
>> git-multimail wasn't compatible with Python 3.x. 2to3 can fix
>> automatically a number of 3.x compatibility issues, but not all of them
>> so I gave up and installed Python 2.7.
>
> What version of Python was it that caused problems?

Python 2.4.3, installed with RHEL 5.9.

> I just discovered that the script wouldn't have worked with Python
> 2.4, where "email.utils" used to be called "email.Utils".

Indeed, "import email.Utils" works with this Python.

> But I pushed a fix to GitHub:
>
>     ddb1796660 Accommodate older versions of Python's email module.

Not sufficient, but I added a pull request that works for me with 2.4.

>> @@ -835,6 +837,17 @@ class ReferenceChange(Change):
>>                  for line in self.expand_lines(NO_NEW_REVISIONS_TEMPLATE):
>>                      yield line
>>  
>> +            if adds and self.showlog:
>> +                yield '\n'
>> +                yield 'Detailed log of added commits:\n\n'
>> +                for line in read_lines(
>> +                        ['git', 'log']
>> +                        + self.logopts
>> +                        + ['%s..%s' % (self.old.commit, self.new.commit,)],
>> +                        keepends=True,
>> +                        ):
>> +                    yield line
>> +
>>              # The diffstat is shown from the old revision to the new
>>              # revision.  This is to show the truth of what happened in
>>              # this change.  There's no point showing the stat from the
>> 
>
> Thanks for the patch.  I like the idea, but I think the implementation
> is incorrect.  Your code will not only list new commits but will also
> list commits that were already in the repository on another branch
> (e.g., if an existing feature branch is merged into master, all of the
> commits on the feature branch will be listed).  (Or was that your
> intention?)

I did not think very carefully about this case, but the behavior of my
code seems sensible (although not uncontroversial): it's just showing
the detailed log for the same commits as the summary at the top of the
email. I have no personnal preferences.

> But even worse, it will fail to list commits that were
> added at the same time that a branch was created (e.g., if I create a
> feature branch with a number of commits on it and then push it for the
> first time).

Right.

> Probably the Push object has to negotiate with its constituent
> ReferenceChange objects to figure out which one is responsible for
> summarizing each of the commits newly added by the push (i.e., the ones
> returned by push.get_new_commits(None)).

I updated the pull request with a version that works for new branches,
and takes the list of commits to display from the call to
get_new_commits (which were already there for other purpose). Then, it
essentially calls "git log --no-walk $list_of_sha1s".

This should be better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
