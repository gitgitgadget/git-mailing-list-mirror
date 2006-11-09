X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn can lose changes silently
Date: Wed, 08 Nov 2006 23:33:53 -0800
Message-ID: <m2u019ysym.fsf@ziti.local>
References: <455277A6.2000404@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 07:34:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=LBdixJhs0aeRCgZO7mkW1IMAg/gZQmK2O+oFoLFc6HrUXGv0klrd6kuNn6jYAmmiEir96WeUZC0TYNSl25MvyMfl9eli0rnJ9W+Y1TM0Zn8K5hYUe/W5LvRMXBxn9IPX/sm0jQhGS/NoB6V6SbSag49KaYrxRcDjUCRv98Nhr6w=
In-Reply-To: <455277A6.2000404@midwinter.com> (Steven Grimm's message of "Wed, 08 Nov 2006 16:34:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31182>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi4QJ-0007go-Te for gcvg-git@gmane.org; Thu, 09 Nov
 2006 08:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753619AbWKIHeC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 02:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbWKIHeB
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 02:34:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:13882 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753619AbWKIHeA
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 02:34:00 -0500
Received: by ug-out-1314.google.com with SMTP id m3so142093ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 23:33:59 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr869172ugm.1163057639313; Wed, 08
 Nov 2006 23:33:59 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 e23sm475774ugd.2006.11.08.23.33.58; Wed, 08 Nov 2006 23:33:59 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> git-svn is happy to overwrite changes in the svn repository with no
> warnings. Didn't seem to be known behavior when I mentioned it in
> #git, so here's an example, starting completely from scratch to make
> it easier to reproduce. I'm using git-svn 1.4.3 and svn 1.2.3 on OS
> X.

I can reproduce your example and also see the same thing when
accessing an svn repository via https [I've never used the local
file:// mode and was leary of it].

> It is probably not a feature that you can lose changes without knowing
> about it! Even if I'd run git-svn fetch before that commit, it still
> wouldn't help if the svn version of the file changed between the time
> I ran fetch and the time I ran dcommit, totally possible with a busy
> svn repository.
>
> Opinions? Suggestions on fixing it? Do other people agree this is a
> bug?

I think this is a pretty big deal -- at least in terms of user
expectation.  The man page for 'git-svn commit' warns that upstream
changes will be lost.  But in suggesting to use 'git-svn dcommit'
instead, one might expect (hope?) this overwritting upstream changes
to not occur.

I'm embarassed to admit that I've been using git-svn for a few weeks
now and didn't test out these details.  

Here is a patch that I think improves matters a bit:

diff --git a/git-svn.perl b/git-svn.perl
index 4a56f18..daa1764 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -830,6 +830,17 @@ sub commit_diff {
        ($repo, $SVN_PATH) = repo_path_split($SVN_URL);
        $SVN_LOG ||= libsvn_connect($repo);
        $SVN ||= libsvn_connect($repo);
+
+        my ($r_last, $cmt_last) = svn_grab_base_rev();
+        my $fetched = fetch();
+       if ($r_last != $fetched->{revision}) {
+               print STDERR "There are new revisions that were fetched ",
+                               "and need to be merged (or acknowledged) ",
+                               "before committing.\n",
+                               "last rev: $r_last\n",
+                               " current: $fetched->{revision}\n";
+               exit 1;
+       }
        my @lock = $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
        my $ed = SVN::Git::Editor->new({        r => $SVN->get_latest_revnum,
                                                ra => $SVN_LOG, c => $tb,

But for a possibly busy svn repository, the only real solution is one
that uses the svn libs in a way that behaves like the svn client in
terms of atomicity.

