From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 4/4] filter-branch: fix variable export logic
Date: Tue, 13 May 2008 21:18:53 -0700
Message-ID: <7v7idxr00i.fsf@gitster.siamese.dyndns.org>
References: <20080513084338.GA23729@sigill.intra.peff.net>
 <20080513084638.GD23799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 14 06:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw8TP-0006cz-IP
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 06:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYENETD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 00:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbYENETD
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 00:19:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbYENETB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 00:19:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EC1838E8;
	Wed, 14 May 2008 00:19:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 344A738E6; Wed, 14 May 2008 00:18:57 -0400 (EDT)
In-Reply-To: <20080513084638.GD23799@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 May 2008 04:46:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0AB271C-216C-11DD-8672-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82068>

Jeff King <peff@peff.net> writes:

> filter-branch tries to restore "old" copies of some
> environment variables by using the construct:
>
>   unset var
>   test -z "$old_var" || var="$old_var" && export var
>
> However, by the short-circuit logic, we will always run
> 'export var'.

Thanks.

I was confused by this description ("short-circuit logic"), but I do not
think there is no short-circuit going on.  This is a simple ignorance of
shell syntax.

In a shell scriptlet:

	a || b && c

AND list operator (&&) and OR list operator (||) have the same precedence
and bind to the left.  Because the second part of OR list is always true,
we always export.

I have a mild suspecion that this was simply an artifcat of a careless
conversion from export var="$val" form we did in the past.  I should have
caught them back then.

The patch is fine, but I find this easier to read:

+test -z "$ORIG_GIT_DIR" || {
+	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
+}
+test -z "$ORIG_GIT_WORK_TREE" || {
+	GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+	export GIT_WORK_TREE
+}
+test -z "$ORIG_GIT_INDEX_FILE" || {
+	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+	export GIT_INDEX_FILE
+}
