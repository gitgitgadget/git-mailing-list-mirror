From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] commit: reject invalid UTF-8 codepoints
Date: Thu, 04 Jul 2013 21:58:08 +0200
Message-ID: <51D5D3D0.3030102@web.de>
References: <cover.1372957719.git.sandals@crustytoothpaste.net> <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jul 04 21:58:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UupfX-00013G-TP
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 21:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532Ab3GDT6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 15:58:15 -0400
Received: from mout.web.de ([212.227.17.11]:52458 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756832Ab3GDT6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 15:58:15 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lmcf9-1ULlhK2gWh-00aAcK; Thu, 04 Jul 2013 21:58:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130704171943.GA267700@vauxhall.crustytoothpaste.net>
X-Provags-ID: V03:K0:P2xuXcrLTRl5cCMcbr+IuyMVl0KWBW7qSHs4H+q9Tv844dy7hRy
 5+c5AmVsgugqOPZPN3E3gl4xVhcCqwR3kOD0gNYKuwCoq0gYGJ/qWjGjnISVTOWkV8Kmxtb
 lm6hxhCl+vE2eZgbrbBOxgFEROrwvX8j2EVojMxUKEFuHj4p0FDQs++0sDcdmOsAZmQWa+e
 PExLYTajScvEMDgX4Bedg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229610>

On 2013-07-04 19.19, brian m. carlson wrote:
> The commit code already contains code for validating UTF-8, but it does not
> check for invalid values, such as guaranteed non-characters and surrogates.  Fix
s/guaranteed non-characters/code points out of range/
> this by explicitly checking for and rejecting such characters.
Do we really reject them, or do we (only) warn about them ? 

Other question:
Now that we have a check for codepoints out of range, beyond U+10FFFF,
do we want to have an additional testcase ?


> +test_expect_success 'UTF-8 invalid characters refused' '
May be:
 test_expect_success 'UTF-8 invalid surrogate' '


> +	test_when_finished "rm -f $HOME/stderr $HOME/invalid" && 
> +	rm -f "$HOME/stderr" &&
> +	echo "UTF-8 characters" >F &&
> +	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
> +		>"$HOME/invalid" &&
good
> +	git commit -a -F "$HOME/invalid" \
> +		2>"$HOME"/stderr &&
> +	grep "did not conform" "$HOME"/stderr
> +'
> +
> +rm -f "$HOME/stderr"
Does it make sense to "grep on the fly", like this:
git commit -a -F "$HOME/invalid" 2>&1  | grep "did not conform"
