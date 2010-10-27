From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Wed, 27 Oct 2010 02:32:34 +0200
Message-ID: <201010270232.37961.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 02:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAtwh-0001tC-9b
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 02:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760652Ab0J0Aco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 20:32:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47190 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab0J0Acm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 20:32:42 -0400
Received: by bwz11 with SMTP id 11so92540bwz.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6oEII6vYtkPgAMBu/M5PE7+xjm+PPBQwPuQ8e8pdzag=;
        b=T71KO1oNldIWkvab49Nqs1K7BoEaOtI68jLGT+fPGuPZelhzloC4RZA2iou7FNFkhq
         1Cc1hGFQIeP+u0Ii18iKx5plLOkJlfJ8oAaz1yldxOJi1/h77QHsqMQQhaTAou7f2Sl9
         Z3aMtJhJLiy5f0MB2y8ckQK6DuRXqKzNvscZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dpMi1At0uySvTzciX6FIzFhysq8dO6GHbbdccL86gG7xtLVfpN1aNXuiacHLRwCEQD
         teOmhLhr1K7GDZ6GtN0ncPGpvzmq06tUOpWre+HK5qK6eLyiHpZZ1/evs/NyJmOOBkEk
         GjIxFurQDELKeUDVci5V0CL+6BhUKD0d+ftiA=
Received: by 10.204.50.211 with SMTP id a19mr6787485bkg.130.1288139560229;
        Tue, 26 Oct 2010 17:32:40 -0700 (PDT)
Received: from [192.168.1.13] (abwo92.neoplus.adsl.tpnet.pl [83.8.238.92])
        by mx.google.com with ESMTPS id g8sm6454448bkg.11.2010.10.26.17.32.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Oct 2010 17:32:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160015>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> In remote and summary view, display a block for each remote, with the
> fetch and push URL(s) as well as the list of the remote heads.
> 
> In summary view, if the number of remotes is higher than a prescribed
> limit, only display the first <limit> remotes and their fetch and push
> urls, without any heads information and without grouping.

I like this idea.

I guess that we can always implement more fancy limiting in the future
(e.g. taking into account total number of displayed remote heads).

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl       |  185 +++++++++++++++++++++++++++++++++++++++++-----
>  gitweb/static/gitweb.css |    6 ++
>  2 files changed, 172 insertions(+), 19 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index feca8bc..5f08dcc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2772,6 +2772,66 @@ sub git_get_last_activity {
>  	return (undef, undef);
>  }
>  
> +# Returns a hash ref mapping remote names to their fetch and push URLs.
> +# We return a hash ref rather than a hash so that a simple check with defined
> +# can be used to tell apart the "no remotes" case from other kinds of
> +# failures.

Just an idea (it is not necessary to implement it; it has its own
drawbacks): we could implement here

  return wantsarray ? %remotes : \%remotes;

so the caller that wants hash, would get hash; and the one wanting
reference (to distinguish error from no remotes), would get hash
reference.

> +#
> +# It is possible to limit the retrieved remotes either by number
> +# (specifying a -limit parameter) or by name (-wanted parameter).

I don't quite like limiting when generating, and would prefer do limiting
on display, especially if not doing limiting would not affect performance
much (git command invoked doesn't do limiting, like in case of 
git_get_heads_list / git_get_tags_list or *most important* parse_commits).

Especially if it complicates code that much (see below).

Not doing limiting here, in git_get_remotes_list (or just git_get_remotes)
would also make API simpler; the single optional argument would be name of
remote we want to retrieve.

+# It is possible to limit the retrieved remotes to only single remote
+# by passing its name as a parameter to git_get_remotes_list.


> +#
> +# When a single remote is wanted, we cannot use 'git remote show -n' because
> +# that command always work (assuming it's a remote URL if it's not defined),
> +# and we cannot use 'git remote show' because that would try to make a network
> +# roundtrip. So the only way to find if that particular remote is defined is to
> +# walk the list provided by 'git remote -v' and stop if and when we find what
> +# we want.

I would add 'Implemetation note: ' here, which means start with
'Implementation note: When ..." -- but it is not necessary.

> +sub git_get_remotes_list {
> +	my %params = @_;
> +	my $limit = $params{-limit};
> +	my $wanted = $params{-wanted};
> +	my %remotes = ();
> +
> +	open my $fd, '-|' , git_cmd(), 'remote', '-v';
> +	return unless $fd;
> +	while (my $remote = <$fd>) {
> +		chomp $remote;
> +		$remote =~ s!\t(.*?)\s+\((\w+)\)$!!;
> +		next if $wanted and not $remote eq $wanted;
> +		my ($url, $key) = ($1, $2);
> +
> +		# a remote may appear more than once because of multiple URLs,
> +		# so if this is a remote we know already, be sure to continue,
> +		# lest we end up with a remote for which we get the fetch URL
> +		# bot not the push URL, for example
> +		my $more = exists $remotes{$remote};
> +		$more ||= defined $limit ? (keys(%remotes) <= $limit) : 1;
> +		if ($more) {
> +			$remotes{$remote} ||= { 'heads' => () };
> +			$remotes{$remote}{$key} = $url;
> +		} else {
> +			last;
> +		}
> +	}
> +	close $fd or return;
> +	return \%remotes;
> +}

