From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3] git-svn: Fix discarding of extra parents from svn:mergeinfo
Date: Mon, 22 Feb 2010 10:57:34 +0100
Message-ID: <201002221057.35088.trast@student.ethz.ch>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com> <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Sam Vilain <sam@vilain.net>,
	Eric Wong <normalperson@yhbt.net>
To: Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:07:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjV34-0003gD-T8
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 10:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab0BVJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 04:57:37 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:1852 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab0BVJ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 04:57:36 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 10:57:35 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 10:57:34 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <1266825442-32107-4-git-send-email-tuomas.suutari@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140659>

On Monday 22 February 2010 08:57:22 Tuomas Suutari wrote:
> Use merge-base rather than rev-list for detecting if a parent is an
> ancestor of another, because rev-list gives incorrect results
> sometimes.
[...]
> -				my $revs = command_oneline(
> -					"rev-list", "-1",
> -					"$new_parents[$i]..$new_parents[$j]",
> +				my $mergebase = command_oneline(
> +					"merge-base",
> +					"$new_parents[$i]", "$new_parents[$j]",
>  				       );
> -				if ( !$revs ) {
> +				if ( $mergebase eq $new_parents[$i] ) {
>  					undef($new_parents[$i]);

I think you swapped the test (or I got confused, which is entirely
possible).  Let I = $new_parents[$i] and J = $new_parents[$j].  The
old one was

  test -z "$(git rev-list -1 I..J)"

which reads "unless there are any commits on J which are not on I",
i.e., it fails unless J is an ancestor of I.

But the new one is

  "$(git merge-base I J)" == I.

so suddenly I must be an ancestor of J.

Is that what you were fixing?  Because I don't think the 'rev-list -1'
test is any worse than the merge-base test.  If it's not, please tell
us what you are fixing.  Either way, please change the commit message
appropriately.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
