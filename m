From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header fields
Date: Thu, 09 Jun 2016 11:45:03 +0200
Message-ID: <vpqoa7asnkw.fsf@anie.imag.fr>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130736.32163-1-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 11:46:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAwXG-0002JT-NA
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 11:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbcFIJpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 05:45:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:34275 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423246AbcFIJp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 05:45:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u599j2ar004343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 11:45:03 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u599j3ua032137;
	Thu, 9 Jun 2016 11:45:03 +0200
In-Reply-To: <20160608130736.32163-1-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:07:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 09 Jun 2016 11:45:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u599j2ar004343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466070308.71506@h/C7HStAkdIgA2Rvw3M4YA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296877>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index edbba3a..21776f0 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -84,13 +84,16 @@ See the CONFIGURATION section for 'sendemail.multiEdit'.
>  	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
>  	set, as returned by "git var -l".
>  
> ---in-reply-to=<identifier>::
> +--in-reply-to=<Message-Id|email_file>::
>  	Make the first mail (or all the mails with `--no-thread`) appear as a
> -	reply to the given Message-Id, which avoids breaking threads to
> -	provide a new patch series.
> +	reply to the given Message-Id (given directly by argument or via the email
> +	file), which avoids breaking threads to provide a new patch series.
>  	The second and subsequent emails will be sent as replies according to
>  	the `--[no]-chain-reply-to` setting.
>  +
> +Furthermore, if the argument is an email file, parse it and populate header
> +fields appropriately for the reply.

"populate header fields appropriately" would seem obscure to someone not
having followed this converation. At least s/fields/To: and Cc: fields/.

> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -55,6 +55,7 @@ git send-email --dump-aliases
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --in-reply-to          <file>  * Populate header fields appropriately.

Likewise. To avoid an overly long line, I'd write just "Populate
To/Cc/In-reply-to".

Probably <file> should be <email_file>.

> +if ($initial_reply_to && -f $initial_reply_to) {
> +	my $error = validate_patch($initial_reply_to);
> +	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
> +		if $error;
> +
> +	open my $fh, "<", $initial_reply_to or die "can't open file $initial_reply_to";
> +	my $mail = Git::parse_email($fh);
> +	close $fh;
> +
> +	my $initial_sender = $sender || $repoauthor || $repocommitter || '';

This is duplicated from the "if ($compose) { ... my $tpl_sender = ..." a
bit later in the existing file. It would be better to get this "my
$initial_sender = ..." out of your "if" and use $initial_sender directly
later IMHO.

Actually, $initial_sender does not seem to be a good variable name. It's
not really "initial", right?

> +	my $prefix_re = "";
> +	my $subject_re = $mail->{"subject"}[0];
> +	if ($subject_re =~ /^[^Re:]/) {
> +		$prefix_re = "Re: ";
> +	}
> +	$initial_subject = $prefix_re . $subject_re;

Why introduce $prefix_re. You can just

	my $subject = $mail->{"subject"}[0];
	if (...) {
        	$subject = "Re: " . $subject;
        }

(preferably using sensible as '...' as noted by Junio ;-) ).

In previous iterations of this series, you had issues with non-ascii
characters in at least To: and Cc: fields (perhaps in the Subject field
too?). Are they solved? I don't see any tests about it ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
