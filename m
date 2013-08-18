From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-send-email: Cache generated message-ids, use them when prompting
Date: Sun, 18 Aug 2013 14:08:00 -0700
Message-ID: <7vvc32n1vz.fsf@alter.siamese.dyndns.org>
References: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Sun Aug 18 23:08:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBACo-0003ap-MU
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 23:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3HRVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 17:08:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab3HRVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 17:08:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB61D3A203;
	Sun, 18 Aug 2013 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XNtAOF4k31MT10QwtpBM59JHamw=; b=ZMha16
	/MpwLbwikb9OoJluUepCkFcMtCsoGJkNy88gaCUmeU/DSeaYdJ0fdV+8RU2CEI9t
	o4xbVHdDumkBcm962NNjlh4OeJX1s2tdPRP4mWoZRDv1uiseHDrKaM0pVGusn/HP
	iHxAfzoHj8NRb9YjlUoS8d5GogsjNnX3gjjHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wSD5jwA5jrng/O9ipwQcZHEpgZVuyvAp
	CHpSHDDjfLx9zA0H5W/25uMLkgv/gvgVdp9/B9jDDqi1dHAZXLNPWAESo6u+14hB
	XHN9TbvXiu43nfWvCrg3DPvVc7nXXQpLhdEpHKFJBA7jIZx7oBqSmMjBGT9WJUXU
	XoQX2aMG2/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF383A202;
	Sun, 18 Aug 2013 21:08:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D259C3A1FE;
	Sun, 18 Aug 2013 21:08:01 +0000 (UTC)
In-Reply-To: <1376701126-5759-1-git-send-email-rv@rasmusvillemoes.dk> (Rasmus
	Villemoes's message of "Sat, 17 Aug 2013 00:58:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 445BD300-084A-11E3-AB44-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232519>

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> This is mostly a proof of concept/RFC patch. The idea is for
> git-send-email to store the message-ids it generates, along with the
> Subject and Date headers of the message. When prompting for which
> Message-ID should be used in In-Reply-To, display a list of recent
> emails (identifed using the Date/Subject pairs; the message-ids
> themselves are not for human consumption). Choosing from that list
> will then use the corresponding message-id; otherwise, the behaviour
> is as usual.
>
> When composing v2 or v3 of a patch or patch series, this avoids the
> need to get one's MUA to display the Message-ID of the earlier email
> (which is cumbersome in some MUAs) and then copy-paste that.
>
> If this idea is accepted, I'm certain I'll get to use the feature
> immediately, since the patch is not quite ready for inclusion :-)
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> ---
>  git-send-email.perl | 101 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 5 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index f608d9b..2e3685c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -26,6 +26,7 @@ use Data::Dumper;
>  use Term::ANSIColor;
>  use File::Temp qw/ tempdir tempfile /;
>  use File::Spec::Functions qw(catfile);
> +use Date::Parse;

Hmm, is this part of core that we do not have to worry about some
people not having it?  It appears that Git/SVN/Log.pm explicitly
avoids using it.

> @@ -203,6 +204,7 @@ my ($validate, $confirm);
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> +my ($msgid_cache_file, $msgid_maxprompt);

I do not see $msgid_maxprompt used anywhere in the new code.

