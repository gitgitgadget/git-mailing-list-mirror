From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Mon, 26 Oct 2015 12:17:24 -0700
Message-ID: <20151026191724.GE7881@google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqnGu-0006O3-SC
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbJZTR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 15:17:29 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34093 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbbJZTR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:17:28 -0400
Received: by padhk11 with SMTP id hk11so196712073pad.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JUcp8/G5J0WT16dcZMDX0SY3nieXOW1R8k3rk7muqYE=;
        b=reOwIxbebaan9lMgSrd2B+oF+d2+3SadqR7K1vUllL84kjhEktQFNMbsBydj/K28tB
         lfBJlQLJpNqme3kHzq8pxfD0q43IpsDiL2cCMI0asJHVgUTNkdTKhrzaYuqjpkSBaKjD
         NtalL56qdfCdITHM1wDTqXQV7XtlE57uWVMiSDlVZ3NTConK6aiVj4gXPnjZfdyraPw3
         GZ2S9kFFW47G0DUoOJQiF+shCaWomXTC6ApxJmvKmHesrAXrssSj7NarwyrZMWlIlfD9
         9NdKsY++aIFSAiFy5J3XkY+u5lFBr7gdrk+sIwxLVGxa3IOHPBLIxp9MV2p14TrGMJW8
         Ws4Q==
X-Received: by 10.68.189.69 with SMTP id gg5mr24037474pbc.55.1445887047631;
        Mon, 26 Oct 2015 12:17:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:28d6:2c54:3a57:2d94])
        by smtp.gmail.com with ESMTPSA id dd4sm35330412pbb.52.2015.10.26.12.17.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Oct 2015 12:17:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280209>

Johannes Schindelin wrote:

> When prefixing a Git call in the test suite with 'TEST_GDB_GIT=1 ', it
> will now be run with GDB, allowing the developer to debug test failures
> more conveniently.

Neat.

[...]
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -19,4 +19,11 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
>  PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
>  
> +if test -n "$TEST_GDB_GIT"
> +then
> +	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"

Most TEST_ environment variables that git respects are under
GIT_TEST_* --- e.g., GIT_TEST_OPTS.  Should this match that pattern
as well, for easier debugging with commands like 'env | grep GIT_'?

What happens if the child in turn calls git again?  Should this
unset TEST_GDB_GIT in gdb's environment?

The gdb manual and --help output advertise "--args".  Has "-args"
(with a single dash) always worked?

> +	echo "Could not run gdb -args ${GIT_EXEC_PATH}/@@PROG@@ $*" >&2
> +	exit 1

Does the 'exec' after the fi need this as well?  exec is supposed to
itself print a message and exit when it runs into an error.  Would
including an 'else' with the if make the control flow clearer?  E.g.

	if test -n "$TEST_GDB_GIT"
	then
		exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
	else
		exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
	fi

Thanks,
Jonathan

diff --git i/wrap-for-bin.sh w/wrap-for-bin.sh
index a151c95..db0ec6a 100644
--- i/wrap-for-bin.sh
+++ w/wrap-for-bin.sh
@@ -19,11 +19,10 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
-if test -n "$TEST_GDB_GIT"
+if test -n "$GIT_TEST_GDB"
 then
-	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-	echo "Could not run gdb -args ${GIT_EXEC_PATH}/@@PROG@@ $*" >&2
-	exit 1
+	unset GIT_TEST_GDB
+	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+else
+	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
 fi
-
-exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
