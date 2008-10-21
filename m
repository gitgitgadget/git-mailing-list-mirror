From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rm: loosen safety valve for empty files
Date: Mon, 20 Oct 2008 19:50:36 -0700
Message-ID: <7v4p361x1f.fsf@gitster.siamese.dyndns.org>
References: <20081021003712.GB32569@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 04:52:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks7Ll-0004YK-TQ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 04:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYJUCut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 22:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYJUCut
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 22:50:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYJUCus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 22:50:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CE6A71A34;
	Mon, 20 Oct 2008 22:50:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D9CD071A2C; Mon, 20 Oct 2008 22:50:43 -0400 (EDT)
In-Reply-To: <20081021003712.GB32569@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 20 Oct 2008 20:37:12 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 100A2BDA-9F1B-11DD-8E54-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98754>

Jeff King <peff@peff.net> writes:

> This covers the intent-to-add situation, and presumably
> there is little harm in not protecting users who have
> legitimately added an empty file. In many cases, the file
> will still be empty, in which case the safety valve does not
> trigger anyway (since the content remains untouched in the
> working tree). Otherwise, we do remove the fact that no
> content was staged, but given that the content is by
> definition empty, it is not terribly difficult for a user to
> recreate it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> ...
> +test_expect_success 'ok to remove cached empty file' '
> +	touch empty &&
> +	git add empty &&
> +	echo content >empty &&
> +	git rm --cached empty
> +'

I am actually of two minds about this patch.

With one of the commits in the nd/narrow series, we can easily add more
flag bits to the index entries, and it is conceivable that we would want
to change the "add -N" implementation to set an "intent to add" bit (which
we don't), in addition to registering an empty blob at the path (which we
currently do).  I envision that such a change would allow us to:

 - let "git diff" continue to diff with an emptiness and keep showing what
   people would expect;

 - teach "git write-tree" (and various "commit" building commands) to
   either (1) ignore a staged empty blob when the "intent to add" bit is
   set, or (2) warn and abort, saying "you told me you will tell me what
   the actual contents will be later, but you haven't done so -- I'll
   refuse to operate until you make up your mind";

in addition to what you are trying to fix here with "git rm".  With such a
change, your "git rm empty" code can also distinguish between an empty
blob the user wanted to add _as the final contents_, and a path that has
been marked with "add -N", and behave differently (the former would not
require -f while the latter would).

As an interim measure, I suspect your patch is an improvement from the
current state of affairs, but the above test will then break when an
improvement to "git add -N" implementation outlined above materializes.

So how about changing the test to explicitly check that a path that was
added by "git add -N" can be removed, and either (1) not check about an
empty blob that was explicitly added by the user, or (2) check that an
empty blob that was explicitly added by the user cannot be "git rm"'ed
without -f, with expect_failure?
