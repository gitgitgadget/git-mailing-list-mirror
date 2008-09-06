From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-symbolic-ref: comment on the use of
 "resolve_ref" with reading == 0
Date: Sat, 06 Sep 2008 03:08:43 -0700
Message-ID: <7vwshpsi1g.fsf@gitster.siamese.dyndns.org>
References: <20080906095543.c627b692.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Sep 06 12:12:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbulz-00080U-U9
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 12:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbYIFKIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYIFKIw
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 06:08:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYIFKIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 06:08:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C1DD76DC1;
	Sat,  6 Sep 2008 06:08:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D82CF76DC0; Sat,  6 Sep 2008 06:08:47 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD8907AA-7BFB-11DD-A51E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95068>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
> index bfc78bb..9490c47 100644
> --- a/builtin-symbolic-ref.c
> +++ b/builtin-symbolic-ref.c
> @@ -12,6 +12,16 @@ static void check_symref(const char *HEAD, int quiet)
> ...
> +	/*
> +	 * It doesn't seem logical to use "resolve_ref" with reading == 0
> +	 * as we are just checking if a ref exists,...
> ...
> +	 */

I have to say that this comment is confused.

When you have a full ref (as opposed to an abbreviated one that you might
give to dwim_ref()), you can use it for two kinds of things:

 (1) You can use it to find out what _object_ the ref points at.  This is
     "reading" the ref, and the ref, if it is not symbolic, has to exist,
     and if it is symbolic, it has to point at an existing ref, because
     the "read" goes through the symref to the ref it points at.

 (2) Anything else.  This could be a prelude to "writing" to the ref, in
     which case a write to a symref that points at yet-to-be-born ref will
     create the real ref pointed by the symref, so such a symref is not an
     error.  It has to answer "here is the real ref you should write into"
     (or, "we will write into").

     But the access that is not "reading" does not have to be "writing";
     it can be merely checking _where it leads to_.  And check_symref()
     uses this call for exactly that purpose.  This access is not
     "checking if a ref exists".

So reading==0 is the logical thing to do here.
