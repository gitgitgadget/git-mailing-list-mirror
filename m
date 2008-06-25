From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Wed, 25 Jun 2008 14:24:04 -0700
Message-ID: <7vwskdxl6z.fsf_-_@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte>
 <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer>
 <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
 <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
 <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
 <7vd4m5z1f8.fsf@gitster.siamese.dyndns.org>
 <32541b130806251358n3ab6cfc8y7a90d898b9308e12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:25:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBcUW-0004VE-K4
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYFYVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYFYVY2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 17:24:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYFYVY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 17:24:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7F5D17C61;
	Wed, 25 Jun 2008 17:24:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2521D7BF2; Wed, 25 Jun 2008 17:24:08 -0400 (EDT)
In-Reply-To: <32541b130806251358n3ab6cfc8y7a90d898b9308e12@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 25 Jun 2008 16:58:09 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16A5992C-42FD-11DD-BB4C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86352>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 6/25/08, Junio C Hamano <gitster@pobox.com> wrote:
>> "Avery Pennarun" <apenwarr@gmail.com> writes:
>> >>   * You say "git checkout -- file" when you want to "check out the file
>>  >>    from the index";
>>  >
>>  > The real question here is the --.  Is it strictly needed?  It's
>>  > optional in things like git-diff, which just do their best to guess
>>  > what you mean if you don't use the --.
>>
>> No, I wrote -- only for clarity, because you can happen to have a branch
>>  whose name is the same as the file.  Otherwise you can safely omit it,
>>  just like git-diff and any other commands that follow the -- convention.
>
> Oops, I got mixed up.  Only git-reset requires the --.  Would it make
> sense to bring git-reset into line with everything else, then?

Ah, interesting.  It appears that the current "reset in C" inherited that
bug from the scripted version.  It works most of the time without --
except for one place.

	# prove that the work tree is clean...
	$ git reset --hard
	HEAD is now at 7b7f39e Fix use after free() in builtin-fetch
	$ git diff
        $ git diff --cached

	# what's different since HEAD^?
        $ git diff --name-only HEAD^
        builtin-fetch.c

        # reset the path
        $ git reset HEAD^ builtin-fetch.c
	builtin-fetch.c: needs update

	# prove that HEAD did not move
	$ git rev-parse HEAD
	7b7f39eae6ab0bbcc68d3c42a5b23595880e528f
	# prove that work tree did not change
        $ git diff HEAD
        # prove that index has old version
	$ git diff --cached HEAD^

Reset is about resetting the index and --hard option tells it to propagate
the change down to the work tree as well.

There is no "reset to the index", so "reset -- path" would be a redundant
way to spell "reset HEAD path" or "reset HEAD -- path" which is even more
redundant.

As long as builti-fetch.c is not a valid ref, you should be able to get
out of the above mess by any one of:

	$ git reset builtin-fetch.c
        $ git reset -- builtin-fetch.c
        $ git reset HEAD builtin-fetch.c

but the first one complains, saying builtin-fetch.c is not a valid ref.

This may help.

diff --git a/builtin-reset.c b/builtin-reset.c
index f34acb1..c7d60f5 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -194,9 +194,21 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
-	if (i < argc && strcmp(argv[i], "--"))
-		rev = argv[i++];
-
+	/*
+	 * Possible arguments are:
+	 *
+	 * git reset <rev> <paths>...
+	 * git reset <rev> -- <paths>...
+	 * git reset -- <paths>...
+	 * git reset <paths>...
+	 */
+	if (i < argc && strcmp(argv[i], "--")) {
+		/* could be "git reset <path>" */
+		if (get_sha1(argv[i+1], sha1))
+			;
+		else
+			rev = argv[i++];
+	}
 	if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
 
