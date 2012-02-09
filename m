From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/2] git-p4: add test case for RCS keywords
Date: Thu, 09 Feb 2012 14:55:39 -0800
Message-ID: <7v8vkbvcpg.fsf@alter.siamese.dyndns.org>
References: <1328785409-30936-1-git-send-email-luke@diamand.org>
 <1328785409-30936-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 23:55:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvcu4-0000Mg-96
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 23:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab2BIWzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 17:55:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2BIWzn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 17:55:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A5B9623E;
	Thu,  9 Feb 2012 17:55:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gkdn1K9KiAjiClPq6aHIAGj6Uzw=; b=nWyKtC
	yb8656dSEPtdOkYK5zGA++LU+hiYfyfwHKRiX3Go6gezNxM8pP+ypBAj77sHkmfa
	iRS99qcYsi1J68QhXVI1YDI+jJbTH6LXGYciTijoaK/KzIAzcz9iqF2V83qvqkOG
	ELl27ff4WDRCTWsaXNFNfZC4kMkys5ptSc7RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sN8oB+YSOvcVihmyb0Eqr3XALP6zYe5K
	ZF75LeCR8OrJFoIRTmibMfbv1OBlMr3ufQZUJMqOkHfNOdcApO/anVVn2jAXLmDV
	2rB4e+1pGjdoIq6/Z4IGXy4Z6y1zDzs+URFaruBk553rCLQFtIUvqKObJDk+vrm4
	OY0swSgOoxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11420623D;
	Thu,  9 Feb 2012 17:55:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4604F623C; Thu,  9 Feb 2012
 17:55:41 -0500 (EST)
In-Reply-To: <1328785409-30936-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Thu, 9 Feb 2012 11:03:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30CD2292-5371-11E1-BF06-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190336>

Luke Diamand <luke@diamand.org> writes:

> +create_kw_file() {
> + cat <<'EOF' > $1

Please start this shell function like this instead:

        create_kw_file () {
                cat <<\EOF >"$1"

The first line is merely cosmetic but matches the convention used in our
shell scripts better.

As to the second line:

 * Quoting "$1" should not be strictly necessary according to POSIX rules,
   but we saw reports that some shells "helpfully" give unnecessary
   warnings when $1 (or whatever variable that holds the name of the file
   the output is redirected into) contains $IFS characters.

 * An indent in our shell scripts is a HT, not a SP (or four spaces or
   whatever).

 * And our convention is not to have an extra SP after redirection '>' (or
   '<') operator.

> +test_expect_success 'init depot' '
> +	(
> +		cd "$cli" &&
> +		echo file1 >file1 &&
> +		p4 add file1 &&
> +		p4 submit -d "change 1" &&
> +		create_kw_file kwfile1.c &&
> +		p4 add kwfile1.c &&
> +		p4 submit -d "Add rcw kw file" kwfile1.c
> +	)
> +'
> +
> +p4_append_to_file() {
> + f=$1
> + p4 edit -t ktext $f &&
> + echo "/* $(date) */" >> $f &&
> + p4 submit -d "appending a line in p4" &&
> + cat $f
> +}

Surround all occurrences of '$f' with double-quotes, e.g.

	cat "$f"

to avoid unexpected breakage when later somebody tries to use a file whose
name happens to contain a space. The first assignment "f=$1" can stay as-is.

> +
> +# Create some files with RCS keywords. If they get modified
> +# elsewhere then the version number gets bumped which then
> +# results in a merge conflict if we touch the RCS kw lines,
> +# even though the change itself would otherwise apply cleanly.
> +test_expect_failure 'cope with rcs keyword expansion damage' '
> + "$GITP4" clone --dest="$git" //depot &&
> + cd "$git" &&

Please do not cd around in test script outside a subshell.  Otherwise, any
failure in a subsequent command in this && chain before you reach the next
"cd" will leave you in an unexpected directory and can break later tests.

The worst example would be

	test_expect_something 'one' '
		mkdir -p git/play/pen &&
                cd git/play/pen &&
                do something &&
        	cd ../../.. &&
                do something that potentially can fail &&
                cd git/play/pen &&
                do something
	'
	# blindly assuming the above succeeded up to the last 'cd git'
        test_expect_something 'two' '
		cd ../../.. &&
        	rm -fr git &&
                do something else
	'

If the first test fails in the middle before it brings you back down to
'git/play/pen' with the last 'cd git/playpen', then the next test moves
you up three levels and you will be running "rm -fr" on a wrong 'git'!
