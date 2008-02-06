From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 6 Feb 2008 09:05:14 +0100
Message-ID: <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>, srp@srparish.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 09:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMfJx-0004vZ-7l
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 09:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYBFIHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 03:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYBFIHU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 03:07:20 -0500
Received: from wincent.com ([72.3.236.74]:60233 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbYBFIHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 03:07:19 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1685FSf014490;
	Wed, 6 Feb 2008 02:05:16 -0600
In-Reply-To: <7vr6fr9noj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72767>

El 5/2/2008, a las 21:02, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> I just noticed that my copy of git-daemon running from xinetd on Red
>> Hat Enterprise Linux 3 has been broken since upgrading to 1.5.4.
>>
>> On the client side this is what you see ("git clone" used in the
>> example but you get the same issue with "git ls-remote"):
>>
>>  git clone git://git.wincent.com/wikitext.git
>>  Initialized empty Git repository in /tmp/wikitext/.git/
>>  fatal: The remote end hung up unexpectedly
>>  fetch-pack from 'git://git.wincent.com/wikitext.git' failed.
>>
>> Nothing printed to the logs on the server side: it simply hangs up. =
=20
>> By
>> connecting via telnet I've confirmed that git-daemon is running and
>> does accept the initial connection.
>>
>> The verdict according to "git bisect" is that
>> 511707d42b3b3e57d9623493092590546ffeae80 is first bad commit:
>>
>> commit 511707d42b3b3e57d9623493092590546ffeae80
>> Author: Scott R Parish <srp@srparish.net>
>> Date:   Sun Oct 28 04:17:20 2007 -0700
>>
>>    use only the $PATH for exec'ing git commands
>
> Perhaps you did not install git on the PATH processes launched
> by your inetd implementation would use?

I don't know what PATH environment xinetd provides, but I can =20
reproduce this directly as follows from the command line without any =20
involvement from xientd:

=46irst, set up PATH with all the standard locations, with directories =
=20
under /usr/local specified first. Git 1.5.4 is installed in /usr/local/=
=20
bin:

   # export PATH=3D/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/=20
sbin:/sbin

This fails with the "remote end hung up unexpectedly" error:

   # /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah

Drop the --inetd option and it works with no errors:

   # /usr/local/bin/git-daemon --base-path=3D/blah -- /blah

Now, if I downgrade to Git 1.5.3.8, it works both with and without the =
=20
--inetd option.

The above behaviour is the same regardless of how I specify the path =20
to git-daemon (ie. absolute or relative, dashed or dashless).

Is there anything I can do to get "git daemon" to be more verbose on =20
failing?

Cheers,
Wincent
