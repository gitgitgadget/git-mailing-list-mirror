From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] Demonstrate breakage: checkout overwrites untracked
 symlink with directory
Date: Sat, 5 Feb 2011 19:33:51 +0100
Message-ID: <20110205183351.GA25717@localhost>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org>
 <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Feb 05 19:32:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlmwJ-0001a5-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 19:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab1BEScl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 13:32:41 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46778 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab1BESck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 13:32:40 -0500
Received: by bwz15 with SMTP id 15so3741346bwz.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p3U7Fo36NCln8QrmWmFXfSIz6q2Rvka9tK45hcmJwP0=;
        b=ua+n6zQhpxuoYgca84ISG6WeULYuv2WculQt2mGCiBrB17qbPsIb6bMjEKB0rF4QUi
         onsU3TX62e+T7MM1B7jHQUU26htBfBoFLiruk4j7gy+PECQ36dAFfVvEwRajjs7E/1l1
         tTMG39lsyrrlFq+MtOWclzh/PQEojOwEs/7uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=KRwY6Q5Tkg6ltxfLONrq785rw2IJ8rfM/JOQy/QTY4hq2wFqdxFswYiwiLInKMxg5i
         cfu0464CmalmpOMgFOJHUQh2+dtDQ0HjTtBtxzlaIWjrhlWt5/SfqMCaIT/ov7Cx1ucu
         RWUK2yWhIbnc7ukPY8nYaksK3O3ysSJFfTyik=
Received: by 10.204.72.148 with SMTP id m20mr998734bkj.69.1296930758858;
        Sat, 05 Feb 2011 10:32:38 -0800 (PST)
Received: from darc.lan (p5B22E480.dip.t-dialin.net [91.34.228.128])
        by mx.google.com with ESMTPS id q18sm1091155bka.15.2011.02.05.10.32.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 10:32:37 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PlmxD-0006in-Jx; Sat, 05 Feb 2011 19:33:51 +0100
Content-Disposition: inline
In-Reply-To: <201102051918.44848.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166107>

Hi Hannes,

On Sat, Feb 05, 2011 at 07:18:44PM +0100, Johannes Sixt wrote:
>
> This adds tests where an untracked file and an untracked symlink are in the
> way where a directory should be created by 'git checkout'. Commit b1735b1a
> (do not overwrite files in leading path, 2010-12-14) fixed the case where
> a file is in the way, but the untracked symlink is still removed silently.

Indeed. It was my impression from reading the code that this
behavior is intentional. To protect symlinks from being overwritten
as well, I believe we simply have to remove FL_SYMLINK from the
following line in check_leading_path().

diff --git a/symlinks.c b/symlinks.c
index 3cacebd..034943b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -223,7 +223,7 @@ int check_leading_path(const char *name, int len)
        int flags;
        int match_len = lstat_cache_matchlen(cache, name, len, &flags,
                           FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
-       if (flags & (FL_SYMLINK|FL_NOENT))
+       if (flags & FL_NOENT)
                return 0;
        else if (flags & FL_DIR)
                return -1;

It does fix your testcase, but it may break others and I will have
to review the code to be sure.

Clemens
