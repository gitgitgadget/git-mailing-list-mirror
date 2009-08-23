From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Mon, 24 Aug 2009 09:46:35 +1200
Message-ID: <4A91B8BB.1030906@vilain.net>
References: <20090823203640.B195D189B12@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 23 23:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfKuB-0004KZ-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 23:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933952AbZHWVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 17:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755953AbZHWVrA
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 17:47:00 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48676 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbZHWVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 17:47:00 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id A32F913E7CC; Mon, 24 Aug 2009 09:47:00 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id B25C721CE53;
	Mon, 24 Aug 2009 09:46:47 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20090823203640.B195D189B12@perkele>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126884>

Peter Krefting wrote:
> Instead of having each imported tar ball's commit message be "Imported
> from filename.tar", optionally take a commit message from a file
> called "filename.tar.msg".
>
> Instead of having each commit have the same author and committer
> information, optionally read the committer information from a file
> called "filename.tar.committer" and author from a file called
> "filename.tar.author".
>
> Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
> ---
> I used this (albeit based on a slightly earlier verison of the script)
> to generate a better-looking history when importing
> http://git.debian.org/?p=crashmail/jamnntpd.git and
> http://git.debian.org/?p=crashmail/crashmail.git into Git, using
> excerpts from the embedded change history as commit messages.
>
>  contrib/fast-import/import-tars.perl |   42 +++++++++++++++++++++++++++++++--
>  1 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
> index 78e40d2..7aad16f 100755
> --- a/contrib/fast-import/import-tars.perl
> +++ b/contrib/fast-import/import-tars.perl
> @@ -109,12 +109,48 @@ foreach my $tar_file (@ARGV)
>  		$have_top_dir = 0 if $top_dir ne $1;
>  	}
>  
> +	# Optionally read a commit message from <filename.tar>.msg
> +	my $commit_msg = "Imported from $tar_file.";
> +	if (open MSG, '<', "${tar_file}.msg")
> +	{
> +		$commit_msg = '';
> +		while (<MSG>)
> +		{
> +			$commit_msg .= $_;
> +		}
> +		close MSG;
> +	}
> +
> +	# Optionally read a committer from <filename.tar>.committer
> +	# (first line is name, second line is e-mail address).
> +	my $this_committer_name = $committer_name;
> +	my $this_committer_email = $committer_email;
> +	if (open COMMITTER, '<', "${tar_file}.committer")
> +	{
> +		($this_committer_name, $this_committer_email) = <COMMITTER>;
> +		chomp $this_committer_name;
> +		chomp $this_committer_email;
> +		close COMMITTER;
> +	}
> +
> +	# Optionally read an author from <filename.tar>.author
> +	# (first line is name, second line is e-mail address).
> +	my $this_author_name = $author_name;
> +	my $this_author_email = $author_email;
> +	if (open AUTHOR, '<', "${tar_file}.author")
> +	{
> +		($this_author_name, $this_author_email) = <AUTHOR>;
> +		chomp $this_author_name;
> +		chomp $this_author_email;
> +		close AUTHOR;
> +	}
> +
>   

It's not necessary to duplicate code like that.

Also I wonder if there isn't a nicer interface for users.  Why not allow
the file to specify From:, Committer: etc as header lines

	# Optionally read a commit message from <filename.tar>.msg
	my $commit_msg = "Imported from $tar_file.";
	my ($committer, $commit_date, $author, $author_date);
	if (open MSG, '<', "${tar_file}.desc")
	{
		my $state = "header";
		$commit_msg = '';
		my $last_val;
		while (<MSG>)
		{
			if ($state eq "header") {
				if (m{^([A-Z][\w\-]+): (.*)}) {
					my ($header, $value) = $1;
					$last_val = ($header eq "Date" ? \$author_date :
						$header eq "From" ? \$author :
						$header eq "Subject" ? \$commit_msg :
						$header eq "Commit-Date" ? \$commit_date :
						$header eq "Committer" ? \$committer :
						undef );
					if ($last_val) {
						$$last_val = $value;
					}
					else {
						warn "ignoring header '$header' in ${tar_file}.desc line $.\n";
					}
				}
				elsif (m{^\s+(.+)}) {
					if ($last_val) {
						$$last_val .= " $1";
					}
				}
				elsif (m{^\s*$}) {
					$commit_msg .= ($commit_msg ? "\n" : "") . "\n";
					$state = "body";
					next;
				}
			}
			if ($state eq "body") {
				$commit_msg .= $_;
			}
		}
		close MSG;
	}

	($this_committer_name, $this_committer_email) =
		choose_email($committer, $committer_name, $committer_email);
	($this_author_name, $this_author_email) =
		choose_email($author, $author_name, $author_email);

	sub choose_email {
		my ($spec_combined, $def_name, $def_email) = @_;
		return ($def_name, $def_email) unless $spec_combined;
		if ($spec_combined =~ m{^([^<]+) <([^@]+@[^@]+)>$})) {
			($1, $2);
		}
		elsif ($spec_combined =~ m{^([^@]+@[^@]+) \((.*)\)$}) {
			($2, $1);
		}
		else {
			warn "Couldn't parse e-mail address '$spec_combined'";
			($def_name, $def_email);
		}
	}

Something like that, anyway...

Sam



>  	print FI <<EOF;
>  commit $branch_ref
> -author $author_name <$author_email> $author_time +0000
> -committer $committer_name <$committer_email> $commit_time +0000
> +author $this_author_name <$this_author_email> $author_time +0000
> +committer $this_committer_name <$this_committer_email> $commit_time +0000
>  data <<END_OF_COMMIT_MESSAGE
> -Imported from $tar_file.
> +$commit_msg
>  END_OF_COMMIT_MESSAGE
>  
>  deleteall
>   
