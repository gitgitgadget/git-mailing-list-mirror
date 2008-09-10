From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Tue, 09 Sep 2008 22:35:18 -0700
Message-ID: <7vabegzhpl.fsf@gitster.siamese.dyndns.org>
References: <201191.94038.qm@web95010.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, GIT SCM <git@vger.kernel.org>,
	Jing Xue <jingxue@digizenstudio.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 07:36:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdINX-0004ef-Ku
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 07:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYIJFf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 01:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbYIJFf2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 01:35:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYIJFf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 01:35:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0F755C6ED;
	Wed, 10 Sep 2008 01:35:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9A17E5C6EC; Wed, 10 Sep 2008 01:35:20 -0400 (EDT)
In-Reply-To: <201191.94038.qm@web95010.mail.in2.yahoo.com>
 (dhruva@ymail.com's message of "Wed, 10 Sep 2008 10:43:26 +0530 (IST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45401E9A-7EFA-11DD-A719-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95482>

dhruva <dhruva@ymail.com> writes:

> @@ -975,10 +978,11 @@ class P4Sync(Command):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
>                  continue
>
> -            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> -                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> -            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
> -                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
> +            if kwstrip:
> +                if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> +                    text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
> +                elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
> +                    text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)

A style tip.

It makes it easier to convince others that you didn't screw up in the
conversion if you cascade the code this way instead:

-	if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+	if not kwstrip:
+		pass
+	elif stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
 		text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
 	elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
 		text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|...

This technique not just only makes the patch smaller and easier to review,
it also makes the result less deeply nested and easier to read as well.
