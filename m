From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Wed, 03 Dec 2008 15:55:16 -0800
Message-ID: <7vy6yw95ln.fsf@gitster.siamese.dyndns.org>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L81aG-0008VL-LP
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYLCXz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 18:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbYLCXz1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 18:55:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYLCXz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 18:55:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DEE72180C1;
	Wed,  3 Dec 2008 18:55:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7187E180C0; Wed, 
 3 Dec 2008 18:55:18 -0500 (EST)
In-Reply-To: <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Wed, 3 Dec 2008 23:59:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAF8C6DE-C195-11DD-89D8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102308>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> The manually-built email format in commitdiff_plain output is not
> appropriate for feeding git-am, because of two limitations:
>  * when a range of commits is specified, commitdiff_plain publishes a
>    single patch with the message from the first commit, instead of a
>    patchset,
>  * in either case, the patch summary is replicated both as email subject
>    and as first line of the email itself, resulting in a doubled summary
>    if the output is fed to git-am.
>
> We thus create a new view that can be fed to git-am directly by exposing
> the output of git format-patch directly. This allows patch exchange and
> submission via gitweb.
>
> A configurable limit is imposed on the number of commits which will be
> included in a patchset, to prevent DoS attacks on the server. Setting
> the limit to 0 will disable the patch view, setting it to a negative
> number will remove the limit.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 40 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2738643..c9abfcf 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -329,6 +329,13 @@ our %feature = (
>  	'ctags' => {
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# The maximum number of patches in a patchset generated in patch
> +	# view. Set this to 0 or undef to disable patch view, or to a
> +	# negative number to remove any limit.
> +	'patches' => {
> +		'override' => 1,
> +		'default' => [16]},
>  );

Looking at the existing entries in the %feature hash, it seems that it is
our tradition that a new feature starts as disabled and not overridable
(see 'ctags' in the context above).

>  sub git_commitdiff {
>  	my $format = shift || 'html';
> +
> +	my $patch_max = gitweb_check_feature('patches');
> +	if ($format eq 'patch') {
> +		die_error(403, "Patch view not allowed") unless $patch_max;
> +	}
> +

Should you have to pay overhead for the check-feature call even when
the $format is not "patch"?

> @@ -5396,6 +5410,7 @@ sub git_commitdiff {
>  	}
>  	# we need to prepare $formats_nav before almost any parameter munging
>  	my $formats_nav;
> +

Noise.

> @@ -5532,6 +5552,15 @@ sub git_commitdiff {
>  			print to_utf8($line) . "\n";
>  		}
>  		print "---\n\n";
> +	} elsif ($format eq 'patch') {
> +		my $filename = basename($project) . "-$hash.patch";
> +
> +		print $cgi->header(
> +			-type => 'text/plain',
> +			-charset => 'utf-8',
> +			-expires => $expires,
> +			-content_disposition => 'inline; filename="' . "$filename" . '"');
> +		# TODO add X-Git-Tag/X-Git-Url headers in a sensible way

A stupid question.  Are you talking about sending these X-Foo as extra
HTTP headers?  What good would they do (iow what will they be used for by
the receiving browser/wget)?

Other than that the patch seems quite straightforward and was a pleasant
read.  Thanks.
