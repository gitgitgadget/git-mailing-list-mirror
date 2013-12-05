From: Jeff King <peff@peff.net>
Subject: Re: [BUG] redundant error message
Date: Thu, 5 Dec 2013 16:28:51 -0500
Message-ID: <20131205212851.GA21776@sigill.intra.peff.net>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
 <20131205191518.GB19039@sigill.intra.peff.net>
 <xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
 <20131205200306.GA13443@sigill.intra.peff.net>
 <xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
 <20131205210000.GA19617@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 22:28:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VogTi-0005r5-GY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 22:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab3LEV2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 16:28:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:51217 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751276Ab3LEV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 16:28:54 -0500
Received: (qmail 3268 invoked by uid 102); 5 Dec 2013 21:28:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 15:28:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 16:28:51 -0500
Content-Disposition: inline
In-Reply-To: <20131205210000.GA19617@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238912>

On Thu, Dec 05, 2013 at 04:00:00PM -0500, Jeff King wrote:

> Yes, I do expect an error. But it should not be "-- after filename". It
> should be "foobar is not a revision".
> [...]
> It would be nice to get the error messages right, though. I do not see
> any reason why it could not follow the same steps as "git log",
> converting revisions (or throwing an error as appropriate) on the left
> side of the "--", and passing through the right side untouched.

IOW, the patch below, which is the same strategy that setup_revisions
uses:

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c76b89d..845eab9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -476,6 +476,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	int has_dashdash = 0;
 	int output_prefix = 0;
 	unsigned char sha1[20];
 	const char *name = NULL;
@@ -489,6 +490,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_dashdash = 1;
+			break;
+		}
+	}
+
 	prefix = setup_git_directory();
 	git_config(git_default_config, NULL);
 	for (i = 1; i < argc; i++) {
@@ -765,6 +774,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 		if (verify)
 			die_no_single_rev(quiet);
+		if (has_dashdash)
+			die("bad revision '%s'", arg);
 		as_is = 1;
 		if (!show_file(arg, output_prefix))
 			continue;


BTW, the raw looping to find "--" made me wonder how we handle:

  git log --grep -- HEAD

I'd expect it to be equivalent to:

  git log --grep=-- HEAD

but it's not; we truncate the arguments and complain that --grep is
missing its argument. Which is probably good enough, given that the
alternative is doing a pass that understands all of the options. But it
does mean that the "--long-opt=arg" form is safer than the split form if
you are passing along an arbitrary "arg".

-Peff
