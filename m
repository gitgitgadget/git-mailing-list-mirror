From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH v2 2/2] send-email: quote-email quotes the message body
Date: Sat, 28 May 2016 17:01:11 +0200
Message-ID: <vpqlh2ujkg8.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464369102-7551-3-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sat May 28 17:01:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fk3-0005Uv-Qc
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbcE1PB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:01:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35935 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcE1PB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:01:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4SF19Iw006435
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 28 May 2016 17:01:09 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4SF1BKb031132;
	Sat, 28 May 2016 17:01:11 +0200
In-Reply-To: <1464369102-7551-3-git-send-email-tom.russello@grenoble-inp.org>
	(Tom Russello's message of "Fri, 27 May 2016 19:11:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sat, 28 May 2016 17:01:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4SF19Iw006435
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465052471.17777@9BMKOmrKzv0ODyryY+EE9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295820>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> Currently, `send-email` without `--compose` implies `--annotate`.

I don't get it. Did you mean s/without/with/? Even if so, this is not
exactly true: "git send-email --compose -1" will open the editor only
for the cover-letter, while adding --annotate will also open it for the
patch.

> Keeping that behavior when using `--quote-email` populates the patch file with
> the quoted message body, and the patch is saved no matter what. If the user
> closes his editor and then exits `send-email`, changes will be saved.
>
> Should we keep the current behavior for the user, keeping the changes (including
> the quoted message body) in the patch, or should we discard them?

(Note: we discussed this off-list already, but I'll try to summarize my
thoughts here)

I don't have strong opinion on this, but I think there's a difference
between launching the editor directly on the input patch files
(resulting in _user_'s edit being done directly on them) and having the
script modify it in-place (resulting in automatic changes done directly
on the user's files).

I usually use "git send-email" directly without using "git
format-patch", so I'm not the best juge. But I can imagine a flow like

1) run "git send-email *.patch"

2) start editting

3) notice there's something wrong, give up for now (answer 'q' when git
   send-email prompts for confirmation, or kill it via Control-C in a
   terminal)

4) run "git send-email *.patch" again

5) be happy that changes done at 2) are still there.

With --quote-email, it's different. The scenario above would result in

5') WTF, why is the email quoted twice?

Unfortunately, I don't really have a solution for this. My first thought
was that we should copy the files to a temporary location before
starting the editor (that what I'm used to when using "git send-email"
without "git format-patch"), but that would prevent 5) above.

> @@ -109,7 +109,10 @@ is not set, this will be prompted for.
>  --quote-email=<email_file>::
>  	Reply to the given email and automatically populate the "To:", "Cc:" and
>  	"In-Reply-To:" fields. If `--compose` is set, this will also fill the
> -	subject field with "Re: [<email_file>'s subject]".
> +	subject field with "Re: [<email_file>'s subject]" and quote the message body
> +	of <email_file>.

I'd add "in the introductory message".

> +	while (<$fh>) {
> +		# Only for files containing crlf line endings
> +		s/\r//g;

The comment doesn't really say what it does.

What about "turn crlf line endings into lf-only"?

>  } elsif ($annotate) {
> -	do_edit(@files);
> +	if ($quote_email) {
> +		my $quote_email_filename = ($repo ?
> +			tempfile(".gitsendemail.msg.XXXXXX",
> +				DIR => $repo->repo_path()) :
> +			tempfile(".gitsendemail.msg.XXXXXX",
> +				DIR => "."))[1];
> +
> +		do_insert_quoted_message($quote_email_filename, $files[0]);
> +
> +		my $tmp = $files[0];
> +		$files[0] = $quote_email_filename;
> +
> +		do_edit(@files);
> +
> +		# Erase the original patch
> +		move($quote_email_filename, $tmp);
> +		$files[0] = $tmp;

When writing comment, always try to ask the question "why?" more than
"what?". This part is possibly controversial, think about a contributor
finding this piece of code later without having followed the current
conversation. He'd probably expect an explanation about why you need a
temp file here and not elsewhere.

> +	open my $c, "<", $original_file
> +	or die "Failed to open $original_file : " . $!;
> +
> +	open my $c2, ">", $tmp_file
> +		or die "Failed to open $tmp_file : " . $!;

No space before :.

> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1916,6 +1916,12 @@ test_expect_success $PREREQ 'Fields with --quote-email are correct' '
>  	echo "$cc_adr" | grep cc1@example.com
>  '
>  
> +test_expect_success $PREREQ 'correct quoted message with --quote-email' '
> +	grep "On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt1 &&
> +	grep "> Have you seen my previous email?" msgtxt1 &&
> +	grep ">> Previous content" msgtxt1
> +'

When the spec says "if --compose ... then ...", "after the triple-dash",
and "in the first patch", one would expect at least one test with
--compose and one without, something to check that the insertion was
done below the triple-dash, and one test with two patches, checking that
the second patch is not altered by --quote-email.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
