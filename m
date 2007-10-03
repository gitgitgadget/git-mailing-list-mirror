From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 01:42:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710030133020.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Oct 03 02:43:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcsKl-0004IM-Vh
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbXJCAnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 20:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbXJCAnS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:43:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:35714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752755AbXJCAnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:43:16 -0400
Received: (qmail invoked by alias); 03 Oct 2007 00:43:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 03 Oct 2007 02:43:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NzPo3aXvNHIfRZeHjEo4WJbz0hplFvpZtJXIQYQ
	FWxeVfxMlbqDoJ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59761>

Hi,

I do not want to depend on more than necessary in msysGit, and therefore I 
started to write an asciidoc replacement.

So here it is: a perl script that does a good job on many .txt files in 
Documentation/, although for some it deviates from "make man"'s output, 
and for others it is outright broken.  It is meant to be run in 
Documentation/.

My intention is not to fix the script for all cases, but to make patches 
to Documentation/*.txt themselves, so that they are more consistent (and 
incidentally nicer to the script).

Now, I hear you already moan: "But Dscho, you know you suck at Perl!"

Yeah, I know, but maybe instead of bashing on me (pun intended), you may 
want to enlighten me with tips how to make it nicer to read.  (Yes, there 
are no comments; yes, I will gladly add them where appropriate; yes, html 
is just a stub.)

So here, without further ado, da script:

-- snip --
#!/usr/bin/perl

$conv = new man_page();
$conv->{manual} = 'Git Manual';
$conv->{git_version} = 'Git ' . `cat ../GIT-VERSION-FILE`;
$conv->{git_version} =~ s/GIT_VERSION = //;
$conv->{git_version} =~ s/-/\\-/;
$conv->{git_version} =~ s/\n//;
$conv->{date} = `date +%m/%d/%Y`;
$conv->{date} =~ s/\n//;

$par = '';
handle_file($ARGV[0]);
$conv->finish();

sub handle_text {
	if ($par =~ /^\. /s) {
		my @lines = split(/^\. /m, $par);
		shift @lines;
		$conv->enumeration(\@lines);
	} elsif ($par =~ /^\* /s) {
		my @lines = split(/^\* /m, $par);
		shift @lines;
		$conv->enumeration(\@lines, 'unnumbered');
	} elsif ($par =~ /^\[verse\]/) {
		$par =~ s/\[verse\] *\n?//;
		$conv->verse($par);
	} elsif ($par =~ /^(\t|  +)/s) {
		$par =~ s/^$1//mg;
		$par =~ s/^\+$//mg;
		$conv->indent($par);
	} elsif ($par =~ /^([^\n]*)::\n((\t|  +).*)$/s) {
		my ($first, $rest, $indent) = ($1, $2, $3);
		$rest =~ s/^\+$//mg;
		while ($rest =~ /^(.*?\n\n)--+\n(.*?\n)--+\n\n(.*)$/s) {
			my ($pre, $verb, $post) = ($1, $2, $3);

			$pre =~ s/^(\t|$indent)//mg;
			if ($first ne '') {
				$conv->begin_item($first, $pre);
				$first = '';
			} else {
				$conv->normal($pre);
			}

			$conv->verbatim($verb);
			$rest = $post;
		}
		$rest =~ s/^(\t|$indent)//mg;
		if ($first ne '') {
			$conv->begin_item($first, $rest);
		} else {
			$conv->normal($rest);
		}
		$conv->end_item();
	} elsif ($par =~ /^-+\n(.*\n)-+\n$/s) {
		$conv->verbatim($1);
	} else {
		$conv->normal($par);
	}
	$par = '';
}

sub handle_file {
	my $in;
	open($in, '<' . $_[0]);
	while (<$in>) {
		if (/^=+$/) {
			if ($par ne '' && length($_) >= length($par)) {
				$conv->header($par);
				$par = '';
				next;
			}
		} elsif (/^-+$/) {
			if ($par ne '' && length($_) >= length($par)) {
				$conv->section($par);
				$par = '';
				next;
			}
		} elsif (/^~+$/) {
			if ($par ne '' && length($_) >= length($par)) {
				$conv->subsection($par);
				$par = '';
				next;
			}
		} elsif (/^\[\[(.*)\]\]$/) {
			handle_text();
			$conv->anchor($1);
			next;
		} elsif (/^$/) {
			if ($par =~ /^-+\n.*[^-]\n$/s) {
				# fallthru; is verbatim, but needs more.
			} elsif ($par =~ /::\n$/s) {
				# is item, but needs more.
				next;
			} else {
				handle_text();
				next;
			}
		} elsif (/^include::(.*)\[\]$/) {
			handle_text();
			handle_file($1);
			next;
		}

		# convert "\--" to "--"
		s/\\--/--/g;
		# convert "\*" to "*"
		s/\\\*/*/g;

		# handle gitlink:
		s/gitlink:([^\[ ]*)\[(\d+)\]/sprintf "%s",
			$conv->get_link($1, $2)/ge;
		# handle link:
		s/link:([^\[ ]*)\[(.+)\]/sprintf "%s",
			$conv->get_link($1, $2, 'external')/ge;

		$par .= $_;
	}
	close($in);
	handle_text();
}

