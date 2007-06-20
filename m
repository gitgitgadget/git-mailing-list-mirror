From: Sam Vilain <sam@vilain.net>
Subject: Re: post-update script to update wc - suggestions welcome
Date: Wed, 20 Jun 2007 19:03:22 +1200
Message-ID: <4678D13A.7090904@vilain.net>
References: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 09:03:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0uE1-0007S8-TL
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 09:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbXFTHDc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 03:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbXFTHDc
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 03:03:32 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:35479 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425AbXFTHDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 03:03:31 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id D7D7F13A4F8; Wed, 20 Jun 2007 19:03:29 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 4258013A342
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 19:03:24 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <E1I0tZY-0001Uz-00@www.watts.utsl.gen.nz>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50542>

Sam Vilain wrote:
> #!/bin/sh
> #
> # An example hook script to prepare a packed repository for use over
> # dumb transports.
> #
> # To enable this hook, make this file executable by "chmod +x post-update".
> 
> git-update-server-info
> 
> ref=$1

In particular, if anyone can think of a clever and reliable way to
detect whether the repository is bare or not (perhaps the presence of
$GIT_DIR/index ?), then this could conceivably become the default
example hook script, by making the below bit conditional on whether this
looks like a non-bare repository.

Sam.

> active=`git-symbolic-ref HEAD`
> if [ "$ref" = "$active" ]
> then
>   echo "Pushing to checked out branch - updating working copy" >&2
>   export GIT_DIR=`cd $GIT_DIR; pwd`
>   cd ..
>   success=
>   if git-diff-files
>   then
>     git-diff-index -z -R --name-status HEAD | perl -n0 -le \
> 	'if ($z^=1) {
> 		$status=$_;
> 	 }
> 	 else {
>         	$filename=$_;
> 		printf STDERR "$status\t$filename\n";
> 		if($status eq "D"){
> 			unlink($filename)
> 				or die("unlink($filename) failed; $!")
> 		}
>          }' &&
>     git-reset --hard HEAD && success=1
>   fi
>   if [ -z "$success" ]
>   then
>     (
>     echo "Non-bare repository checkout is not clean - not updating it"
>     echo "However I AM going to update the index.  Any in-progress commit"
>     echo "happening in that checkout will be thrown away, but on the bright"
>     echo "side this is probably the least confusing thing for us to do and"
>     echo "at least we're not throwing any files somebody has changed away"
>     git-reset --mixed HEAD
>     echo 
>     echo "This is the new status of the upstream working copy:"
>     git-status
>     ) >&2
>   fi
> fi
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
