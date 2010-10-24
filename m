From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] branch -h: show usage even in an invalid repository
Date: Sun, 24 Oct 2010 02:20:32 -0500
Message-ID: <20101024072032.GA23455@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 09:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9ux6-0001mB-5z
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 09:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab0JXHY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 03:24:28 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37893 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab0JXHY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 03:24:27 -0400
Received: by ywk9 with SMTP id 9so1551692ywk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aVQ5rPsMjv3KA3huEj8OEzBxYOYPvQFglgiAdUR6xIw=;
        b=Ktv5Vpsfk8vpta+rXEb56kF5E1Nr5ZJ4Z6DK3Op2qsMMmA/qvLHkO1RLtZFWAyjZgf
         ig5EQd2O3M0VPhg3yXvswZzFHvroagv8pdeL1Yv7n3WqEAmzYJgmL84rKIbEbbIMmZso
         LA0luxGVQVYASMLUsn054SvsTCHXNPNK7jI24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZBmxcO+x8C2msVRNtMk6VJ4osJraBbw93tqmr1qNUU5jm5FX+P2G8TSvahCfSfwcRw
         j3Us3gmCZq9UMiumCXEc3F6M0JLqWWapynLwEdSf/nqTu73WJFfgycLSQKOM4btYe+pN
         0Mzk6qbDgCGf38i8bPafvbpIn+Vu2RbWd8uUY=
Received: by 10.151.79.2 with SMTP id g2mr10075922ybl.84.1287905067139;
        Sun, 24 Oct 2010 00:24:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q4sm1555198yba.2.2010.10.24.00.24.25
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 00:24:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159837>

Junio C Hamano wrote:

>  - Some tests redirect both the standard output and the standard error
>    (like this patch) and check the combined result, while some others
>    (e.g. 2/7) check only the standard error stream.  Don't we want to be
>    testing them more uniformly?

Good point.  The current state is:

 - Messages from a mistake in usage are reported to stderr.
 - Messages from git <command> -h are reported to stdout or
   stderr, with a slight preference for stdout.

A nicer behavior would be

 - Messages from a mistake in usage are reported to stderr.
 - Messages from git <command> -h are reported to stdout.

Here's a helper to make it easier for commands that use parse-options
to adopt that nicer behavior.  It writes its output to stdout, so it
should only be used to be used to handle the -h option.  Example:

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage_for_help_opt(builtin_foo_usage, options);

	... some scary commands that should not run with -h ...

	argc = parse_options(argc, ...
	if (argc != 1)
		usage_with_options(builtin_foo_usage, options);

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---

diff --git a/parse-options.c b/parse-options.c
index 0fa79bc..e92fcfe 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -567,6 +567,13 @@ void usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void usage_for_help_opt(const char * const *usagestr,
+			const struct option *opts)
+{
+	usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+	exit(129);
+}
+
 void usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git a/parse-options.h b/parse-options.h
index d982f0f..de69826 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -152,6 +152,9 @@ extern int parse_options(int argc, const char **argv, const char *prefix,
 extern NORETURN void usage_with_options(const char * const *usagestr,
                                         const struct option *options);
 
+extern NORETURN void usage_for_help_opt(const char * const *usagestr,
+                                        const struct option *options);
+
 extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
 				   const struct option *options);
