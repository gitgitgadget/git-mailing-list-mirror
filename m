From: skillzero@gmail.com
Subject: Re: RFC: Sparse checkout improvements (was: Re: question (possibly) 
	on git subtree/submodules)
Date: Tue, 27 Jul 2010 09:55:24 -0700
Message-ID: <AANLkTimJpmGqOogQ1HtN0zu0=tPK0C0kQuEkg4PeOqUh@mail.gmail.com>
References: <xotjlj92i9gr.fsf@leonardo.pit.corp.google.com>
	<4C49C9C6.3080409@gmail.com>
	<loom.20100727T125434-697@post.gmane.org>
	<m3bp9tks6e.fsf@localhost.localdomain>
	<4C4EEC0D.2070105@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Alex <ajb44.geo@yahoo.com>,
	git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 18:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdnRF-0008Vf-Rt
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 18:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab0G0Qz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 12:55:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58882 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab0G0Qz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 12:55:27 -0400
Received: by yxg6 with SMTP id 6so557034yxg.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dtdQootzp9OkIMJ/1cJCn2wS1x3q4PsnWie1jSHObuw=;
        b=UCThUyD0Km+cWlyAvlvDAkrEAaneAp1+s5XjdTOgM0b5+CvACj6aaVzFE4bh/2DjkT
         9BMVrmTh0PqPAgJMB/7TXWXbBmPJYJvVHOazrdKuGBJCww3iA3nWtJ6Npd1ioO1+2xnL
         4WbkQU4Tn+GqPDWXVp74dnnJARsFt1vkh+7g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IFzNCogAlZKgjUmnx3gfKdh9IBholjzR1UVh47MFYub5Qk/QtE0hH0b6CpiEijeTeB
         DPqXKg7Vf28AxXew2Evfz/hX7P/5gvkWUlgYQ0mC4zgawUipfTbzXJJP0x4ULIOZLWkz
         PX9nTJsJet+VFHr/3tyt2lCnBCHRnH1a/lGNA=
Received: by 10.90.95.7 with SMTP id s7mr7079311agb.9.1280249724216; Tue, 27 
	Jul 2010 09:55:24 -0700 (PDT)
Received: by 10.90.177.3 with HTTP; Tue, 27 Jul 2010 09:55:24 -0700 (PDT)
In-Reply-To: <4C4EEC0D.2070105@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151956>

On Tue, Jul 27, 2010 at 7:24 AM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:

> * What's missing is a way to define named collections of paths
> ("sparse-sets?") in .git/info/sparse-checkout, so that you can conven=
iently
> checkout a particular subset of the working directory. =C2=A0It would=
 also be nice
> to switch between different sparse-sets.

I pasted in a script I wrote to work with the sparse checkout feature.
I'm not a scripting expert so it probably doesn't things incorrectly.
It lets you create "modules" by adding sections to .gitmodules file at
the root of the repository (or a file you specify). You can list them,
switch/checkout between them, or reset back to normal:

[module "MyApp1"]
	<path1>
	<path2>

$ git module list
MyApp1

$ git module checkout MyApp1

$ git module reset

> * It would also be good to have a way for a repo to define a default
> sparse-set, so that a clone would only checkout that default.

Yes, this would be nice. Ideally what I would like is for there to be
a clone option to specify a "module" (what I've been calling sparse
sets). A first step could just clone the full repository with -n then
do 'git module checkout <module>' (what my other scripts do to prepare
archives). Ideally, it would do some work on the server side to only
send the objects needed for paths specified by the sparse set (but
still allow me to commit and later push changes back).

--=20

git-module script (email may mess up the spacing, causing things to
not line up, but you get the idea)

use Getopt::Long qw(:config gnu_getopt);
use File::Path;

my $gBranch			=3D "";
my $gHelp			=3D 0;
my $gModulesFile	=3D "";
my $gModules		=3D {};
my $gRecursive		=3D 0;

# Parse the command line.
if( @ARGV < 1 ) { Usage(); }
GetOptions(
	"b|branch=3Ds"		=3D> \$gBranch,
	"h|help"			=3D> \$gHelp,
	"f|modules-file=3Ds"	=3D> \$gModulesFile,
	"r|recursive!"		=3D> \$gRecursive,
) or die( "\n" );
if( $gHelp ) { Usage(); }

