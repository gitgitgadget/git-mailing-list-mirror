From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Mon, 17 Aug 2009 16:21:54 -0700
Message-ID: <7vzl9ykovh.fsf@alter.siamese.dyndns.org>
References: <4A89E185.2010307@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBWk-0003fy-6q
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237AbZHQXWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757791AbZHQXWA
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:22:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZHQXV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:21:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 941252DC4C;
	Mon, 17 Aug 2009 19:21:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92D292DC4B; Mon, 17 Aug 2009
 19:21:56 -0400 (EDT)
In-Reply-To: <4A89E185.2010307@fastmail.fm> (Karthik R.'s message of "Mon\,
 17 Aug 2009 18\:02\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3453CCA-8B84-11DE-88C1-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126319>

Karthik R <karthikr@fastmail.fm> writes:

> +# If GIT_SSH is set, also set SVN_SSH...
> +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
> +# ... and escape \s in shell-variable on Windows
> +if ($^O eq 'MSWin32' || $^O eq 'msys') {
> +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
> +}
> +

Two questions.

 - What if a user has SVN_SSH exported _and_ wants to use a different one
   from the one s/he uses for git?  Naturally such a user would set both
   environment variables and differently, but this seems to override the
   value in SVN_SSH;

 - Can a user have SVN_SSH exported, on MSWin32 or msys, and use svn
   outside git?  If so, what does the value of SVN_SSH look like?  Does it
   typically have necessary doubling of backslashes already?

What I am getting at is, if the patch should look something like this
instead:

	if (! exists $ENV{SVN_SSH}) {
		if (exists $ENV{GIT_SSH}) {
			$ENV{SVN_SSH} = $ENV{GIT_SSH};
			if ($^O eq 'MSWin32' || $^O eq 'msys') {
                               $ENV{SVN_SSH} =~ s/\\/\\\\/g;
			}
		}
	}
