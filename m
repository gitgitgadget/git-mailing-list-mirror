From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Documentation/remote-helpers: explain capabilities first
Date: Fri, 18 Mar 2011 12:45:04 -0500
Message-ID: <20110318174504.GA22332@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 18:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0djk-0001pS-2U
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 18:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab1CRRpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 13:45:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41818 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198Ab1CRRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 13:45:12 -0400
Received: by gyf1 with SMTP id 1so1666889gyf.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=aGBHF+FQ9MDmrmbb85tFUFXbnfM0ri39mOPp+wqNCEU=;
        b=GvQPcMlbtSAAUuWhPtf/4oNmL6Z5fXBZ4G/O+K8Yug92Xg7icChW7yHV3eAUDI+KKF
         rkDzM/QEoVGKbin0+icGANYEsntDhu1meh6i7ZEDNUyd4xTEpDhN0hvItb5aXBG+xI5l
         OzlpQOD0gCOyJZHveYhvXD0HeFeqbHQqKtnig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=vdC+Dm3Z2qeWnsWAuPd5QzSA1rUmQju4pBKgfm7iivtcgQxoUg/RHW3786hLJntQ6L
         4qy5+zrEY2Ox2I4UQaIMX1rIq6rfdiG03eEioDP4La3+e4SErg4cg36eiKAB5vocIWx7
         ndggxEINF5thl4SKkrxLKhCqrtHP5uVDni4Hc=
Received: by 10.236.76.66 with SMTP id a42mr1972042yhe.79.1300470311808;
        Fri, 18 Mar 2011 10:45:11 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id h30sm1945890yhm.0.2011.03.18.10.45.09
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 10:45:10 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169341>

The current remote helper documentation is from the perspective of
git, so to speak: it presents a full menu of commands for a person
invoking a remote helper to choose from.  In practice, that's less
useful than it could be, since the daunted novice remote-helper author
probably just wanted a list of commands she needs to implement to get
started.  So preface the command list with an overview of each
capability, its purpose, and what commands it requires.

As a side effect, this makes it a little clearer that git doesn't just
choose arbitrary commands to run, even if the remote helper advertises
all capabilities --- instead, there are well defined command sequences
for various tasks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
No documentation for "export" and "gitdir" yet (by the way: would it
make sense to export the GIT_DIR environment variable so a round trip
for the 'gitdir' capability would eventually be unnecessary?).

The current documentation left me lost, so I wrote this (which still
probably leaves one lost).  Thoughts?

 Documentation/git-remote-helpers.txt |  101 +++++++++++++++++++++++++--------
 1 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 87cd11f..e7a3985 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -29,16 +29,87 @@ commands generally concern facilities like discovering and updating
 remote refs, transporting objects between the object database and
 the remote repository, and updating the local object store.
 
-Helpers supporting the 'fetch' capability can discover refs from the
-remote repository and transfer objects reachable from those refs to
-the local object store. Helpers supporting the 'push' capability can
-transfer local objects to the remote repository and update remote refs.
-
 Git comes with a "curl" family of remote helpers, that handle various
 transport protocols, such as 'git-remote-http', 'git-remote-https',
 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
 'fetch', 'option', and 'push'.
 
+CAPABILITIES
+------------
+
+Different remote helpers expect to communicate with git in different
+ways.  These are declared to git through the helper's response to the
+`capabilities` command (see COMMANDS, below).
+
+'option'::
+	Can accept settings like `verbosity` (how much output to write
+	to stderr) and `depth` (how much history is wanted in the case
+	of a shallow clone) that affect how other commands are carried
+	out.
++
+Supported commands: 'option'.
+
+Capabilities for Pushing
+~~~~~~~~~~~~~~~~~~~~~~~~
+'connect'::
+	Can attempt to connect to 'git receive-pack' (for pushing),
+	'git upload-pack', etc for communication using the
+	packfile protocol.
++
+Supported commands: 'connect'.
+
+'push'::
+	Can discover remote refs and push local commits and the
+	history leading up to them to new or existing remote refs.
++
+Supported commands: 'list for-push', 'push'.
+
+If a helper advertises both 'connect' and 'push', git will use
+'connect' if possible and fall back to 'push' if the helper requests
+so when connecting (see the 'connect' command under COMMANDS).
+
+Capabilities for Fetching
+~~~~~~~~~~~~~~~~~~~~~~~~~
+'connect'::
+	Can try to connect to 'git upload-pack' (for fetching),
+	'git receive-pack', etc for communication using the
+	packfile protocol.
++
+Supported commands: 'connect'.
+
+'fetch'::
+	Can discover remote refs and transfer objects reachable from
+	them to the local object store.
++
+Supported commands: 'list', 'fetch'.
+
+'import'::
+	Can discover remote refs and output objects reachable from
+	them as a stream in fast-import format.
++
+Supported commands: 'list', 'import'.
+
+If a helper advertises 'connect', git will use it if possible and
+fall back to another capability if the helper requests so when
+connecting (see the 'connect' command under COMMANDS).
+When choosing between 'fetch' and 'import', git prefers 'fetch'.
+Other frontends may have some other order of preference.
+
+'refspec' <refspec>::
+	This modifies the 'import' capability.
++
+A helper advertising
+`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
+in its capabilities is saying that, when it handles
+`import refs/heads/topic`, the stream it outputs will update the
+`refs/svn/origin/branches/topic` ref.
++
+This capability can be advertised multiple times.  The first
+applicable refspec takes precedence.  The left-hand of refspecs
+advertised with this capability must cover all refs reported by
+the list command.  If no 'refspec' capability is advertised,
+there is an implied `refspec {asterisk}:{asterisk}`.
+
 INVOCATION
 ----------
 
@@ -167,26 +238,6 @@ completing a valid response for the current command.
 Additional commands may be supported, as may be determined from
 capabilities reported by the helper.
 
-CAPABILITIES
-------------
-
-'fetch'::
-'option'::
-'push'::
-'import'::
-'connect'::
-	This helper supports the corresponding command with the same name.
-
-'refspec' 'spec'::
-	When using the import command, expect the source ref to have
-	been written to the destination ref. The earliest applicable
-	refspec takes precedence. For example
-	"refs/heads/*:refs/svn/origin/branches/*" means that, after an
-	"import refs/heads/name", the script has written to
-	refs/svn/origin/branches/name. If this capability is used at
-	all, it must cover all refs reported by the list command; if
-	it is not used, it is effectively "*:*"
-
 REF LIST ATTRIBUTES
 -------------------
 
-- 
1.7.4.1
