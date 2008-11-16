From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/4] gitweb: introduce remote_heads feature
Date: Sun, 16 Nov 2008 09:16:32 -0800
Message-ID: <7vvdun3827.fsf@gitster.siamese.dyndns.org>
References: <1226842089-1159-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:18:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1lGS-000802-WE
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbYKPRQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYKPRQs
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:16:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYKPRQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:16:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A991E16D54;
	Sun, 16 Nov 2008 12:16:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3786616D46; Sun,
 16 Nov 2008 12:16:33 -0500 (EST)
In-Reply-To: <1226842089-1159-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Sun, 16 Nov 2008 14:28:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58634FC8-B402-11DD-995E-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101143>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> With this feature enabled, remotes are retrieved (and displayed)
> when getting (and displaying) the heads list.

Wouldn't it be easier to read if you just said: "Include 'remotes' in the
heads_list", because:

 - "heads list" does not sound like a proper English phrase but you are
   referring to the sub "heads_list";

 - it is obvious and unnecessary to say "when getting, they are retrieved,
   when displaying, they are displayed", which is what your parenthesized
   parts of the sentence is about;

I am also suggesting to drop "With this feature enabled"; I do not think
of a case where somebody runs gitweb on a repository with refs/remotes and
does not want to show them.

> Typical usage would be for
> local repository browsing, e.g. by using git-instaweb (or even a more
> permanent gitweb setup), to check the repository status and the relation
> between tracking branches and the originating remotes.

When proofreading what you've written, it is usually a good idea to read
it without anything you wrote in parentheses once, and then re-read it
with parentheses removed (but the stuff in your parentheses kept), and
compare which one you like better.  More often than not, you'd find that
either parenthesized parts are unnecessary, or they are important enough
that you shouldn't put them in parentheses.

In this case, because you made it clear that you are giving just an
example and not trying to be exhaustive by saying "e.g.", I think dropping
the parenthesized part from the description is better.

Also I think the description is better without "to check...originating
remotes.", because:

 - "to check the repository status"?  what status?  it is too broad to be
   a meaningful description;

 - "relation between tracking vs origin" is one thing gitweb is very bad
   at doing, because it flattens the history, compared to things like
   gitk, which you need to compete with especially because you are
   advocating the feature to help local browsing.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b0d00ea..e1f81f6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -329,6 +329,18 @@ our %feature = (
> ...
> @@ -410,6 +422,18 @@ sub feature_pickaxe {
> ...
> +sub feature_remote_heads {
> ...
> +}

When would somebody want to disable this?  Please explain; I'd like to
understand the motivation behind it.

One argument for making this feature optional I can think of is to retain
backward compatibility because we didn't show them before, but I would say
that is a weak argument.  Before release 1.5.0 made the separate remotes
layout the default, everything was in refs/heads/, so you could even argue
that this "fixes" the gitweb bug introduced in that release that stopped
showing the branches you copied from elsewhere.

> @@ -2660,10 +2684,12 @@ sub git_get_heads_list {
>  	my $limit = shift;
>  	my @headslist;
>  
> +	my $remote_heads = gitweb_check_feature('remote_heads');
> +
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -		'refs/heads'
> +		'refs/heads', ( $remote_heads ? 'refs/remotes' : '')
>  		or return;
>  	while (my $line = <$fd>) {
>  		my %ref_item;

Imagine a later version of git may introduce 'refs/frotz/nitfol' namespace
hierarchy that is commonly known as the 'xyzzy class' and is also useful
to show.  Wouldn't it be easier to update gitweb to match such a change if
this part of the code were written like this?

	my %head_class = ('refs/heads' => 'head');
	$head_class{'refs/remotes'} = 'remote'
	        if ( this feature is used );
	$head_class{'refs/frotz/nitfol'} = 'xyzzy'
	        if ( the xyzzy class is used);
        open my $fd, ... (keys %head_class);

> @@ -2674,8 +2700,9 @@ sub git_get_heads_list {
>  		my ($committer, $epoch, $tz) =
>  			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
>  		$ref_item{'fullname'}  = $name;
> -		$name =~ s!^refs/heads/!!;
> +		$name =~ s!^refs/(head|remote)s/!!;
>  
> +		$ref_item{'class'} = $1;

And then outside the loop, you'd prepare:

	my $headpat = join('|', map { quotemeta($_) } keys %head_class);

and inside the loop you would do:

	if ($name =~ s{^($headpat)/}{}) {
        	$ref_item{'class'} = $head_class{$1};
		...

Only one place to configure the list of classes, and make everybody use
that list instead of hardcoding the assumption that there are two and only
two kinds of things "head" vs "remote".
