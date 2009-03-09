From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep Bus Error
Date: Sun, 08 Mar 2009 17:29:31 -0700
Message-ID: <7v1vt7k07o.fsf@gitster.siamese.dyndns.org>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 01:32:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgTPd-0001Ot-9g
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 01:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZCIA3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 20:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZCIA3j
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 20:29:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZCIA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 20:29:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 99734A06B7;
	Sun,  8 Mar 2009 20:29:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83EC8A06B6; Sun,
  8 Mar 2009 20:29:33 -0400 (EDT)
In-Reply-To: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sun, 8 Mar 2009 19:27:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E87A75E-0C41-11DE-B8B6-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112655>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> The --color display code in git-grep is giving me a bus error in
> show_line at line 492:
>
>>                         printf("%.*s%s%.*s%s",
>>                                match.rm_so, bol,
>>                                opt->color_match,
>>                                match.rm_eo - match.rm_so, bol +
>> match.rm_so,
>>                                GIT_COLOR_RESET);
>
> The first problem is that %.*s does not appear to do on OS X what the
> author thinks it does.

Hmm, that means that printf on OSX does not dohat the POSIX thinks it
ought to.

    http://www.opengroup.org/onlinepubs/009695399/functions/fprintf.html

says that "a negative precision is taken as if the precision were
omitted"; it does not say "a negative or zero" here.

Which is a bit sad, because we would need to apply a workaround like
yours.  We shouldn't have to.

> To fix that, I changed it to the following:
>
>> 			if( match.rm_so > 0 )
>> 				printf( "%.*s", match.rm_so, bol );
>> 			if( match.rm_eo > match.rm_so )
>> 				printf("%s%.*s%s",
>> 					   opt->color_match,
>> 					   match.rm_eo - match.rm_so, bol + match.rm_so,
>> 					   GIT_COLOR_RESET);

> This code does not fail, but instead gives lines like the following
> (showing the raw color codes):
>
> .gitignore:\033[31m\033[1m(nugit

Hmm, that is strange.  Your above change issues color_match and COLOR_RESET
only when you have something between rm_eo and rm_so.  I do not see
anything between "ESC [ 31 m" and "ESC [ m" above, and you have an extra "1"
between "ESC [" and terminating "m" in the reset sequence.