package man_page;

sub new {
	my ($class) = @_;
	my $self = {
		sep => '',
		links => [],
#		generator => 'Home grown git txt2man converter'
		generator => 'DocBook XSL Stylesheets v1.71.1 <http://docbook.sf.net/>'
	};
	bless $self, $class;
	return $self;
}

sub header {
	my ($self, $text) = @_;
	$text =~ s/-/\\-/g;

	if ($self->{preamble_shown} == undef) {
		$title = $text;
		$title =~ s/\(\d+\)$//;
		print '.\"     Title: ' . $title
			. '.\"    Author: ' . "\n"
			. '.\" Generator: ' . $self->{generator} . "\n"
			. '.\"      Date: ' . $self->{date} . "\n"
			. '.\"    Manual: ' . $self->{manual} . "\n"
			. '.\"    Source: ' . $self->{git_version} . "\n"
			. '.\"' . "\n";
	}

	$text =~ tr/a-z/A-Z/;
	my $suffix = "\"$self->{date}\" \"$self->{git_version}\""
		. " \"$self->{manual}\"";
	$text =~ s/^(.*)\((\d+)\)$/.TH "\1" "\2" $suffix/;
	print $text;

	if ($self->{preamble_shown} == undef) {
		print '.\" disable hyphenation' . "\n"
			. '.nh' . "\n"
			. '.\" disable justification (adjust text to left'
				. ' margin only)' . "\n"
			. '.ad l' . "\n";
		$self->{preamble_shown} = 1;
	}

	$self->{last_op} = 'header';
}

sub section {
	my ($self, $text) = @_;

	$text =~ tr/a-z/A-Z/;
	$text =~ s/^(.*)$/.SH "\1"/;

	print $text;

	$self->{last_op} = 'section';
}

sub subsection {
	my ($self, $text) = @_;

	$text =~ s/^(.*)$/.SS "\1"/;

	print $text;

	$self->{last_op} = 'subsection';
}

sub get_link {
	my ($self, $command, $section, $option) = @_;

	if ($option eq 'external') {
		my $links = $self->{links};
		push(@$links, $command);
		$command =~ s/\.html$//;
		$command =~ s/-/ /g;
		push(@$links, $command);
		return '\fI' . $command . '\fR\&[1]';
	} else {
		return '\fB' . $command . '\fR(' . $section . ')';
	}
}

