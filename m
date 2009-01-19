From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v1 1/1] bug fix, diff whitespace ignore options
Date: Mon, 19 Jan 2009 04:53:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901190446480.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de> 
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>  <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de> <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com> <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
 <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:54:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOlDq-0002Y8-Sy
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbZASDxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 22:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbZASDxX
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:53:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:38067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754309AbZASDxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 22:53:22 -0500
Received: (qmail invoked by alias); 19 Jan 2009 03:53:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp040) with SMTP; 19 Jan 2009 04:53:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0RHhaGtr07CB9DGP27xojo4k2Yc4xUbtt2yYdUc
	In+FQVl9Eb2Qnl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106316>

Hi,

On Sun, 18 Jan 2009, Keith Cascio wrote:

>  Fixed bug in diff whitespace ignore options.
>  It is now OK to specify more than one whitespace ignore option
>  on the command line. In unit test 4015, expect success rather
>  than failure for 4 cases.
>  Note: I do not fully understand why this fix works, but it passes
>  all 68 t4???-* diff test scripts.
> 
> The semantics of the three whitespace ignore flags
> { -w, -b, --ignore-space-at-eol }
> obey a relation of transitive implication, i.e. the stronger
> options imply the weaker options:
> -w                    implies the other two
> -b                    implies --ignore-space-at-eol
> --ignore-space-at-eol implies only itself
> 
> Therefore it is never necessary to specify more than one of these
> on the command line.  Yet we imagine scenarios where software
> wrappers (e.g. GUIs, etc) generate command lines that switch on
> more than one of these flags simultaneously.  It is unreasonable
> to prohibit specifying more than one, since a new user might not
> immediately discern the implication relation.  Now we call such
> a command line valid and legal.
> 
> Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
> ---

This does not really look all that similar to other commit messages.

For example, "Note: I do not fully understand why this fix works, but it 
passes all 68 t4???-* diff test scripts." is rather discouraging.  If you 
are not convinced, how should we be?

However, I almost can excuse that, but...

>  t/t4015-diff-whitespace.sh |    8 ++++----
>  xdiff/xutils.c             |   22 ++++++++++++----------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index d7974d1..b9bda86 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -245,17 +245,19 @@ static unsigned long
> xdl_hash_record_with_whitespace(char const **data,
>  			while (ptr + 1 < top && isspace(ptr[1])
>  					&& ptr[1] != '\n')
>  				ptr++;
> -			if (flags & XDF_IGNORE_WHITESPACE_CHANGE
> -					&& ptr[1] != '\n') {
> -				ha += (ha << 5);
> -				ha ^= (unsigned long) ' ';
> -			}
> -			if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
> -					&& ptr[1] != '\n') {
> -				while (ptr2 != ptr + 1) {
> +			if( ! (          flags & XDF_IGNORE_WHITESPACE

... this is just plain ugly, not to mention breaking the coding style of 
the surrounding code in a rather blatant way.

> )){
> +				if(      flags & XDF_IGNORE_WHITESPACE_CHANGE
> +						&& ptr[1] != '\n') {
>  					ha += (ha << 5);
> -					ha ^= (unsigned long) *ptr2;
> -					ptr2++;
> +					ha ^= (unsigned long) ' ';
> +				}
> +				else if( flags & XDF_IGNORE_WHITESPACE_AT_EOL
> +						&& ptr[1] != '\n') {
> +					while (ptr2 != ptr + 1) {
> +						ha += (ha << 5);
> +						ha ^= (unsigned long) *ptr2;
> +						ptr2++;
> +					}

Besides, I think what you actually wanted is

		if (flags & XDF_IGNORE_WHITESPACE)
			; /* already handled */
		else if (flags & XDF_IGNORE_WHITESPACE_CHANGE)
			...
		else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL)
			...

for improved readability both of the code and the patch.

Ciao,
Dscho
