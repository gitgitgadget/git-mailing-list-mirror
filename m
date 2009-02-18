From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/2] gitweb: Fix warnings with override permitted but
 no repo override
Date: Wed, 18 Feb 2009 00:40:27 -0800
Message-ID: <7vvdr8yw78.fsf@gitster.siamese.dyndns.org>
References: <499AD871.8000808@oak.homeunix.org>
 <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, fg@one2team.net,
	giuseppe.bilotta@gmail.com, pasky@suse.cz
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 09:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZi0N-0006TH-0k
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 09:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbZBRIkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 03:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZBRIkj
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 03:40:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbZBRIki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 03:40:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F0ED72B61C;
	Wed, 18 Feb 2009 03:40:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D0282B579; Wed,
 18 Feb 2009 03:40:29 -0500 (EST)
In-Reply-To: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org>
 (Marcel M. Cary's message of "Tue, 17 Feb 2009 19:00:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D06D78D4-FD97-11DD-B797-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110515>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> When a feature like "blame" is permitted to be overridden in the
> repository configuration but it is not actually set in the
> repository, a warning is emitted due to the undefined value
> of the repository configuration, even though it's a perfectly
> normal condition.
>
> The warning is grounds for test failure in the gitweb test script,
> so it causes some new feature tests of mine to fail.
>
> This patch prevents warning and adds a test case to exercise it.
>
> Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> ---
>
> Here's a small patch I put together while tinkering with bug hyperlinking.
> Does this look reasonable?

To my cursory look, it doesn't, and it is not entirely your fault, but if
we applied this patch, it would not improve things very much.  It just
would shift the same problem around.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7c48181..653f0be 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -402,13 +402,13 @@ sub feature_bool {
>  	my $key = shift;
>  	my ($val) = git_get_project_config($key, '--bool');
>  
> -	if ($val eq 'true') {
> +	if (!defined $val) {
> +		return ($_[0]);
> +	} elsif ($val eq 'true') {
>  		return (1);
>  	} elsif ($val eq 'false') {
>  		return (0);
>  	}

I think the warning you are talking about is to compare $val with 'true'
with 'eq' operator when $val could be undef.  The check to see if $val is
undefined ato avoid that 'eq' comparison is fine, and the intent to return
false is also good, but I think feature_bool is meant to say "yes" or
"no", and existing code for 'false' is returning (0).  I'd rather see your
new codepath normalize incoming undef the same way string 'false' is
normalized to return (0).  Granted, the caller should be prepared to take
the answer as boolean and treat the usual Perl false values (numeric zero,
a string with single "0", or an undef) without barfing, so returning (undef)
from here ought to be safe (otherwise the callers are broken), but I'd
rather see this function play safe.

But it certainly is not my main complaint.

>  sub feature_snapshot {
> @@ -1978,6 +1978,8 @@ sub git_get_project_config {
>  		$config_file = "$git_dir/config";
>  	}
>  
> +	return undef if (!defined $config{"gitweb.$key"});
> +

I think this change is missing a lot of necessary fixes associated with
it.  Have you actually audited all the callers of this function you are
modifying?  For example, feature_bool does this:

        sub feature_bool {
                my $key = shift;
                my ($val) = git_get_project_config($key, '--bool');

                if ($val eq 'true') {
                        return (1);
                } elsif ($val eq 'false') {
	...

With your above change, I think a missing configuration variable will
stuff undef in $val, and trigger the same "$val eq 'true'" comparison
warning here.

Granted, without your change the existing code triggers the same error in
another way, by calling config_to_bool sub with undef here:

	# ensure given type
	if (!defined $type) {
		return $config{"gitweb.$key"};
	} elsif ($type eq 'bool') {
		# backward compatibility: 'git config --bool' returns true/false
		return config_to_bool($config{"gitweb.$key"}) ? 'true' : 'false';

and config_to_bool sub is written in the same carelessness like so:

        sub config_to_bool {
                my $val = shift;

                # strip leading and trailing whitespace
                $val =~ s/^\s+//;

and triggers the same error here in the s/// operation.  I think the right
fix for this part would look like this:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7c48181..2b140cc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1920,6 +1920,8 @@ sub git_parse_project_config {
 sub config_to_bool {
 	my $val = shift;
 
+	return 1 if (!defined $val);
+
 	# strip leading and trailing whitespace
 	$val =~ s/^\s+//;
 	$val =~ s/\s+$//;

Because

	[gitweb]
        	variable

parsed by git_parse_project_config('gitweb') should return a hash that
maps "gitweb.variable" to undef it must be fed as undef to
config_to_bool.  This variable should be reported as "true".

There are tons of undef unsafeness in this file from a very cursory look.

Unrelated to any of these, I think the following is wrong:

        sub feature_patches {
                my @val = (git_get_project_config('patches', '--int'));

                if (@val) {
                        return @val;
                }

                return ($_[0]);
        }

As git_get_project_config() always returns something, hence "if (@val)"
can never be false.
