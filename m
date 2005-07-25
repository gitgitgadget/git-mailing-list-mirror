From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support for directories to git-rename-script.
Date: Sun, 24 Jul 2005 23:21:14 -0700
Message-ID: <7vpst7z9r9.fsf@assigned-by-dhcp.cox.net>
References: <20050725052646.GB6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 08:25:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwOa-0004dN-23
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVGYGYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVGYGW2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:22:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42121 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261219AbVGYGVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 02:21:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725062116.LLZU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 02:21:16 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050725052646.GB6098@mythryan2.michonline.com> (Ryan Anderson's message of "Mon, 25 Jul 2005 01:26:47 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> +open(F,"-|","git-ls-files")
> +	or die "Failed to open pipe from git-ls-files: " . $!;
> +
> +@allfiles = <F>;
> +close(F);

We can afford to handle funny characters in the filename right
without pain in Perl, so let's do it right:

    use vars qw($/);
    $/ = "\0";
    open F, '-|', 'git-ls-files', '-z'
    	or die "Failed to open pipe from git-ls-files: " . $!;
    @allfiles = map { chomp; $_} <F>;

> +@srcfiles = grep /^$src/, @allfiles;
> +@dstfiles = @srcfiles;
> +s#^$src(/|$)#$dst$1# for @dstfiles;

Be careful with these regexps.  Perhaps something like this?

    @dstfiles = @srcfiles = grep /^\Q$src\E/, @allfiles;
    s#^\Q$src\E(/|$)#$dst$1# for @dstfiles;

or perhaps a bit more readable:

    my $qsrc = quotemeta($src);
    @dstfiles = @srcfiles = grep /^$qsrc/, @allfiles;
    for (@dstfiles) { s/^$qsrc(/|$)/$dst$1/; }

> +rename($src,$dst)
> +	or die "rename failed: $!";

Making sure leading directories for $dst exists, perhaps?

Otherwise looks good.

> +sub usage($) {

This is just a style thing, but do you really care to force a
scalar contect when "usage" is used?
