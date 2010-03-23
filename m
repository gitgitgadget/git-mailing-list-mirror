From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v6] Improve remote-helpers documentation
Date: Tue, 23 Mar 2010 15:08:00 +0530
Message-ID: <f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com>
References: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 10:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu0ZG-00017x-PA
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 10:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048Ab0CWJi3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 05:38:29 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:48700 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab0CWJi1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 05:38:27 -0400
Received: by ywh2 with SMTP id 2so2258409ywh.33
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ERXIISkGY9m5dIkEWCost+CMexdUrsQtwnsm8k88PgU=;
        b=ADLsuWwQf1GAGNr7Q8wvepoktA7BR5KEwho7dRILPASpBhpZih/QFSHEWXFfb6CmgM
         Mjw5HWgQP/j0ECLFqufT1oKLxEYV7NTuD42aioU3S977k3z/lWTn5SnvRVubAffaFngr
         ArUXfYIOGPIxp+0x1VzKc+JyqRPrl14/SsEeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hs+l7Bum6+nrXcyqijfk4HSFtt4JiTstXJRpdqfzwzbFQ2sfj9G8/FN+1EkO0f7UXx
         c+I4KzKDYjNsPU1THhjBrTGJyVKICM3CHR9kK0KrcyNSPcvZncdjcl0X0BvMPHQfWeDL
         z/2pxsJ5UyaNk4yLRXKI+wqvUzpFkGkcF7tw4=
Received: by 10.91.32.1 with SMTP id k1mr3365575agj.8.1269337100162; Tue, 23 
	Mar 2010 02:38:20 -0700 (PDT)
In-Reply-To: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143001>

Rewrote the description section to describe what exactly remote
helpers are and the need for them. Mentioned the curl family of remote
helpers as an example. Fixed minor typos in the rest of the document.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
=A0 =A0Complete rewrite since last revision, inspired by Junio's detail=
ed review.

=A0Documentation/git-remote-helpers.txt | =A0 89 ++++++++++++++++++++--=
------------
=A01 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 1b5f61a..2382fb4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -3,7 +3,7 @@ git-remote-helpers(1)

=A0NAME
=A0----
-git-remote-helpers - Helper programs for interoperation with remote gi=
t
+git-remote-helpers - Helper programs to interact with remote repositor=
ies

=A0SYNOPSIS
=A0--------
@@ -12,11 +12,31 @@ SYNOPSIS
=A0DESCRIPTION
=A0-----------

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

=A0COMMANDS
=A0--------
@@ -25,8 +45,8 @@ Commands are given by the caller on the helper's
standard input, one per line.

=A0'capabilities'::
=A0 =A0 =A0 =A0Lists the capabilities of the helper, one per line, endi=
ng
- =A0 =A0 =A0 with a blank line. Each capability may be preceded with '=
*'.
- =A0 =A0 =A0 This marks them mandatory for git version using the remot=
e
+ =A0 =A0 =A0 with a blank line. Each capability may be preceded with '=
*',
+ =A0 =A0 =A0 which marks them mandatory for git version using the remo=
te
=A0 =A0 =A0 =A0helper to understand (unknown mandatory capability is fa=
tal
=A0 =A0 =A0 =A0error).

@@ -35,27 +55,27 @@ Commands are given by the caller on the helper's
standard input, one per line.
=A0 =A0 =A0 =A0[<attr> ...]". The value may be a hex sha1 hash, "@<dest=
>" for
=A0 =A0 =A0 =A0a symref, or "?" to indicate that the helper could not g=
et the
=A0 =A0 =A0 =A0value of the ref. A space-separated list of attributes f=
ollows
- =A0 =A0 =A0 the name; unrecognized attributes are ignored. After the
- =A0 =A0 =A0 complete list, outputs a blank line.
+ =A0 =A0 =A0 the name; unrecognized attributes are ignored. The list e=
nds
+ =A0 =A0 =A0 with a blank line.
=A0+
=A0If 'push' is supported this may be called as 'list for-push'
=A0to obtain the current refs prior to sending one or more 'push'
=A0commands to the helper.

