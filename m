From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [RFC/PATCH] gitweb: Use list form of 'open "-|"' pipeline
Date: Tue, 11 Mar 2008 10:01:00 +0100
Message-ID: <20080311090100.GN10103@mail-vs.djpig.de>
References: <20080308165245.15343.62914.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:02:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0NI-0003vr-At
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbYCKJBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbYCKJBT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:01:19 -0400
Received: from pauli.djpig.de ([78.46.38.139]:51000 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbYCKJBS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:01:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 9E97C9006E;
	Tue, 11 Mar 2008 10:01:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMcvyE2uTkGg; Tue, 11 Mar 2008 10:01:01 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 43E2690071;
	Tue, 11 Mar 2008 10:01:01 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JZ0M0-0003ES-Fl; Tue, 11 Mar 2008 10:01:00 +0100
Content-Disposition: inline
In-Reply-To: <20080308165245.15343.62914.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76813>

On Sat, Mar 08, 2008 at 05:57:20PM +0100, Jakub Narebski wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a5df2fe..ba97a7b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1455,6 +1455,35 @@ sub git_cmd_str {
>  	return join(' ', git_cmd());
>  }
>  
> +# my $fh = output_pipeline(['cmd_1', 'option'], ['cmd_2', 'argument']);
> +# is equivalent to (is the "list form" of) the following
> +# open my $fh, "-|", "cmd_1 option | cmd_2 argument"
> +#
> +# Based on http://www.perlmonks.org/?node_id=246397

It might be worthwile to look into how e.g. IPC::Run does this.

> +sub output_pipeline {
> +	my @commands_list = @_;
> +	exit unless @commands_list;
> +
> +	my $pid = open(my $fh, "-|");
> +	#die "Couldn't fork: $!" unless defined $pid;

Why are all the die's commented out?

> +	if ($pid) { # parent
> +		return $fh;
> +	}
> +
> +	# child
> + COMMAND:
> +	while (my $command = pop @commands_list) {
> +		my $pid = @commands_list ? open(STDIN, "-|") : -1;
> +		#die "Couldn't fork: $!" unless defined $pid;
> +
> +		next COMMAND unless ($pid); # parent
> +		exec @$command;             # child

The "parent" and "child" comments here are wrong, which was really
really confusing...

This should probably be "new child" instead of "parent" and
"old child" instead of "child".

Thw whole concept of processing the array backwards might be shorter,
I personally find it somewhat confusing though.

What happens to all these child processes anyway if one of them fails to
exec?

> +		#die "Couldn't exec \"@$command\": $!";
> +	}
> +}
> +
>  # get HEAD ref of given project as hash
>  sub git_get_head_hash {
>  	my $project = shift;
> @@ -4545,27 +4574,26 @@ sub git_snapshot {
>  		$hash = git_get_head_hash($project);
>  	}
>  
> -	my $git_command = git_cmd_str();
>  	my $name = $project;
> -	$name =~ s,([^/])/*\.git$,$1,;
> +	$name =~ s,([^/])/*\.git$,$1,; # strip '.git' or '/.git'
>  	$name = basename($name);
> -	my $filename = to_utf8($name);
> -	$name =~ s/\047/\047\\\047\047/g;
> -	my $cmd;
> -	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
> -	$cmd = "$git_command archive " .
> -		"--format=$known_snapshot_formats{$format}{'format'} " .
> -		"--prefix=\'$name\'/ $hash";
> +	$name = to_utf8($name);  # or only for filename, not prefix?
> +	$name .= "-$hash";
> +
> +	my @cmds = ([git_cmd(), "archive",
> +		"--format=$known_snapshot_formats{$format}{'format'}",
> +		"--prefix=$name/", $hash]);
>  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
> -		$cmd .= ' | ' . join ' ', @{$known_snapshot_formats{$format}{'compressor'}};
> +		push @cmds, $known_snapshot_formats{$format}{'compressor'};
>  	}
>  
>  	print $cgi->header(
>  		-type => $known_snapshot_formats{$format}{'type'},
> -		-content_disposition => 'inline; filename="' . "$filename" . '"',
> +		-content_disposition => 'inline; filename="' .
> +			"$filename$known_snapshot_formats{$format}{'suffix'}" . '"',

Huh, that compiles? Where is $filename defined now at all?

>  		-status => '200 OK');
>  
> -	open my $fd, "-|", $cmd
> +	my $fd = output_pipeline(@cmds)
>  		or die_error(undef, "Execute git-archive failed");
>  	binmode STDOUT, ':raw';
>  	print <$fd>;

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
