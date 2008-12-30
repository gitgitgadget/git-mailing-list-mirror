From: Alexander Potashev <aspotashev@gmail.com>
Subject: [RFC PATCH] builtin-apply: prevent non-explicit permission changes
Date: Wed, 31 Dec 2008 02:53:57 +0300
Message-ID: <20081230235357.GA12747@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:55:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHoQg-000793-Cz
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYL3Xx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbYL3Xx6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:53:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:34492 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbYL3Xx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:53:57 -0500
Received: by bwz14 with SMTP id 14so17912159bwz.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 15:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=WpEAyPwy8QRjB779SzgRtktcV/q2VlfOE7qcAVyMb1M=;
        b=DetXZ6LomBJ98a+xEsI1XuVtlgXLpVZ8An3mN1nxM06tRt5P1bKAqsUfSlxtlmVvCM
         hpIXhhHSpWsjHXcl8kQ78Ev6A9dPo2PpLlYFDun9yHpa+s/kfafsSIqB4wV4zyxPLQLN
         YEkgW7TbUX3187WDGn2ZerIpsSe83dy+W0PjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=oercBdoibahlo7A7+7cJR3hFuCez1XbraX3fUPSDjNqTqlBfobvKYN+DJv67olUx9g
         8/cXfCyK4n2vS/iBDyY84/xut3ZCUQ+zOQxJ6iuYDwHs8ORVIjPGenzg+QJEmVfUUQdq
         UQqeOQjh4g8z2p+qu8fMVnjss5Kx8wquuPF9A=
Received: by 10.181.155.9 with SMTP id h9mr4845195bko.176.1230681234702;
        Tue, 30 Dec 2008 15:53:54 -0800 (PST)
Received: from smtp.gmail.com (ppp91-77-14-201.pppoe.mtu-net.ru [91.77.14.201])
        by mx.google.com with ESMTPS id 12sm21980884fks.13.2008.12.30.15.53.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 15:53:53 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Wed, 31 Dec 2008 02:53:57 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104228>

 
Prevent 'git apply' from changing permissions without
'old mode'/'new mode' lines in patch.
(WARNING: this changes the behaviour of 'git apply')

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---

Once upon a time there was a shell script in a Git repository. But that
shell script had 100644 permission (regular file). Then I did
'chmod +x', commit... but the shell script was related to my friend's
stuff in the repository and I received a patch from him regarding the
script. But the patch was against a repository version before
'chmod +x', thus it contained an index line such as the following:

	index fc3c3a4..066a4ac 100644
(it still had '100644' permissions)

I have to note that there was no 'old/new mode' lines. But when I ran
'git am <patch>' it restored '100644' permissions. So, 'git am' changed
my permissions (100755 -> 100644) without any explicit permission
changes in the patch.

I think, 'git apply'/'git am' should apply only _changes_ _mentioned_ in
patch; if there's no 'old mode ...'/'new mode ...' lines in it, 'git
apply' shouldn't change the permissions.


Test cases are probably wanted, but I don't really know how to do them
and I'll only give a chain of commands to reproduce the issue:

	mkdir repo
	cd repo

	git init
	echo "This is a shell script" > script.sh
	git add script.sh
	git ci -m "initial commit"

	echo "a new line and a newline" >> script.sh
	git ci -a -m "only content changes"	# aka patch to apply
	git format-patch -1			# now we have a patch

	git reset --hard HEAD^
	chmod +x script.sh
	git ci -a -m "permission changes"

	git am 0001-only-content-changes.patch
	stat -c %a script.sh			# check the result

'stat' says '644' if 'git am' has changed the permissions or '755' if
it hasn't.

					Alexander


 builtin-apply.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..071f6d8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
 	memcpy(patch->new_sha1_prefix, line, len);
 	patch->new_sha1_prefix[len] = 0;
 	if (*ptr == ' ')
-		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
+		patch->old_mode = strtoul(ptr+1, NULL, 8);
 	return 0;
 }
 
@@ -2447,6 +2447,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (st_mode != patch->old_mode)
 		fprintf(stderr, "warning: %s has type %o, expected %o\n",
 			old_name, st_mode, patch->old_mode);
+	patch->new_mode = st_mode;
 	return 0;
 
  is_new:
-- 
1.6.0.6
