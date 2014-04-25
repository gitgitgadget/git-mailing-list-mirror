From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Fri, 25 Apr 2014 19:19:54 -0400
Message-ID: <20140425231953.GB3855@sigill.intra.peff.net>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 01:20:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdpPV-000519-75
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 01:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbaDYXT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 19:19:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:38715 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbaDYXTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 19:19:55 -0400
Received: (qmail 5729 invoked by uid 102); 25 Apr 2014 23:19:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Apr 2014 18:19:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Apr 2014 19:19:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247132>

On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:

> * jk/external-diff-use-argv-array (2014-04-21) 6 commits
>   (merged to 'next' on 2014-04-22 at e6d92d7)
>  + run_external_diff: refactor cmdline setup logic
>  + run_external_diff: hoist common bits out of conditional
>  + run_external_diff: drop fflush(NULL)
>  + run_external_diff: clean up error handling
>  + run_external_diff: use an argv_array for the environment
>  + run_external_diff: use an argv_array for the command line
> 
>  Code clean-up.
> 
>  Will keep in 'next' for the remainder of the cycle.

The first one does fix a possible stack overflow (albeit of one NULL,
not arbitrary content, so I don't think it's exploitable). We may want
to do:

diff --git a/diff.c b/diff.c
index 54d5308..a03744b 100644
--- a/diff.c
+++ b/diff.c
@@ -2894,7 +2894,7 @@ static void run_external_diff(const char *pgm,
 			      int complete_rewrite,
 			      struct diff_options *o)
 {
-	const char *spawn_arg[10];
+	const char *spawn_arg[11];
 	int retval;
 	const char **arg = &spawn_arg[0];
 	struct diff_queue_struct *q = &diff_queued_diff;

as a fix for maint/2.0.0 in the interim. I can write a commit message
for that if you're interested.

> * fc/publish-vs-upstream (2014-04-21) 8 commits
>  - sha1_name: add support for @{publish} marks
>  - sha1_name: simplify track finding
>  - sha1_name: cleanup interpret_branch_name()
>  - branch: display publish branch
>  - push: add --set-publish option
>  - branch: add --set-publish-to option
>  - Add concept of 'publish' branch
>  - t5516 (fetch-push): fix test restoration
> 
>  Add branch@{publish}; it seems that this is somewhat different from
>  Ram and Peff started working on.  There were many discussion
>  messages going back and forth but it does not appear that the
>  design issues have been worked out among participants yet.

If you are waiting on me, I do not have much else to say on this topic.
@{publish} as specified by Felipe is not useful to me, and I would
continue to pursue @{push} separately as "the remote-tracking branch of
where you would push to". I think there is room for both concepts.

As for the patches themselves, I have not reviewed them carefully, and
would prefer not to. As I mentioned before, though, I would prefer the
short "@{p}" not be taken for @{publish} until it has proven itself.

-Peff
