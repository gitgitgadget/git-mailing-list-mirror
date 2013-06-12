From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] submodule: handle multibyte characters in name
Date: Wed, 12 Jun 2013 23:38:47 +0200
Message-ID: <51B8EA67.7040801@web.de>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com> <1370991854-1414-2-git-send-email-iveqy@iveqy.com> <7vppvr11kg.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umskz-0000W7-4z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757865Ab3FLVix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 17:38:53 -0400
Received: from mout.web.de ([212.227.15.3]:63436 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908Ab3FLVix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 17:38:53 -0400
Received: from [192.168.178.41] ([91.3.174.164]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MIvFp-1Ukwwg3bEf-002VSc; Wed, 12 Jun 2013 23:38:48
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vppvr11kg.fsf_-_@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:RF1x+x/po5fieHIAGachB1aQRi68YpF8tJ7ED5+//liW5s/u4q4
 BKhpiywGR/vEPxWFmrbZX82B4SmM2J2KFz+wnoPqGiydIJNwSjbWRBVe5kkeuX/ZCMucWRa
 NDEWwKzB7Aj5U/95WAZmgWGttzv9TKroyzE6eIeK5qB+dQEhQi5frSj31RsDGlY2UXZYJo+
 SKmuK1AHBaPqcc9A44CfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227684>

Am 12.06.2013 23:06, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
>> Bugg reported here:
>> http://thread.gmane.org/gmane.comp.version-control.git/218922/focus=226791
> 
> The URL is nice supplemental info as footnote, but please write log
> message in a way that a reader can understand without going there.
> In this case, it wouldn't be so hard, I think, perhaps like:
> 
> 	Many "git submodule" operations do not work on a submodule
> 	at a path whose name is not in ASCII.
> 
> 	This is because "git ls-files" is used to find which paths
> 	are bound to submodules to the current working tree, and the
> 	output is C-quoted by default for non ASCII pathnames.
> 
> 	Read from "git ls-files -z" instead, which is easier than
> 	unwrapping C-quote ourselves.
> 
> or something.
> 
>>  module_list()
>>  {
>>  	(
>> -		git ls-files --error-unmatch --stage -- "$@" ||
>> +		git ls-files --error-unmatch --stage -z -- "$@" ||
>>  		echo "unmatched pathspec exists"
>>  	) |
>> +	sed -e 's/\x00/\n/g' |
> 
> It is strange to preprosess input to be read by a Perl script with
> sed ;-)
> 
> How about doing it this way instead?  Does the result pass your
> test?

Hmm, I just came around to test that patch, and for me the new
test even succeeds without the changes to module_list(). So I'm
not convinced yet what we are fixing here ;-)

The original poster reported that the submodule just added locally
is not showing up in a subsequent `git submodule`. And it doesn't
for me either, no matter if the path contains umlauts or not. Will
take a deeper look when I find some more time to do that, maybe
recent changes to "git add" play a role here too.

>  git-submodule.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 79bfaac..19faf58 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -113,7 +113,7 @@ resolve_relative_url ()
>  module_list()
>  {
>  	(
> -		git ls-files --error-unmatch --stage -- "$@" ||
> +		git ls-files --error-unmatch --stage -z -- "$@" ||
>  		echo "unmatched pathspec exists"
>  	) |
>  	perl -e '
> @@ -121,6 +121,7 @@ module_list()
>  	my ($null_sha1) = ("0" x 40);
>  	my @out = ();
>  	my $unmatched = 0;
> +	$/ = "\0";
>  	while (<STDIN>) {
>  		if (/^unmatched pathspec/) {
>  			$unmatched = 1;
> 
