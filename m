From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] git-svn: add support for --first-parent
Date: Thu, 6 Sep 2007 10:34:14 +0200
Message-ID: <8c5c35580709060134x22ed48d2nc9123e234fc6cf70@mail.gmail.com>
References: <1188984929315-git-send-email-hjemli@gmail.com>
	 <20070905101929.GB11074@soma>
	 <8c5c35580709060018p50398071s32b271d52f4dc7e3@mail.gmail.com>
	 <20070906075104.GA10192@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITCoe-0007Wi-Um
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbXIFIeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbXIFIeP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:34:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:3490 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbXIFIeO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:34:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so104444wah
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iSyPcfOCiXYEXJMA6fIYxP7+4NtQmnHxi2IMu6/9WQE=;
        b=nggFFxiquN+OyBEf7JbQRIw4JmvAXYsTw0w6PwN6e/6rhpEvaWdrvHWtUJHmzS94D5tMXwF8Lh1KPBHfgnbsBOSoe8H7II5gHGwC9UaR+eNsG+xnpmnRXNjw0YGHoaD/+KkaAHgomqPqoNsNJBiJFnULTSP6Yybz9JHHeOczn3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JMi/491lRjgw1ZDq+UaY1RszmKNZOb4BvcCyTUnxMoNZ8oo/WlW0Mlj3HkZkp1VNqACK5uZ7boO3Nyvy09wwgLN8xjjBXKO8rzmpM0inSZu3gQVEQfU/4eroNF0roUDDxrpNFJGo3uTetAsYiy3O6tXeLlIg/nj35mDsuiW/o1U=
Received: by 10.115.109.1 with SMTP id l1mr243995wam.1189067654083;
        Thu, 06 Sep 2007 01:34:14 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 6 Sep 2007 01:34:14 -0700 (PDT)
In-Reply-To: <20070906075104.GA10192@hand.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57839>

On 9/6/07, Eric Wong <normalperson@yhbt.net> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > On 9/5/07, Eric Wong <normalperson@yhbt.net> wrote:
> > > Lars Hjemli <hjemli@gmail.com> wrote:
> > > > When git-svn uses git-log to find embedded 'git-svn-id'-lines in commit
> > > > messages, it can get confused when local history contains merges with
> > > > other git-svn branches. But if --first-parent is supplied to git-log,
> > > > working_head_info() will only see 'branch-local' commits and thus the
> > > > first commit containing a 'git-svn-id' line should refer to the correct
> > > > subversion branch.
> > >
> > > Ideally, we'd probably stop, say something and give the user the choice
> > > of branches if multiple parents available.
> >
> > Could you elaborate? (I don't understand how following the first
> > parent of a merge could end up at the wrong svn branch)
>
> Well, if the user didn't know about --first-parent (like me yesterday
> :), they could still end up miscommitting to any branch.  That's been a
> complaint of users for a while now.  Thinking more about it,
> --first-parent should probably be the default.
>
> But, if they want to commit a different branch instead of the one they
> merged into (so the second/third/fourth parent), --first-parent would
> never give them that chance.

Ok, so maybe '--first-parent' should be the default unless the user
specified something like '--upstream <revspec>', like this:

diff --git a/git-svn.perl b/git-svn.perl
index d21eb7f..0590299 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -819,8 +819,13 @@ sub cmt_metadata {
 sub working_head_info {
        my ($head, $refs) = @_;
        my @args = ('log', '--no-color');
-       push @args, '--first-parent' if $_first_parent;
-       my ($fh, $ctx) = command_output_pipe(@args, $head);
+       if ($_revspec) {
+           push @args, $_revspec;
+       } else {
+           push @args, '--first-parent';
+           push @args, $head;
+       }
+       my ($fh, $ctx) = command_output_pipe(@args);
        my $hash;
        my %max;
        while (<$fh>) {

This should give the user plenty of rope ;-)

--
larsh
