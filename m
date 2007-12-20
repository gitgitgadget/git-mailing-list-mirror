From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Wed, 19 Dec 2007 23:52:41 -0800
Message-ID: <7vlk7preeu.fsf@gitster.siamese.dyndns.org>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org> <4767934F.7070706@op5.se>
	<7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
	<20071218114949.711ba447@pc09.procura.nl>
	<7vr6hiv4ny.fsf@gitster.siamese.dyndns.org>
	<20071219211226.41920430@pc09.procura.nl>
	<7vzlw6tlpt.fsf@gitster.siamese.dyndns.org>
	<20071220081806.0ccdf636@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Dec 20 08:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5GDq-0005oe-Jy
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 08:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbXLTHxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 02:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXLTHxF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 02:53:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbXLTHxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 02:53:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA669986;
	Thu, 20 Dec 2007 02:52:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A5879984;
	Thu, 20 Dec 2007 02:52:53 -0500 (EST)
In-Reply-To: <20071220081806.0ccdf636@pc09.procura.nl> (H. Merijn Brand's
	message of "Thu, 20 Dec 2007 08:18:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68981>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

>> > Also because these are the *only* _POSIX_VERSION defines in the entire
>> > include tree, and 11.23 does have a select.h, which makes the patch below
>> > to be not OK on 11.23. I'm not stating that HP follows the rules in any
>> > correct way, but if this is to be sure that select.h gets included if the
>> > OS supports it, it will fail.
>> ...
>> But your grep did not catch their definition of _POSIX1_VERSION_$YEAR
>> which are used to define the actual value of _POSIX_VERSION.
>
> If it is used to *define* _POSIX_VERSION, it should have come up too,
> wouldn't it?

Sorry, I should re-read your grep output.  It is possible that I am
quite confused.

Your grep session begins like this:

>> >> > /usr/include 103 > grep -r POSIX_VERSION *
>> >> > sys/unistd.h:#    define _POSIX_VERSION _POSIX1_VERSION_88
>> >> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_90
>> >> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_93

Now, if they had

	#define _POSIX1_VERSION_88	198808L
        #define _POSIX1_VERSION_90	199009L
        #define _POSIX1_VERSION_93	199309L
        #define _POSIX1_VERSION_95	199506L
        #define _POSIX1_VERSION_01	200112L

elsewhere in their include files, then

 (1) "grep -r POSIX_VERSION *" wouldn't have matched them;

 (2) not all of the three output form sys/unistd.h could be in effect at
     the same time.  There may be #ifdef around it to control which
     definition is used, but your "grep" wouldn't have shown them
     either.

Maybe HP-UX include files #ifdef the definition of _POSIX_VERSION
depending on what is asked for with feature test macros?  We do not
define _POSIX_C_SOURCE to 200112L but we do define _XOPEN_SOURCE to 600.
According to:

    http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_02.html

this should be sufficient to ask for POSIX.1-2001 features.

But in any case, 88/90/93 are all too old (predates 2001-12) so if these
three definitions are only possible values in their include files, then
we wouldn't see _POSIX_VERSION set to 200112L.  That is unfortunate.
It seems we need to go back to that "NO_SYS_SELECT_H=YesPlease" thing.
