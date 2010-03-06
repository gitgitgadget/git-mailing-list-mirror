From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] bash-completion: Support running with set -u in bash 4.0
Date: Sat, 6 Mar 2010 12:16:55 -0600
Message-ID: <20100306181655.GA2261@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>,
	Thomas Nilsson <thomas.nilsson@unixangst.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No16d-0004YU-M2
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab0CFSQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 13:16:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52443 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab0CFSQw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 13:16:52 -0500
Received: by gyh3 with SMTP id 3so186768gyh.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=fALtLeXWC9MIjUcn71h7SYrUVL5yrNUNDZJpUtoZZ/Y=;
        b=aNujaXkFr0NLF2KGoeZ05JVvniyPU72SEEjj4CycR7fCivVUfSaAOAtVhjg/9QaWRN
         JL6MJxD0A7aAAzAh/6Rpf2H+t2ollxcD+Pu3iqkKv6N7trhPITdYopeJx3oHypaJtAwj
         8G2mgG/hSSCJoEziSKMWK2zD6X65sZttes7j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=kuOL7T+D4jU/bUBJ/XCpVqdCFQBWIDDZ/66b+Bv7+4Cg/xLcOwdmqff0KDPvjBsR1n
         2RiRB+dg6KVuAeCAn8rTBD80432AhnPPiX5M7mkSlG92ZoM486Jad8q3j3EipRzszLuP
         o730yjm8IzXugutDsazc1txpwDOxz8MDfcVZU=
Received: by 10.91.145.11 with SMTP id x11mr3075570agn.86.1267899411207;
        Sat, 06 Mar 2010 10:16:51 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2648381iwn.14.2010.03.06.10.16.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 10:16:50 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Nilsson <thomas.nilsson@unixangst.com>
Date: Tue, 23 Feb 2010 12:13:00 +0100

Starting with bash 4.0-beta, under "set -u" semantics, accessing
undefined local variables is now an error.  Some user environments
enable this setting in the interactive shell, with unpleasant results:

 knirch@traktor:~/source/external/git (master)$ set -o unset
 bash: w: unbound variable
 knirch@traktor:~/source/external/git$ git ^Ibash: command: unbound variable
 bash: w: unbound variable
 knirch@traktor:~/source/external/git$
 bash: w: unbound variable
 knirch@traktor:~/source/external/git$

Most of these variables should be bound to "".  In contexts where the
completion functions should access an undefined variable, accessing a
default empty string (as in "${1-}" instead of "$1") is a reasonable
way to cope, as it silences the undefined variable error while still
supplying an empty string.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sent by Thomas to <http://bugs.debian.org/571087> (thanks!).  One
might use 'set -u' in an interactive shell while manually
single-stepping through a shell script, perhaps.

 contrib/completion/git-completion.bash |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe93747..d97467e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -84,8 +84,8 @@ __git_ps1 ()
 {
 	local g="$(__gitdir)"
 	if [ -n "$g" ]; then
-		local r
-		local b
+		local r=""
+		local b=""
 		if [ -f "$g/rebase-merge/interactive" ]; then
 			r="|REBASE-i"
 			b="$(cat "$g/rebase-merge/head-name")"
@@ -127,11 +127,11 @@ __git_ps1 ()
 			}
 		fi
 
-		local w
-		local i
-		local s
-		local u
-		local c
+		local w=""
+		local i=""
+		local s=""
+		local u=""
+		local c=""
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
@@ -2181,7 +2181,7 @@ _git ()
 		c=$((++c))
 	done
 
-	if [ -z "$command" ]; then
+	if [ -z "${command-}" ]; then
 		case "${COMP_WORDS[COMP_CWORD]}" in
 		--*)   __gitcomp "
 			--paginate
-- 
1.7.0
