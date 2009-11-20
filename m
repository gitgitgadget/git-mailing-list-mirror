From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/resend] CVS Server: Support reading base and roots from 
 environment
Date: Fri, 20 Nov 2009 14:42:48 -0800
Message-ID: <7vocmwvmvr.fsf@alter.siamese.dyndns.org>
References: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Phil Miller <mille121@illinois.edu>
X-From: git-owner@vger.kernel.org Fri Nov 20 23:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBcC1-0005vX-Gv
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 23:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbZKTWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZKTWmx
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 17:42:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZKTWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 17:42:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E673A9ED03;
	Fri, 20 Nov 2009 17:42:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7uS4kV7llmcZAq1KOS+7Mktgus=; b=H5c7tJ
	58pAsTE4ac56wXoeHps9WPP7ZUZ8qdMinIqsx/qjzgIX/XmlBu+qRhyc79zi6pAR
	+QAf2HhUvVIBxEd9Fq2t7Z7U9bl7hyR0PmmkSfcvJsFH8xfuM3iEaz/2fxCoHgmv
	9iuDNNPhizL3alMPdrZvdE/s2VpJ9KWOdb7BM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YdCUF4MXZhLNFY6qgDsB1HS0TkEG2/g5
	zYme5lo5brZsx5bFJYdhHMwWRjwJNRqrrpOzfxgimwTffPNvtLhKUUtPjJ2u4cBS
	8jXNvYCsNNFtYtIIVbM7qlUhOe/ZtOcqYi83TsxvuL9oPyx9oUIJw23UNk/OdzdH
	3kh49IGHNdQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C42259ECFF;
	Fri, 20 Nov 2009 17:42:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 579339ECFD; Fri, 20 Nov 2009
 17:42:50 -0500 (EST)
In-Reply-To: <81f018ac0911200805g55bd1607u651334c1ed7f1303@mail.gmail.com>
 (Phil Miller's message of "Fri\, 20 Nov 2009 10\:05\:44 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0AE3EEBE-D626-11DE-A217-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133383>

Phil Miller <mille121@illinois.edu> writes:

> The Gitosis single-account Git/ssh hosting system runs git commands
> through git-shell after confirming that the connecting user is
> authorized to access the requested repository. This works well for
> upload-pack and receive-pack, which take a repository argument through
> git-shell. This doesn't work so well for `cvs server', which is passed
> through literally, with no arguments. Allowing arguments risks
> sneaking in `--export-all', so that restriction should be maintained.
>
> Despite that, passing a list of repository roots is necessary for
> per-user access control by the hosting software, and passing a base
> path improves usability without weakening security. Thus,
> git-cvsserver needs to come up with these values at runtime by some
> other means. Since git-shell preserves the environment for other
> purposes, the environment can carry these arguments as well.
>
> Thus, modify git-cvsserver to read $GIT_CVSSERVER_{BASE_PATH,ROOTS} in
> the absence of equivalent command line arguments.
>
> Signed-off-by: Phil Miller <mille121@illinois.edu>
> ---

Thanks.

Any comments from cvsserver users?

>  git-cvsserver.perl |   21 ++++++++++++++++++++-
>  1 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 6dc45f5..9e58d2a 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -104,6 +104,7 @@ $log->info("--------------- STARTING -----------------");
>  my $usage =
>      "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
>      "    --base-path <path>  : Prepend to requested CVSROOT\n".
> +    "                          Can be read from GIT_CVSSERVER_BASE_PATH\n".
>      "    --strict-paths      : Don't allow recursing into subdirectories\n".
>      "    --export-all        : Don't check for gitcvs.enabled in config\n".
>      "    --version, -V       : Print version information and exit\n".
> @@ -111,7 +112,8 @@ my $usage =
>      "\n".
>      "<directory> ... is a list of allowed directories. If no directories\n".
>      "are given, all are allowed. This is an additional restriction, gitcvs\n".
> -    "access still needs to be enabled by the gitcvs.enabled config option.\n";
> +    "access still needs to be enabled by the gitcvs.enabled config option.\n".
> +    "Alternately, these directories may be specified in
> GIT_CVSSERVER_ROOTS.\n";

When you introduce a single variable holding multiple values, you need to
document how to cram the values into it.  Maybe such a detail isn't
necessary in this usage text, but definitely in the documentation.

Documentation/git-cvsserver.txt needs to be updated to describe the
features added by this patch.

By the way, this patch is line-wrapped.  Here, and...

>  my @opts = ( 'help|h|H', 'version|V',
>  	     'base-path=s', 'strict-paths', 'export-all' );
> @@ -148,6 +150,23 @@ if ($state->{'export-all'} &&
> !@{$state->{allowed_roots}}) {

... also here.

>      die "--export-all can only be used together with an explicit whitelist\n";
>  }
>
> +# Environment handling for running under git-shell
> +if ($ENV{GIT_CVSSERVER_BASE_PATH}) {

It probably is more kosher to say

	if (exists $ENV{...})

as the base_path _could_ be '0' that evaluates to false.  When the path
does not begin with a '/', what will it be relative to?  Do we want to
document it (not a rhetorical question)?

> +    if ($state->{'base-path'}) {
> +	die "Cannot specify base path both ways.\n";
> +    }
> +    my $base_path = $ENV{GIT_CVSSERVER_BASE_PATH};
> +    $state->{'base-path'} = $base_path;
> +    $log->debug("Picked up base path '$base_path' from environment.\n");
> +}
> +if ($ENV{GIT_CVSSERVER_ROOTS}) {
> +    if (@{$state->{allowed_roots}}) {
> +	die "Cannot specify roots both ways: @ARGV\n";
> +    }
> +    my @allowed_root = split(',', $ENV{GIT_CVSSERVER_ROOTS});
> +    $state->{allowed_roots} = [ @allowed_root ];

Even though a comma is probably rare in pathname components, I do not know
if this is good.

How much thought went into choosing comma for this purpose?  Is there a
particular reason you chose ',' as the separator?  That should be
documented in the commit log message.

Logical alternative choices are "split at whitespace" (mimics the way how
command line argument splitting works) and "colon" (mimics the way how
$PATH is split into component paths).

If a pathname component with whitespaces (Windows and Macs?) is not an
issue, I would imagine "split at whitespace" is much more natural way to
handle this, but probably many people have "My Programs" and such.

Especially because it is hard, if not impossible, to have a pathname
component that contains a colon on Windows, I suspect that a colon is much
rare compared to whitespaces and commas in the name of people's
directories and files.  It might be better to split at colon like $PATH is
handled than using a comma, if you are not going to give any escape
mechanism to .
