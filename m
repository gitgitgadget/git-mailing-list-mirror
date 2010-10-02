From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] setup: make sure git dir path is in a permanent buffer
Date: Sat, 2 Oct 2010 03:36:52 -0500
Message-ID: <20101002083652.GE29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xdZ-0004Bh-6e
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab0JBIkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:40:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63458 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445Ab0JBIkB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:40:01 -0400
Received: by iwn5 with SMTP id 5so4740690iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=k7WAxkcTv8+h/VaI4lwmlXDm13L8NcUaeypRlUkdoZ4=;
        b=o1KAFKYpDjvzzjvhsd4TpdW2z4b0AZlbOKf4VXaKtNvYlM+anZsjsToaXgGSPqb8nA
         ublOWQR1pON3UJfbiLD+xwBjUqxm/r+qukfXQfy716zKAUJ9JPIFfuGErAlevJ4ntJ2R
         k5+aTHlLBNqVB4752sA2O1y0kbVpfNv53qIuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kWeMXTyae88t86qnnpkvMAl7jYnzMFdBZaPkl71zf1CQ0i/WoJB8/1m9ZKpu/F27kf
         aZc1++ZxuSL9IuKpUpEfz3ZvFzWBIv6XDMDUc9zsPz18JZlnXG2lLrRU0u+TxzqE0ks0
         c8b890s4ag6zOBVIOqaKzwy7SSKquiFKyNFoo=
Received: by 10.231.157.195 with SMTP id c3mr6932230ibx.155.1286008800378;
        Sat, 02 Oct 2010 01:40:00 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d13sm350162ibb.14.2010.10.02.01.39.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:39:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157799>

If setup_git_env() is run before the usual repository discovery
sequence and .git is a file with the text

	gitdir: <path>

(with <path> any string) then the in-core git_dir variable is set to
the result of converting <path> to an absolute path using
make_absolute_path().

Unfortunately make_absolute_path() returns its result in a static
buffer that is overwritten by later calls.  Such a call could cause
later accesses to git_dir (from git_pathdup(), for example) to read
the wrong path, leaving git very confused.

It is not obvious whether any existing code in git will trigger the
problem, but in any case, it is worth a few dozen bytes to copy the
return value from make_absolute_path() for some added peace of mind.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 environment.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/environment.c b/environment.c
index c44a30b..de5581f 100644
--- a/environment.c
+++ b/environment.c
@@ -87,8 +87,10 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir)
+	if (!git_dir) {
 		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		git_dir = git_dir ? xstrdup(git_dir) : NULL;
+	}
 	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir = getenv(DB_ENVIRONMENT);
-- 
1.7.2.3
