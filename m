From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] grep: rip out pessimization to use fixmatch()
Date: Tue, 12 Jan 2010 22:51:24 -0800
Message-ID: <7vzl4its43.fsf_-_@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 07:51:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx4w-0008D5-0I
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab0AMGvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860Ab0AMGvi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:51:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34213 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab0AMGvh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:51:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5D7E90FAF;
	Wed, 13 Jan 2010 01:51:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nSF88iGTEGuTKAPiOsBzPkqlBN8=; b=bh5scD
	tGI28xGY9eFPzdCL098AYXTl72wdLJO++oI6fM0ACxC/c8dFjSDmuiu4L7G5JGFJ
	JfebGo9s/9Yy7/7bxzY+zeczapql7xN464LrIk48qdldwpvkVP/iUKYt52dK/5UB
	kj68lK15vm0p5Z1yRa3R1VIqQ/sQ85rsn1x0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o97xkPWs1Ht9wG1fqPDORh6fGoXTepUF
	2gVlco4+G61YWmeRFiqLOLhYUkdsdKcbpypcAdNG3qpSxJMXfujw6w6pQVLo0d5y
	NLXMue8ASHZAOehoB6oqmQxh5XwAPVDPHltbNZqGbs/bGMb7rJKDz5E9wO9hn+41
	pOXriAd8bx8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8304690FAB;
	Wed, 13 Jan 2010 01:51:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 748EE90FA2; Wed, 13 Jan
 2010 01:51:25 -0500 (EST)
In-Reply-To: <7v63774tfd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 12 Jan 2010 00\:29\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 14EEB6FA-0010-11DF-9B93-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136772>

Even when running without the -F (--fixed-strings) option, we checked the
pattern and used fixmatch() codepath when it does not contain any regex
magic.  Finding fixed strings with strstr() surely must be faster than
running the regular expression crud.

Not so.  It turns out that on some libc implementations, using the
regcomp()/regexec() pair is a lot faster than running strstr() and
strcasestr() the fixmatch() codepath uses.  Drop the optimization and use
the fixmatch() codepath only when the user explicitly asked for it with
the -F option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I first thought that this is somewhat questionable and we might want
 an option --[no-]fixed-string-optimization to control it, but there
 already is an option to do so with a shorter name, namely "-F".

 grep.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/grep.c b/grep.c
index 62723da..8e1f7de 100644
--- a/grep.c
+++ b/grep.c
@@ -29,13 +29,6 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
 	p->next = NULL;
 }
 
-static int is_fixed(const char *s)
-{
-	while (*s && !is_regex_special(*s))
-		s++;
-	return !*s;
-}
-
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
@@ -43,7 +36,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 
-	if (opt->fixed || is_fixed(p->pattern))
+	if (opt->fixed)
 		p->fixed = 1;
 	if (opt->regflags & REG_ICASE)
 		p->fixed = 0;
-- 
1.6.6.292.ge84ea.dirty
