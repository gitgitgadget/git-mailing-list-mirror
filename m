Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6F420989
	for <e@80x24.org>; Thu, 13 Oct 2016 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbcJMU40 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 16:56:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37616 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbcJMU4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 16:56:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D0B4E20989;
        Thu, 13 Oct 2016 20:55:55 +0000 (UTC)
Date:   Thu, 13 Oct 2016 20:55:55 +0000
From:   Eric Wong <e@80x24.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Mathieu Arnold <mat@freebsd.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: problem with git worktree and git svn
Message-ID: <20161013205555.GA599@dcvr>
References: <6c83c905-b10a-7f54-873f-54186faacfc8@FreeBSD.org>
 <CAGZ79kZo5W1r0s26G3foB7caP6+u66mdzqzyneqXBX_B7A0RKg@mail.gmail.com>
 <20161013015233.GA18001@whir>
 <CACsJy8ADmHLW5ba4bVTGN9ccqpMDNFgkqE_5JvnqZ0BxWcaCvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8ADmHLW5ba4bVTGN9ccqpMDNFgkqE_5JvnqZ0BxWcaCvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Oct 13, 2016 at 8:52 AM, Eric Wong <e@80x24.org> wrote:
> > +sub svn_dir {
> > +       my $git_dir = scalar @_ ? $_[0] : $ENV{GIT_DIR};
> > +       my $common = $ENV{GIT_COMMON_DIR} || "$git_dir/commondir";
> > +       $git_dir .= '/'.::file_to_s($common) if -e $common;
> > +       my $svn_dir = $git_dir . '/svn';
> > +       $svn_dir =~ tr!/!/!s;
> > +       $svn_dir;
> > +}
> 
> 
> If this is shell script, this function could be just
> 
> svn_dir() {
>     git rev-parse --git-path svn
> }

Ah, thanks; I missed --git-path.  I will do this in Git/SVN.pm:

--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -808,12 +808,7 @@ sub get_fetch_range {
 }
 
 sub svn_dir {
-	my $git_dir = scalar @_ ? $_[0] : $ENV{GIT_DIR};
-	my $common = $ENV{GIT_COMMON_DIR} || "$git_dir/commondir";
-	$git_dir .= '/'.::file_to_s($common) if -e $common;
-	my $svn_dir = $git_dir . '/svn';
-	$svn_dir =~ tr!/!/!s;
-	$svn_dir;
+	command_oneline(qw(rev-parse --git-path svn));
 }
 
 sub tmp_config {

> which should give you correct path in either single or multi-worktree
> context and you don't need to bother with details like
> $GIT_COMMON_DIR. But I don't know how Perl bindings are implemented, I
> don't know if we have something similar (or easy to add it, like
> Git::git_path()).

I'm not sure it's necessary given the convenience of command_oneline,
and I'd rather avoid the overhead of documenting+supporting a new API
for Git.pm

> I don't know much about git-svn, but from the look of it I agree
> replacing $ENV{GIT_DIR}/svn with svn_dir() should fix it, assuming
> that you don't hard code $ENV{GIT_DIR}/blahblah somewhere else. I
> don't see any other potential problems (from multi-worktree
> perspective).

I think there was a place where $GIT_DIR/config was used, but
only for documentation purposes.
