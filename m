From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Mon, 11 Nov 2013 22:29:25 +0100
Message-ID: <52814C35.6040205@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de> <loom.20131111T214646-550@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ari Pollak <ari@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 22:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfz35-0000ml-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492Ab3KKV32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:29:28 -0500
Received: from mout.web.de ([212.227.15.4]:56191 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab3KKV30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:29:26 -0500
Received: from [192.168.178.41] ([91.3.132.224]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Ma2Pz-1W14yA1d31-00LnAA for <git@vger.kernel.org>;
 Mon, 11 Nov 2013 22:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <loom.20131111T214646-550@post.gmane.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:qOH+qbd86N0vTWcXU/rFsVQLXnk3bVTtT19nB2441+Uwg2HEldj
 0hjVTlyGt/NmDnwq6AWcd30YG27HN3f+3ww4XS81BdU5wPlLUa7FBzwWxQxgf09o+IoQCYs
 58IgI2JnPKdoMUAmtG4NrAq3ub+j4NQCrLkwSRnham2FrKoAI1U64BhM22JoOuroD5pc+JZ
 tqDSACnFm8ErCnNWLTyAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237659>

Am 11.11.2013 21:48, schrieb Ari Pollak:
> Jens Lehmann writes:
>> And after adding a modified file the log message also shows the diff of
>> that file (and without leading "# "s too), so I doubt that diffs aren't
>> normally included in the commit message with -v. What am I missing?
> 
> Ah, it is true that -v normally does not prefix the diffs with #, but there 
> must be some filter in place after I save & quit my editor when a normal file 
> diff is present, since that does not get included in the final commit 
> message. But the submodule log does get included, which does not seem 
> intentional.

Ok, now this makes sense. "git commit" strips off the diff added by
-v by skipping everything starting with "\ndiff --git ". But that
logic fails when the "diff.submodule = log" setting adds a shortlog
instead of a regular diff, as that starts with "\nSubmodule ".

The diff below fixes the problem you describe for me. (But I do not
consider it a worthwhile fix in its current form because a line
starting with "Submodule " might appear in a perfectly normal commit
message, while "diff --git " most probably won't).

And while testing this issue I noticed another problem: When using
"git commit -a" not only the staged commits of a submodule get
committed, but also the unstaged commits. Will look into that too.

-------------------------8<---------------------
diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..ff6e171 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1600,11 +1600,14 @@ int cmd_commit(int argc, const char **argv, const char *
                die(_("could not read commit message: %s"), strerror(saved_errno
        }

-       /* Truncate the message just before the diff, if any. */
+       /* Truncate the message just before the diff or submodule shortlog */
        if (verbose) {
                p = strstr(sb.buf, "\ndiff --git ");
                if (p != NULL)
                        strbuf_setlen(&sb, p - sb.buf + 1);
+               p = strstr(sb.buf, "\nSubmodule ");
+               if (p != NULL)
+                       strbuf_setlen(&sb, p - sb.buf + 1);
        }

        if (cleanup_mode != CLEANUP_NONE)
