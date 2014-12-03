From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 03 Dec 2014 09:08:32 -0800
Message-ID: <xmqqfvcwk6en.fsf@gitster.dls.corp.google.com>
References: <20140324213814.GA1267@achilles.my.domain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 18:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwDPu-00021I-9h
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 18:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaLCRIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 12:08:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969AbaLCRIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 12:08:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5833421784;
	Wed,  3 Dec 2014 12:08:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VQbjlxcyrLHYhVPxvfV/TEkR92M=; b=D6InlL
	eqDAcDZAuL9MxksoK3Cp/KkAZQqbsgd+hd5br3iCLy7nLeZ85Qvm0xmEWFGlOmnR
	a0gt8cqsiQpye5aNPZWkN6CWlYMJSOmOXXKqwGyUV85Y3pP0zo75QLj5FhlMAmTf
	EYGV9VnFmIktSlIKd9B7aRBp+NFCu1IxGtNBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dtZwKWHPvZBi8A1J7KzIN1FLUKoze68n
	MISLaeYUuLGJuZ6F3/ou9Vq942OPxrR8WQcteC5qkJO9UFhnFCb/U15U5/fHryKs
	rA3XRyTyvOF40uatByV4xYyQtmMvG0r/is8YtJ9n2YcwTSvUn/HarUnLyZ12hrrO
	OA4TN0aUByQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E63E21783;
	Wed,  3 Dec 2014 12:08:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE24D21782;
	Wed,  3 Dec 2014 12:08:33 -0500 (EST)
In-Reply-To: <20140324213814.GA1267@achilles.my.domain> (Luis Henriques's
	message of "Mon, 24 Mar 2014 21:38:27 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 034ABED8-7B0F-11E4-893F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260663>

Luis Henriques <henrix@camandro.org> writes:

> +--xmailer::
> +	Prevent adding the "X-Mailer:" header.  Default value is
> +	'sendemail.xmailer'.

Two problems here.

 - "git send-email --xmailer" would _ADD_, not prevent adding, the
   header, regardless of the value of sendemail.xmailer.

 - It is unspecified what happens when you do not have
   sendemail.xmailer and do not give the --xmailer option.

Perhaps

--xmailer::
--no-xmailer::

	By default, `git send-email` adds an "X-Mailer:" header to
        the message to identify the version of itself.  The
        `--no-xmailer` option can be used to turn this off (setting
        the `sendemail.xmailer` configuration to false has the same
        effect).  The `--xmailer` option from the command line is
        useful to countermand `sendemail.xmailer` that is set to
        `false`.

or something?


> diff --git a/git-send-email.perl b/git-send-email.perl
> index fdb0029..8789124 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -54,6 +54,7 @@ git send-email [options] <file | directory | rev-list options >
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --[no-]xmailer                 * Don't add "X-Mailer:" header.  Default on.

The same confusion exists here.  "Don't ... default on" hints that
by default we won't see "X-mailer:" which is not true.

A way to avoid confusion is to describe what the option is about for
the positive variant, just like it is done for "--[no-]annotate"
option below.

> @@ -174,6 +175,9 @@ my $force = 0;
>  my $multiedit;
>  my $editor;
>  
> +# Usage of X-Mailer email header
> +my $xmailer;
> +
>  sub do_edit {
>  	if (!defined($editor)) {
>  		$editor = Git::command_oneline('var', 'GIT_EDITOR');
> @@ -214,7 +218,8 @@ my %config_bool_settings = (
>      "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
>      "validate" => [\$validate, 1],
>      "multiedit" => [\$multiedit, undef],
> -    "annotate" => [\$annotate, undef]
> +    "annotate" => [\$annotate, undef],
> +    "xmailer" => [\$xmailer, 1]
>  );
>  
>  my %config_settings = (
> @@ -311,6 +316,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "8bit-encoding=s" => \$auto_8bit_encoding,
>  		    "compose-encoding=s" => \$compose_encoding,
>  		    "force" => \$force,
> +		    "xmailer!" => \$xmailer,
>  	 );
>  
>  usage() if $help;
> @@ -1144,8 +1150,10 @@ To: $to${ccline}
>  Subject: $subject
>  Date: $date
>  Message-Id: $message_id
> -X-Mailer: git-send-email $gitversion
>  ";
> +	if ($xmailer) {
> +		$header .= "X-Mailer: git-send-email $gitversion\n";
> +	}
>  	if ($reply_to) {
>  
>  		$header .= "In-Reply-To: $reply_to\n";

tests?

Thanks.
