From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Tue, 26 Apr 2016 01:10:56 +0200
Message-ID: <20160426011056.Horde.yl47nWMpVGsuGDgrKiKb_nR@webmail.informatik.kit.edu>
References: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com>
 <20160425162502.31558-1-szeder@ira.uka.de>
 <xmqq8u01mwji.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ben Woosley <Ben.Woosley@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 01:11:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aupfD-000687-71
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 01:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbcDYXLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 19:11:31 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34907 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751848AbcDYXLa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 19:11:30 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aupf2-0000Td-IT; Tue, 26 Apr 2016 01:11:24 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1aupea-0002F2-R2; Tue, 26 Apr 2016 01:10:56 +0200
Received: from x4db01c0d.dyn.telefonica.de (x4db01c0d.dyn.telefonica.de
 [77.176.28.13]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 26 Apr 2016 01:10:56 +0200
In-Reply-To: <xmqq8u01mwji.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1461625884.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292580>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> You can have a look at these patches at
>>
>>   https://github.com/szeder/git completion-test-multiple-bash-versio=
ns
>>
>> and perhaps you could even adapt it to LFS and/or p4 somehow.
>>
>>> Plus if we want to be consistent we would
>>> need to do the same for LFS 1.0, 1.2, and for pretty much every oth=
er
>>> dependency...
>>
>> I'm not sure we should be consistent in this case, at least not sole=
ly
>> for consistency's sake and not in git.git. Taking what I did for Bas=
h
>> and doing it for different versions of LFS, p4, etc. could perhaps
>> keep the runtime under control, but t/Makefile would surely get out
>> of control rather quickly.  Putting these into a travis-ci matrix is
>> so much simpler, but the runtime makes it infeasible, of course.
>
> I took a brief look of your branch, and I like its approach.  If I
> understood your approach correctly, you:
>
>  * Group selected tests in t/ as "these are bash related tests I
>    care about" in t/Makefile;

Yes.

>  * Add Travis test target to build Git with specific versions of
>    bash, and run the above target instead of the full test to
>    exercise the version of bash you are testing.

Not quite.

   * Add t/Makefile targets to run a Bash-related test script with a
     specific Bash version, one target for each script-version pair,
     and a target to run all Bash-related tests with all listed
     Bash-versions.

   * Extend the travis-ci config so that, after building Git as usual
     and running the full test suite as usual, it additionaly runs all
     Bash-related tests will all listed Bash versions on Linux builds.

> And I agree that the same can be done for LFS versions and P4
> versions.  Only a handful tests in t/ are about these niches.

Luckily for me, running a test script with a specific Bash version is
as trivial as '/path/to/bash-vX.Y t9902-completion.sh'.  No
modifications to the test scripts or to lib-bash.sh were necessary.

OTOH, Git LFS and p4 tests, AFAICS, rely on git-lfs and p4 binaries
being available in $PATH, and the p4 tests need two binaries.  So
there is more work that has to be done, as we would need a way to
override those binaries found in $PATH, either through an environment
variable or a command line option.  Bonus points for a solution that
would work equally well with LFS, p4 and Bash: then perhaps we could
have a single unified block of Makefile metaprogramming, which could
generate  all those test targets from a list of dependency-specific
tests and a list of paths to different versions of that dependency.
Then it might even be suitable for inclusion in git.git.


>> I think the best we can do is to keep this out of git.git and let
>> (hope?) developers interested in a particular subsystem do this
>> "multiple version compatibility" tests as they see fit.
