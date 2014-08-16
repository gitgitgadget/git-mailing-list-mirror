From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] convert: Stream from fd to required clean filter
 instead of mmap
Date: Sat, 16 Aug 2014 11:27:03 +0100
Message-ID: <20140816102703.GD7857@serenity.lan>
References: <1407303134-16635-1-git-send-email-prohaska@zib.de>
 <1407303134-16635-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	peff@peff.net, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 16 12:27:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIbCr-0001ny-OJ
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 12:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbaHPK1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 06:27:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47164 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaHPK1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 06:27:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E9158CDA5BF;
	Sat, 16 Aug 2014 11:27:18 +0100 (BST)
X-Quarantine-ID: <B00mcfioovR2>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B00mcfioovR2; Sat, 16 Aug 2014 11:27:18 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id BDE02CDA5CD;
	Sat, 16 Aug 2014 11:27:05 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1407303134-16635-3-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255321>

On Wed, Aug 06, 2014 at 07:32:14AM +0200, Steffen Prohaska wrote:
[...]
> The expectation on the process size is tested using /usr/bin/time.  An
> alternative would have been tcsh, which could be used to print memory
> information as follows:
> 
>     tcsh -c 'set time=(0 "%M"); <cmd>'
> 
> Although the logic could perhaps be simplified with tcsh, I chose to use
> 'time' to avoid a dependency on tcsh.
[...]
> @@ -190,6 +196,58 @@ test_expect_success 'required filter clean failure' '
>  	test_must_fail git add test.fc
>  '
>  
> +# Handle differences in /usr/bin/time.
> +#
> +#  - Linux: call with '-v'.
> +#    output: <spaces><description>:<space><value-in-KBytes>
> +#
> +#  - Mac: call with '-l'.
> +#    output: <spaces><value-in-Bytes><spaces><description>
> +#    Strip three digits to get to KB (base 10 is good enough).
> +#
> +case $(uname -s) in
> +Linux)
> +	test_set_prereq HAVE_MAX_MEM_USAGE
> +	max_mem_usage_KB () {
> +	    /usr/bin/time -v "$@" 2>&1 |
> +	    grep 'Maximum resident set size' |
> +	    cut -d ':' -f 2
> +	}
> +	;;
> +Darwin)
> +	test_set_prereq HAVE_MAX_MEM_USAGE
> +	max_mem_usage_KB () {
> +		/usr/bin/time -l "$@" 2>&1 |
> +		grep 'maximum resident set size' |
> +		sed -e 's/  */ /' |
> +		cut -d ' ' -f 2 |
> +		sed -e 's/...$//'
> +	}
> +	;;
> +esac
> +
> +max_mem_usage_is_lt_KB () {
> +	limit=$1
> +	shift
> +	mem_usage=$(max_mem_usage_KB "$@")
> +	if [ $mem_usage -lt $limit ]; then
> +		true
> +	else
> +		printf 'Command used too much memory (expected limit %dKB, actual usage %dKB).\n' \
> +			$limit $mem_usage
> +		false
> +	fi
> +}
> +
> +test_expect_success HAVE_MAX_MEM_USAGE \
> +'filtering large input to small output should use little memory' '
> +	git config filter.devnull.clean "cat >/dev/null" &&
> +	git config filter.devnull.required true &&
> +	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
> +	echo "30MB filter=devnull" >.gitattributes &&
> +	max_mem_usage_is_lt_KB 15000 git add 30MB
> +'

This test fails for me:

-- 8< --
expecting success: 
        git config filter.devnull.clean "cat >/dev/null" &&
        git config filter.devnull.required true &&
        for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
        echo "30MB filter=devnull" >.gitattributes &&
        max_mem_usage_is_lt_KB 15000 git add 30MB

Command used too much memory (expected limit 15000KB, actual usage 15808KB).
not ok 8 - filtering large input to small output should use little memory
-- >8 --

This is on Linux 3.16 x86_64 with GCC 4.8.3 and glibc 2.19.  My GCC also
has "-fstack-protector" and "-D_FORTIFY_SOURCE=2" enabled by default;
turning those off for Git decreased the memory usage by about 500KB but
not enough to make the test pass.  Of course, all of the libraries Git
is linking are also compiled with those flags...

Is the 15MB limit supposed to be imposed somewhere or is it just a guide
of how much memory we expect Git to use in this scenario?
