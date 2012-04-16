From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 4/4] git-rebase: add keep_empty flag
Date: Mon, 16 Apr 2012 12:46:54 -0400
Message-ID: <20120416164654.GE13366@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-5-git-send-email-nhorman@tuxdriver.com>
 <20120415093302.GA6263@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJp56-0007o5-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab2DPQrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:47:08 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37097 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPQrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:47:06 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SJp4p-00010O-KY; Mon, 16 Apr 2012 12:47:01 -0400
Content-Disposition: inline
In-Reply-To: <20120415093302.GA6263@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195663>

On Sun, Apr 15, 2012 at 11:33:03AM +0200, Clemens Buchacher wrote:
> On Fri, Apr 13, 2012 at 02:45:07PM -0400, Neil Horman wrote:
> >
> > Add a command line switch to git-rebase to allow a user the ability to specify
> > that they want to keep any commits in a series that are empty.
> 
> Thanks. That should be useful.
> 
> > +is_empty_commit() {
> > +     ptree=$(git rev-parse "$1"^{tree})
> > +     pptree=$(git rev-parse "$1"^^{tree})
> > +     return $(test "$ptree" = "$pptree")
> > +}
> > +
> 
> What's the extra leading 'p' for? Any reason not to use 'tree' and
> 'ptree'?
> 
Hold-over from when I did this in C (pointer to tree vs. pointer to parent
tree).  I can remove the p though, as you right, it makes less sense in a shell

> >  pick_one () {
> >  	ff=--ff
> > +
> > +	if is_empty_commit $@
> > +	then
> > +		empty_args="--allow-empty"
> > +	fi
> > +
> >  	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
> 
> You do not handle the case where pick_one is called with -n. I think you
> need to move the case statement in front and then call is_empty_commit
> $sha1.
> 
> Not that it matters after this change, but in general using $@ without
> quotes looks wrong to my eyes.
> 
Ack, to both points.

> > @@ -780,9 +792,17 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
> >  	sed -n "s/^>//p" |
> >  while read -r shortsha1 rest
> >  do
> > +
> > +	if test -z "$keep_empty" && is_empty_commit $shortsha1
> > +	then
> > +		comment_out="# pick"
> > +	else
> > +		comment_out="pick"
> > +	fi
> > +
> >  	if test t != "$preserve_merges"
> >  	then
> > -		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
> > +		printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"
> 
> How about setting comment_out="# " or comment_out="" instead and then
> 
>  printf '%s%s\n' "$comment_out" "pick $shortsha1 $rest" >> "$todo"
> 
> That would read more natural to me.
Yeah, I can do that
> 
