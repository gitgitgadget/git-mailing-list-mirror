From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH_v1] add git credential login to remote mediawiki
Date: Sun, 10 Jun 2012 15:37:42 +0200
Message-ID: <vpqaa0bmgnt.fsf@bauges.imag.fr>
References: <1339268028-13991-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<20120610121827.GB6453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdiLf-0004Mq-VA
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 15:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab2FJNhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 09:37:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56977 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2FJNhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 09:37:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5ADSgNd003676
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 15:28:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SdiKt-0004W1-2i; Sun, 10 Jun 2012 15:37:43 +0200
In-Reply-To: <20120610121827.GB6453@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 10 Jun 2012 08:18:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 15:28:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5ADSgNd003676
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339939723.61394@BWm2+HqHRrbAbRj91tD8Rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199603>

Jeff King <peff@peff.net> writes:

> On Sat, Jun 09, 2012 at 08:53:48PM +0200, Javier.Roucher-Iglesias@ensimag.imag.fr wrote:
>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
>> index c18bfa1..4b14d78 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki
>> +++ b/contrib/mw-to-git/git-remote-mediawiki
>> @@ -152,28 +152,111 @@ while (<STDIN>) {
>>  ########################## Functions ##############################
>>  
>>  # MediaWiki API instance, created lazily.
>> +sub run_credential {
>
> Is there any reason not to add this to perl/Git.pm? I suspect that other
> scripts will want to use it, too (for example, send-email could probably
> use it for SMTP credentials).

Currently, git-remote-mediawiki is a standalone script (doesn't use
Git.pm). This is good because it makes it trivial to install, but bad in
the sense that it may force us (or others) to reinvent the wheel.

Until now, the wheels we reinvented were very simple (run_git
essentially), but we may be reaching the point where it makes sense to
use and contribute to Git.pm.

Unfortunately, from a non-technical point of view, Javier is
contributing this as part of a student project, which ends this week,
and it's probably not reasonable to introduce such change so late. So,
I'd keep it here at least for now, and a move to Git.pm could be a
separate future topic.

>> +	if (scalar(@_) == 2) {
>> +		if ($_[1] eq ("store" || "cache")) {
>> +			run_git("config credential.helper \'$_[1]\'");
>> +		} else {
>> +			print STDERR "ERROR: run_credential (fill|approve|reject) [store|cache]\n";
>> +			exit 1;
>> +		}
>> +	}
>
> This hunk looks wrong. You should never be setting the credential.helper
> config; that is the responsibility of the user to set, as they want to
> select whatever helper is appropriate. Nor do you need to care about
> which helpers are in use; the point of git-credential is that it will do
> that for you.

Absolutely.

>   sub fill_credential {
>           my $quoted_url = quotemeta(shift);
>
>           my $verbatim = `git credential fill $quoted_url`;
>           $? and die "git-credential failed";
>
>           $verbatim =~ /^username=(.*)$/m
>                   or die "git-credential did not give us a username";
>           my $username = $1;
>           $verbatim =~ /^password=(.*)$/m
>                   or die "git-credential did not give us a password";
>
>           return ($username, $password, $verbatim);
>   }
>
>   sub report_credential {
>           my ($type, $verbatim) = @_;
>           open(my $fh, '|-', "git credential $type");
>           print $fh $verbatim;
>   }

That sounds sensible too. We should be careful not to give a password as
argument (or users of the same machine will be able to find it with e.g.
"ps u"), but your proposal is OK with that.

>> +			# error if key undef
>> +			if (not defined $key) {
>> +				print STDERR "ERROR reciving reponse git credential fill\n";
>> +				exit 1;
>> +			}
[...]
>> +	} else {
>> +		while (<Reader>) {
>> +			print STDERR "\nERROR while running git credential $op:\n$_";
>> +		}
>> +	}
>> +}
>
> This isn't a good way to check for errors. The non-fill actions will
> never produce output on stdout, and you are not intercepting their
> stderr. Besides which, checking for errors by reading stderr is not a
> good practice; you should check the return value of the command in $?
> after it finishes.

I think it should do both. In case "git credential fill" returns
something that doesn't match the regexp, we don't want perl to error
with "use of undefined value", but that's just being defensive because
it shouldn't happen.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
