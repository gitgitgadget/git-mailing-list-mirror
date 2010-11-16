From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Bogus error: Untracked working tree file '....' would be
 overwritten by merge. Aborting
Date: Tue, 16 Nov 2010 18:24:06 +0700
Message-ID: <20101116112406.GA18259@do>
References: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 12:25:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIJfH-0006SH-NE
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 12:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab0KPLZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 06:25:26 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50473 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877Ab0KPLZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 06:25:25 -0500
Received: by pva4 with SMTP id 4so71262pva.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 03:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=slNxnSu/61lR6stEI0fOyWDeyqYCSkz7hNG4oxsLlTU=;
        b=ef3UmfwUEuMpxufV9o0pt+dvOl6DiQ2n8xy1BTsHnAEJH1qWNYYI5IHGZJz8jtHGAh
         pYbFi0mnKvxne8oqCLn+nbtaD8+4hvrsxYhoA0D/s5HiSLeU4/9rrXcJ4/IzHtM5eLZe
         1NYXUFvFrRXvADJOmBviG58pTE5anB2Kc23GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AVOiIvxkY/VCNL0r2zr9cRTELaMONMS+1b46KgYZfXOj4TIkBa07GvvO51Vw10S0sj
         jTYNSDT9qDe3fw5shJolR97BYi5N9ZhkNN7Ti3KC2jnLkGhG84xJ1ORMfyDmv6OosbHR
         mAoGaoEWlC1qeDvH2CMqmUZ5vtpQ0A2kfwmxQ=
Received: by 10.142.241.19 with SMTP id o19mr6554801wfh.72.1289906724379;
        Tue, 16 Nov 2010 03:25:24 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id p8sm1250662wff.16.2010.11.16.03.25.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 03:25:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Nov 2010 18:24:06 +0700
Content-Disposition: inline
In-Reply-To: <AANLkTinv7XsXNR2MMbaGAUo2=WgL6SEWkuzwGU_7YVn0@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161558>

On Tue, Nov 16, 2010 at 11:26:19AM +0100, demerphq wrote:
> The error in the subject line is generated if one has a git repo
> checked out to a commit that adds a new file and one does something
> like:
> 
> git reset HEAD^
> 
> and then a merge operation that involves going forward onto or past HEAD.
> 
> Why is this error generated when the file is *exactly* the same as the
> file that would overwrite it?
> 
> Obviously it makes sense to throw this error when data would be lost,
> but when they are identical what is the point?

Something like this may help. Completely untested but could be a
starting point. See [1] for a more generic case, where users just want
git it ignore updating worktree and go ahead.
-- 
Duy

[1] http://thread.gmane.org/gmane.comp.version-control.git/160568/focus=160725

-- 8< --
diff --git a/unpack-trees.c b/unpack-trees.c
index 803445a..f9451fc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -980,6 +980,12 @@ static int same(struct cache_entry *a, struct cache_entry *b)
 }
 
 
+static int identical_content(struct cache_entry *ce, struct stat *st)
+{
+	unsigned char sha1[20];
+	return !index_path(sha1, ce->name, st, 0) && !hashcmp(sha1, ce->sha1);
+}
+
 /*
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
@@ -1006,6 +1012,10 @@ static int verify_uptodate_1(struct cache_entry *ce,
 		 */
 		if (S_ISGITLINK(ce->ce_mode))
 			return 0;
+
+		if (identical_content(ce, &st))
+			return 0;
+
 		errno = 0;
 	}
 	if (errno == ENOENT)
@@ -1195,6 +1205,8 @@ static int verify_absent_1(struct cache_entry *ce,
 				return 0;
 		}
 
+		if (identical_content(ce, &st))
+			return 0;
 		return o->gently ? -1 :
 			add_rejected_path(o, error_type, ce->name);
 	}
-- 8< --
