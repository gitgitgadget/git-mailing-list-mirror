From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add the tag.gpgsign option to sign annotated tags
Date: Mon, 21 Mar 2016 14:26:23 -0700
Message-ID: <xmqqa8lrldz4.fsf@gitster.mtv.corp.google.com>
References: <20160319182310.GA23124@spk-laptop>
	<20160320042912.GD18312@sigill.intra.peff.net>
	<20160320150703.GB5139@spk-laptop>
	<xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
	<20160321192904.GC20083@spk-laptop>
	<xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
	<20160321205015.GF20083@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:26:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7LM-0007sP-2R
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbcCUV01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:26:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750838AbcCUV00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:26:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23DE64E883;
	Mon, 21 Mar 2016 17:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S7Zz0ny3lO+MvyOFd6gA8jsE1io=; b=XNU26W
	r/V57BADpp7isEcoL1bhNonrk1D6IlmsGKRrN5gzPe9iQpmqRwC9W/g6rrNhWDyT
	Xh3j870OB4xzzwXq+mlnmN71P8h3KS9mpPpruwgMclqAEtAn9TcBmtPLQPHava0/
	PHszizXw33jwzFAnWpCREZk4vST7Owbn4vu2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dyimR1X8NJibboCDnXY3qjZNLjjsZSvZ
	OcAXtsfhoyIC4mp3n80UH/hN7lxudowv0z0mjlsGoJARJH1OKnbehvkC6sNYRHtL
	5QOqQ//Q6b/JBtylx1QVftShVIXJFEm6xqouhhtIFi5CVAqoyT+6vAgbjPBQefIj
	NkUZY/CZesE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 197FD4E882;
	Mon, 21 Mar 2016 17:26:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 897524E881;
	Mon, 21 Mar 2016 17:26:24 -0400 (EDT)
In-Reply-To: <20160321205015.GF20083@spk-laptop> (Laurent Arnoud's message of
	"Mon, 21 Mar 2016 21:50:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9066AC2A-EFAB-11E5-899C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289465>

Laurent Arnoud <laurent@spkdev.net> writes:

> @@ -326,7 +332,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int create_reflog = 0;
> -	int annotate = 0, force = 0;
> +	int annotate = -1, force = 0;

I really do not like this part of the change.  The original code is
already bad in the sense that it uses "annotate" to mean "we need to
create a tag object, not just a lightweight tag" in some places
which already needs careful reading, but with this it no longer is
clear what this argument even means.  It sometimes means "we are
creating a tag object" and some other times means "we did not see
'-a' on the command line" but only until the variable gets assigned
by existing "if opt.sign is there, set it to true" tweaking.

I wonder if an approach like the following would result in a cleaner
code that is easier to maintain:

 - Leave this to be initialized to 0, allow it to be toggled upon
   seeing "-a" via the parse_options() mechanism, but redefine its
   meaning to be "-a option was passed".  Make it never be touched
   by anything else (e.g. "if (opt.sign) annotate = 1;" is wrong).

 - Introduce a new "create_tag_object" variable, initialized to 0.
   Existing code that sets "annotate = 1" (e.g. "-s" is passed,
   "-m/-F" is passed, etc.) will instead set this variable.  The
   condition of if() statement to call create_tag() would also be
   looking at this variable, not "annotate".

 - Before calling create_tag(), look at the value of your new
   configuration and "annotate", and set opt.sign as needed.

A patch to do so might look something like this (totally untested).


 builtin/tag.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..d262f92 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static unsigned int colopts;
+static int force_sign_annotate;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
@@ -168,6 +169,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 		return status;
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
+	if (!strcmp(var, "tag.forcesignannotated")) {
+		force_sign_annotate = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
 
@@ -327,7 +332,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	char *cleanup_arg = NULL;
 	int create_reflog = 0;
 	int annotate = 0, force = 0;
-	int cmdmode = 0;
+	int cmdmode = 0, create_tag_object = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct ref_transaction *transaction;
@@ -385,12 +390,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	if (opt.sign)
-		annotate = 1;
+	if (opt.sign || annotate)
+		create_tag_object = 1;
 	if (argc == 0 && !cmdmode)
 		cmdmode = 'l';
 
-	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
+	if ((create_tag_object || msg.given || msgfile || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
 	finalize_colopts(&colopts, -1);
@@ -431,7 +436,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
 			die(_("only one -F or -m option is allowed."));
-		annotate = 1;
+		create_tag_object = 1;
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
 		else {
@@ -474,8 +479,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
-	if (annotate)
+	if (create_tag_object) {
+		if (force_sign_annotate && !annotate)
+			opt.sign = 1;
 		create_tag(object, tag, &buf, &opt, prev, object);
+	}
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
