From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] notes remove: --stdin reads from the standard input
Date: Thu, 19 May 2011 10:55:38 -0700
Message-ID: <7vliy27exx.fsf@alter.siamese.dyndns.org>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
 <1305764061-21303-4-git-send-email-gitster@pobox.com>
 <20110519105009.GA11107@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 19:55:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7Rx-0004rh-1q
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab1ESRzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:55:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828Ab1ESRzp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:55:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FCEA5928;
	Thu, 19 May 2011 13:57:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WnEPukB2lUYy5OyVQtx90ilI9hM=; b=SK4ezD
	rKdJbThR5vzQKQWXwcR8VooAebK51aBhtPe7/K9TYTVYYLvJwVfdXvDj7PgyBq5P
	5GSVAr2mnIAKxHiZfHxpnVqY0zfhOqeoOKQHjkSLxuV0XMhNjPXdLNcwU4gDpD1H
	13VX72+i3/IcLGCIft6wwy6U4tYaKYpHchbEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bdo3f9lSHpYhA2XPgxo7kVqdbCDgpZFl
	s95qWshcpihwNKA+yuTIAftAP94473uRuY/yatzDaAeSwt7EqneAT+dMvwEIO8cI
	/xW1TUTP50vmNURhOvOU+ti0EgERL9qJ49DwrOihkC9SlAHGMqtz+jeO73rUr1cq
	aRpP+EgDwY0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DBE55927;
	Thu, 19 May 2011 13:57:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 086135923; Thu, 19 May 2011
 13:57:45 -0400 (EDT)
In-Reply-To: <20110519105009.GA11107@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 May 2011 06:50:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 824CE3A2-8241-11E0-91D5-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173982>

Jeff King <peff@peff.net> writes:

> On Wed, May 18, 2011 at 05:14:21PM -0700, Junio C Hamano wrote:
>
>> +	if (from_stdin) {
>> +		struct strbuf sb = STRBUF_INIT;
>> +		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
>> +			int len = sb.len;
>> +			if (len && sb.buf[len - 1] == '\n')
>> +				sb.buf[--len] = '\0';
>> +			retval |= remove_one_note(t, sb.buf, flag);
>> +		}
>> +	}
>
> Wouldn't strbuf_rtrim (or even strbuf_trim) be useful here?

Thanks for noticing.

I just mimicked what was done to the result of strbuf_getwholeline() in
other places (I think from revision.c but I am not sure).

An incremental correction, relative to what I had in 'pu' overnight, looks
like this.

 builtin/notes.c  |    5 ++---
 t/t3301-notes.sh |   26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 164d605..f8e437d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1000,11 +1000,10 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	if (from_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 		while (strbuf_getwholeline(&sb, stdin, '\n') != EOF) {
-			int len = sb.len;
-			if (len && sb.buf[len - 1] == '\n')
-				sb.buf[--len] = '\0';
+			strbuf_rtrim(&sb);
 			retval |= remove_one_note(t, sb.buf, flag);
 		}
+		strbuf_release(&sb);
 	}
 	if (!retval)
 		commit_notes(t, "Notes removed by 'git notes remove'");
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index e1b5619..16de05a 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -478,13 +478,14 @@ test_expect_success 'removing with --ignore-missing but bogus ref' '
 test_expect_success 'remove reads from --stdin' '
 	before=$(git rev-parse --verify refs/notes/commits) &&
 	test_when_finished "git update-ref refs/notes/commits $before" &&
+
+	# We have only two -- add another and make sure it stays
+	git notes add -m "extra" &&
+	git notes list HEAD >after-removal-expect &&
 	git rev-parse HEAD^^ HEAD^^^ >input &&
 	git notes remove --stdin <input &&
-	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
-	test 2 = $(wc -l <actual) &&
-	git ls-tree -r --name-only refs/notes/commits >actual &&
-	>empty &&
-	test_cmp empty actual
+	git notes list | sed -e "s/ .*//" >actual &&
+	test_cmp after-removal-expect actual
 '
 
 test_expect_success 'remove --stdin is also atomic' '
@@ -496,16 +497,17 @@ test_expect_success 'remove --stdin is also atomic' '
 	test "$before" = "$after"
 '
 
-test_expect_success 'removing with --stdin --missing-ok' '
+test_expect_success 'removing with --stdin --ignore-missing' '
 	before=$(git rev-parse --verify refs/notes/commits) &&
 	test_when_finished "git update-ref refs/notes/commits $before" &&
+
+	# We have only two -- add another and make sure it stays
+	git notes add -m "extra" &&
+	git notes list HEAD >after-removal-expect &&
 	git rev-parse HEAD^^ HEAD^^^ HEAD^ >input &&
-	git notes remove --missing-ok --stdin <input &&
-	git diff --name-only refs/notes/commits^ refs/notes/commits >actual &&
-	test 2 = $(wc -l <actual) &&
-	git ls-tree -r --name-only refs/notes/commits >actual &&
-	>empty &&
-	test_cmp empty actual
+	git notes remove --ignore-missing --stdin <input &&
+	git notes list | sed -e "s/ .*//" >actual &&
+	test_cmp after-removal-expect actual
 '
 
 test_expect_success 'list notes with "git notes list"' '
