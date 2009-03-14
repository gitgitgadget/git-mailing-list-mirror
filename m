From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
 for push
Date: Sat, 14 Mar 2009 13:56:42 -0700
Message-ID: <7viqmbakmt.fsf@gitster.siamese.dyndns.org>
References: <20090311220144.GA6782@pvv.org>
 <7vwsavlg6q.fsf@gitster.siamese.dyndns.org> <20090312115433.GA2848@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Liaw3-0002WC-Ue
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbZCNU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbZCNU4v
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:56:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbZCNU4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:56:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A1F7B6873;
	Sat, 14 Mar 2009 16:56:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF0416872; Sat,
 14 Mar 2009 16:56:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2B776AA-10DA-11DE-B436-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113265>

Finn Arne Gangstad <finnag@pvv.org> writes:

> Something like this amended into the last commit? I can amend it on top
> of the last one and resend if that is better.

Thanks.

I looked at these two patches after squashing them into one, and I think
it makes sense as the final shape of a two patch series.

Although the purist in me tells me that addition of the "tracking" and the
"current" should be in a separate commit as they are purely new features,
I think it is Ok.  In that sense, "nothing" is a new feature anyway, and
"current" is something we already have, so the true addition here is only
the "tracking" one.

I also reworded the commit log message a bit, like this:

    Author: Finn Arne Gangstad <finnag@pvv.org>
    Date:   Wed Mar 11 23:01:45 2009 +0100

    New config push.default to decide default behavior for push
    
    When "git push" is not told what refspecs to push, it pushes all matching
    branches to the current remote.  For some workflows this default is not
    useful, and surprises new users.  Some have even found that this default
    behaviour too easy to trigger by accident with unwanted consequences.
    
    Introduce a new configuration variable "push.default" that decides what
    action git push should take if no refspecs are given or implied by the
    command line arguments or the current remote configuration. If this
    variable is unconfigured, display a prominent warning when default
    behavior is triggered.
    
    Possible values are:
    
      'nothing'  : Push nothing;
      'matching' : Current default behaviour, push all branches that already
                   exist in the current remote;
      'tracking' : Push the current branch to whatever it is tracking;
      'current'  : Push the current branch to a branch of the same name,
      	           i.e. HEAD.

    Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I however had to scratch my head for 20 seconds wondering where the push
happens when do_default_push() codepath is taken, and it turns out that
the function is there merely to set up the push refspecs for the default
case; the function is misnamed.  I'd further squash the following patch
in.

diff --git a/builtin-push.c b/builtin-push.c
index 51f4c4a..e4988da 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -76,8 +76,7 @@ static const char *warn_unconfigured_push_msg[] = {
 	"  'nothing'  : Do not push anythig",
 	"  'matching' : Push all matching branches (the current default)",
 	"  'tracking' : Push the current branch to whatever it is tracking",
-	"  'current'  : Push the current branch",
-	""
+	"  'current'  : Push the current branch"
 };
 
 static void warn_unconfigured_push(void)
@@ -87,7 +86,7 @@ static void warn_unconfigured_push(void)
 		warning("%s", warn_unconfigured_push_msg[i]);
 }
 
-static void do_default_push(void)
+static void setup_default_push_refspecs(void)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
@@ -147,7 +146,7 @@ static int do_push(const char *repo, int flags)
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			do_default_push();
+			setup_default_push_refspecs();
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
