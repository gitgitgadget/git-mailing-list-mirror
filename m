From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 13:13:36 -0800
Message-ID: <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeavX-0008Cw-PS
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 22:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab0BHVNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 16:13:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHVNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 16:13:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33CA898DDB;
	Mon,  8 Feb 2010 16:13:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y1BHsinjyQAa77GsWTF3uywpOkU=; b=tocL8d
	C+i8FSSLVo3M9P2urwSw6eBfmuzO3/qvYWKJMHUBoN0COFxx6H3hj58zpLjpg9IX
	Y4czAly7gnE+mDOJMdhzVeyjBMNhu0hw8a2gQ8gY3+8HrS2NSxRMNHh75WFIwD1w
	pjHdCS1so4LUQLe91DNJTSCK2Ubb1adHf9DEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pFNunJirQg1kLGoZjZatIORG9boOxQP6
	Dj9pbU0k3ERKaXbs7IOMFxWBPQ2A2vJIw/soOERxzq3+mNKHDpibT0lm2WEjZAM4
	KGZqtNKfK7bemUMzzYHmYHTxwq1KXBexrMWi38Mwm/6Cb228+hs4+gtlLwUOrRhN
	+DRVOUbEwJo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B5B98DD6;
	Mon,  8 Feb 2010 16:13:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C72698DD5; Mon,  8 Feb
 2010 16:13:38 -0500 (EST)
In-Reply-To: <7vtytrih7b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 08 Feb 2010 12\:51\:52 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4E129D4-14F6-11DF-906D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139320>

I realize that I more-or-less repeated what I already said for the second
round, so let's try a different approach.

How about replacing the three patches with something like this?

-- >8 --
Subject: push --porcelain: usability updates

"git push --porcelain" is meant for Porcelain scripts to read from; there
is no reason to give advice messages meant for the user under that mode.

When reporting the update status, the name of the destination and
"Everything up-to-date" message were shown to the standard error stream,
but that is unfriendly when a Porcelain script is reading from us.  Send
them to the standard output to make it easier for them.

---
 builtin-push.c |    5 +++++
 transport.c    |    5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..f5082d8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -226,6 +226,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
+	if (flags & TRANSPORT_PUSH_PORCELAIN) {
+		/* Do not give advice messages to Porcelain scripts */
+		advice_push_nonfastforward = 0;
+	}
+
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die("--delete is incompatible with --all, --mirror and --tags");
 	if (deleterefs && argc < 2)
diff --git a/transport.c b/transport.c
index 3846aac..0492934 100644
--- a/transport.c
+++ b/transport.c
@@ -675,7 +675,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
 {
 	if (!count)
-		fprintf(stderr, "To %s\n", dest);
+		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);
 
 	switch(ref->status) {
 	case REF_STATUS_NONE:
@@ -1071,7 +1071,8 @@ int transport_push(struct transport *transport,
 		}
 
 		if (!quiet && !ret && !refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
+			fprintf(porcelain ? stdout : stderr,
+				"Everything up-to-date\n");
 		return ret;
 	}
 	return 1;
