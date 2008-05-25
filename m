From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CodingGuidelines: Add a note to avoid assignments inside
 if()
Date: Sat, 24 May 2008 22:17:26 -0700
Message-ID: <7vd4nbj72x.fsf@gitster.siamese.dyndns.org>
References: <1211498769-26871-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun May 25 07:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K08cn-0006O1-TG
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 07:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbYEYFRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 01:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbYEYFRj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 01:17:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbYEYFRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 01:17:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94EF349CF;
	Sun, 25 May 2008 01:17:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D041A49CC; Sun, 25 May 2008 01:17:28 -0400 (EDT)
In-Reply-To: <1211498769-26871-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Fri, 23 May 2008 01:26:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2A4AD6C-2A19-11DD-8B13-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82851>

Thanks.

FYI, recently in a nearby mailing list, we had this gem:

    From: Linus Torvalds <torvalds@linux-foundation.org>
    Subject: Re: [PATCH 3/5] isdn: fix integer as NULL pointer warning
    Date: Fri, 23 May 2008 08:08:57 -0700 (PDT)
    Message-ID: <alpine.LFD.1.10.0805230803290.3081@woody.linux-foundation.org>

    ...
    >  	len += sprintf(page+len, "%-16s %s\n", "type", s);
    > -	if ((s = cinfo->version[VER_DRIVER]) != 0)
    > +	if ((s = cinfo->version[VER_DRIVER]) != NULL)
    >  		len += sprintf(page+len, "%-16s %s\n", "ver_driver", s);

    For thigns like this (ie testing an assignment), I personally much prefer

            s = cinfo->version[VER_DRIVER];
            if (s)
                    len += sprintf(page+len, "%-16s %s\n", "ver_driver", s);

    over the uglier and unreadable version.

    IOW, testing assignments is good only when:

     - you have to do it because of syntax (ie notably in a "while()" loop)

     - there's some reason you want it to be a single statement (eg doing a 
       macro or other thing)

     - of the assignment is really simple, and the test is not against NULL or 
       zero.

    The reason for that "the test is not against NULL or zero" is that testing 
    for NULL and 0 is better done with just a "if (x)", and in an assignment 
    that just means either (a) a incomprehensible extra parenthesis just to 
    shut the compiler up or (b) changing the simple test into a stupid test 
    (ie doing "if (x != NULL)").

    (b) is much preferable to (a), but just doing it as two statements is 
    much preferable to either!
