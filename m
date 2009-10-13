From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] bisect reset: Allow resetting to any commit, not just a branch
Date: Tue, 13 Oct 2009 22:06:18 +0200
Message-ID: <200910132206.18460.chriscool@tuxfamily.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <7vaazw6uyi.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.0910131116300.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:09:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxnfr-0004q8-6e
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934234AbZJMUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753074AbZJMUFK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:05:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36266 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728AbZJMUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:05:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1CB70818903;
	Tue, 13 Oct 2009 22:04:26 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 31E67818333;
	Tue, 13 Oct 2009 22:04:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.2.00.0910131116300.5105@dr-wily.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130198>

On Tuesday 13 October 2009, Anders Kaseorg wrote:
> @@ -311,8 +311,7 @@ bisect_reset() {
>  	}
>  	case "$#" in
>  	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
> -	1) git show-ref --verify --quiet -- "refs/heads/$1" ||
> -	       die "$1 does not seem to be a valid branch"
> +	1) git rev-parse --verify "$1^{commit}" || exit
>  	   branch="$1" ;;
>  	*)
>  	    usage ;;

I agree with the purpose of the patch but I think something like the 
following would be better:

@@ -311,8 +311,8 @@ bisect_reset() {
        }
        case "$#" in
        0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
-       1) git show-ref --verify --quiet -- "refs/heads/$1" ||
-              die "$1 does not seem to be a valid branch"
+       1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null ||
+               die "'$1' does not seem to point to a valid commit"
           branch="$1" ;;
        *)
            usage ;;

It would give a better error message when "git rev-parse" fails instead of:

fatal: Needed a single revision

and it would not print the SHA1 from "$1^{commit}" when "git rev-parse" 
succeeds.

Best regards,
Christian.