if( @ARGV < 1 ) { die( "error: no command specified. See 'git module
help'.\n" ); }
my $cmd =3D shift;
if(    $cmd eq "checkout" )	{ cmd_checkout(); }
elsif( $cmd eq "help" )		{ Usage(); }
elsif( $cmd eq "list" )		{ cmd_list(); }
elsif( $cmd eq "reset" )	{ cmd_reset(); }
else { die( "error: unknown command '$cmd'. See 'git module help'.\n" )=
; }

#
# cmd_checkout
#
sub	cmd_checkout
{
	ReadModulesFile();
	my $moduleName =3D shift @ARGV;
	if( !$moduleName )				{ die( "error: no module name specified.\n" ); }
	if( !$gModules->{$moduleName} )	{ die( "error: module '$moduleName'
not found.\n" ); }
=09
	# Enable sparse.
	my $currentCmd =3D "git config core.sparseCheckout true";
	system( $currentCmd ) =3D=3D 0 or die( "error: '$currentCmd' $?.\n" );
=09
	# Write the sparse patterns.
	my $gitDir =3D `git rev-parse --git-dir`;
	if( $? !=3D 0 ) { die( "error: can't find git repository $?.\n" ); }
	chop( $gitDir );
	my $sparsePath =3D $gitDir . "/info/sparse-checkout";
	if( $? !=3D 0 ) { die( "error: read git directory failed $?.\n" ); }
	open( FILE, ">", $sparsePath ) or die( "error: can't open '$sparsePath=
'.\n" );
	foreach( @{$gModules->{$moduleName}} )
	{
		print( FILE "$_\n" );
	}
	close( FILE );
=09
	# Checkout using the new sparse patterns.
	my $currentCmd =3D "git checkout $gBranch --";
	system( $currentCmd ) =3D=3D 0 or die( "error: '$currentCmd' $?.\n" );
}

#
# cmd_list
#
sub	cmd_list
{
	ReadModulesFile();
	my $moduleName =3D shift @ARGV;
	if( $moduleName eq "" )
	{
		if( $gRecursive )
		{
			foreach my $moduleName ( sort( keys %{$gModules} ) )
			{
				print( "$moduleName\n" );
				foreach( @{$gModules->{$moduleName}} )
				{
					print( "\t$_\n" );
				}
			}
		}
		else
		{
			foreach my $moduleName ( sort( keys %{$gModules} ) )
			{
				print( "$moduleName\n" );
			}
		}
	}
	else
	{
		if( !$gModules->{$moduleName} ) { die( "module '$moduleName' not
found.\n" ); }
		foreach( @{$gModules->{$moduleName}} )
		{
			print( "$_\n" );
		}
	}
}

#
# cmd_reset
#
sub	cmd_reset
{
	# Enable sparse.
	my $currentCmd =3D "git config core.sparseCheckout true";
	system( $currentCmd ) =3D=3D 0 or die( "error: '$currentCmd' $?.\n" );
=09
	# Write a special sparse pattern of "*" to mean everything.
	my $gitDir =3D `git rev-parse --git-dir`;
	if( $? !=3D 0 ) { die( "error: can't find git repository $?.\n" ); }
	chop( $gitDir );
	my $sparsePath =3D $gitDir . "/info/sparse-checkout";
	if( $? !=3D 0 ) { die( "error: read git directory failed $?.\n" ); }
	open( FILE, ">", $sparsePath ) or die( "error: can't open '$sparsePath=
'.\n" );
	print( FILE "*\n" );
	close( FILE );
=09
	# Checkout to clear the skip-worktree bits and checkout all entries.
	my $currentCmd =3D "git checkout $gBranch --";
	system( $currentCmd ) =3D=3D 0 or die( "error: '$currentCmd' $?.\n" );
=09
	# Disable sparse.
	my $currentCmd =3D "git config core.sparseCheckout false";
	system( $currentCmd ) =3D=3D 0 or die( "error: '$currentCmd' $?.\n" );
}

#
# ReadModulesFile
#
sub	ReadModulesFile
{
	my @lines =3D ();
	if( $gModulesFile eq "" )		# No file means read from the .gitmodules
file in the repo.
	{
		if( $gBranch ne "" )	{ @lines =3D `git show $gBranch:.gitmodules`;}
		else					{ @lines =3D `git show HEAD:.gitmodules`; }
		if( $? !=3D 0 )			{ die( "error: read .gitmodules file failed: $?.\n"=
 ); }
	}
	elsif( $gModulesFile eq "-" )	# - means read from stdin.
	{
		@lines =3D <STDIN>;
	}
	else
	{
		open( FILE, $gModulesFile ) or die( "error: can't open '$gModulesFile=
'.\n" );
		@lines =3D <FILE>;
		close( FILE );
	}
	chomp( @lines );
=09
	my $isModule   =3D 0;
	my $moduleName =3D "";
	foreach my $line ( @lines )
	{
		$line =3D~ s/^\s+//; # Strip leading whitespace.
		$line =3D~ s/\s+$//; # Strip trailing whitespace.
		$line =3D~ s/\r//g;  # Strip CR's.
		$line =3D~ s/\n//g;  # Strip LF's.
		if( $line =3D~ /\s*\[(.*?)\]\s*/ ) # Check for section header.
		{
			$moduleName =3D $1;
			if( $moduleName =3D~ /\s*module\s*\"(.*)\"/ )
			{
				$moduleName =3D $1;
				$isModule =3D 1;
			}
			else
			{
				$isModule =3D 0;
			}
			next;
		}
		next if !$isModule;			# Skip entries that aren't in module sections.
		next if $line =3D~ /^\s*\;/;	# Skip lines beginning with ';'.
		next if $line =3D~ /^\s*\#/;	# Skip lines beginning with '#'.
		next if length $line =3D=3D 0;	# Skip empty lines.
		push( @{$gModules->{$moduleName}}, $line );
	}
}

#
# Usage
#
sub	Usage
{
	print( STDERR "Usage: git-module [options] command [command options]\n=
" );
	print( STDERR "\n" );
	print( STDERR "Options:\n" );
	print( STDERR "    -b/--branch <name>          Branch to use.\n" );
	print( STDERR "    -f/--modules-file <file>    Custom modules file to
use.\n" );
	print( STDERR "\n" );
	print( STDERR "Commands:\n" );
	print( STDERR "    checkout <name>     Check out a module.\n" );
	print( STDERR "    list [-r] [name]    List module(s). -r lists
modules and patterns.\n" );
	print( STDERR "    reset               Reset to a non-sparse checkout.=
\n" );
	print( STDERR "\n" );
	exit( 1 );
}
