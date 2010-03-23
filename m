From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v6] Improve remote-helpers documentation
Date: Tue, 23 Mar 2010 13:15:19 +0530
Message-ID: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 08:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtyoJ-00053S-Pb
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 08:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab0CWHpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 03:45:41 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:44922 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab0CWHpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 03:45:40 -0400
Received: by ywh2 with SMTP id 2so2227326ywh.33
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type;
        bh=D3O5cxMg2ByYkDER4OxSHRzHyM5FzkthwaMh8Q2gfsE=;
        b=BQ+2Mg21iKpjwF1bzYcmKG5qEv4TPHXH76PV9J1xFAwm+YjEoyoaNQ/1EQl4ZVHZQW
         4tgdM7Wgu/Oka46ML6vCeffp/F8FWyRdOBdSa2vqhGqheki886rLz3cdTYfhkU4+as2Z
         Dc/EwM6TWe2Md0EVEQyw8kYiLvjGFdnoTBH64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=v/y40zjpMUOw82KSxD9mUcDpyUwAeEsNJ2KLySNfiNwecpou5bNezOxGa0p6LGVBEn
         jpxnGrWa+eVBUrmOcJ7pxtwiZCx+txiVXfphr4ID0MG4g99ln3IchlQV0K6yfjak2kVa
         hhaec7t5OTvPRAU1g4PYDmvRHtSaUVrSPG7s0=
Received: by 10.91.32.1 with SMTP id k1mr3246397agj.8.1269330339340; Tue, 23 
	Mar 2010 00:45:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142992>

Rewrote the description section to describe what exactly remote
helpers are and the need for them. Mentioned the curl family of remote
helpers as an example. Fixed minor typos in the rest of the document.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
    Complete rewrite since last revision, inspired by Junio's detailed review.

 Documentation/git-remote-helpers.txt |   89 ++++++++++++++++++++--------------
 1 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..2382fb4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

 NAME
 ----
-git-remote-helpers - Helper programs for interoperation with remote git
+git-remote-helpers - Helper programs to interact with remote repositories

 SYNOPSIS
 --------
@@ -12,11 +12,31 @@ SYNOPSIS
 DESCRIPTION
 -----------

-These programs are normally not used directly by end users, but are
-invoked by various git programs that interact with remote repositories
-when the repository they would operate on will be accessed using
-transport code not linked into the main git binary. Various particular
-helper programs will behave as documented here.
+Remote helper programs are normally not used directly by end users,
+but are invoked by git when it needs to interact with remote
+repositories. They implement a subset of the capabilities documented
+here, and conform to the "remote helper protocol". When git needs
+needs to interact with a repository served by a remote helper, it
+spawns the helper as an independent process and interacts with it over
+the specified protocol. Essentially, git sends commands to the helper
+over standard input, and receives the result written to standard
+output by the helper over a pipe. Also, since remote helpers often
+need to link to the libraries required to interact with the remote
+repository, they avoid linking to the main git programs to evade
+licensing issues.
+
+All the capabilities of remote helpers have to do with discovering and
+updating remote refs, transporting objects between local and remote,
+and updating the local object store. Using the 'fetch' capability,
+they can discover refs on the remote, transfer objects from the remote
+reachable via those refs to local, and update the local object
+store. Using the 'push' capability, they can transfer objects from
+local to remote, and update the corresponding refs as necessary.
+
+Git comes with a "curl" family of remote helpers, specifically
+'git-remote-http', 'git-remote-https', 'git-remote-ftp' and
+'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
+and 'push'.

 COMMANDS
 --------
@@ -25,8 +45,8 @@ Commands are given by the caller on the helper's
standard input, one per line.

 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line. Each capability may be preceded with '*'.
-	This marks them mandatory for git version using the remote
+	with a blank line. Each capability may be preceded with '*',
+	which marks them mandatory for git version using the remote
 	helper to understand (unknown mandatory capability is fatal
 	error).

@@ -35,27 +55,27 @@ Commands are given by the caller on the helper's
standard input, one per line.
 	[<attr> ...]". The value may be a hex sha1 hash, "@<dest>" for
 	a symref, or "?" to indicate that the helper could not get the
 	value of the ref. A space-separated list of attributes follows
