From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Shift object enumeration out of upload-pack
Date: Wed, 10 Jun 2009 00:20:19 -0700
Message-ID: <7vr5xssggc.fsf@alter.siamese.dyndns.org>
References: <c77435a80906071834m1600d23dpb4a1b58c7a61361d@mail.gmail.com>
	<7vvdn78n98.fsf@alter.siamese.dyndns.org>
	<c77435a80906091650j7709d006j64749c9692c25b29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI6l-0001HJ-Vy
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbZFJHUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZFJHUT
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:20:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63299 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZFJHUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:20:18 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610072018.HWCT25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 10 Jun 2009 03:20:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 27LK1c0074aMwMQ047LKq4; Wed, 10 Jun 2009 03:20:20 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=6T3YdD5i54EA:10 a=7Bo2R7OvxYYA:10
 a=pGLkceISAAAA:8 a=6VC1-P1-AAAA:8 a=9KeM8TZf8H8Xul7rGbsA:9
 a=RUD2M6O4TIvMjo82xmMA:7 a=Yy-ycDIysg5Fyx343HkPtCkdbswA:4 a=MSl-tDqOz04A:10
 a=LRnQQUT8V1QA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121260>

Nick Edelen <sirnot@gmail.com> writes:

> Offload object enumeration in upload-pack to pack-objects, but fall
> back on internal revision walker for shallow interaction.   Aside from
> architecturally making more sense, this also leaves the door open for
> pack-objects to employ a revision cache mechanism.  Test t5530 updated
> in order to explicitly check both enumeration methods.
>
> Signed-off-by: Nick Edelen <sirnot@gmail.com>
> Acked-by: Nicolas Pitre <nico@cam.org>
>
> ---
>  err, I guess you wanted me to resubmit this?

Strictly speaking, _I_ don't, but _you_ might ;-)

I doubt that the proposed commit log message justifies the claim
"architecturally making more sense" with concrete enough discussion, but
I'll let it pass.

Your log message got much better this time, by hinting that this is a
preparatory step to introduce the rev-cache mechanism.  It is good way to
defend a patch saying that it is not just a useless code churn, but it is
a necessary step to get us closer to a more useful goal.

> diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
> index f5102b9..22eec24 100755
> --- a/t/t5530-upload-pack-error.sh
> +++ b/t/t5530-upload-pack-error.sh
> ...
> @@ -51,11 +52,20 @@ test_expect_success 'fsck fails' '
>  test_expect_success 'upload-pack fails due to error in rev-list' '
>
>  	! echo "0032want $(git rev-parse HEAD)
> -00000009done
> +0034shallow $(git rev-parse HEAD^)00000009done
>  0000" | git upload-pack . > /dev/null 2> output.err &&
>  	grep "waitpid (async) failed" output.err
>  '
>
> +test_expect_success 'upload-pack fails due to error in pack-objects
> enumeration' '

You have a wrapped line here.  Please check the setting of your MUA,
especially if you are planning to send more patches to the list in the
future.

No need to resend; I fixed this up when applying.

Thanks.
