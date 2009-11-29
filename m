From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 17:47:48 +0100
Message-ID: <20091129164748.GB7921@atjola.homenet>
References: <loom.20091129T164518-669@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Weseloh <Peter.Weseloh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 17:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmwI-0005Vo-Bp
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZK2Qrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 11:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbZK2Qrq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:47:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:54637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbZK2Qrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:47:46 -0500
Received: (qmail invoked by alias); 29 Nov 2009 16:47:50 -0000
Received: from i59F55C61.versanet.de (EHLO atjola.homenet) [89.245.92.97]
  by mail.gmx.net (mp058) with SMTP; 29 Nov 2009 17:47:50 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Cdi1jjfnCVpQLxYHS3QL2llu4haDDdzFEE7QoAH
	toaFiMnjQmJXju
Content-Disposition: inline
In-Reply-To: <loom.20091129T164518-669@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134022>

On 2009.11.29 16:28:17 +0000, Peter Weseloh wrote:
> Suppose I have the following situation:
>
>   o--o--o                    Release_1.0
>  /    \  \
> o-o-o--o--o-o-o-o-o-o---o--o Mainline
>      \       \       \ /
>       F1--F2--M1--F3--M2     Feature_A
>
> Now I want to backport "Feature_A" to the "Release_1.0" branch so tha=
t
> it gets included into the next minor release, i.e. I want to apply th=
e
> commits F1, F2 and F3 onto the "Release_1.0" branch.

> Is there a better way? To me this scenario sounds not unusual but I
> could not find a solution.

What's unusual there is that you merged from Mainline to Feature_A.
Usually, the history would look like this:

   o--o--o                    Release_1.0
  /    \  \
 o-o-o--o--o-o-o-o-o-o---o--o Mainline
      \                 /
       F1-----F2------F3      Feature_A

And then you could easily use rebase to get the job done.

Had you known beforehand that Feature_A is a candidate for backporting,
you would have even branch from an older commit like this:

   o--o--o                    Release_1.0
  /    \  \
 o-o-o--o--o-o-o-o-o-o---o--o Mainline
  \                     /
   F1--------F2-------F3      Feature_A

Then you could easily merge Feature_A to Release_1.0 as well, without
merging anything unrelated.

But that's just for the future...

Given you current history, you could use format-patch + am like this:

git format-patch --stdout --first-parent Mainline..Feature_A > fa.mbox
git checkout Release_1.0
git am -3 fa.mbox

The --first-parent options make it follow the first parent of the merge
commits only, so the whole stuff on the Mainline branch is ignored. And
you just get F1, F2 and F3 in fa.mbox, which you then apply using am.

A long time ago, I hacked the --first-parent thing into rebase, but (of
course) the first iteration of the patch wasn't quite perfect and as
I've not been scratching my own itch there, I never got around to
actually polish the patch so it could get into git.git. Maybe you want
to pick it up?

http://thread.gmane.org/gmane.comp.version-control.git/62782

Bj=F6rn
