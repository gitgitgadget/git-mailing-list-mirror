From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
Date: Thu, 31 Jan 2008 13:51:13 -0800
Message-ID: <7vr6fxbr5a.fsf@gitster.siamese.dyndns.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>
	<47A06EF9.60704@users.sourceforge.net>
	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
	<47A1733E.9040103@users.sourceforge.net>
	<7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>
	<7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>
	<20080131094124.GA25546@coredump.intra.peff.net>
	<7vfxwecmfe.fsf@gitster.siamese.dyndns.org>
	<20080131104256.GF25546@coredump.intra.peff.net>
	<alpine.LSU.1.00.0801311128190.23907@racer.site>
	<6bc632150801310356w1b2fa019n87d92986aed807c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Adam Piatyszek" <ediap@users.sourceforge.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "pradeep singh rautela" <rautelap@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 22:52:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKhKH-0003bM-Bn
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 22:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759231AbYAaVvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 16:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758734AbYAaVvc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 16:51:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759231AbYAaVvb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 16:51:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C8B592BEA;
	Thu, 31 Jan 2008 16:51:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E54F2BE5;
	Thu, 31 Jan 2008 16:51:20 -0500 (EST)
In-Reply-To: <6bc632150801310356w1b2fa019n87d92986aed807c5@mail.gmail.com>
	(pradeep singh rautela's message of "Thu, 31 Jan 2008 17:26:18 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72137>

"pradeep singh rautela" <rautelap@gmail.com> writes:

> How about something like,
>                   warning("Ignoring ignore entry because of trailing
> slash: %s\n Remove the trailing slash from the directory name to
> ignore it", string);
> May be this will help absolute git newbies.

I am afraid that this is leading us in the wrong direction.

What would be the first reaction if somebody sees such a
message?

    The message implies that the user said "foo/" which would be
    ignored and the right substitution is "foo".  If that is the
    right substitution, why doesn't the stupid "git" program do
    that for the user automatically?!?!?!?!

See?

"Remove the trailing" suggestion assumes that we would want "foo/"
and "foo" to mean the same thing.

Maybe we do, but we usually match both directory "foo/" and
regular file "foo" when you say "foo", and we match only
directory "foo/" when you say "foo/", as you saw in the ls-files
example.

While I am not 100% convinced that we want to keep the
distinction between these two forms, I am far from thinking that
the existing distinction in other parts of the system is useless
and should be removed.

Maybe we would want to drop this distinction in the gitignore
entries, and the apparent inconsistency may not hurt in reality.
If that is what we would want, that is fine, but then we
shouldn't give a warning with a stupid piece of advice, but
instead just do it ourselves.

Like this on top of 'master' (i.e. discarding all the previous
patches), perhaps...

-- >8 --
[PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"

A pattern "foo/" in the exclude list did not match directory
"foo", but a pattern "foo" did.  This just strips the trailing
slash from such input.

This makes the behaviour slightly inconsistent with that of
pathspecs, where "foo/" only matches directory "foo" and not
regular file "foo" and make "foo/" in the ignore list match
regular file "foo" happily.  This may hopefully does not matter
in practice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitignore.txt        |    3 +++
 dir.c                              |   22 ++++++++++++++++++----
 t/t3001-ls-files-others-exclude.sh |   26 ++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 08373f5..081a4df 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -57,6 +57,9 @@ Patterns have the following format:
    included again.  If a negated pattern matches, this will
    override lower precedence patterns sources.
 
+ - If the pattern ends with a slash, it is removed for the
+   purpose of the following description.
+
  - If the pattern does not contain a slash '/', git treats it as
    a shell glob pattern and checks for a match against the
    pathname without leading directories.
diff --git a/dir.c b/dir.c
index 3e345c2..fe51829 100644
--- a/dir.c
+++ b/dir.c
@@ -126,14 +126,28 @@ static int no_wildcard(const char *string)
 void add_exclude(const char *string, const char *base,
 		 int baselen, struct exclude_list *which)
 {
-	struct exclude *x = xmalloc(sizeof (*x));
+	struct exclude *x;
+	size_t len;
+	int to_exclude = 1;
 
-	x->to_exclude = 1;
 	if (*string == '!') {
-		x->to_exclude = 0;
+		to_exclude = 0;
 		string++;
 	}
-	x->pattern = string;
+	len = strlen(string);
+	if (len && string[len - 1] == '/') {
+		char *s;
+		x = xmalloc(sizeof(*x) + len);
+		s = (char*)(x+1);
+		memcpy(s, string, len - 1);
+		s[len - 1] = '\0';
+		string = s;
+		x->pattern = s;
+	} else {
+		x = xmalloc(sizeof(*x));
+		x->pattern = string;
+	}
+	x->to_exclude = to_exclude;
 	x->patternlen = strlen(string);
 	x->base = base;
 	x->baselen = baselen;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index e25b255..5bc4885 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -99,4 +99,30 @@ EOF
 test_expect_success 'git-status honours core.excludesfile' \
 	'diff -u expect output'
 
+test_expect_success 'trailing slash in exclude allows directory match(1)' '
+
+	git ls-files --others --exclude=one/ >output &&
+	if grep "^one/" output
+	then
+		echo Ooops
+		false
+	else
+		: happy
+	fi
+
+'
+
+test_expect_success 'trailing slash in exclude allows directory match (2)' '
+
+	git ls-files --others --exclude=one/two/ >output &&
+	if grep "^one/two/" output
+	then
+		echo Ooops
+		false
+	else
+		: happy
+	fi
+
+'
+
 test_done
-- 
1.5.4.rc5.16.gc0279
