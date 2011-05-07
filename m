From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] rerere: Expose an API corresponding to 'clear' functionality
Date: Sat, 7 May 2011 18:47:45 +0530
Message-ID: <20110507131745.GA29061@ramkum.desktop.amazon.com>
References: <20110413203843.GC30630@elie> <1304663813-27724-1-git-send-email-artagnon@gmail.com> <7vr58b22ny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 15:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIhOQ-0006k7-RZ
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 15:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab1EGNRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 09:17:53 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:54371 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab1EGNRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 09:17:53 -0400
X-IronPort-AV: E=Sophos;i="4.64,331,1301875200"; 
   d="scan'208";a="73887724"
Received: from smtp-in-0102.sea3.amazon.com ([10.224.19.46])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 May 2011 13:17:51 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0102.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p47DHkDQ007891;
	Sat, 7 May 2011 13:17:46 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 93C7875481C; Sat,  7 May 2011 18:47:45 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173051>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > Libify the "rerere clear" into a simple function called rerere_clear
> > that takes no arguments, and returns the exit status.  Also export
> > unlink_rr_item as unlink_rerere_item so rerere_clear and the
> > un-libified "git rerere gc" can both use it.
> >
> > Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  What changed since v2: Jonathan's review.
> 
> Are you sure this is the version you wanted to send?
> 
> You now return -1 from rerere_clear() when setup_rerere() says that the
> feature is not enabled, and this is propagated back to cmd_rerere(),
> causing the whole command to report a failure in its exit status, which
> seems to me a grave regression.  Your previous round got this part right,
> but it is broken in this round.

Ugh, I'm not sure how this change crept in- sorry :|
Could you please squash this diff into the patch?

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/rerere.c b/rerere.c
index aaca3b0..fda02f6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -687,7 +687,7 @@ int rerere_clear(void)
 
 	fd = setup_rerere(&merge_rr, 0);
 	if (fd < 0)
-		return -1;
+		return 0;
 	for (i = 0; i < merge_rr.nr; i++) {
 		const char *name = (const char *)merge_rr.items[i].util;
 		if (!has_rerere_resolution(name))

> Also I seem to recall that Jonathan suggested that you do not have to
> expose unlink_rr_item() as an external symbol if you moved the garbage
> collection part from builtin/rerere.c to rerere.c but I do not see such a
> change in this patch.  I think the gc interface is a lot more reasonable
> API to expose to external callers ("git gc" may want to make an internal
> call to rerere_gc() moved to rerere.c, instead of spawning "git rerere gc"
> as an external command) than unlink_rerere_item() that is only useful for
> callers that are deep inside rerere specific codepath.

I'll quote Jonathan from the previous review:

"
I think the reason for this is that rerere_gc is not being exposed at
the same time, right?  I suppose if I were doing it, I would have
moved that to rerere.c, too and kept unlink_rr_item static, but there
is also appeal in a minimal patch.  It would be clearer to say
something to the effect that we

	Also export unlink_rr_item as unlink_rerere_item so
	rerere_clear and the un-libified "git rerere gc" can
	both use it.
"

To the first part of the question: yes, that's the reason for exposing
unlink_rr_item as unlink_rerere_item.  Yet, I followed the latter
approach for the appeal of the minimal patch -- I should have said
this explicitly.  Anyway, I plan to post another patch cleaning up and
libifying rerere shortly.

Junio: If you feel that garbage_collect should be exposed in this
patch, I'll post an alternative version now, and you can pick the one
you like :)

-- Ram
