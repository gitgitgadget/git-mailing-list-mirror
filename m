From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 6/6] send-email: add option --cite to quote the message body
Date: Thu, 09 Jun 2016 13:49:45 +0200
Message-ID: <vpqvb1ir38m.fsf@anie.imag.fr>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130833.32274-1-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 13:50:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAyTJ-0008WG-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 13:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbcFILt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 07:49:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37925 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcFILt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 07:49:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u59Bni7k030343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jun 2016 13:49:44 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u59BnjlA002403;
	Thu, 9 Jun 2016 13:49:45 +0200
In-Reply-To: <20160608130833.32274-1-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:08:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 09 Jun 2016 13:49:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u59Bni7k030343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1466077785.35022@ffQ20m2i/m533Q9PRwyz6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296881>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> If used with `in-reply-to=<email_file>`, cite the message body of the given
> email file. Otherwise, do nothing.

It should at least warn when --in-reply-to=<email_file> is not given
(either no --in-reply-to or --in-reply-to=<id>). I don't see any
use-case where a user would want --cite on the command-line and not want
--in-reply-to=<email_file>. OTOH, it seems a plausible user-error, and
the user would appreciate a message saying what's going on.

> @@ -56,6 +57,8 @@ git send-email --dump-aliases
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
>      --in-reply-to          <file>  * Populate header fields appropriately.
> +    --cite                         * Quote the message body in the cover if
> +                                     --compose is set, else in the first patch.
>      --[no-]xmailer                 * Add "X-Mailer:" header (default).
>      --[no-]annotate                * Review each patch that will be sent in an editor.
>      --compose                      * Open an editor for introduction.

Just wondering: would it make sense to activate --cite by default when
--in-reply-to=file is used, and to allow --no-cite to disable this?

This is something we can easily do now without breaking backward
compatibility (--in-reply-to=file doesn't exist yet), but would be more
painful to do later.

> @@ -640,6 +644,7 @@ if (@files) {
>  	usage();
>  }
>  
> +my $message_cited;

Nit: I read "$message_cited" as "Boolean saying whether the message was
cited". $cited_message would be clearer to me (but this is to be taken
with a grain of salt as I'm not a native speaker), since the variable
holds the content of the cited message.

> +sub do_insert_cited_message {
> +	my $tmp_file = shift;
> +	my $original_file = shift;
> +
> +	open my $c, "<", $original_file
> +	or die "Failed to open $original_file: " . $!;
> +
> +	open my $c2, ">", $tmp_file
> +		or die "Failed to open $tmp_file: " . $!;
> +
> +	# Insertion after the triple-dash
> +	while (<$c>) {
> +		print $c2 $_;
> +		last if (/^---$/);
> +	}
> +	print $c2 $message_cited;

I would add a newline here to get a blank line between the message cited
and the diffstat.

I think non-ascii characters would deserve particular attention here
too. For example, if the patch contain only ascii and the cited part
contains UTF-8, does the generated patch have a proper Content-type:
header?

I can imagine worse, like a patch containing latin1 character and a
cited message with another 8-bit encoding.

> +test_expect_success $PREREQ 'correct cited message with --in-reply-to and --compose' '
> +	grep "> On Sat, 12 Jun 2010 15:53:58 +0200, author@example.com wrote:" msgtxt3 &&

I would prefer to have the full address including the real name here (A
<author@example.com>) in this example. Actually, after a quick look at
the code, I don't understand where the name has gone (what's shown here
is extracted from the From: header).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