sub common {
	my ($self, $text, $option) = @_;

	# escape backslashes, but not in "\n", "\&" or "\fB"
	$text =~ s/\\(?!n|f[A-Z]|&)/\\\\/g;
	# escape "-"
	$text =~ s/-/\\-/g;
	# handle ...
	$text =~ s/(\.\.\.)/\\&\1/g;
	# remove double space after full stop or comma
	$text =~ s/([\.,])  /\1 /g;

	if ($option ne 'no-markup') {
		# make 'italic'
		$text =~ s/'([^'\n]*)'/\\fI\1\\fR/g;
		# ignore `
		$text =~ s/`//g;
		# make *bold*
		$text =~ s/\*([^\*\n]*)\*/\\fB\1\\fR/g;
		# handle <<sections>
		$text =~ s/<<([^>]*)>>/the section called \\(lq\1\\(rq/g;
	}

	return $text;
}

sub normal {
	my ($self, $text) = @_;

	if ($text eq "") {
		return;
	}

	$text = $self->common($text);

	$text =~ s/ *\n(.)/ \1/g;

	if ($self->{last_op} eq 'normal') {
		print "\n";
	}

	print $text;

	$self->{last_op} = 'normal';
}

sub verse {
	my ($self, $text) = @_;

	$text = $self->common($text);
	$text =~ s/^\t/        /mg;

	print ".sp\n.RS 4\n.nf\n" . $text . ".fi\n.RE\n";

	$self->{last_op} = 'verse';
}

sub enumeration {
	my ($self, $text, $option) = @_;

	my $counter = 0;
	foreach $line (@$text) {
		$counter++;
		print ".TP 4\n"
			. ($option eq 'unnumbered' ? '\(bu' : $counter . '.')
			. "\n"
			. $self->common($line);
	}

	$self->{last_op} = 'enumeration';
}

sub begin_item {
	my ($self, $item, $text) = @_;

	$item = $self->common($item);
	$text = $self->common($text);

	$text =~ s/([^\n]) *\n([^\n])/\1 \2/g;

	print ".PP\n" . $item . "\n.RS 4\n" . $text;

	$self->{last_op} = 'item'; 
}

sub end_item {
	my ($self) = @_;

	print ".RE\n";

	$self->{last_op} = 'end_item';
}

sub indent {
	my ($self, $text) = @_;

	$text = $self->common($text, 'no-markup');
	$text =~ s/^\t/        /mg;

	if ($self->{last_op} eq 'normal') {
		print "\n";
	}

	print ".sp\n.RS 4\n.nf\n" . $text . ".fi\n.RE\n";

	$self->{last_op} = 'indent';
}

sub verbatim {
	my ($self, $text) = @_;

	$text = $self->common($text, 'no-markup');

	# convert tabs to spaces
	$text =~ s/^\t/        /mg;
	# remove trailing empty lines
	$text =~ s/\n\n*$/\n/;

	if ($self->{last_op} eq 'normal') {
		print "\n";
	}

	print ".sp\n.RS 4\n.nf\n.ft C\n" . $text . ".ft\n\n.fi\n.RE\n";

	$self->{last_op} = 'verbatim';
}

sub anchor {
	my ($self, $text) = @_;

	$self->{last_op} = 'anchor';
}

sub finish {
	my ($self) = @_;
	my $links = $self->{links};

	if ($#$links >= 0) {
		print '.SH "REFERENCES"' . "\n";
		my $i = 1;
		while ($#$links >= 0) {
			my $ref = shift(@$links);
			$ref =~ s/-/\\-/g;
			my $label = shift(@$links);
			printf (".IP \"% 2d.\" 4\n%s\n.RS 4\n\\%%%s\n.RE\n",
				$i++, $label, $ref);
		}
	} else {
		print "\n";
	}
}

package html_page;

sub new {
	my ($class) = @_;
	my $self = {};
	bless $self, $class;
	return $self;
}

-- snap --

Ciao,
Dscho

P.S.: I need to catch some Zs, and do some real work, so do not be 
surprised if I do not respond within the next 24 hours.
