From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Tue, 19 Jan 2016 22:05:42 -0600
Message-ID: <871t9cvqsp.fsf@waller.obbligato.org>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
	<87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: Marcus Brinkmann <m.brinkmann@semantics.de>
X-From: git-owner@vger.kernel.org Wed Jan 20 05:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLk1t-0005sB-5u
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 05:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934578AbcATEFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 23:05:53 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:34553 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933267AbcATEFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 23:05:52 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aLk3E-0001G4-8N; Tue, 19 Jan 2016 22:07:20 -0600
In-Reply-To: <569EE046.9040506@semantics.de> (Marcus Brinkmann's message of
	"Wed, 20 Jan 2016 02:17:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Marcus Brinkmann <m.brinkmann@semantics.de> writes: > 'git
    subtree split' will fail if the history of the subtree has empty > tree commits
    (or trees that are considered empty, such as submodules). > This fix keeps
    track of this condition and correctly follows the history > over such commits.
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9  
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284425>

Marcus Brinkmann <m.brinkmann@semantics.de> writes:

> 'git subtree split' will fail if the history of the subtree has empty
> tree commits (or trees that are considered empty, such as submodules).
> This fix keeps track of this condition and correctly follows the history
> over such commits.

Thanks for working on this!  Please add a test to t7900-subtree.sh.

> @@ -625,12 +629,16 @@ cmd_split()
>  		
>  		# ugly.  is there no better way to tell if this is a subtree
>  		# vs. a mainline commit?  Does it matter?
> -		if [ -z $tree ]; then
> -			set_notree $rev
> -			if [ -n "$newparents" ]; then
> -				cache_set $rev $rev
> +		if [ -z $found_first_commit ]; then
> +			if [ -z $tree ]; then
> +				set_notree $rev
> +				if [ -n "$newparents" ]; then
> +					cache_set $rev $rev
> +				fi
> +				continue
> +			else
> +				found_first_commit=yes
>  			fi
> -			continue
>  		fi
>
>  		newrev=$(copy_or_skip "$rev" "$tree" "$newparents") || exit $?

Can you explain the logic here?  The old code appears to be using the
lack of a tree to filter out "mainline" commits from the subtree history
when splitting.  If that test is only done before seeing a proper
subtree commit and never after, then any commit mainline commit
following the first subtree commit in the rev list will miss being
marked with set_notree and the cache will not have the identity entry
added.

Test #36 in t7900-subtree.sh has a mainline commit listed after the
first subtree commit in the rev list, I believe.

I'm not positive your change is wrong, I'd just like to understand it
better.  I'd also like a comment explaining why it works so future
developers don't get confused.  Overall, I am trying to better comment
the code as I make my own changes.

                           -David
