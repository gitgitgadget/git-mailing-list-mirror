From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] parse-options: allow git commands to invent new option
 types
Date: Mon, 29 Nov 2010 21:08:53 -0600
Message-ID: <20101130030853.GD5326@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101130025223.GA5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 04:09:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGad-0003FI-L5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 04:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab0K3DJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 22:09:06 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:48969 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0K3DJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 22:09:04 -0500
Received: by vws15 with SMTP id 15so467384vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 19:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eFXKfkH2G49XSqrQMV6nFK1lziZObJ+LUot4DBp9Crk=;
        b=hOLs4jU+tenFna7nIXSMAw0vzDv3n4oOOb0pjKYQFsFENyVP9OMWga0bZ1i9O5cn6L
         JNUqznb2LZ9KFyNHyOGeKFRPm5cKbbIY2elGz41Nyl4rMjTSvO2jZ7i2R94wDetzsG2B
         ikonN2OooDWTXjgAFdeR5QcF0nCFL+jqrST4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MVkp7qL/oWOpnxbXM8gsmDhQ4HbNqrnpbj9KnlAcypmEhN7xa0nman3mbVbVbMjSQ8
         b0Duwtw6lcBQx30LwGQYDJxHP17i7En64h5dWrujo/kd2AVIo3e2VhCiZV9B+tcrt4if
         8Os9FmbzhoiLcEN0NrtDys4+e5oQRwA5RXIak=
Received: by 10.220.93.81 with SMTP id u17mr333348vcm.121.1291086543777;
        Mon, 29 Nov 2010 19:09:03 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id b26sm1860166vby.13.2010.11.29.19.09.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 19:09:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130025223.GA5326@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162466>

parse-options provides a variety of option behaviors, including
OPTION_CALLBACK, which should take care of just about any sane
behavior.  All supported behaviors obey the following constraint:

 A --foo option can only accept (and base its behavior on)
 one argument, which would be the following command-line
 argument in the "unsticked" form.

Alas, some existing git commands have options that do not obey that
constraint.  For example, update-index --cacheinfo takes three
arguments, and update-index --resolve takes all later parameters as
arguments.

Introduces an OPTION_LOWLEVEL_CALLBACK backdoor to parse-options so
such option types can be supported without tempting inventors of other
commands through mention in the public API.  Commands can set the
callback field to a function accepting three arguments: the option
parsing context, the option itself, and a flag indicating whether the
the option was negated.  When the option is encountered, that function
is called to take over from get_value().  The return value should be
zero for success, -1 for usage errors.

Thanks to Stephen Boyd for API guidance.

Improved-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from v1:

. lowlevel callbacks inherit standard get_value argument
  checking
. lowlevel callbacks cannot tailor error messages based on
  long vs short option
. OPT_UNSET and OPT_SHORT therefore do not need to be exposed
. brief mention in parse-options.h comments.

We can always tweak the API again later.  None of the examples in
update-index even pay attention to the "unset" bit.

 parse-options.c |    3 +++
 parse-options.h |    8 +++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index bc92d69..38c8fd3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -81,6 +81,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return opterror(opt, "takes no value", flags);
 
 	switch (opt->type) {
+	case OPTION_LOWLEVEL_CALLBACK:
+		return (*(parse_opt_ll_cb *)opt->callback)(p, opt, unset);
+
 	case OPTION_BIT:
 		if (unset)
 			*(int *)opt->value &= ~opt->defval;
diff --git a/parse-options.h b/parse-options.h
index d982f0f..bd0fe16 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -17,6 +17,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
 };
 
@@ -43,6 +44,10 @@ enum parse_opt_option_flags {
 struct option;
 typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
 
+struct parse_opt_ctx_t;
+typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int unset);
+
 /*
  * `type`::
  *   holds the type of the option, you must have an OPTION_END last in your
@@ -87,7 +92,8 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *				useful for users of OPTION_NEGBIT.
  *
  * `callback`::
- *   pointer to the callback to use for OPTION_CALLBACK.
+ *   pointer to the callback to use for OPTION_CALLBACK or
+ *   OPTION_LOWLEVEL_CALLBACK.
  *
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
-- 
1.7.2.3