Without implementing limiting in git_get_remotes_list(), but leaving it
for the display subroutine, it would reduce to:

+sub git_get_remotes_list {
+	my $wanted = shift;
+	my %remotes = ();
+
+	open my $fd, '-|' , git_cmd(), 'remote', '-v';
+	return unless $fd;
+	while (my $remote = <$fd>) {
+		chomp $remote;
+		next unless ($remote =~ s!\t(.*?)\s+\((\w+)\)$!!);
+		# $wanted remote might be present multiple times in output
+		next if ($wanted && $remote ne $wanted);
+		my ($url, $key) = ($1, $2);
+
+		$remotes{$remote}{$key} = $url;
+	}
+	close $fd or return;
+	return \%remotes;
+}

> +
> +# Takes a hash of remotes as first parameter and fills it by adding the
> +# available remote heads for each of the indicated remotes.
> +# A maximum number of heads can also be specified.

All git_get_* subroutines _return_ something; this looks more like fill_*
function for me.

> +sub git_get_remote_heads {
> +	my ($remotes, $limit) = @_;
> +	my @heads = map { "remotes/$_" } keys %$remotes;
> +	my @remoteheads = git_get_heads_list($limit, @heads);
> +	foreach (keys %$remotes) {
> +		my $remote = $_;
> +		$remotes->{$remote}{'heads'} = [ grep {
> +			$_->{'name'} =~ s!^$remote/!!
> +			} @remoteheads ];
> +	}
> +}

We could remove limiting number of heads shown per remote also from here,
but this time 1.) the $limit parameter is passed down to git_get_heads_list
which in turn uses $limit as parameter to git command  2.) it doesn't
simplify code almost at all:

+sub fill_remote_heads {
+	my $remotes = shift;
+
+	my @heads = map { "remotes/$_" } keys %$remotes;
+	## A QUESTION: perhaps it would be better to pass @remoteheads as parameter?
+	my @remoteheads = git_get_heads_list(undef, @heads);
+	foreach my $remote (keys %$remotes) {
+		$remotes->{$remote}{'heads'} =
+			[ grep { $_->{'name'} =~ s!^$remote/!! } @remoteheads ];
+	}
+}


A QUESTION: perhaps it would be better to pass @remoteheads as parameter?
I wonder if won't end up with calling git_get_heads_list multiple times...
well, the improvement can be left for later.  Answering this question
should not affect accepting this patch series.

