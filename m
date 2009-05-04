From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] templates: make example pre-commit hook verify submodule commits exist
Date: Sun, 03 May 2009 22:27:50 -0700
Message-ID: <7vzldt4euh.fsf@alter.siamese.dyndns.org>
References: <E1M0oxK-0002uG-RT@mail1.catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon May 04 07:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0qzs-0000rH-6Y
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 07:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZEDFpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 01:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbZEDFpl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 01:45:41 -0400
Received: from fed1rmmtai106.cox.net ([68.230.241.54]:34365 "EHLO
	fed1rmmtai106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbZEDFpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 01:45:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090504052749.ZBJJ2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 May 2009 01:27:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id nHTq1b0074aMwMQ04HTq7w; Mon, 04 May 2009 01:27:50 -0400
X-Authority-Analysis: v=1.0 c=1 a=YCZlbH2lAoYA:10 a=aYitfKqsYd4A:10
 a=sAV9wGZvAAAA:8 a=cZdP0qvEbt8crDu3tesA:9 a=AL_2k3AOKESaFholW53-IcaOQIEA:4
X-CM-Score: 0.00
In-Reply-To: <E1M0oxK-0002uG-RT@mail1.catalyst.net.nz> (Sam Vilain's message of "Mon\, 4 May 2009 15\:32\:29 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118203>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> With submodules it can be quite easy to end up with a situation where the
> version in the supermodule doesn't exist in the submodule.  Add to the
> example pre-commit hook a script which checks before every commit whether
> the submodule commit is likely to exist at the URL defined in the
> .gitmodules file.
>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>  This should be useful for those using submodules.  Perhaps it should also
>  have an equivalent in the 'git submodule' command.

If I am a developer who is not interested in any of the submodules in the
project at all (i.e. I do not have any submodule checked out), my commits
will never touch any of the submodules.  In such a case, I shouldn't be
forced to fetch/clone the submodule nor have a checkout.

Which means...

> +# first, check that all submodule commits are available by a remote
> +# which has the same URL as the one they are listed in.
> +if [ -n "$GIT_WORK_TREE" ]
> +then
> +	cd "$GIT_WORK_TREE"
> +fi
> +
> +git ls-tree $(git write-tree) | grep commit |
> +while read mode type sha1 submodule
> +do

... the input fed to this while look utterly wrong.  At least, you should
be checking *new* commit that is introduced to the tree with this commit.

I didn't read the body of the while loop; no matter what it does, if its
input is wrong, its end result cannot be correct.
