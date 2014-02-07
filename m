From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Confusing git log --- First time bug submission please advise on
 best practices
Date: Fri, 7 Feb 2014 17:26:20 +0700
Message-ID: <20140207102619.GA27616@lanh>
References: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
 <CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
 <874n4cjk83.fsf@fencepost.gnu.org>
 <CAJaBJzKy0b8MBuB_X_4n8E2=q=CyrpxOyFFrgv_2CQ19pkNmwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Vincent van Ravesteijn <vfr@lyx.org>,
	Francis Stephens <francisstephens@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 11:26:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBidc-0006D2-JT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 11:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbaBGK0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 05:26:20 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62511 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaBGK0T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 05:26:19 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so3048595pbc.26
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L8ZBVfhq2CuJ8jItAj0d+5FoVLbuCnJurG119dPlWQU=;
        b=S+EzMBNN1kKDW8OTbcxOTOF/aHhf324ovTh/PGANLuloTu14N6BywOET4Vc9wmKrAc
         eNLe8ldAbyQtnrtwrApNHFj7hKPPrJ7mT9lq8q4k8amKOcYEwW65a78km/PNFs/8b1Xu
         eAY5Q8dyhoLI/sw8N9vZpTjMyZDUVNxNwSY4Lbyu3Y/rjbkgTnCCMOeEmok12AmrU+4T
         sf3RBg8pa5C8FOHQIJHiTuT5Kgw1U2MMOocWSjk3gcHgkZ68nfRKyVBzIA0uK7OWeVqm
         UTfWBBTITk0kQBmqvwi5r1Dgzm/cQZd7GT1WCo4xpPm6PVS+5GICi/jQVfqgg0osr1KG
         u2KA==
X-Received: by 10.66.179.143 with SMTP id dg15mr6919349pac.52.1391768779124;
        Fri, 07 Feb 2014 02:26:19 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id qw8sm12144687pbb.27.2014.02.07.02.26.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 02:26:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 07 Feb 2014 17:26:20 +0700
Content-Disposition: inline
In-Reply-To: <CAJaBJzKy0b8MBuB_X_4n8E2=q=CyrpxOyFFrgv_2CQ19pkNmwQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241765>

On Fri, Feb 07, 2014 at 09:43:46AM +0000, Francis Stephens wrote:
> Thanks for your clear response. I can see where I went wrong now.

Maybe something like this would help avoid confusion a bit in the
future? This toy patch puts a horizontal line as a break between two
commits if they are not related, so we can clearly see linear commit
segments.

--graph definitely helps, but it's too many threads for topic-based
development model like git.git that I avoid it most of the time.

-- 8< --
diff --git a/log-tree.c b/log-tree.c
index 08970bf..7841bf2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -795,6 +795,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 int log_tree_commit(struct rev_info *opt, struct commit *commit)
 {
+	static struct commit_list *last_parents;
 	struct log_info log;
 	int shown;
 
@@ -805,6 +806,17 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
 
+	if (last_parents) {
+		struct commit_list *p = last_parents;
+		int got_parent = 0;
+		for (; p && !got_parent; p = p->next)
+			got_parent = !hashcmp(p->item->object.sha1,
+					      commit->object.sha1);
+		if (!got_parent)
+			printf("______________________________________________________________________\n");
+		free_commit_list(last_parents);
+		last_parents = NULL;
+	}
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
 		log.parent = NULL;
@@ -813,5 +825,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	}
 	opt->loginfo = NULL;
 	maybe_flush_or_die(stdout, "stdout");
+	last_parents = copy_commit_list(commit->parents);
 	return shown;
 }
-- 8< --

> 
> On Thu, Feb 6, 2014 at 4:10 PM, David Kastrup <dak@gnu.org> wrote:
> > Vincent van Ravesteijn <vfr@lyx.org> writes:
> >
> >> The commits that are in the log for master and which are not in the
> >> log for originssh/master are merged in at "6833fd4 (HEAD, master);
> >> Completed merge".
> >>
> >> As "git log" can only present the commits in a linear way, it shows
> >> the commits from the ancentry of both parents of HEAD in a reverse
> >> chronological order. This means that the commits from the two
> >> ancestries are mixed and commits that are shown after each other don't
> >> have to be parent and child. See the documentation of "git log" and
> >> the section "Commit Ordering": "By default, the commits are shown in
> >> reverse chronological order."
> >
> > git log --graph can help with getting a better picture.
