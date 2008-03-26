From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Tue, 25 Mar 2008 20:31:49 -0700
Message-ID: <7vod92jh3u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210014100.19665@iabervon.org>
 <7vmyosskyu.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803211148120.19665@iabervon.org>
 <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803251841420.2775@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 04:32:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeMNZ-0000bR-3z
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 04:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYCZDcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbYCZDcB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:32:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46946 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYCZDcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 23:32:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E44081C18;
	Tue, 25 Mar 2008 23:31:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F10191C17; Tue, 25 Mar 2008 23:31:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803251841420.2775@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 25 Mar 2008 18:45:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78248>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 21 Mar 2008, Junio C Hamano wrote:
>>
>> We tightened the refspec validation code in an earlier ef00d15 (Tighten
>> refspec processing, 2008-03-17) per my suggestion, but the suggestion was
>> misguided to begin with and it broke this usage:
>
> It seems to have also broken "git push --tags".
>
> I now get 
>
> 	fatal: Invalid refspec 'refs/tags/*'
>
> which seems a bit sad.

Yeah that indeed is very sad.  Given that Andrew identified another
regression on the fetch side today, I am beginning to suspect that 1.5.4
was still too early to merge the C rewrite.  On the other hand, until we
tag, new features are not tested in the field, so...

Especially that "refs/tags/*" is sad in that it is leaking an internal
implementation detail.  I do not think the original code ever used
wildcards on the push side, and it probably was a good idea to allow
wildcards when the code was rewritten.

In any case, this should fix it.

 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index b68c681..5316d6d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -120,7 +120,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= TRANSPORT_PUSH_VERBOSE;
 	if (tags)
-		add_refspec("refs/tags/*");
+		add_refspec("refs/tags/*:refs/tags/*");
 	if (all)
 		flags |= TRANSPORT_PUSH_ALL;
 	if (mirror)