>  
>  my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
>  
> @@ -214,7 +216,7 @@ my %config_bool_settings = (
>      "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
>      "validate" => [\$validate, 1],
>      "multiedit" => [\$multiedit, undef],
> -    "annotate" => [\$annotate, undef]
> +    "annotate" => [\$annotate, undef],

Is this related to this patch in any way?

>  );
>  
>  my %config_settings = (
> @@ -237,6 +239,7 @@ my %config_settings = (
>      "from" => \$sender,
>      "assume8bitencoding" => \$auto_8bit_encoding,
>      "composeencoding" => \$compose_encoding,
> +    "msgidcachefile" => \$msgid_cache_file,
>  );
>  
>  my %config_path_settings = (
> @@ -311,6 +314,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>  		    "compose-encoding=s" => \$compose_encoding,
>  		    "force" => \$force,
> +		    "msgid-cache-file=s" => \$msgid_cache_file,
>  	 );

Is there a standard, recommended location we suggest users to store
this?  

>  usage() if $help;
> @@ -784,10 +788,31 @@ sub expand_one_alias {
>  @bcclist = validate_address_list(sanitize_address_list(@bcclist));
>  
>  if ($thread && !defined $initial_reply_to) {
> -	$initial_reply_to = ask(
> -		"Message-ID to be used as In-Reply-To for the first email (if any)? ",
> -		default => "",
> -		valid_re => qr/\@.*\./, confirm_only => 1);
> +	my @choices;
> +	if ($msgid_cache_file) {
> +		@choices = msgid_cache_getmatches();

It is a bit strange that "filename is specified => we will find the
latest 10" before seeing if we even check to see if that file
exists.  I would have expected that a two-step "filename is given =>
try to read it" and "if we did read something => give choices"
process would be used.

Also "getmatches" that does not take any clue from what the caller
knows (the title of the series, for example) seems much less useful
than ideal.  The callee is not getting anything to work with to get
sensible "matches".

> @@ -1282,6 +1307,8 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
>  
> +	msgid_cache_this($message_id, $subject, $date) if ($msgid_cache_file && !$dry_run);

Is this caching each and every one, even for things like "[PATCH 23/47]"?

> @@ -1508,6 +1535,8 @@ sub cleanup_compose_files {
>  
>  $smtp->quit if $smtp;
>  
> +msgid_cache_write() if $msgid_cache_file;

Is this done under --dry-run?

> @@ -1556,3 +1585,65 @@ sub body_or_subject_has_nonascii {
>  	}
>  	return 0;
>  }
> +
> +my @msgid_new_entries;
> +
> +# For now, use a simple tab-separated format:
> +#
> +#    $id\t$date\t$subject\n
> +sub msgid_cache_read {
> +	my $fh;
> +	my $line;
> +	my @entries;
> +	if (not open ($fh, '<', $msgid_cache_file)) {
> +		# A non-existing cache file is ok, but should we warn if errno != ENOENT?

It should not be a warning but an informational message, "creating a
new cachefile", when bootstrapping, no?

> +	while ($line = <$fh>) {
> +		chomp($line);
> +		my ($id, $date, $subject) = split /\t/, $line;
> +		my $epoch = str2time($date);
> +		push @entries, {id=>$id, date=>$date, epoch=>$epoch, subject=>$subject};
> +	}
> +	close($fh);
> +	return @entries;

So all the old ones are read, without dropping ancient and possibly
useless ones here...

> +sub msgid_cache_write {
> +	my $fh;
> +	if (not open($fh, '>>', $msgid_cache_file)) {
> +	    warn "cannot open $msgid_cache_file for appending: $!";
> +	    return;
> +	}
> +	printf $fh "%s\t%s\t%s\n", $_->{id}, $_->{date}, $_->{subject} for (@msgid_new_entries);
> +	close($fh);

And the new ones are appended to the end without expiring anything.

When does the cache shrink, and who is responsible for doing so?

> +# Return an array of cached message-ids, ordered by "relevance". It
> +# might make sense to take the Subject of the new mail as an extra
> +# argument and do some kind of fuzzy matching against the old
> +# subjects, but for now "more relevant" simply means "newer".
> +sub msgid_cache_getmatches {
> +	my ($maxentries) = @_;
> +	$maxentries //= 10;

The //= operator is mentioned in perl581delta.pod, it seems, and
none of our Perl scripted Porcelains seems to use it yet.  Is it
safe to assume that everybody has it?

> +	my @list = msgid_cache_read();
> +	@list = sort {$b->{epoch} <=> $a->{epoch}} @list;
> +	@list = @list[0 .. $maxentries-1] if (@list > $maxentries);
> +	return @list;
> +}
> +
> +sub msgid_cache_this {
> +	my $msgid = shift;
> +	my $subject = shift;
> +	my $date = shift;
> +	# Make sure there are no tabs which will confuse us, and save
> +	# some valuable horizontal real-estate by removing redundant
> +	# whitespace.
> +	if ($subject) {
> +		$subject =~ s/^\s+|\s+$//g;
> +		$subject =~ s/\s+/ /g;
> +	}
> +	# Replace undef or the empty string by an actual string. Nobody uses "0" as the subject...

That's a strange sloppiness for somebody who uses //=, no?

> +	$subject ||= '(none)';
> +	$date //= format_2822_time(time());
> +	$date =~ s/\s+/ /g;
> +	push @msgid_new_entries, {id => $msgid, subject => $subject, date => $date};
> +}

I am personally not very interested, but that only means I will not
be the one who will be enthusiastically rooting for inclusion; it
does not mean I reject the general notion outright.

But the behaviour the posted patch seems to implement seems to fall
far short of how useful the general notion "save message ID of what
we sent, so that we can reply to them" could be.
