From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: handle multibyte characters in name
Date: Wed, 12 Jun 2013 14:06:23 -0700
Message-ID: <7vppvr11kg.fsf_-_@alter.siamese.dyndns.org>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com>
	<1370991854-1414-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 23:06:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmsFY-0005r9-7l
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 23:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225Ab3FLVGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 17:06:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40917 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab3FLVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 17:06:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79F26274C9;
	Wed, 12 Jun 2013 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fUG3NpT4nTfIGwlxXay3/abr8f4=; b=ERSdIp
	PkRRaT5UAg1Q0HjbIIng1gCBrxf8nZ5ICreNW2L43zXEDP35ymcovgvAcXvZnNLj
	ZYBYqmAR22+6astUWgiwgsUNjfjzsgXJnhIXzfJ+Z/DVS1keNkPfhEpVXBkRgJJM
	SIx0Iu7Smuxe+J+Da+emZK8+xB2KdtBL/WyJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQKMvVsqnZWa0zRC3e+ex+NdXJeAboBr
	nTy2Cm6uOsQA6zD8cy3DvSn701adBil3VPjrCaAi25jE6oOf9CdaIuoJLxbxIIp6
	Qmai7w4MNTyKcV6VLMb7Ab19QtvtGi87SquyBVho1m6PIPD+0OdGDOF4p8B9HRYi
	dcP3GISwQdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E8AA274C8;
	Wed, 12 Jun 2013 21:06:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A32A1274C6;
	Wed, 12 Jun 2013 21:06:24 +0000 (UTC)
In-Reply-To: <1370991854-1414-2-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Wed, 12 Jun 2013 01:04:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0C0442C-D3A3-11E2-A62B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227679>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> Bugg reported here:
> http://thread.gmane.org/gmane.comp.version-control.git/218922/focus=226791

The URL is nice supplemental info as footnote, but please write log
message in a way that a reader can understand without going there.
In this case, it wouldn't be so hard, I think, perhaps like:

	Many "git submodule" operations do not work on a submodule
	at a path whose name is not in ASCII.

	This is because "git ls-files" is used to find which paths
	are bound to submodules to the current working tree, and the
	output is C-quoted by default for non ASCII pathnames.

	Read from "git ls-files -z" instead, which is easier than
	unwrapping C-quote ourselves.

or something.

>  module_list()
>  {
>  	(
> -		git ls-files --error-unmatch --stage -- "$@" ||
> +		git ls-files --error-unmatch --stage -z -- "$@" ||
>  		echo "unmatched pathspec exists"
>  	) |
> +	sed -e 's/\x00/\n/g' |

It is strange to preprosess input to be read by a Perl script with
sed ;-)

How about doing it this way instead?  Does the result pass your
test?

 git-submodule.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..19faf58 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -113,7 +113,7 @@ resolve_relative_url ()
 module_list()
 {
 	(
-		git ls-files --error-unmatch --stage -- "$@" ||
+		git ls-files --error-unmatch --stage -z -- "$@" ||
 		echo "unmatched pathspec exists"
 	) |
 	perl -e '
@@ -121,6 +121,7 @@ module_list()
 	my ($null_sha1) = ("0" x 40);
 	my @out = ();
 	my $unmatched = 0;
+	$/ = "\0";
 	while (<STDIN>) {
 		if (/^unmatched pathspec/) {
 			$unmatched = 1;
