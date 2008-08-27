From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Tue, 26 Aug 2008 23:13:13 -0700
Message-ID: <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080822211902.GA31884@coredump.intra.peff.net>
 <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org>
 <20080827001944.GA7347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEIV-000648-Pw
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbYH0GNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYH0GNX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:13:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYH0GNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 02:13:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F04A69EE8;
	Wed, 27 Aug 2008 02:13:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 943AB69EE5; Wed, 27 Aug 2008 02:13:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F02A580-73FF-11DD-8D36-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93858>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2008 at 04:31:30PM -0700, Junio C Hamano wrote:
>
>> > This allows the use of author abbreviations when specifying commit
>> > authors via the --author option to git commit. "--author=$key" is
>> > resolved by looking up "user.$key.name" and "user.$key.email" in the
>> > config.
>> 
>> Maybe it is just me, but I am hesitant about the contamination of user.*
>> configuration namespace.  This patch as a general solution does not scale
>> well, once you start working with more than a few dozen people.
>
> It is not just you. I think this version of the patch is much improved,
> but I am still against user.$key.*. At the very least, it needs its own
> namespace.

It's not just that.  Having many of these in .git/config will slow down
any unrelated thing that needs to read from config.

I am not married to the "reuse existing information" idea, but doing it
the way this sample patch does at least makes only people who uses this
feature to pay the price and only when they use it.

Not extensively tested, beyond the usual test suite, and using it for real
only once to commit this with "git commit --author=Jeff".  I wanted to say
"Michael J" instead, but there is this little chicken-and-egg problem ;-)

 builtin-commit.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git c/builtin-commit.c w/builtin-commit.c
index 649c8be..8aae906 100644
--- c/builtin-commit.c
+++ w/builtin-commit.c
@@ -710,6 +710,30 @@ static int message_is_empty(struct strbuf *sb, int start)
 	return 1;
 }
 
+static const char *find_author_by_nickname(const char *name)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strbuf buf = STRBUF_INIT;
+	const char *av[20];
+	int ac = 0;
+
+	init_revisions(&revs, NULL);
+	strbuf_addf(&buf, "--author=%s", name);
+	av[++ac] = "--all";
+	av[++ac] = buf.buf;
+	av[++ac] = NULL;
+	setup_revisions(ac, av, &revs, NULL);
+	prepare_revision_walk(&revs);
+	commit = get_revision(&revs);
+	if (commit) {
+		strbuf_release(&buf);
+		format_commit_message(commit, "%an <%ae>", &buf);
+		return strbuf_detach(&buf, NULL);
+	}
+	die("No existing author found with '%s'", name);
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix)
@@ -720,6 +744,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	logfile = parse_options_fix_filename(prefix, logfile);
 	template_file = parse_options_fix_filename(prefix, template_file);
 
+	if (force_author && !strchr(force_author, '>'))
+		force_author = find_author_by_nickname(force_author);
+
 	if (logfile || message.len || use_message)
 		use_editor = 0;
 	if (edit_flag)
