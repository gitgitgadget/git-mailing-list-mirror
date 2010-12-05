From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] vcs-svn: fix intermittent repo_tree corruption
Date: Sun, 5 Dec 2010 03:32:53 -0600
Message-ID: <20101205093253.GC4332@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
 <20101130194833.GA9064@burratino>
 <20101205091605.GA4332@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 10:34:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPAzJ-0006OV-DU
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 10:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab0LEJdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 04:33:13 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:54751 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab0LEJdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 04:33:12 -0500
Received: by gwb20 with SMTP id 20so5734500gwb.1
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 01:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6j/XnUm8JosXP4l2kSCBPUPrlkcJj68Vs7qoQOOWL7I=;
        b=cxxMedbJWZ35VU8J32VQQ2HFpdiEQGcOTQ/YuJx6ALcd/Ez2QiMHsZje+6f4fTC0hg
         1cugDJB59WKVbR//v7ldIjjB0NkE/0Wk/3Q9cFuN/qPTGjYcoJlayJinh0iDiAzYdKXN
         y7w0nRYd6iBofkAK06LGwZXrTD4qmqNcuhwxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZhHNOrrZFwULLRhEwfh6aCi1KP7KVTM53Rzzf3hJH5U9nfvK9WW/0vXRck8KZnjF5h
         0zA740pEyWFIAORN5cah9XUrAZCeZlnsF62FLSXZJQeTJ/H5UX8+ES/V0w40/DgXu4qJ
         3U0peXrLTIutNJO7+La5byDEf1BE4zQN6mS9Y=
Received: by 10.151.154.8 with SMTP id g8mr7062523ybo.322.1291541591233;
        Sun, 05 Dec 2010 01:33:11 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id u3sm832174yba.16.2010.12.05.01.33.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 01:33:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101205091605.GA4332@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162931>

Pointers to directory entries do not remain valid after a call to
dent_insert.

Noticed in the course of importing a small Subversion repository
(~1000 revs); after setting up a dirent for a certain path as a
placeholder, by luck dent_insert would trigger a realloc that
shifted around addresses, resulting in an import with that file
replaced by a directory.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Tested using the aforementioned small svn repository.  Any ideas for a
more reliable test to include in the test suite?  Maybe some hack to
force realloc to always move the memory it controls, like

	in git-compat-util.h:

	#ifdef WANT_SKITTISH_REALLOC
	#define realloc skittish_realloc
	#endif

	in compat/realloc.c:

	#undef realloc
	void *skittish_realloc(void *ptr, size_t size)
	{
		void *result, *tmp;
		dest = malloc(size);
		ptr = realloc(ptr, size);
		if (!ptr || !dest);
			return NULL;
		memcpy(dest, ptr, size);
		return dest;
	}

?

 vcs-svn/repo_tree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index e94d91d..e3d1fa3 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -131,7 +131,7 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
 		if (dent == key) {
 			dent->mode = REPO_MODE_DIR;
 			dent->content_offset = 0;
-			dent_insert(&dir->entries, dent);
+			dent = dent_insert(&dir->entries, dent);
 		}
 
 		if (dent_offset(dent) < dent_pool.committed) {
@@ -142,7 +142,7 @@ static void repo_write_dirent(uint32_t *path, uint32_t mode,
 			dent->name_offset = name;
 			dent->mode = REPO_MODE_DIR;
 			dent->content_offset = dir_o;
-			dent_insert(&dir->entries, dent);
+			dent = dent_insert(&dir->entries, dent);
 		}
 
 		dir = repo_dir_from_dirent(dent);
-- 
1.7.2.4