=A0'option' <name> <value>::
- =A0 =A0 =A0 Set the transport helper option <name> to <value>. =A0Out=
puts a
+ =A0 =A0 =A0 Sets the transport helper option <name> to <value>. =A0Ou=
tputs a
=A0 =A0 =A0 =A0single line containing one of 'ok' (option successfully =
set),
=A0 =A0 =A0 =A0'unsupported' (option not recognized) or 'error <msg>'
- =A0 =A0 =A0 (option <name> is supported but <value> is not correct
+ =A0 =A0 =A0 (option <name> is supported but <value> is not valid
=A0 =A0 =A0 =A0for it). =A0Options should be set before other commands,
- =A0 =A0 =A0 and may how those commands behave.
+ =A0 =A0 =A0 and may influence the behavior of those commands.
=A0+
=A0Supported if the helper has the "option" capability.

=A0'fetch' <sha1> <name>::
=A0 =A0 =A0 =A0Fetches the given object, writing the necessary objects
=A0 =A0 =A0 =A0to the database. =A0Fetch commands are sent in a batch, =
one
- =A0 =A0 =A0 per line, and the batch is terminated with a blank line.
+ =A0 =A0 =A0 per line, terminated with a blank line.
=A0 =A0 =A0 =A0Outputs a single blank line when all fetch commands in t=
he
=A0 =A0 =A0 =A0same batch are complete. Only objects which were reporte=
d
=A0 =A0 =A0 =A0in the ref list with a sha1 may be fetched this way.
@@ -67,7 +87,7 @@ suitably updated.
=A0Supported if the helper has the "fetch" capability.

=A0'push' +<src>:<dst>::
- =A0 =A0 =A0 Pushes the given <src> commit or branch locally to the
+ =A0 =A0 =A0 Pushes the given local <src> commit or branch to the
=A0 =A0 =A0 =A0remote branch described by <dst>. =A0A batch sequence of
=A0 =A0 =A0 =A0one or more push commands is terminated with a blank lin=
e.
=A0+
@@ -91,6 +111,9 @@ Supported if the helper has the "push" capability.
=A0 =A0 =A0 =A0by applying the refspecs from the "refspec" capability t=
o the
=A0 =A0 =A0 =A0name of the ref.
=A0+
+Especially useful for interoperability with a foreign versioning
+system.
++
=A0Supported if the helper has the "import" capability.

=A0'connect' <service>::
@@ -108,9 +131,9 @@ Supported if the helper has the "import" capability=
=2E
=A0Supported if the helper has the "connect" capability.

=A0If a fatal error occurs, the program writes the error message to
-stderr and exits. The caller should expect that a suitable error
-message has been printed if the child closes the connection without
-completing a valid response for the current command.
+stderr and exits. The caller should expect a suitable error
+if the child closes the connection without
+giving a valid response for the current command.

=A0Additional commands may be supported, as may be determined from
=A0capabilities reported by the helper.
@@ -119,16 +142,11 @@ CAPABILITIES
=A0------------

=A0'fetch'::
- =A0 =A0 =A0 This helper supports the 'fetch' command.
-
=A0'option'::
- =A0 =A0 =A0 This helper supports the option command.
-
=A0'push'::
- =A0 =A0 =A0 This helper supports the 'push' command.
-
=A0'import'::
- =A0 =A0 =A0 This helper supports the 'import' command.
+'connect'::
+ =A0 =A0 =A0 This helper supports the corresponding command with the s=
ame name.

=A0'refspec' 'spec'::
=A0 =A0 =A0 =A0When using the import command, expect the source ref to =
have
@@ -140,9 +158,6 @@ CAPABILITIES
=A0 =A0 =A0 =A0all, it must cover all refs reported by the list command=
; if
=A0 =A0 =A0 =A0it is not used, it is effectively "*:*"

-'connect'::
- =A0 =A0 =A0 This helper supports the 'connect' command.
-
=A0REF LIST ATTRIBUTES
=A0-------------------

@@ -158,19 +173,19 @@ REF LIST ATTRIBUTES
=A0OPTIONS
=A0-------
=A0'option verbosity' <N>::
- =A0 =A0 =A0 Change the level of messages displayed by the helper.
- =A0 =A0 =A0 When N is 0 the end-user has asked the process to be
- =A0 =A0 =A0 quiet, and the helper should produce only error output.
- =A0 =A0 =A0 N of 1 is the default level of verbosity, higher values
+ =A0 =A0 =A0 Changes the verbosity of messages displayed by the helper=
=2E
+ =A0 =A0 =A0 A value of 0 for N means that processes operate
+ =A0 =A0 =A0 quietly, and the helper produces only error output.
+ =A0 =A0 =A0 1 is the default level of verbosity, and higher values
=A0 =A0 =A0 =A0of N correspond to the number of -v flags passed on the
=A0 =A0 =A0 =A0command line.

=A0'option progress' \{'true'|'false'\}::
- =A0 =A0 =A0 Enable (or disable) progress messages displayed by the
+ =A0 =A0 =A0 Enables (or disables) progress messages displayed by the
=A0 =A0 =A0 =A0transport helper during a command.

=A0'option depth' <depth>::
- =A0 =A0 =A0 Deepen the history of a shallow repository.
+ =A0 =A0 =A0 Deepens the history of a shallow repository.

=A0'option followtags' \{'true'|'false'\}::
=A0 =A0 =A0 =A0If enabled the helper should automatically fetch annotat=
ed
@@ -186,9 +201,9 @@ OPTIONS
=A0 =A0 =A0 =A0helpers this only applies to the 'push', if supported.

=A0'option servpath <c-style-quoted-path>'::
- =A0 =A0 =A0 Set service path (--upload-pack, --receive-pack etc.) for
- =A0 =A0 =A0 next connect. Remote helper MAY support this option. Remo=
te
- =A0 =A0 =A0 helper MUST NOT rely on this option being set before
+ =A0 =A0 =A0 Sets service path (--upload-pack, --receive-pack etc.) fo=
r
+ =A0 =A0 =A0 next connect. Remote helper may support this option, but
+ =A0 =A0 =A0 must not rely on this option being set before
=A0 =A0 =A0 =A0connect request occurs.

=A0Documentation
--
1.7.0.2
