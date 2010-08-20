From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mergetool: Remove explicit references to /dev/tty
Date: Fri, 20 Aug 2010 07:27:25 -0500
Message-ID: <20100820122724.GS10407@burratino>
References: <20100820035236.GA18267@gmail.com>
 <1282303049-11201-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQil-0002yP-5H
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab0HTM3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:29:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43541 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0HTM3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:29:13 -0400
Received: by yxg6 with SMTP id 6so1195837yxg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kRva6ooINaJIYf39UkBkImNDNOH0jrCYopxscSvUH0I=;
        b=fT+0MfcR9GP/qmG+hcSWfrJiCUnVnqsKYMIodaNaCZd/lzjpOfvajeJqfN6gWIXDgG
         GE0DsTkyTQT2g4Apga8nUjfbFYPKgrqok+6zNpWjouXd5lS21JAb83yt1+h3/3ps8RU4
         nzMWA1l/41EWqfFt8dBub3CX28Q5bgR0oMLjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PNnf+Je/VPBWtFx/LBsLzgyS3nLOHWutkp8g2tCzE8MXbm9K9+2ycEALf0xad0SgEz
         6YpgvBbNUvBLdRo4pAxVdN4VA3iC3+dh+9xrRWZlim3ylx9f2+VoWsCXnrrwxvskDeKJ
         N2qMLfCYF6g7DBaYkyn1u2Ms3avrQyYQO7H38=
Received: by 10.150.181.18 with SMTP id d18mr1621684ybf.270.1282307352312;
        Fri, 20 Aug 2010 05:29:12 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u41sm248238yba.1.2010.08.20.05.29.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:29:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282303049-11201-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154021>

Charles Bailey wrote:

> mergetool used /dev/tty to switch back to receiving input from the user
> via inside a block with a redirected stdin.
> 
> This harms testability, so change mergetool to save its original stdin
> to an alternative fd in this block and restore it for those sub-commands
> that need the original stdin.

Sounds good.

> +++ b/git-mergetool--lib.sh
> @@ -35,7 +35,7 @@ check_unchanged () {
>  		while true; do
>  			echo "$MERGED seems unchanged."
>  			printf "Was the merge successful? [y/n] "
> -			read answer < /dev/tty
> +			read answer

Part of the run_merge_tool codepath.  The only place this is called
with TOOL_MODE=merge is by merge_file which has stdin redirected,
so this should be safe.  Good.

> +++ b/git-mergetool.sh
> @@ -292,14 +292,15 @@ if test $# -eq 0 ; then
>      printf "Merging:\n"
>      printf "$files\n"
>  
> -    files_to_merge |
> +    # Save original stdin to fd 3
> +    files_to_merge 3<&0 |

I would think this should work, but it doesn't feel idiomatic.  Why
not save stdin a little earlier, so the reader does not have to track
down whether it has been redirected?

The test quietly passes for me with dash but fails with ksh:

 /home/jrn/src/git4/git-mergetool: line 303: 3: cannot open [Bad file descriptor]

With the patch below on top, it passes with dash and ksh.
---
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 84edf7d..2e82522 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -275,10 +275,13 @@ files_to_merge() {
     fi
 }
 
 
 if test $# -eq 0 ; then
     cd_to_toplevel
 
+    # Save original stdin
+    exec 3<&0
+
     if test -e "$GIT_DIR/MERGE_RR"
     then
 	rerere=true
@@ -292,8 +294,7 @@ if test $# -eq 0 ; then
     printf "Merging:\n"
     printf "$files\n"
 
-    # Save original stdin to fd 3
-    files_to_merge 3<&0 |
+    files_to_merge |
     while IFS= read i
     do
 	if test $last_status -ne 0; then
-- 
