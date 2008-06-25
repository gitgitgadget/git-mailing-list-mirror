From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Wed, 25 Jun 2008 12:14:41 -0700
Message-ID: <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBaT8-0000fj-Kh
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYFYTOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYFYTOz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:14:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYFYTOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:14:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 946401BB35;
	Wed, 25 Jun 2008 15:14:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8AEC41BB32; Wed, 25 Jun 2008 15:14:46 -0400 (EDT)
In-Reply-To: <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com> (Christian
 Holtje's message of "Wed, 25 Jun 2008 14:47:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBD730D6-42EA-11DD-BCB6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86324>

Christian Holtje <docwhat@gmail.com> writes:

> On Jun 25, 2008, at 2:14 PM, Alex Riesen wrote:
>> Christian Holtje, Tue, Jun 24, 2008 21:21:22 +0200:
>>> diff --git a/t/t7503-template-hook--pre-commit.sh b/t/t7503-template-
>>> hook--pre-commit.sh
>>
>> Your patch has long lines wrapped.
>>
>>> diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-
>>> commit
>>> index b25dce6..335ca09 100644
>>> --- a/templates/hooks--pre-commit
>>> +++ b/templates/hooks--pre-commit
>>> @@ -55,8 +55,14 @@ perl -e '
>>> 	if (s/^\+//) {
>>> 	    $lineno++;
>>> 	    chomp;
>>> -	    if (/\s$/) {
>>> -		bad_line("trailing whitespace", $_);
>>> +	    if (/\r$/) {
>>> +		if (/\s\r$/) {
>>> +		    bad_line("trailing whitespace", $_);
>>> +		}
>>> +	    } else {
>>> +		if (/\s$/) {
>>> +		    bad_line("trailing whitespace", $_);
>>> +		}
>>
>> You coud just strip the trailing (cr)lf, instead of chomp:
>>
>>  	if (s/^\+//) {
>>  	    $lineno++;
>> - 	    chomp;
>> +	    s/\r?\n$//so;
>> 	    if (/\s$/) {
>> 		bad_line("trailing whitespace", $_);
>>
>> Makes for a shorter patch and less code.
>
> That's a good idea!  However, this patch is not going anyplace, I
> think.  Junio submitted a different patch to disable the pre-commit
> example.
>
> Junio, do you want me to make this change anyway?  It does make sense.
> The unittests for the pre-commit hook may or may not still be  useful.

"disable" is not an issue.  The intention has always been that these are
samples, and it was an accident that some packaging shipped them enabled
by mistake.  The patch was to make that mistake harder to make.

The issue now is about keeping the example hooks _relevant_.  The one we
have does not work well with projects that want to check in files with
CRLF line endings (iow, without using autocrlf to attempt to make the
project files cross-platform), so it is irrelevant for such projects with
Windows origin.

The "solution" you are proposing to strip out \r makes the check less
useful for projects that want to keep files with LF line endings in the
commited history, because your patch would stop catching such a mistake of
adding an CR before LF.  It is robbing from Peter to pay Paul, and I am
afraid it would make the sample even more irrelevant in the end.  I do not
think we would want to go there.

I suggested using "diff --check" (and possibly teaching "diff --check"
other things the scripted example checks, such as conflict markers),
which would know to honor the line endings specified per path via
gitattributes(5), instead of building on top of the big Perl script, and I
had an impression that you agreed to the approach.