> +
>  sub git_get_references {
>  	my $type = shift || "";
>  	my %refs;
> @@ -5054,6 +5114,100 @@ sub git_heads_body {
>  	print "</table>\n";
>  }
>  
> +# Display a single remote block

Note that you would end up with two very similarly named subrotines:
git_remote_body and git_remotes_body.  Perhaps it would be better to
call this one git_remote_block, or git_describe_remote?

> +sub git_remote_body {
> +	my ($remote, $rdata, $limit, $head) = @_;
> +
> +	my $heads = $rdata->{'heads'};
> +	my $fetch = $rdata->{'fetch'};
> +	my $push = $rdata->{'push'};

We could have used the following Perl shortcut

+	my ($heads, $fetch, $push) = @{$rdata}{qw(heads fetch push)};

but it isn't needed, and I guess it even could hurt readibility...

> +
> +	my $urls = "<table class=\"projects_list\">\n" ;
> +
> +	if (defined $fetch) {
> +		if ($fetch eq $push) {
> +			$urls .= format_repo_url("URL", $fetch);
> +		} else {
> +			$urls .= format_repo_url("Fetch URL", $fetch);
> +			$urls .= format_repo_url("Push URL", $push) if defined $push;
> +		}
> +	} elsif (defined $push) {
> +		$urls .= format_repo_url("Push URL", $push);
> +	} else {
> +		$urls .= format_repo_url("", "No remote URL");
> +	}
> +
> +	$urls .= "</table>\n";

I'm not sure about naming this variable $urls...

> +
> +	my ($maxheads, $dots);
> +	if (defined $limit) {
> +		$maxheads = $limit - 1;
> +		if ($#{$heads} > $maxheads) {
> +			$dots = $cgi->a({-href => href(action=>"remotes", hash=>$remote)}, "...");
> +		}
> +	}
> +
> +	print $urls;
> +	git_heads_body($heads, $head, 0, $maxheads, $dots);

Wouldn't this be simpler:

+	my $dots;
+	if (defined $limit && $limit < @$heads) {
+		$dots = $cgi->a({-href => href(action=>"remotes", hash=>$remote)}, "...");
+	}
+
+	print $urls;
+	git_heads_body($heads, $head, 0, $limit, $dots);

We would do similar trick as in other parts: request one item more than we
display to check if there is more data.

> +}
> +
> +# Display a list of remote names with the respective fetch and push URLs
> +# This routine only gets called when there are more remotes than the given
> +# limit, so we know that we have to append an ellipsis to the table and
> +# that we have to pop one of the keys.

I think it would be a better idea to make this subroutine generic: display
only list of remotes, limited to $limit remotes maximum.

+# Display a list of remote names with the respective fetch and push URLs,
+# without displaying remote heads (used when there are too many remotes).

> +sub git_remotes_list {
> +	my ($remotedata) = @_;
> +	print "<table class=\"heads\">\n";
> +	my $alternate = 1;
> +	my @keys = sort keys %$remotedata;
> +	pop @keys;
> +
> +	while (my $remote = shift @keys) {
> +		my $rdata = $remotedata->{$remote};
> +		my $fetch = $rdata->{'fetch'};
> +		my $push = $rdata->{'push'};

If we do explicit limiting (not assuming that $remotedata is already
limited on generation), it could look like the following:

+sub git_remotes_list {
+	my ($remotedata, $limit) = @_;
+
+	print "<table class=\"heads\">\n";
+	my $alternate = 1;
+	my @remotes = sort keys %$remotedata;
+	$limit = scalar @remotes
+		unless defined $limit;
+
+	for (my $i = 0; $i < $limit; $i++) {
+		my $remote = $remotes[$i];
+		my $rdata = $remotedata->{$remote};
+		my $fetch = $rdata->{'fetch'};
+		my $push  = $rdata->{'push'};

> +		if ($alternate) {
> +			print "<tr class=\"dark\">\n";
> +		} else {
> +			print "<tr class=\"light\">\n";
> +		}
> +		$alternate ^= 1;
> +		print "<td>" .
> +		      $cgi->a({-href=> href(action=>'remotes', hash=>$remote),
> +			       -class=> "list name"},esc_html($remote)) . "</td>";

Very, very minor nitpick: if "<td>" is on separate line, why "</td>"
isn't?

> +		print "<td class=\"link\">" .
> +		      (defined $fetch ? $cgi->a({-href=> $fetch}, "fetch") : "fetch") .
> +		      " | " .
> +		      (defined $push ? $cgi->a({-href=> $push}, "push") : "push") .
> +		      "</td>";
> +
> +		print "</tr>\n";
> +	}
> +	print "<tr>\n" .
> +	      "<td colspan=\"3\">" .
> +	      $cgi->a({-href => href(action=>"remotes")}, "...") .
> +	      "</td>\n" . "</tr>\n";

With explicit limiting this would be:

+	if ($limit < @remotes) {
+		print "<tr>\n" .
+		      "<td colspan=\"3\">" .
+		      $cgi->a({-href => href(action=>"remotes")}, "...") .
+		      "</td>\n" .
+		      "</tr>\n";
+	}

> +	print "</table>";
> +}
> +
> +# Display remote heads grouped by remote, unless there are too many
> +# remotes ($have_all is false), in which case we only display the remote
> +# names

This of course also would have to be changed if limiting is done at
display time, not at generation time (at least for limiting list of
remotes, if not for generating list of refs).

> +sub git_remotes_body {
> +	my ($remotedata, $limit, $head) = @_;
> +	if (not defined $limit or scalar keys %$remotedata <= $limit) {
> +		git_get_remote_heads($remotedata, $limit);
> +		while (my ($remote, $rdata) = each %$remotedata) {
> +			git_print_section({-class=>"remote", -id=>$remote},
> +				["remotes", $remote, $remote], sub {
> +					git_remote_body($remote, $rdata, $limit, $head);
> +				});
> +		}
> +	} else {
> +		git_remotes_list($remotedata, $limit);
> +	}

Minor issue: wouldn't it make for easier reading to have less code in
the 'if' part of if { ... } else { ... } clause, and more code in 'else'
part.

> +}

The rewritten function, which makes invoked display subroutines to do
the limiting by themselves, could look like this:

+# Display remote heads grouped by remote, unless there are too many
+# remotes, in which case we only display the remote names
+sub git_remotes_body {
+	my ($remotedata, $limit, $head) = @_;
+
+	if (defined $limit && $limit < scalar keys %$remotedata) {
+		# $limit limits number of displayed remotes
+		git_remotes_list($remotedata, $limit);
+
+	} else {
+		# $limit limits number of displayed heads in each remote
+		fill_remote_heads($remotedata); ## or fill_remote_heads($remotedata, $limit+1);
+		while (my ($remote, $rdata) = each %$remotedata) {
+			git_print_section(
+				{-class=>"remote", -id=>$remote},
+				["remotes", $remote, $remote],
+				sub { git_remote_block($remote, $rdata, $limit, $head) }
+			);
+		}
+	}
+}


> +
>  sub git_search_grep_body {
>  	my ($commitlist, $from, $to, $extra) = @_;
>  	$from = 0 unless defined $from;
> @@ -5200,7 +5354,7 @@ sub git_summary {
>  	# there are more ...
>  	my @taglist  = git_get_tags_list(16);
>  	my @headlist = git_get_heads_list(16, 'heads');
> -	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
> +	my $remotedata = $remote_heads ? git_get_remotes_list(-limit => 16) : undef;

If git_get_remotes_list wouldn't do limiting, it would simply be

-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my $remotedata = $remote_heads ? git_get_remotes_list() : undef;

>  	my @forklist;
>  	my $check_forks = gitweb_check_feature('forks');
>  
> @@ -5278,11 +5432,9 @@ sub git_summary {
>  		               $cgi->a({-href => href(action=>"heads")}, "..."));
>  	}
>  
> -	if (@remotelist) {
> +	if ($remotedata) {
>  		git_print_header_div('remotes');
> -		git_heads_body(\@remotelist, $head, 0, 15,
> -		               $#remotelist <= 15 ? undef :
> -		               $cgi->a({-href => href(action=>"remotes")}, "..."));
> +		git_remotes_body($remotedata, 16, $head);
>  	}
>  
>  	if (@forklist) {

This wouldn't change, and would be the same even if git_get_remotes_list
wouldn't do limiting.


Perhaps it would be worth adding comment about git_remotes:

@@ -5599,6 +5740,7 @@ sub git_heads {
 	git_footer_html();
 }
 
+# dual lived: used both for single remote view, and for list of all remotes
 sub git_remotes {
 	gitweb_check_feature('remote_heads')
 		or die_error(403, "Remote heads view is disabled");


Though I am not sure if it is good public API.  Perhaps it is...

> @@ -5606,31 +5758,26 @@ sub git_remotes {
>  	my $head = git_get_head_hash($project);
>  	my $remote = $input_params{'hash'};
>  
> -	my @remotelist;
> +	my $remotedata = git_get_remotes_list(-wanted => $remote);
> +	die_error(500, "Unable to get remote information") unless defined $remotedata;

It would be little simpler with git_get_remotes_list not doing the
limiting, because of which we can use slightly simpler API.

+	my $remotedata = git_get_remotes_list($remote);
+	die_error(500, "Unable to get remote information")
+		unless defined $remotedata;

>  
> -	if (defined $remote) {
> -		# only display the heads in a given remote
> -		@remotelist = map {
> -			my $ref = $_ ;
> -			$ref->{'name'} =~ s!^$remote/!!;
> -			$ref
> -		} git_get_heads_list(undef, "remotes/$remote");
> -	} else {
> -		@remotelist = git_get_heads_list(undef, 'remotes');
> +	if (keys(%$remotedata) == 0) {

You can write simply

+	unless (%$remotedata) {

>From perldata(1):  "If you evaluate a hash in scalar context, it returns
false if the hash is empty."

> +		die_error(404, defined $remote ?
> +			"Remote $remote not found" :
> +			"No remotes found");
>  	}
>  
>  	git_header_html(undef, undef, -action_extra => $remote);
>  	git_print_page_nav('', '',  $head, undef, $head,
>  		format_ref_views($remote ? '' : 'remotes'));
>  
> +	git_get_remote_heads($remotedata, undef);

+	fill_remote_heads($remotedata, undef);

>  	if (defined $remote) {
>  		git_print_header_div('remotes', "$remote remote for $project");
> +		git_remote_body($remote, $remotedata->{$remote}, undef, $head);
>  	} else {
>  		git_print_header_div('summary', "$project remotes");
> -	}
> -
> -	if (@remotelist) {
> -		git_heads_body(\@remotelist, $head);
> +		git_remotes_body($remotedata, undef $head);
>  	}

You are missing comma after 'undef' here

-	if (@remotelist) {
-		git_heads_body(\@remotelist, $head);
+		git_remotes_body($remotedata, undef, $head);
 	}

-- 
Jakub Narebski
ShadeHawk on #git
