From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] import memmem() with linear complexity from Gnulib
Date: Sun, 01 Mar 2009 12:15:01 +0100
Message-ID: <49AA6E35.40205@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7vmyc6foj3.fsf@gitster.siamese.dyndns.org> <1235848615.7043.30.camel@ubuntu.ubuntu-domain> <20090228224401.GA27262@glandium.org> <20090301034123.GC30384@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 12:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldjez-0006cw-28
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 12:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbZCALPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 06:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZCALPM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 06:15:12 -0500
Received: from india601.server4you.de ([85.25.151.105]:54622 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbZCALPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 06:15:10 -0500
Received: from [10.0.1.101] (p57B7F2B0.dip.t-dialin.net [87.183.242.176])
	by india601.server4you.de (Postfix) with ESMTPSA id EED002F8037;
	Sun,  1 Mar 2009 12:15:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090301034123.GC30384@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111838>

Jeff King schrieb:
> On Sat, Feb 28, 2009 at 11:44:01PM +0100, Mike Hommey wrote:
> 
>>> ---
>>>  Makefile             |    1 +
>>>  compat/memmem.c      |  103 +++++++++----
>>>  compat/str-two-way.h |  429 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 504 insertions(+), 29 deletions(-)
>> Seeing how much memmem is being used in the codebase, is it really worth?
> 
> See earlier in the thread, where "git log -Stoken" is substantially
> faster on Linux versus Windows (but some exact numbers before and after
> on Windows would be nice to have in the commit message).

Yes, and also please see the other numbers I just posted.  It's more of
an update -- we took the current memmem() fall-back from glibc, too, and
they switched to this shiny new implementation to avoid the quadratic
complexity of the old one in the meantime.

I was going to say that with a fast memmem() we could convert some
strstr() calls, especially those where we know the lengths of the
strings anyway -- intuitively, memmem() should be faster than strstr()
in that case.  However, the following patch on top of the Gnulib import
makes "git grep grep v1.6.1" take 10% *more* time for me (on Windows).
I wonder why.


diff --git a/grep.c b/grep.c
index 062b2b6..66ef171 100644
--- a/grep.c
+++ b/grep.c
@@ -39,6 +39,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
 
+	p->pattern_len = strlen(p->pattern);
+
 	if (opt->fixed || is_fixed(p->pattern))
 		p->fixed = 1;
 	if (opt->regflags & REG_ICASE)
@@ -268,16 +270,17 @@ static void show_name(struct grep_opt *opt, const char *name)
 	printf("%s%c", name, opt->null_following_name ? '\0' : '\n');
 }
 
-static int fixmatch(const char *pattern, char *line, regmatch_t *match)
+static int fixmatch(const char *pattern, size_t pattern_len, const char *bol,
+		    const char *eol, regmatch_t *match)
 {
-	char *hit = strstr(line, pattern);
+	char *hit = memmem(bol, eol - bol, pattern, pattern_len);
 	if (!hit) {
 		match->rm_so = match->rm_eo = -1;
 		return REG_NOMATCH;
 	}
 	else {
-		match->rm_so = hit - line;
-		match->rm_eo = match->rm_so + strlen(pattern);
+		match->rm_so = hit - bol;
+		match->rm_eo = match->rm_so + pattern_len;
 		return 0;
 	}
 }
@@ -335,7 +338,7 @@ static int match_one_pattern(struct grep_opt *opt, struct grep_pat *p, char *bol
 			       pmatch, 0);
 	}
 	else {
-		hit = !fixmatch(p->pattern, bol, pmatch);
+		hit = !fixmatch(p->pattern, p->pattern_len, bol, eol, pmatch);
 	}
 
 	if (hit && opt->word_regexp) {
diff --git a/grep.h b/grep.h
index 5102ce3..2e22ab2 100644
--- a/grep.h
+++ b/grep.h
@@ -28,6 +28,7 @@ struct grep_pat {
 	int no;
 	enum grep_pat_token token;
 	const char *pattern;
+	size_t pattern_len;
 	enum grep_header_field field;
 	regex_t regexp;
 	unsigned fixed:1;
