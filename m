From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "fatal: Untracked working tree file 'so-and-so' would be
 overwritten by merge"
Date: Mon, 9 Oct 2006 09:03:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610090858120.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610081657400.3952@g5.osdl.org>
 <7v7izaf62c.fsf@assigned-by-dhcp.cox.net> <7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 18:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWxb9-0000UU-HA
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 18:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932812AbWJIQDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932953AbWJIQDU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 12:03:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932812AbWJIQDT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Oct 2006 12:03:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k99G39aX015421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Oct 2006 09:03:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k99G38YH003330;
	Mon, 9 Oct 2006 09:03:08 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodsmdq0m.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.466 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28571>



On Sun, 8 Oct 2006, Junio C Hamano wrote:
> 
> Note note note.  The above patch alone leaves merge risky to
> remove an untracked working tree files, and needs to be
> compensated by corresponding checks to the git-merge-xxx
> strategies.  The original code was overcautious, but was
> protecting valid cases too.

I think the difference _should_ be that we only remove the local file if 
it was removed _remotely_.

In  that case, it was there in the original tree, and removing it is 
correct.

> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh index 
> fba4b0c..25aedb7 100755 --- a/git-merge-one-file.sh +++ 
> b/git-merge-one-file.sh @@ -23,6 +23,9 @@ #
>  "$1.." | "$1.$1" | "$1$1.")

So I actually think that we should NOT consider these three cases to be 
the same.

There are really two distinct cases:

 - "$1.." and "$1.$1"
	The file had already been removed locally, AND WE SHOULD NOT TOUCH 
	IT.

 - "$1$1.":
	The file was removed remotely, and we SHOULD remove it locally.

In fact, we already have that as a "special case":

>  	if [ "$2" ]; then
>  		echo "Removing $4"
> +	elif test -f "$4"
> +		echo "ERROR: untracked $4 is removed by the merge."
> +		exit 1
>  	fi
>  	if test -f "$4"; then
>  		rm -f -- "$4" &&

That

	if [ "$2" ]; then
		echo "Removing $4"

is _exactly_ that case: it is the "$1$1." case, and we already treat it 
differently, but we actually treat it differently the wrong way: we only 
print out the message for that case, but the actual "touch working tree" 
code should _also_ be affected.

If the local index doesn't change, we should not print out the "Removing 
'so-and-so'" message, but we should also not even _touch_ that file, 
because it was already "gone" as far as the local tree was concerned.

Agreed?

		Linus
