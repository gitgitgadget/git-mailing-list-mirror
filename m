From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] t9020: use configured Python to run test helper
Date: Wed, 19 Dec 2012 08:15:40 -0500
Message-ID: <20121219131540.GA14207@padd.com>
References: <7vip7yd4u2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 14:16:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlJVB-0006pN-V0
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 14:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab2LSNPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 08:15:45 -0500
Received: from honk.padd.com ([74.3.171.149]:44421 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab2LSNPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 08:15:44 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id C7FDE20C2;
	Wed, 19 Dec 2012 05:15:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 30B9422615; Wed, 19 Dec 2012 08:15:40 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vip7yd4u2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211820>

gitster@pobox.com wrote on Tue, 18 Dec 2012 20:49 -0800:
> The test helper svnrdump_sim.py is used as "svnrdump" during the
> execution of this test, but the arrangement had a few undesirable
> things:
> 
>  - it relied on symbolic links;
>  - unportable "export VAR=VAL" was used;
>  - GIT_BUILD_DIR variable was not quoted correctly;
>  - it assumed that the Python interpreter is in /usr/bin/ and
>    called "python" (i.e. not "python2.7" etc.)
> 
> Rework this by writing a small shell script that spawns the right
> Python interpreter, using the right quoting.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * The analysis above counts more bugs than the number of lines that
>    are deleted in this section of the code...
> 
>  t/t9020-remote-svn.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index 4f2dfe0..d7be66a 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -12,9 +12,13 @@ then
>  	test_done
>  fi
>  
> -# We override svnrdump by placing a symlink to the svnrdump-emulator in .
> -export PATH="$HOME:$PATH"
> -ln -sf $GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py "$HOME/svnrdump"
> +# Override svnrdump with our simulator
> +PATH="$HOME:$PATH"
> +export PATH PYTHON_PATH GIT_BUILD_DIR
> +
> +write_script "$HOME/svnrdump" <<\EOF
> +exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
> +EOF

You don't really need to export PYTHON_PATH and GIT_BUILD_DIR if
you get them expanded in the svnrdump script wrapper.  Unquote
the EOF but add \ for $@.

Either way it's a nice improvement, especially with the
bugs/lines metric being >1.

		-- Pete
