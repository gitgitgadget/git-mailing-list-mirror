From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Mon, 26 Oct 2009 13:31:56 -0700
Message-ID: <1256589116-6998-3-git-send-email-bebarino@gmail.com>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WEt-0000Dl-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbZJZUcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 16:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbZJZUcL
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:32:11 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41351 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbZJZUcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 16:32:10 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so12431506fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=L7si7rd0cOmGNkkIOsZFKvs1iN8HVYYgtowGgIsObFE=;
        b=wV3lAfJWYjdQVZ8uS2uwUianGQPeqslpKWa1nGNpkEVWr72qMEn1ZjDX2zQawfGK3m
         HxdLWwRbitIf5YRqqO/71aM0G9NjvRYP5lC3u1Ik8yUP0PovBhKgvyOgOvjaYxcjr8Ib
         tPUorD86DZVugJBdCF1gMP1Ca3cKOFRwhgyjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QJLY3jzNGyXLBgriXLKMRFtLOiow20tldzyc+ClR9yEiAuxUyeSR4qsRyMCY7kr84N
         VGalLbfal+UW+BjNkXGBLcq92jrNMFhRKCbl0yWgq5CSeMQ3Vb17tY6OUYp7ljnJBQDc
         3gmUJaXMun+W4YIgpJHocZI2QxpgrvvecO6BM=
Received: by 10.204.15.3 with SMTP id i3mr3477883bka.71.1256589134912;
        Mon, 26 Oct 2009 13:32:14 -0700 (PDT)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 2sm946786fks.18.2009.10.26.13.32.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 13:32:13 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 26 Oct 2009 13:32:08 -0700
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131268>

Some users don't want to compile their completion, even when the build
generated completion is 10x faster to load. For example, in my bashrc I
source the completion script directly so I can stay up to date with the
latest completion by merely pulling changes.

Do this by generating the lists dynamically when the merge strategy and
command lists still have their initial values (__GIT_MERGE_STRATEGYLIST,
__GIT_ALL_COMMANDLIST).

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

 This duplicates code, but I don't know of a way to re-use the dynamic
 code without sourcing a bash script and possibly breaking someone's build.

 contrib/completion/git-completion.bash.in |  132 +++++++++++++++++++++++++++--
 1 files changed, 123 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash.in b/contrib/completion/git-completion.bash.in
index d873b98..37d204c 100644
--- a/contrib/completion/git-completion.bash.in
+++ b/contrib/completion/git-completion.bash.in
@@ -60,15 +60,6 @@ __git_merge_strategylist=__GIT_MERGE_STRATEGYLIST
 __git_all_commandlist=__GIT_ALL_COMMANDLIST
 __git_porcelain_commandlist=__GIT_PORCELAIN_COMMANDLIST
 
-# remind folks that git-completion.bash.in can't be sourced
-case "$__git_merge_strategylist" in
-__GIT*)
-	echo "E: git-completion.bash.in can't be sourced"
-	return 1 ;;
-esac
-
-
-
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -333,6 +324,22 @@ __git_remotes ()
 	done
 }
 
+__git_merge_strategies ()
+{
+	if ["$__git_merge_strategylist" != "__GIT_MERGE_STRATEGYLIST"]; then
+		echo "$__git_merge_strategylist"
+		return
+	fi
+	git merge -s help 2>&1 |
+	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
+		s/\.$//
+		s/.*://
+		s/^[ 	]*//
+		s/[ 	]*$//
+		p
+	}'
+}
+__git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"
 
 __git_complete_file ()
 {
@@ -481,6 +488,113 @@ __git_complete_strategy ()
 	return 1
 }
 
+__git_all_commands ()
+{
+	if ["$__git_all_commandlist" != "__GIT_ALL_COMMANDLIST"]; then
+		echo "$__git_all_commandlist"
+		return
+	fi
+	local i
+	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	do
+		case $i in
+		*--*)             : helper pattern;;
+		*) echo $i;;
+		esac
+	done
+}
+__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
+
+__git_porcelain_commands ()
+{
+	if ["$__git_porcelain_commandlist" != "__GIT_PORCELAIN_COMMANDLIST"]; then
+		echo "$__git_porcelain_commandlist"
+		return
+	fi
+	local i
+	for i in "help" $(__git_all_commands)
+	do
+		case $i in
+		*--*)             : helper pattern;;
+		applymbox)        : ask gittus;;
+		applypatch)       : ask gittus;;
+		archimport)       : import;;
+		cat-file)         : plumbing;;
+		check-attr)       : plumbing;;
+		check-ref-format) : plumbing;;
+		checkout-index)   : plumbing;;
+		commit-tree)      : plumbing;;
+		count-objects)    : infrequent;;
+		cvsexportcommit)  : export;;
+		cvsimport)        : import;;
+		cvsserver)        : daemon;;
+		daemon)           : daemon;;
+		diff-files)       : plumbing;;
+		diff-index)       : plumbing;;
+		diff-tree)        : plumbing;;
+		fast-import)      : import;;
+		fast-export)      : export;;
+		fsck-objects)     : plumbing;;
+		fetch-pack)       : plumbing;;
+		fmt-merge-msg)    : plumbing;;
+		for-each-ref)     : plumbing;;
+		hash-object)      : plumbing;;
+		http-*)           : transport;;
+		index-pack)       : plumbing;;
+		init-db)          : deprecated;;
+		local-fetch)      : plumbing;;
+		lost-found)       : infrequent;;
+		ls-files)         : plumbing;;
+		ls-remote)        : plumbing;;
+		ls-tree)          : plumbing;;
+		mailinfo)         : plumbing;;
+		mailsplit)        : plumbing;;
+		merge-*)          : plumbing;;
+		mktree)           : plumbing;;
+		mktag)            : plumbing;;
+		pack-objects)     : plumbing;;
+		pack-redundant)   : plumbing;;
+		pack-refs)        : plumbing;;
+		parse-remote)     : plumbing;;
+		patch-id)         : plumbing;;
+		peek-remote)      : plumbing;;
+		prune)            : plumbing;;
+		prune-packed)     : plumbing;;
+		quiltimport)      : import;;
+		read-tree)        : plumbing;;
+		receive-pack)     : plumbing;;
+		reflog)           : plumbing;;
+		repo-config)      : deprecated;;
+		rerere)           : plumbing;;
+		rev-list)         : plumbing;;
+		rev-parse)        : plumbing;;
+		runstatus)        : plumbing;;
+		sh-setup)         : internal;;
+		shell)            : daemon;;
+		show-ref)         : plumbing;;
+		send-pack)        : plumbing;;
+		show-index)       : plumbing;;
+		ssh-*)            : transport;;
+		stripspace)       : plumbing;;
+		symbolic-ref)     : plumbing;;
+		tar-tree)         : deprecated;;
+		unpack-file)      : plumbing;;
+		unpack-objects)   : plumbing;;
+		update-index)     : plumbing;;
+		update-ref)       : plumbing;;
+		update-server-info) : daemon;;
+		upload-archive)   : plumbing;;
+		upload-pack)      : plumbing;;
+		write-tree)       : plumbing;;
+		var)              : infrequent;;
+		verify-pack)      : infrequent;;
+		verify-tag)       : plumbing;;
+		*) echo $i;;
+		esac
+	done
+}
+__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
+
 __git_aliases ()
 {
 	local i IFS=$'\n'
-- 
1.6.5.2.181.gd6f41
