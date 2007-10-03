From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 05:23:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710030506360.28395@racer.site>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <4702F6BB.60908@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 06:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcvnK-0007mI-Pv
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 06:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbXJCEYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 00:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXJCEYx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 00:24:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:59941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750723AbXJCEYw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 00:24:52 -0400
Received: (qmail invoked by alias); 03 Oct 2007 04:24:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 03 Oct 2007 06:24:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Gn49wGXRGn61L5zlSqJT0NdDR5pLASqbT7BjaNj
	hL3slCV/PgDbar
X-X-Sender: gene099@racer.site
In-Reply-To: <4702F6BB.60908@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59779>

Hi,

On Wed, 3 Oct 2007, Sam Vilain wrote:

> Johannes Schindelin wrote:
> 
> > I do not want to depend on more than necessary in msysGit, and 
> > therefore I started to write an asciidoc replacement.
> 
> It's pretty good, I certainly wouldn't have trouble reading or 
> maintaining it, but I'll give you suggestions anyway.

Thank you very much!  (On both accounts...)

> nice work, replacing a massive XML/XSL/etc stack with a small Perl 
> script ;-)

Uhm... It is less capable, though...

> > -- snip --
> > #!/usr/bin/perl
> 
> Add -w for warnings, also use strict;

<dumb>What does "use strict;" imply?</dumb>

> > sub handle_text {
> 
> this function acts on globals; make them explicit arguments to the 
> function.

Actually, it resets the global $par.  Should I rather make it a class?

> > 	if ($par =~ /^\. /s) {
> > 		my @lines = split(/^\. /m, $par);
> > 		shift @lines;
> > 		$conv->enumeration(\@lines);
> > 	} elsif ($par =~ /^\* /s) {
> 
> uncuddle your elsif's;

I'm sorry... What do you mean?

> also consider making this a "tabular ternary" with the actions in 
> separate functions.
> 
> ie
> 
> $result = ( $par =~ /^\. /s      ? $conv->do_enum($par)    :
>             $par =~ /^\[verse\]/ ? $conv->do_verse($par)  :
>             ... )

I do not like that way... is it Perl standard to code like that?

> However I have a suspicion that your script is doing line-based parsing 
> instead of recursive descent; I don't know whether that's the right 
> thing for asciidoc.  It's actually fairly easy to convert a grammar to 
> code blocks using tricks from MJD's _Higher Order Perl_.  Is it 
> necessary for the asciidoc grammar?

I wanted to keep it simple.  So I'll try to stay away from any fancy 
grammar parsing, and stay with "read lines until you have something to 
process".

> > 		# handle gitlink:
> > 		s/gitlink:([^\[ ]*)\[(\d+)\]/sprintf "%s",
> > 			$conv->get_link($1, $2)/ge;
> > 		# handle link:
> > 		s/link:([^\[ ]*)\[(.+)\]/sprintf "%s",
> > 			$conv->get_link($1, $2, 'external')/ge;
> 
> These REs suffer from LTS (Leaning Toothpick Syndrome).  Consider using 
> s{foo}{bar} and adding the 'x' modifier to space out groups.

I guess you mean the forward slash.  Alas, that's what I'm used to, and 
I'd rather not change it unless forced to... lest I stop understanding my 
own code!

(Besides, I did not find _any_ example showing why "x" should be useful.)

> > 	if ($self->{preamble_shown} == undef) {
> > 		$title = $text;
> > 		$title =~ s/\(\d+\)$//;
> > 		print '.\"     Title: ' . $title
> > 			. '.\"    Author: ' . "\n"
> > 			. '.\" Generator: ' . $self->{generator} . "\n"
> > 			. '.\"      Date: ' . $self->{date} . "\n"
> > 			. '.\"    Manual: ' . $self->{manual} . "\n"
> > 			. '.\"    Source: ' . $self->{git_version} . "\n"
> > 			. '.\"' . "\n";
> > 	}
> 
> I'd consider a HERE-doc, or multi-line qq{ } more readable than this.

Can you give me an example of a HERE-doc?  (What I tried to avoid is 
having ugly indentation-breaking tlobs.)

> > 	$text =~ tr/a-z/A-Z/;
> > 	my $suffix = "\"$self->{date}\" \"$self->{git_version}\""
> > 		. " \"$self->{manual}\"";
> 
> Use qq{} when making strings with lots of embedded double quotes and
> interpolation.

I'll try to find something about qq{} in the docs.

> > 	$text =~ s/^(.*)\((\d+)\)$/.TH "\1" "\2" $suffix/;
> > 	print $text;
> > 
> > 	if ($self->{preamble_shown} == undef) {
> > 		print '.\" disable hyphenation' . "\n"
> > 			. '.nh' . "\n"
> > 			. '.\" disable justification (adjust text to left'
> > 				. ' margin only)' . "\n"
> > 			. '.ad l' . "\n";
> 
> Using commas rather than "." will safe you a concat when printing to
> filehandles, but that's a very small nit to pick :)

Does that also work with older perl?  IIRC there was some strange problem 
with my perl when lots of code in git.git was changed to using commata.

> > 		# handle <<sections>
> > 		$text =~ s/<<([^>]*)>>/the section called \\(lq\1\\(rq/g;
> 
> Hmm, that regex would not match for <<foo > bar>>, if you care you'd 
> need to write something like <<((?:[^>]+|>[^>])*)>>

I'd rather leave it as is -- this script is not meant to grok all kind of 
sh*t.  It is meant to make translating the docs as fast and uncumbersome 
as possible.  Which will involve making the documentation more consistent 
(in and of itself something I rather like).

So unless there comes a compelling reason, I'd rather leave it.

> > sub begin_item {
> > 	my ($self, $item, $text) = @_;
> > 
> > 	$item = $self->common($item);
> > 	$text = $self->common($text);
> > 
> > 	$text =~ s/([^\n]) *\n([^\n])/\1 \2/g;
> 
> "." is the same as [^\n] (without the 's' modifier).

But I need the (implicit) 's' modifier, otherwise the "\n" in the middle 
is not interpreted correctly.  This regsub is meant to unwrap the 
paragraph and put it into a very long line (but leaving \n\n alone).

> > sub finish {
> > 	my ($self) = @_;
> > 	my $links = $self->{links};
> > 
> > 	if ($#$links >= 0) {
> > 		print '.SH "REFERENCES"' . "\n";
> > 		my $i = 1;
> > 		while ($#$links >= 0) {
> 
> just use if (@$links) and while (@$links)

Thanks.  I hoped there would be something like this.

Another thing: if I want to add some documentation, what would be the 
common way to do it?  =pod...=cut?

Thank you for all your tips!

Ciao,
Dscho
