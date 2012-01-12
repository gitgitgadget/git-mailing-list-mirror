From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 22:39:48 +0530
Message-ID: <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke> <20120112165329.GA17173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOAO-0004he-5Q
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab2ALRKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:10:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56301 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab2ALRKK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 12:10:10 -0500
Received: by wgbds12 with SMTP id ds12so2030658wgb.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gyl2bgtHvT20l/YDhLplWECksFwXS+NLHI6UcgCwvTk=;
        b=C4NONlErAtqh3MOehVxI+joKIheXuDT+6NhMPAVQvi/+a/uHREpHhqj3+lyQx3pAl6
         /zYNPVrm+J0v17avQ+0wyk1QKe0KZ2LjfdbYNhefrupgX0bJ2LTPw7N72TpX18vEQKSP
         zMjR7gVemHcAgjyMah7/99yUw9nIsnS8RrrxQ=
Received: by 10.180.103.2 with SMTP id fs2mr7613866wib.21.1326388209234; Thu,
 12 Jan 2012 09:10:09 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 12 Jan 2012 09:09:48 -0800 (PST)
In-Reply-To: <20120112165329.GA17173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188456>

Hi Peff,

Jeff King wrote:
>                  I agree it would be nice to make:
> =C2=A0git cherry-pick commit1 commit3 commit2
>
> work in the order specified, but how does that interact with existing
> cases that provide more traditional revision arguments?

What are your thoughts on making it a flag in the revision API to be
activated with "cherry-pick --literal-order commit1 commit3 commit2"
or similar?  I'm not sure how to get it to reconcile with the more
traditional revision arguments yet. My current worktree (WIP):

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d8020c..47da41b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -228,6 +228,7 @@ static void parse_args(int argc, const char
**argv, struct re
                opts->revs =3D xmalloc(sizeof(*opts->revs));
                init_revisions(opts->revs, NULL);
                opts->revs->no_walk =3D 1;
+               opts->revs->literal_order =3D 1;
                if (argc < 2)
                        usage_with_options(usage_str, options);
                argc =3D setup_revisions(argc, argv, opts->revs, NULL);
diff --git a/revision.c b/revision.c
index 064e351..301ef58 100644
--- a/revision.c
+++ b/revision.c
@@ -2054,7 +2054,10 @@ int prepare_revision_walk(struct rev_info *revs)
                if (commit) {
                        if (!(commit->object.flags & SEEN)) {
                                commit->object.flags |=3D SEEN;
-                               commit_list_insert_by_date(commit,
&revs->commits
+                               if (revs->literal_order)
+                                       commit_list_insert(commit,
&revs->commits
+                               else
+
commit_list_insert_by_date(commit, &revs-
                        }
                }
                e++;
diff --git a/revision.h b/revision.h
index b8e9223..65c3dc3 100644
--- a/revision.h
+++ b/revision.h
@@ -67,6 +67,7 @@ struct rev_info {
                        remove_empty_trees:1,
                        simplify_history:1,
                        lifo:1,
+                       literal_order:1,
                        topo_order:1,
                        simplify_merges:1,
                        simplify_by_decoration:1,
