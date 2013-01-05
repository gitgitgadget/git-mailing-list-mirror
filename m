From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [PATCH v4] git-completion.bash: add support for path completion
Date: Sat, 5 Jan 2013 20:23:39 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com>
 <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se>
 <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 21:24:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TraIB-0000TL-Mp
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 21:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab3AEUXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 15:23:52 -0500
Received: from imr3.ericy.com ([198.24.6.13]:43723 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab3AEUXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 15:23:51 -0500
Received: from EUSAAHC003.ericsson.se ([147.117.188.81])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id r05KNfHM017706
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sat, 5 Jan 2013 14:23:41 -0600
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC003.ericsson.se ([147.117.188.81]) with mapi id 14.02.0318.004; Sat, 5
 Jan 2013 15:23:40 -0500
Thread-Topic: [PATCH v4] git-completion.bash: add support for path completion
Thread-Index: AQHN35v9HSsVlTwzCk6LZCvwjOeDYpg5wPLQgAAkJX6AAHcaLIAA48SG
In-Reply-To: <7vehi0qh4x.fsf@alter.siamese.dyndns.org>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.135]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212712>


> Junio C Hamano <gitster@pobox.com> writes:
> 
>>  Marc Khouzam <marc.khouzam@ericsson.com> writes:
>>
>>> I've been playing with it but I'm not getting the expected
>>> behavior when I cd to a sub-directory.
>>
>> Thanks for testing.  Manlio?
> 
> Can you try the attached patch?

Thanks for this, it improves the situation dramatically.
I did further testing with your patch and found some less obvious
issues.  I didn't debug the script myself as I'm not that familiar with
it either, but I think the testcases below should help Manlio or
someone else look into some regressions.

1- Using .. or . breaks completion when after the '/':
> cd git/contrib
> git rm ../contrib/completion/<tab>
../contrib/completion/ion.bash  ../contrib/completion/ion.tcsh  ../contrib/completion/ion.zsh   ../contrib/completion/sh
It looks like the space taken by the path where we are located, eats up the same number of characters from the file name, e.g.,
   ../contrib/completion/ion.bash
   ../contrib/git-completion.bash

2- Maybe related to problem 1.  Using .. breaks completion in other ways:
> cd git/contrib
> git rm ../con<tab>
../config.c       ../config.mak.in  ../configure.ac   ../connect.c      ../connected.c    ../connected.h    ../convert.c      ../convert.h
Notice that 'contrib' is not proposed.
Don't be fooled by the fact that
> git rm ../cont<tab>
will complete to 
> git rm ../contrib
as it is only because the completion script returned nothing, and bash file-completion 
kicked-in instead (it fooled me :)).

3- Also probably related to problems 1 and 2.  Using absolute paths behaves wierdly and 
worse than before:
git rm /home/marc/git/git/con<tab>
will give
git rm /home/marc/git/git/config-
although there is the 'contrib' dir that should be shown, amongst others.
Seems like the same problem as above with 'git rm ../con<tab>'

In my opinion, the above three cases are regressions.

4- Completion choices include their entire path, which is not what bash does by default.  For example:
> cd git/contrib
> ls completion/git-<tab>
git-completion.bash  git-completion.tcsh  git-completion.zsh   git-prompt.sh
but
> git rm completion/git-<tab>
completion/git-completion.bash  completion/git-completion.tcsh  completion/git-completion.zsh   completion/git-prompt.sh
notice the extra 'completion/' before each completion.  This can get pretty large when completing with 
many directory prefixes.  The current tcsh completion has the same problem which I couldn't fix.  However, I am 
not sure if it can be fixed for bash.

I personally don't think this is regression, just an slight annoyance.

5- With this feature git-completion.bash will return directories as completions.  This is something
git-completion.tcsh is not handling very well.  I will post a patch to fix that.

Below are two suggestions that are in line with this effort but that are not regressions.

A) It would be nice if 
git commit -a <TAB>
also completed with untracked files

B) Now that, for example, 'git rm' completion is smart about path completion 
it would be nice to somehow not trigger bash default file completion
when 'git rm' does not report any completions.  

For example, if I have a file called zz.tar.gz (which is an ignored file) 
and I do 'git rm <tab>', I will get the proper list of files that can be
removed by git, excluding zz.tar.gz.  But if I complete
'git rm zz.tar.<tab>' then the completion script will return nothing,
since git cannot remove that ignored file, but we will then fall-back
to the bash default completion, which will complete the file to zz.tar.gz.

Although there are some issues, I think this feature will greatly benefit the user
and is worth the time needed to fix.

Thanks!

Marc
