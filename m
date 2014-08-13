From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/4] fast-import.c: replace `git_config()` with `git_config_get_*()` family
Date: Wed, 13 Aug 2014 13:24:05 +0200
Message-ID: <vpqppg4vdii.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 13:24:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWf9-0004Sn-5i
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 13:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbaHMLYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 07:24:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58054 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbaHMLYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 07:24:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBO4e3022913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 13:24:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBO53Y023560;
	Wed, 13 Aug 2014 13:24:05 +0200
In-Reply-To: <1407918122-29973-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 13 Aug 2014 01:21:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 13:24:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DBO4e3022913
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408533846.39163@QibEp7f950m7XTsKeWEW6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255201>

Tanay Abhra <tanayabh@gmail.com> writes:

>  fast-import.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)

Only 4 lines less, how disappointing ;-).

More seriously, the old code was essentially dealing with special
values, which your new code needs to do too, so you can hardly do any
less.

> +	if (!git_config_get_int("pack.compression", &pack_compression_level)) {
> +		if (pack_compression_level == -1)
> +			pack_compression_level = Z_DEFAULT_COMPRESSION;
> +		else if (pack_compression_level < 0 ||
> +			 pack_compression_level > Z_BEST_COMPRESSION)
> +			die("bad pack compression level %d", pack_compression_level);

That would be a good use for git_die_config(), to give a better error
message, right?

> -	if (!strcmp(k, "pack.indexversion")) {
> -		pack_idx_opts.version = git_config_int(k, v);
> +	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
> +		pack_idx_opts.version = indexversion_value;

I wondered why you were not assigning to pack_idx_opts.version directly,
but pack_idx_opts.version is uint32 and you don't have
config_get_uint32, so it's OK.

>  		if (pack_idx_opts.version > 2)
> -			die("bad pack.indexversion=%"PRIu32,
> -			    pack_idx_opts.version);
> -		return 0;
> +			die("bad pack.indexversion=%"PRIu32, pack_idx_opts.version);

One more opportunity for git_die_config()?

Not that it's terribly important, but I think it's good that your
refactoring also brings a few end-users benefits. It will help you show
off when you tell your friends what you did this summer (not "I did
useless code churn" ;-) ), and helps everybody see the benefits of your
GSoC ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
