From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v5 4/4] git-rebase: add keep_empty flag
Date: Sun, 15 Apr 2012 11:33:03 +0200
Message-ID: <20120415093302.GA6263@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 11:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJLqk-0003Iq-2G
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 11:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab2DOJeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 05:34:21 -0400
Received: from smtpout14.highway.telekom.at ([195.3.96.79]:6603 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752916Ab2DOJeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 05:34:20 -0400
Received: (qmail 2215 invoked from network); 15 Apr 2012 09:34:17 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL605.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub79.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <nhorman@tuxdriver.com>; 15 Apr 2012 09:34:16 -0000
Content-Disposition: inline
In-Reply-To: <1334342707-3326-5-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195551>

On Fri, Apr 13, 2012 at 02:45:07PM -0400, Neil Horman wrote:
>
> Add a command line switch to git-rebase to allow a user the ability to specify
> that they want to keep any commits in a series that are empty.

Thanks. That should be useful.

> +is_empty_commit() {
> +     ptree=$(git rev-parse "$1"^{tree})
> +     pptree=$(git rev-parse "$1"^^{tree})
> +     return $(test "$ptree" = "$pptree")
> +}
> +

What's the extra leading 'p' for? Any reason not to use 'tree' and
'ptree'?

>  pick_one () {
>  	ff=--ff
> +
> +	if is_empty_commit $@
> +	then
> +		empty_args="--allow-empty"
> +	fi
> +
>  	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac

You do not handle the case where pick_one is called with -n. I think you
need to move the case statement in front and then call is_empty_commit
$sha1.

Not that it matters after this change, but in general using $@ without
quotes looks wrong to my eyes.

> @@ -780,9 +792,17 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
>  	sed -n "s/^>//p" |
>  while read -r shortsha1 rest
>  do
> +
> +	if test -z "$keep_empty" && is_empty_commit $shortsha1
> +	then
> +		comment_out="# pick"
> +	else
> +		comment_out="pick"
> +	fi
> +
>  	if test t != "$preserve_merges"
>  	then
> -		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
> +		printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"

How about setting comment_out="# " or comment_out="" instead and then

 printf '%s%s\n' "$comment_out" "pick $shortsha1 $rest" >> "$todo"

That would read more natural to me.
