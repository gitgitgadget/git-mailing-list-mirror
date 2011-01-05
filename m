From: "Vallon, Justin" <Justin.Vallon@deshaw.com>
Subject: RE: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Wed, 5 Jan 2011 10:04:54 -0500
Message-ID: <982E526FA742C94E9AC26DA766FD07090A33A5@NYCMBX3.winmail.deshaw.com>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
 <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
 <vpqhbdoxpzp.fsf@bauges.imag.fr> <20110104225826.GA2122@burratino>
 <7vmxngdys8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 16:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaUyG-0008Al-IH
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 16:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab1AEPIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 10:08:10 -0500
Received: from master.dr.deshaw.com ([149.77.227.1]:61761 "EHLO
	master.dr.deshaw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1AEPIJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 10:08:09 -0500
Received: from winmail.deshaw.com ([149.77.72.51])
 by master.dr.deshaw.com (8.13.8+Sun/8.13.7/2.0.kim.desco.357) with ESMTP id p05F6ttR017723;
 Wed, 5 Jan 2011 10:06:55 -0500 (EST)
Received: from NYCMBX3.winmail.deshaw.com ([149.77.72.43]) by
 mailnychts1.winmail.deshaw.com ([149.77.72.51]) with mapi; Wed, 5 Jan 2011
 10:06:54 -0500
Thread-Topic: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Thread-Index: AcusaKZy0wRAyj6JS82l50rcE4JXvQAfS1Mg
In-Reply-To: <7vmxngdys8.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164566>

>-----Original Message-----
>From: Junio C Hamano [mailto:gitster@pobox.com]
>Sent: Tuesday, January 04, 2011 6:39 PM
>To: Jonathan Nieder
>Cc: Matthieu Moy; Vallon, Justin; Robin H. Johnson; git@vger.kernel.org
>Subject: Re: [PATCH v2] Fix false positives in t3404 due to
>SHELL=/bin/false
>
>Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Matthieu Moy wrote:
>>>
>>> (my bad, I wrote this SHELL= without exporting it. Since bash
>>> re-exports already exported variables when they are assigned, and my
>>> /bin/sh points to bash, I didn't notice)
>>
>> Isn't that how export works in all Bourne-style shells?  For example:
>>
>> 	$ env var=outside dash -c '
>> 		var=inside;
>> 		dash -c "echo \$var"
>> 	  '
>> 	inside
>> 	$
>>
>> Maybe in the failing case SHELL was not exported but just set to
>> /bin/false in .bashrc or similar?
>
>Thanks, you saved me some time responding ;-)
>
>Matthieu's diagnosis is only half correct in that bash is why he didn't
>notice the problem, but if in this sequence
>
>	var=foo
>        export var
>        var=bar
>        some-command
>
>some-command does not see "bar" as the value of environment variable
>"var", your shell is not POSIX (there is no such thing as "re-exporting").

But, when you say "your shell", you are really referring to /bin/sh, because this behavior is being observed in t/t3404-rebase-interactive.sh.  Which leads to...

Robin: have you observed the problem with Gentoo's /bin/sh?

X=1 ; export X ; /bin/sh -c 'X= ; env | grep ^X='

If so, I would qualify the export with a comment about the mis-behavior:

# Reexport in case sh is non-POSIX
export SHELL

(or, just unset SHELL)

Else, I don't think the re-export is needed (something else is causing your trouble).

>Because POSIX shells are required to mark variables they inherit from the
>environment with the export attribute, your tests will run with SHELL
>exported to the environment if your usual shell is bash (i.e. SHELL is
>already exported to processes it spawns), even if you use another POSIX
>shell to run your git and tests.  That makes the issue doubly harder to
>notice.

I don't really follow this.  The #! line is /bin/sh.  The user's $SHELL does not come into play.  Either SHELL is in /bin/sh's environment and it should be cleared in the child, or it isn't and it won't matter.

-- 
-Justin
