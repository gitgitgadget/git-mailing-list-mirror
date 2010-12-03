From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to
 be more useful
Date: Fri, 3 Dec 2010 02:06:03 -0600
Message-ID: <20101203080603.GC18202@burratino>
References: <20101110015327.GB1503@burratino>
 <1290629960-60917-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:06:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQev-0001IY-Cv
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758018Ab0LCIGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 03:06:20 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35994 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757192Ab0LCIGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:06:19 -0500
Received: by gwj20 with SMTP id 20so4630091gwj.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QmhlH3Dn5TJCnFMgIrroN+9ficr7mHt67L54lajT9uM=;
        b=TLBH/26HnUi7WZphvtq/WpZheAc+KAOhlRdm+8mn67+1YOWyBoLnkPo1kPcMc5bVfl
         YfND3jLte7BhF2m98AyX07VNLkcP5Tb3YDKEc4KBHoyqe1/NEa8pQKMtN4yY1EBV572E
         aYwmz9fchSAdQ+sog/0Vn2UJ5/MQNo4VGtDp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nr22k/9QOEaMwicA7ySfnh53bz73EDhkiVf6RC1dF9nIUWrCsRQt5oROCDJZT8V4KI
         /ftTGFSaT8iuT+zo5cAPYQy1vym9r1onOo6QYvWZ560mTtW7taCiio8Oth16ksrnTXUY
         p+Ce+RQV9waCx0oy72WKfH8ciBpwOopgzsokM=
Received: by 10.150.97.1 with SMTP id u1mr3310384ybb.74.1291363579284;
        Fri, 03 Dec 2010 00:06:19 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id f23sm348821ybh.22.2010.12.03.00.06.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 00:06:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290629960-60917-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162768>

Hi,

Kevin Ballard wrote:

> [Subject: [PATCHv3] git-rebase--interactive.sh: extend "edit" command to be more useful

Maybe something like

	rebase-i: treat "edit" without sha1 as a request to amend previous commit

would make the meaning more obvious in a shortlog.

> Extend the "edit" command to simply stop for editing if no sha1 is
> given or if the sha1 is equal to "-". This behaves the same as "x false"
> but is a bit friendlier for the user.

Nice.  I like the semantics.

> * Picked up the extended explanation suggested by Jonathan Nieder.
>   I left off the last line about "noop" as that doesn't seem related.

Right, please feel free to remind me if I forget to pick that up again.

> * If the line given is "edit - some comments", emit "some comments" when
>   stopped. This is undocumented

I think that's okay for now (though of course it would be best to explain
some example uses in Documentation/git-rebase.txt in the form of examples).

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -469,12 +469,29 @@ do_next () {
> +			comment="$rest"
> +			line=$(git rev-list --pretty=oneline -1 --abbrev-commit --abbrev=7 HEAD)

Hmm, the script seems to assume rev-list will not fail throughout.  :/
Ok.

> +			sha1="${line%% *}"
> +			rest="${line#* }"
> +			echo "$sha1" > "$DOTEST"/stopped-sha

Maybe this can be done without relying on details of --pretty=oneline
format?

			sha1=$(git rev-parse --short HEAD)
			rest=$(git show -s --format=%s HEAD)

(Yes, elsewhere the script uses

	git rev-list --no-merges --pretty=oneline --abbrev-commit \
		--abbrev=7 --reverse --left-right --topo-order "$@" |
	sed -n "s/^>//p" |
	while read -r shortsha1 rest

but in that loop, avoiding an extra exec seems more important.)

> +		fi
>  		git rev-parse --verify HEAD > "$AMEND"
>  		warn "Stopped at $sha1... $rest"
> +		if test -n "$comment"; then
> +			warn
> +			warn "	$comment"
> +			warn

Thanks, looks good to me.

Ideas for tests?  (see t3404 for inspiration)
