From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Tue, 5 Feb 2008 20:28:06 +0100
Message-ID: <A8C3C239-8352-4219-AC19-12280F536A8A@wincent.com>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <AC76050F-D727-4952-A528-55827D5B707B@srparish.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Scott Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMTTl-0001fw-Sf
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 20:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbYBET2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2008 14:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756288AbYBET2L
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 14:28:11 -0500
Received: from wincent.com ([72.3.236.74]:58757 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756207AbYBET2J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 14:28:09 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m15JS6ip032448;
	Tue, 5 Feb 2008 13:28:07 -0600
In-Reply-To: <AC76050F-D727-4952-A528-55827D5B707B@srparish.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72683>


El 5/2/2008, a las 18:49, Scott Parish escribi=F3:

>
> On Feb 5, 2008, at 7:39 AM, Wincent Colaiuta wrote:
>
>> I just noticed that my copy of git-daemon running from xinetd on =20
>> Red Hat Enterprise Linux 3 has been broken since upgrading to 1.5.4.
>>
>> Nothing printed to the logs on the server side: it simply hangs up. =
=20
>> By connecting via telnet I've confirmed that git-daemon is running =20
>> and does accept the initial connection.
>>
>> The verdict according to "git bisect" is that =20
>> 511707d42b3b3e57d9623493092590546ffeae80 is first bad commit:
>>
>> Does that look like it might be the issue? Anyone familiar with =20
>> that part of the code care to comment? Any other info I can provide =
=20
>> that might shed light on the problem?
>
> Prior to that patch, execv_git_cmd called execve in a loop to find =20
> the command to run. The above patch added a setup_path() api to =20
> setup PATH and then called execvp() to do the looping. The problem =20
> in this case is that daemon is never calling setup_path(), so the =20
> builtin path (among others) aren't getting included in the PATH.
>
> You should see the problem go away if you run "git daemon" instead =20
> of "git-daemon". Given that directly using the dash versions of the =20
> commands are discouraged, it probably wouldn't hurt doing this =20
> anyway. I'll work up a patch later today.

Interesting. I use the dashless form on my desktop but I hadn't =20
thought about using it on the server; I'd think that explicitly =20
providing the absolute path should always work anyway (at least, it's =20
meant to, isn't it?).

In any case I did a little more investigation.

As I mentioned in my original email, the daemon is being launched by =20
xinetd. The xinetd configuration launches it with the full path to the =
=20
executable; eg:

   /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah

Changing that to:

   /usr/local/bin/git daemon --inetd --base-path=3D/blah -- /blah

We still get the failure.

But dropping the --inetd flag and launching the daemon manually it =20
works both as:

   /usr/local/bin/git daemon --inetd --base-path=3D/blah -- /blah

And:

   /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah

So there's some kind of funky interaction going on. On seeing your =20
patch come up in the "git bisect" run I wondered what kind of =20
interaction might be happening with the PATH (I imagine the PATH =20
environment inherited by processes that xinetd launches must be pretty =
=20
anemic), but seeing as I can reproduce the problem from the command =20
line (with a well-stocked PATH) that doesn't seem to be the problem.

Cheers,
Wincent
