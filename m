From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix @git_base_url_list usage
Date: Tue, 19 Sep 2006 17:28:28 -0700
Message-ID: <7v64fjnzyr.fsf@assigned-by-dhcp.cox.net>
References: <20060920000946.GC13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 02:28:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPpx4-0006Fq-Nn
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWITA2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWITA2c
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:28:32 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52945 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750753AbWITA2b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 20:28:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920002828.DVWB12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 19 Sep 2006 20:28:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QQUW1V00d1kojtg0000000
	Tue, 19 Sep 2006 20:28:31 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920000946.GC13132@pasky.or.cz> (Petr Baudis's message of
	"Wed, 20 Sep 2006 02:09:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27319>

Petr Baudis <pasky@suse.cz> writes:

> As it is now, that array was never used because the customurl accessor was
> broken and ''unless @url_list'' never happenned.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>...
>  sub git_get_project_url_list {
>  	my $path = shift;
>  
> -	open my $fd, "$projectroot/$path/cloneurl" or return undef;
> +	open my $fd, "$projectroot/$path/cloneurl" or return wantarray ? () : undef;
>  	my @git_project_url_list = map { chomp; $_ } <$fd>;
>  	close $fd;

Why on earth do you want to use wantarray for something like
this?

It's not like you are implementinging any fancy DWIM magic.

Isn't

	open my $fd, "foobar" or return;

much easier to read?

#!/usr/bin/perl

sub return_undef {
	open my $fd, "no-such-file"
	    or return wantarray ? () : undef;
}
sub return_broken {
	open my $fd, "no-such-file"
	    or return undef;
}

sub return_empty {
	open my $fd, "no-such-file"
	    or return;
}

my $returned_undef_1 = return_undef();
my ($returned_undef_2) = return_undef();
my @returned_undef = return_undef();

my $returned_broken_1 = return_broken();
my ($returned_broken_2) = return_broken();
my @returned_broken = return_broken();

my $returned_empty_1 = return_empty();
my ($returned_empty_2) = return_empty();
my @returned_empty = return_empty();

printf "U %d B %d E %d\n",
    scalar(@returned_undef),
    scalar(@returned_broken),
    scalar(@returned_empty);

for ($returned_undef_1,
     $returned_undef_2,
     $returned_broken_1,
     $returned_broken_2,
     $returned_empty_1,
     $returned_empty_2) {
	print "What I said was bogus.\n" if (defined $_);
}
