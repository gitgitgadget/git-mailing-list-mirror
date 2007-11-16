From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix and improve t7004
Date: Fri, 16 Nov 2007 13:42:44 -0800
Message-ID: <7vbq9tyii3.fsf@gitster.siamese.dyndns.org>
References: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org>
	<1195244917-25659-1-git-send-email-mh@glandium.org>
	<EEE710FA-0408-489F-8128-B4C1F06D34FF@lrde.epita.fr>
	<20071116211148.GA28966@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 22:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It8xx-0007Ym-W1
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 22:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbXKPVmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 16:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbXKPVmw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 16:42:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43700 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762264AbXKPVmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 16:42:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 801652F0;
	Fri, 16 Nov 2007 16:43:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DBE3896786;
	Fri, 16 Nov 2007 16:43:07 -0500 (EST)
In-Reply-To: <20071116211148.GA28966@glandium.org> (Mike Hommey's message of
	"Fri, 16 Nov 2007 22:11:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65250>

Mike Hommey <mh@glandium.org> writes:

>>> +	( read empty ;
>>> +	  [ "$empty" ] && exit 1 ;
>>
>> What is this meant to do?  Did you mean [ -n "$empty" ] ?
>
> Replacing with [ -n "$empty" ] would not work properly, except if you
> replace the following ; with &&. Does that really make a readability
> difference ?
>
>>> +	  ! grep -ve "^#" > /dev/null 2>&1 ) < actual
>>
>> The double negation is harder to read.  May I suggest something along these 
>> lines (which seems more readable to me):
>>   while read line; do
>>     case $line in #(
>>       '#'*) ;; # Accept comments (
>>       *) exit 1;;
>>     esac
>>   done
>
> I'm not really convinced. What do other people have to say ?

As shell "read" loses information (a backslash sequence is
interpreted, and trailing whitespaces are stripped and not
assigned to "line" above), it is not such a good vehicle if you
want to make a reasonably strict test on top of.  Some shells
do not implement "read -r" either, so it is also a portability
hassle.

Perhaps...

	# check the first line --- should be empty
	first=$(sed -e 1q <actual) &&
        test -z "$first" &&
	# remove commented lines from the remainder -- should be empty
        rest=$(sed -e 1d -e '/^#/d' <actual) &&
        test -z "$rest"