-	the name; unrecognized attributes are ignored. After the
-	complete list, outputs a blank line.
+	the name; unrecognized attributes are ignored. The list ends
+	with a blank line.
 +
 If 'push' is supported this may be called as 'list for-push'
 to obtain the current refs prior to sending one or more 'push'
 commands to the helper.

 'option' <name> <value>::
-	Set the transport helper option <name> to <value>.  Outputs a
+	Sets the transport helper option <name> to <value>.  Outputs a
 	single line containing one of 'ok' (option successfully set),
 	'unsupported' (option not recognized) or 'error <msg>'
-	(option <name> is supported but <value> is not correct
+	(option <name> is supported but <value> is not valid
 	for it).  Options should be set before other commands,
-	and may how those commands behave.
+	and may influence the behavior of those commands.
 +
 Supported if the helper has the "option" capability.

 'fetch' <sha1> <name>::
 	Fetches the given object, writing the necessary objects
 	to the database.  Fetch commands are sent in a batch, one
-	per line, and the batch is terminated with a blank line.
+	per line, terminated with a blank line.
 	Outputs a single blank line when all fetch commands in the
 	same batch are complete. Only objects which were reported
 	in the ref list with a sha1 may be fetched this way.
@@ -67,7 +87,7 @@ suitably updated.
 Supported if the helper has the "fetch" capability.

 'push' +<src>:<dst>::
-	Pushes the given <src> commit or branch locally to the
+	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
 	one or more push commands is terminated with a blank line.
 +
@@ -91,6 +111,9 @@ Supported if the helper has the "push" capability.
 	by applying the refspecs from the "refspec" capability to the
 	name of the ref.
 +
+Especially useful for interoperability with a foreign versioning
+system.
++
 Supported if the helper has the "import" capability.

 'connect' <service>::
@@ -108,9 +131,9 @@ Supported if the helper has the "import" capability.
 Supported if the helper has the "connect" capability.

 If a fatal error occurs, the program writes the error message to
-stderr and exits. The caller should expect that a suitable error
-message has been printed if the child closes the connection without
-completing a valid response for the current command.
+stderr and exits. The caller should expect a suitable error
+if the child closes the connection without
+giving a valid response for the current command.

 Additional commands may be supported, as may be determined from
 capabilities reported by the helper.
@@ -119,16 +142,11 @@ CAPABILITIES
 ------------

 'fetch'::
-	This helper supports the 'fetch' command.
-
 'option'::
-	This helper supports the option command.
-
 'push'::
-	This helper supports the 'push' command.
-
 'import'::
-	This helper supports the 'import' command.
+'connect'::
+	This helper supports the corresponding command with the same name.

 'refspec' 'spec'::
 	When using the import command, expect the source ref to have
@@ -140,9 +158,6 @@ CAPABILITIES
 	all, it must cover all refs reported by the list command; if
 	it is not used, it is effectively "*:*"

-'connect'::
-	This helper supports the 'connect' command.
-
 REF LIST ATTRIBUTES
 -------------------

@@ -158,19 +173,19 @@ REF LIST ATTRIBUTES
 OPTIONS
 -------
 'option verbosity' <N>::
-	Change the level of messages displayed by the helper.
-	When N is 0 the end-user has asked the process to be
-	quiet, and the helper should produce only error output.
-	N of 1 is the default level of verbosity, higher values
+	Changes the verbosity of messages displayed by the helper.
+	A value of 0 for N means that processes operate
+	quietly, and the helper produces only error output.
+	1 is the default level of verbosity, and higher values
 	of N correspond to the number of -v flags passed on the
 	command line.

 'option progress' \{'true'|'false'\}::
-	Enable (or disable) progress messages displayed by the
+	Enables (or disables) progress messages displayed by the
 	transport helper during a command.

 'option depth' <depth>::
-	Deepen the history of a shallow repository.
+	Deepens the history of a shallow repository.

 'option followtags' \{'true'|'false'\}::
 	If enabled the helper should automatically fetch annotated
@@ -186,9 +201,9 @@ OPTIONS
 	helpers this only applies to the 'push', if supported.

 'option servpath <c-style-quoted-path>'::
-	Set service path (--upload-pack, --receive-pack etc.) for
-	next connect. Remote helper MAY support this option. Remote
-	helper MUST NOT rely on this option being set before
+	Sets service path (--upload-pack, --receive-pack etc.) for
+	next connect. Remote helper may support this option, but
+	must not rely on this option being set before
 	connect request occurs.

 Documentation
-- 
1.7.0.2
