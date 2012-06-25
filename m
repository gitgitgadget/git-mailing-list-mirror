From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Mon, 25 Jun 2012 12:49:53 -0700
Message-ID: <7vr4t3f9y6.fsf@alter.siamese.dyndns.org>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
 <7vobo8hsee.fsf@alter.siamese.dyndns.org>
 <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 21:50:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjFJD-0006QB-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 21:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab2FYTt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 15:49:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59927 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab2FYTt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 15:49:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AB90903F;
	Mon, 25 Jun 2012 15:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IvYQbnUDKIo36955pKNkovSubuM=; b=r27/lx
	njp/CVD8tJUMWuI3G3A2WYvCtiXczuZ0qnlFwKzKhlG2X7X0+mdMH/f8yNGczSVi
	Dy+fGs+9AfG6zIXEJ8NMayLcChXy+BHq1LcxNiMvDzCFa+mFXfi6CkO7qp2npu6p
	nWEGwJ38cg2xGJJCvgeekiqMsMNJIGpKwHygY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtZLS5DEpywpXvATy6ihNbVBDou8Kong
	ikKHUS3kg4pydiTygYjc+M3D1ERlz+DSRFfALRTwiuXj5Km9pbpGbCrnaKYa5Lyg
	fmhxy16MDPhC6n+3l935WpRXQuAN+7MRVu1OLhb6Yfc2r0QCcttnB4uobrNsGTeD
	XyOKbNuS71g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61955903E;
	Mon, 25 Jun 2012 15:49:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDE5D903D; Mon, 25 Jun 2012
 15:49:54 -0400 (EDT)
In-Reply-To: <CAA3EhHJbKj+nbVsZtijsH+h7sFcyeBwT9K=BTeqAuMzSH0RGmg@mail.gmail.com> (Leila's
 message of "Mon, 25 Jun 2012 15:14:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF9855C2-BEFE-11E1-9987-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200594>

Leila <muhtasib@gmail.com> writes:

>>  2. Make setup_revisions() expose got_rev_arg to its callers
>>    (e.g. move it to struct rev_info);
>
> Do you mean have got_rev_args be a wrapper of argc and argv?

No.  The setup_revisions() function knows if it saw a revision
argument from the command line, but currently uses got_rev_args
local variable, so the caller would not be able to tell.  I was
suggesting to use "struct rev_info *revs" that goes in and comes out
of the function to convey that information back to the caller.

But it turns out that it is not even needed.  Read on.

> Or is it just a mechanism to set a signal that the calling command is
> 'log', so that I can do something about it without checking argv[0]?

Didn't I already say not to switch on argv[0] in deeper side of the
callchain?

>>  3. If you did not pass HEAD in opt->def and setup_revisions() said
>>    it did not "got_rev_arg", give whatever error message that you
>>    think is more user friendly.
>>
>
> Sure, I can do this. Note: just to confirm the message/exit will still
> come from inside of setup_revisions()?

No.  I do not want any patch that butchers setup_revisions() with
any of this kind of UI issues.

Something like this, I think, would work.  After all, we already
have a way to expose the revs we got from the command line to the
caller.

The "bad HEAD and no revs..." part, if we choose not to even error
on this, can be removed.

Also other cmd_frotz() functions in the same file might want to use
the s/"HEAD"/default_to_head_if_exists()/ conversion.

 builtin/log.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4f1b42a..6ecf344 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -355,6 +355,15 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	return git_diff_ui_config(var, value, cb);
 }
 
+static const char *default_to_head_if_exists(void)
+{
+	unsigned char sha1[20];
+	if (resolve_ref_unsafe("HEAD", sha1, 1, NULL))
+		return "HEAD";
+	else
+		return NULL;
+}
+
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
@@ -553,8 +562,15 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
-	opt.def = "HEAD";
+	opt.def = default_to_head_if_exists();
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+
+	if (!opt.def && !rev.cmdline.nr) {
+		/*
+		 * bad HEAD and no revs on the command line
+		 */
+		warning("Nothing to show...");
+	}
 	return cmd_log_walk(&rev);
 }
 
