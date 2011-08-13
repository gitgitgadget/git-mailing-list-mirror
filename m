From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: t5800-*.sh: Intermittent test failures
Date: Sat, 13 Aug 2011 21:51:16 +0100
Message-ID: <4E46E3C4.7020608@ramsay1.demon.co.uk>
References: <4E417CB4.50007@ramsay1.demon.co.uk> <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 23:56:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsMBW-0006ko-0k
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 23:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1HMVwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 17:52:15 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:34384 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752333Ab1HMVwO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 17:52:14 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QsM7o-0006Jg-ku; Sat, 13 Aug 2011 21:52:13 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CAGdFq_jv_T-x7VGqm_j-fDfeW6TsBG95=1TWn91Yk9B3TGZdsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179298>

Sverre Rabbelier wrote:
>> I haven't looked to see how the git(fast-export)/git-fast-import processes are
>> plumbed together, but there seems to be a synchronization problem somewhere ...
> 
> This seems odd, before the fast-export process is even started it's
> stdout are wired to the stdin of the helper (and thus the fast-import
> process). What indication do you have that fast-import hasn't started
> and that fast-export has finished?

I indulged in a spot of "printf debugging". ;-)  see more below.

> Also, you say git remote-test everywhere, but it should be git
> remote-testgit, typo?

Yep. [It was actually caused by a cut/paste/edit of pstree output (pstree
truncates long fields); not that you could guess that! ;-P ]

So ...

I added some additional debug code to transport-helper.c (see below) in
addition to creating debug output files from the git-fast-import/export
commands. (I won't show the code for this debug output; it wouldn't be
hard to imagine! :-)

In addition to the uninteresting "printf debugging" info, I used
gettimeofday() to show the start and end times for the git(fast-export)
process and the start time for git-fast-import. The last hunk below,
for instance, shows the code to output the git(fast-export) end time ...

--- >8 ----
diff --git a/transport-helper.c b/transport-helper.c
index 74c3122..7c9d881 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -132,6 +132,8 @@ static struct child_process *get_helper(struct transport *transport)
 	snprintf(git_dir_buf, sizeof(git_dir_buf), "%s=%s", GIT_DIR_ENVIRONMENT, get_git_dir());
 	helper->env = helper_env;
 
+	if (debug)
+		fprintf(stderr, "Debug: start remote helper: <%s>\n", helper->argv[0]);
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die("Unable to find remote helper for '%s'", data->name);
@@ -376,6 +378,8 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	fastimport->argv[1] = "--quiet";
 
 	fastimport->git_cmd = 1;
+	if (debug)
+		fprintf(stderr, "Debug: get_importer, start fast-import\n");
 	return start_command(fastimport);
 }
 
@@ -403,6 +407,8 @@ static int get_exporter(struct transport *transport,
 		fastexport->argv[argc++] = revlist_args->items[i].string;
 
 	fastexport->git_cmd = 1;
+	if (debug)
+		fprintf(stderr, "Debug: get_exporter, start fast-export\n");
 	return start_command(fastexport);
 }
 
@@ -756,6 +762,11 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+	if (debug) {
+		struct timeval tv;
+		gettimeofday(&tv, NULL);
+		fprintf(stderr, "fast-export finished @ %lds %ldus\n", tv.tv_sec, tv.tv_usec);
+	}
 	push_update_refs_status(data, remote_refs);
 	return 0;
 }
--- >8 ----

The debug output from "./t5800-remote-helpers.sh -v" ends like this:

... [snipped]
Debug: Capabilities complete.
Debug: Remote helper: Waiting...
Got command 'list' with args ''
? refs/heads/new
? refs/heads/master
@refs/heads/master HEAD
Debug: Remote helper: <- ? refs/heads/new
Debug: Remote helper: Waiting...
Debug: Remote helper: <- ? refs/heads/master
Debug: Remote helper: Waiting...
Debug: Remote helper: <- @refs/heads/master HEAD
Debug: Remote helper: Waiting...
Debug: Remote helper: <- 
Debug: Read ref listing.
Debug: Remote helper: -> export
Debug: get_exporter, start fast-export
fast-export finished @ 1313178956s 366398us
Debug: Remote helper: Waiting...
Got command 'export' with args ''

The fast-export debug file looks like:

--- >8 ----
fast-export: pid = 11096 (ppid 11090)
started @ 1313178956s 364790us
arg: <fast-export>
arg: <--use-done-feature>
arg: <--export-marks=.git/info/fast-import/a08486a77c5cf1b4aa17fa9e64673e352ebe1a96/testgit.marks>
arg: <--import-marks=.git/info/fast-import/a08486a77c5cf1b4aa17fa9e64673e352ebe1a96/testgit.marks>
arg: <^refs/testgit/origin/master>
arg: <refs/heads/master>
----end args----: <>
handle object: <ab28ce7f215103f3f4bf70fd439541590dccc91b>
handle commit: <refs/heads/master>
main: <done!>
--- >8 ----

The fast-import debug file looks like:

--- >8 ----
fast-import: pid = 11104 (ppid = 11103)
started @ 1313178956s 382392us
main: <start-up>
main: <start-up #1>
main: <before loop>
--- >8 ----

Note that git(fast-export) executes in 1608 micro-seconds and finishes
15994 micro-seconds before git-fast-import starts.

ATB,
Ramsay Jones
