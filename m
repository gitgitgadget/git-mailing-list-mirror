From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Sun, 13 Jul 2008 15:14:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807131504130.4816@eeepc-johanness>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> <200807110036.17504.chriscool@tuxfamily.org> <200807130837.40961.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 15:15:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI1QF-0008Qu-Kp
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 15:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbYGMNOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYGMNOX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 09:14:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:39366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753101AbYGMNOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 09:14:22 -0400
Received: (qmail invoked by alias); 13 Jul 2008 13:14:20 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp065) with SMTP; 13 Jul 2008 15:14:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ELAIuezwEVKTYVG29EhQmDiQMuCk1pv2AzK9Knp
	Te33JKMbYfZHe4
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807130837.40961.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88310>

Hi,

On Sun, 13 Jul 2008, Christian Couder wrote:

> [PATCH] bisect: check all merge bases instead of only one

It would have been so much nicer to squash the two patches into one, as we 
generally frown upon "let's submit one patch that we know is faulty, and 
then another that fixes it".  That's so CVS/SVN.

> @@ -384,19 +383,21 @@ check_merge_bases() {
>  	_skip="$3"
>  	for _g in $_good; do

I really wonder if we can be blessed with less ugly variable names.  Maybe 
some that do not start with an underscore for no apparent reason, and 
maybe some that are longer than one letter, so that you have a chance to 
understand later what it is supposed to contain.  I.e. something like:

	for good in $good_revisions
	do

(You see that I also broke up the "for" and "do" into two lines, as is 
common practice in the rest of Git's shell code.)

>  		is_merge_base_ok "$_bad" "$_g" && continue
> -		_mb=$(git merge-base $_g $_bad)
> -		if test "$_mb" = "$_g" || is_among "$_mb" "$_good"; then
> -			mark_merge_base_ok "$_bad" "$_g"
> -		elif test "$_mb" = "$_bad"; then
> -			handle_bad_merge_base "$_bad" "$_g"
> -		elif is_among "$_mb" "$_skip"; then
> -			handle_skipped_merge_base "$_bad" "$_g" "_mb"
> -		else
> -			mark_testing_merge_base "$_mb"
> -			checkout "$_mb" "a merge base must be tested"
> -			checkout_done=1
> -			break
> -		fi
> +		for _mb in $(git merge-base --all $_g $_bad); do
> +			if test "$_mb" = "$_g" || is_among "$_mb" "$_good"; then
> +				continue
> +			elif test "$_mb" = "$_bad"; then
> +				handle_bad_merge_base "$_bad" "$_g"
> +			elif is_among "$_mb" "$_skip"; then
> +				handle_skipped_merge_base "$_bad" "$_g" "_mb"
> +			else
> +				mark_testing_merge_base "$_mb"
> +				checkout "$_mb" "a merge base must be tested"
> +				checkout_done=1
> +				return
> +			fi
> +		done
> +		mark_merge_base_ok "$_bad" "$_g"
>  	done
>  }

I really wonder if we cannot do better than that, in terms of code 
complexity.

For example, I wonder if we should special-case the start, and not just 
check everytime if there are unchecked merge bases instead.  If there are, 
check the first.

But that can wait until you come back from your vacation...

Have fun,
Dscho
