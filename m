From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:03:51 +0100
Message-ID: <BB900023-A5D7-4ECA-95A6-8334F7976224@wincent.com>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801161531030.17650@racer.site> <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHJL-0008E6-OV
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYAPXEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYAPXEF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:04:05 -0500
Received: from wincent.com ([72.3.236.74]:34202 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbYAPXEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:04:04 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0GN3q3b001964;
	Wed, 16 Jan 2008 17:03:54 -0600
In-Reply-To: <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70764>

El 16/1/2008, a las 16:43, Kevin Ballard escribi=F3:

> On Jan 16, 2008, at 10:34 AM, Johannes Schindelin wrote:
>
>> On Wed, 16 Jan 2008, Mark Junker wrote:
>>
>>> I have some files like "L=FCftung.txt" in my repository. The strang=
e =20
>>> thing is
>>> that I can pull / add / commit / push those files without problem =20
>>> but
>>> git-status always complains that thoes files are untraced (but not =
=20
>>> missing).
>>
>> This is a known problem.  Unfortunately, noone has implemented a fix=
,
>> although if you're serious about it, I can point you to threads =20
>> where it
>> has been hinted how to solve the issue.
>>
>> FWIW the issue is that Mac OS X decides that it knows better how to =
=20
>> encode
>> your filename than you could yourself.
>
> More like, Mac OS X has standardized on Unicode and the rest of the =20
> world hasn't caught up yet. Git is the only tool I've ever heard of =20
> that has a problem with OS X using Unicode.

As far as I know, Subversion has basically exactly the same problem, =20
and any time you consume/produce files on Mac OS X that are be =20
consumed/produced on other platforms you will run into this kind of =20
issue, with any software.

Tell Mac OS X to write a file with "=F3" in the file name ("\xc3\xb3" i=
n =20
UTF-8), and it will "normalize" it prior to writing by converting it =20
into a decomposed form (that is, ASCII "o" followed by "\xcc\x81", or =20
"combining acute accent"). So they're both valid Unicode, both valid =20
UTF-8, and they encode exactly the same characters but the byte stream =
=20
is different.

If you only work on Mac OS X then this will never be a problem because =
=20
all the files you create and therefore all the files you add to your =20
Git repository will have their names in decomposed UTF-8. But when you =
=20
start cloning repositories containing files added on other systems, =20
systems which might use precomposed rather than decomposed UTF-8 then =20
you'll run into exactly this kind of problem. The git.git repo has one =
=20
such file itself (gitweb/test/M=E4rchen, if I remember correctly, which=
 =20
Git reports as untracked).

Now, Mac OS X's behaviour is not entirely "insane" as some would =20
claim; there is indeed a rationale behind it even if you don't agree =20
with it, but it *does* produce some unfortunate teething problems for =20
people wanting to use Mac OS X in a cross-platform environment.

Here are some Apple docs on the subject:

http://developer.apple.com/qa/qa2001/qa1173.html

http://developer.apple.com/qa/qa2001/qa1235.html

I personally wish that UTF-8 didn't allow different normalization =20
forms; then this kind of problem wouldn't arise. But it has arisen and =
=20
we have to live with it. Some workarounds have been proposed for Git, =20
but I haven't seen any convincing proposals yet.

Cheers,
Wincent
