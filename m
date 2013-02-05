From: Jeff King <peff@peff.net>
Subject: Re: [WIP/RFH/RFD/PATCH] grep: allow to use textconv filters
Date: Tue, 5 Feb 2013 15:11:06 -0500
Message-ID: <20130205201106.GA29248@sigill.intra.peff.net>
References: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net>
 <20130205111353.GD24973@sigill.intra.peff.net>
 <5111317E.8060906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2orc-0008Re-GO
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab3BEULK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:11:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35040 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689Ab3BEULI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:11:08 -0500
Received: (qmail 31861 invoked by uid 107); 5 Feb 2013 20:12:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 15:12:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 15:11:06 -0500
Content-Disposition: inline
In-Reply-To: <5111317E.8060906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215532>

On Tue, Feb 05, 2013 at 05:21:18PM +0100, Michael J Gruber wrote:

> Thanks Jeff, that helps a lot! It covers "grep expr" and "grep expr rev
> -- path" just fine. I'll look into "grep expr rev:path" which does not
> work yet because of an empty driver.
> 
> I also have "show --textconv" covered and a suggestion for "cat-file
> --textconv" (to work without a textconv filter).
> 
> Expect a mini-series soon :)

Cool, I'm glad it helped. It would be great if diff_filespec and
grep_source could grow together into a unified object. One of the gross
things about the patch I posted is that we will now sometimes read the
file/blob data via grep_source_load, and sometimes via
diff_populate_filespec. They _should_ be equivalent, but in an ideal
world, they would be the same code path.

That may be too much to tackle for your series, though (I wanted to do
it when I factored out grep_source, but backed off for the same reason).

The "grep expr rev:path" fix should look something like this:

diff --git a/builtin/grep.c b/builtin/grep.c
index 915c8ef..cdc7d32 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -820,13 +820,17 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
+		struct object_context oc;
 		/* Is it a rev? */
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1_with_context(arg, sha1, &oc)) {
 			struct object *object = parse_object(sha1);
 			if (!object)
 				die(_("bad object %s"), arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
+			/* oops, we need something that will remember oc.path
+			 * here, so that we can pass it along to
+			 * grep_source_init  */
 			add_object_array(object, arg, &list);
 			continue;
 		}

But you'll have to replace the object_array with something more
featureful, I think.

-Peff
