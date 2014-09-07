From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Sun, 7 Sep 2014 12:42:27 -0700
Message-ID: <20140907194227.GA1611@google.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQiMC-0007cB-49
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 21:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaIGTmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 15:42:35 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43231 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbaIGTme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 15:42:34 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so4267395pad.35
        for <git@vger.kernel.org>; Sun, 07 Sep 2014 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/4iu2scg9cmCHfqg5NnUsX5/V26WI24ZjN4ZdyE4Fys=;
        b=gn+8jnY1ShQVq4ZtSZ8Ot0vIR+TCxPHya/R4pnN1yn4YVEAowVAN4aTSX24I9l1q23
         JyFoLGw/vysXeWLlaIepMixYml5uVHccCWRTrDwBvYe4NcTsGI+fHc1kyqLsHiaQCeXo
         YhBKudXlJkIJs+bR9zi82GcR8zU+16BKV+WZzwVpX8hnd8LuaRlN4DHxF3Lkr7eXlN+U
         Ni1ov5Jh67vrxpVlHCw9vSJsOcFv2mhpwjh5PbA1b0hb0ayPtUzNZp2vevdyCqmijHjP
         oKBKgplgFzqBh16gRczs2H68BJFiluOVgi+UzbQpU/tkCL+29LtJN/Xu35Eluki8Kcq+
         Fzjg==
X-Received: by 10.68.197.65 with SMTP id is1mr14081006pbc.125.1410118954109;
        Sun, 07 Sep 2014 12:42:34 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ms12sm6996813pbc.51.2014.09.07.12.42.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 12:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410049821-49861-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256623>

Hi,

David Aguilar wrote:

> --- /dev/null
> +++ b/check-headers.sh
> @@ -0,0 +1,29 @@
[...]
> +	"$@" -Wno-unused -I"$subdir" -c -o "$header".check -x c - <"$header" &&

All .c files in git are supposed to start by #include-ing
git-compat-util.h, cache.h, or builtin.h to set the appropriate
feature test macros and include system headers.

Headers rely on that for basic types like int32_t.  They don't need to
include git-compat-util.h because the .c file that included them would
have already, and .h files #include-ed by git-compat-util.h especially
*shouldn't* #include the compat header, so how about something like
the following for squashing in?

A side-thought: as long as we're building pre-compiled headers, could
we use them in the build?

Thanks,
Jonathan

diff --git a/check-headers.sh b/check-headers.sh
index bf85c41..08ca136 100755
--- a/check-headers.sh
+++ b/check-headers.sh
@@ -18,7 +18,7 @@ git ls-files *.h |
 while read header
 do
 	echo "HEADER $header" &&
-	"$@" -Wno-unused -x c -c -o "$header".bin - <"$header" &&
+	"$@" -Wno-unused -x c -include git-compat-util.h -c -o "$header".bin - <"$header" &&
 	rm "$header".bin ||
 	maybe_exit $?
 done
