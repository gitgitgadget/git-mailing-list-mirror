From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: doublecheck if really file or dir
Date: Wed, 23 Jul 2014 22:04:14 +0000
Message-ID: <20140723220414.GA14145@dcvr.yhbt.net>
References: <1405657201-32035-1-git-send-email-amanduch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrej Manduch <amanduch@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:04:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA4e3-0002yH-IV
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 00:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933624AbaGWWEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 18:04:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40576 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933386AbaGWWEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 18:04:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9C11F4DD;
	Wed, 23 Jul 2014 22:04:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1405657201-32035-1-git-send-email-amanduch@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254132>

Andrej Manduch <amanduch@gmail.com> wrote:
> * this fixes 'git svn info `pwd`' buggy behaviour

Good catch, the commit could use a better description, something like:
--------------------------- 8< ----------------------------
Subject: [PATCH] git-svn: "info" checks for dirs more carefully

This avoids a "Reading from filehandle failed at ..." error when
running "git svn info `pwd`".

Signed-off-by: Andrej Manduch <amanduch@gmail.com>
--------------------------- 8< ----------------------------

While your patch avoids an error, but the output isn't right, either.
I tried it running in /home/ew/ruby, the URL field is bogus:

    ~/ruby$ git svn info `pwd`
    Path: /home/ew/ruby
    URL: svn+ssh://svn.ruby-lang.org/ruby/trunk/home/ew/ruby
    Repository Root: svn+ssh://svn.ruby-lang.org/ruby
    Repository UUID: b2dd03c8-39d4-4d8f-98ff-823fe69b080e
    Revision: 46901
    Node Kind: directory
    Schedule: normal
    Last Changed Author: hsbt
    Last Changed Rev: 46901
    Last Changed Date: 2014-07-22 19:06:12 +0000 (Tue, 22 Jul 2014)

The URL should be:

    URL: svn+ssh://svn.ruby-lang.org/ruby/trunk

It's better than an error, but it'd be nice if someone who uses
this command can fix it (*hint* :).

> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2029,7 +2029,7 @@ sub find_file_type_and_diff_status {
>  	my $mode = (split(' ', $ls_tree))[0] || "";
>  
>  	return ("link", $diff_status) if $mode eq "120000";
> -	return ("dir", $diff_status) if $mode eq "040000";
> +	return ("dir", $diff_status) if $mode eq "040000" or -d $path;

"or" has a lower precedence than "||", so I would do the following:

	return ("dir", $diff_status) if $mode eq "040000" || -d $path;

The general rule I've learned is to use "||" for conditionals and
"or" for control flow (e.g. do_something() or die("...") ).

I can take your patch with the above changes (no need to resend),
but I'd be happier to see the URL field corrected if you want
to reroll.

Thanks.
