From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH (resend)] send-email: address expansion for common mailers
Date: Mon, 15 May 2006 00:12:28 -0400
Message-ID: <20060515041227.GP32076@h4x0r5.com>
References: <20060326024416.GA14234@localdomain> <11476592243181-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon May 15 06:13:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfUSs-0002rK-9V
	for gcvg-git@gmane.org; Mon, 15 May 2006 06:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWEOENq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 00:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEOENq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 00:13:46 -0400
Received: from h4x0r5.com ([70.85.31.202]:22799 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751406AbWEOENp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 00:13:45 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FfURY-00059F-Rh; Mon, 15 May 2006 00:12:28 -0400
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <11476592243181-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20015>

On Sun, May 14, 2006 at 07:13:44PM -0700, Eric Wong wrote:
> mutt, gnus, pine, mailrc formats should be supported.
> 
> Testing and feedback for correctness and completeness of all formats
> and support for additional formats would be good.
> 
> Nested expansions are also supported.
> 
> More than one alias file to be used.
> 
> All alias file formats must still of be the same type, though.
> 
> Two git repo-config keys are required for this
> (as suggested by Ryan Anderson):
> 
>     sendemail.aliasesfile = <filename of aliases file>
>     sendemail.aliasfiletype = (mutt|gnus|pine|mailrc)
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
Acked-by: Ryan Anderson <ryan@michonline.com>

> ---
> 
> Looks like this patch got forgotten a while ago, and I never noticed
> because I forgot to set WITH_SEND_EMAIL when doing make install.
> Of course, WITH_SEND_EMAIL should no longer be needed...
> 
>  git-send-email.perl |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 48 insertions(+), 0 deletions(-)
> 
> ff6593287dc500853c1cf05bdb0f32f970f10c9d
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 703dd1f..d8c4b1f 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -89,6 +89,41 @@ sub gitvar_ident {
>  my ($author) = gitvar_ident('GIT_AUTHOR_IDENT');
>  my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
>  
> +my %aliases;
> +chomp(my @alias_files = `git-repo-config --get-all sendemail.aliasesfile`);
> +chomp(my $aliasfiletype = `git-repo-config sendemail.aliasfiletype`);
> +my %parse_alias = (
> +	# multiline formats can be supported in the future
> +	mutt => sub { my $fh = shift; while (<$fh>) {
> +		if (/^alias\s+(\S+)\s+(.*)$/) {
> +			my ($alias, $addr) = ($1, $2);
> +			$addr =~ s/#.*$//; # mutt allows # comments
> +			 # commas delimit multiple addresses
> +			$aliases{$alias} = [ split(/\s*,\s*/, $addr) ];
> +		}}},
> +	mailrc => sub { my $fh = shift; while (<$fh>) {
> +		if (/^alias\s+(\S+)\s+(.*)$/) {
> +			# spaces delimit multiple addresses
> +			$aliases{$1} = [ split(/\s+/, $2) ];
> +		}}},
> +	pine => sub { my $fh = shift; while (<$fh>) {
> +		if (/^(\S+)\s+(.*)$/) {
> +			$aliases{$1} = [ split(/\s*,\s*/, $2) ];
> +		}}},
> +	gnus => sub { my $fh = shift; while (<$fh>) {
> +		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
> +			$aliases{$1} = [ $2 ];
> +		}}}
> +);
> +
> +if (@alias_files && defined $parse_alias{$aliasfiletype}) {
> +	foreach my $file (@alias_files) {
> +		open my $fh, '<', $file or die "opening $file: $!\n";
> +		$parse_alias{$aliasfiletype}->($fh);
> +		close $fh;
> +	}
> +}
> +
>  my $prompting = 0;
>  if (!defined $from) {
>  	$from = $author || $committer;
> @@ -112,6 +147,19 @@ if (!@to) {
>  	$prompting++;
>  }
>  
> +sub expand_aliases {
> +	my @cur = @_;
> +	my @last;
> +	do {
> +		@last = @cur;
> +		@cur = map { $aliases{$_} ? @{$aliases{$_}} : $_ } @last;
> +	} while (join(',',@cur) ne join(',',@last));
> +	return @cur;
> +}
> +
> +@to = expand_aliases(@to);
> +@initial_cc = expand_aliases(@initial_cc);
> +
>  if (!defined $initial_subject && $compose) {
>  	do {
>  		$_ = $term->readline("What subject should the emails start with? ",
> -- 
> 1.3.2.g1c9b
> 
> 
