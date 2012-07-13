From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 18:46:03 -0400
Message-ID: <5000A52B.3090003@windriver.com>
References: <7vobnkadsw.fsf@alter.siamese.dyndns.org> <1342194690-31578-1-git-send-email-paul.gortmaker@windriver.com> <7vipdr8mch.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 00:46:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spod2-0006ts-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 00:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2GMWqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 18:46:18 -0400
Received: from mail.windriver.com ([147.11.1.11]:47020 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2GMWqR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 18:46:17 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6DMkEBW008662
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 13 Jul 2012 15:46:14 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Fri, 13 Jul 2012
 15:46:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vipdr8mch.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201426>

On 12-07-13 03:58 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> If git am fails to apply something, the end user may need
>> to know where to find the patch.  This is normally known for
>> a single patch, but if the user is processing a mbox with
>> many patches, they may not have a single broken out patch
>> handy.  So, provide a helpful hint as to where they can
>> find the patch to do some sort of manual fixup, if we
>> are processing a mbox with more than one patch in it.
> 
> I would rather see this done even for a single patch mbox.  The

OK, I got the opposite impression from your prev. mail when
you mentioned that I hadn't limited the message output at all.

I'm fine with the changes you've proposed below, and can squash that
into a v3 and resend again.

Paul.
--

> patch that was fed to "git apply" by "git am" and failed to apply is
> that one, not the one in the mbox you gave "git am".  The latter may
> be ungrokkable with GNU patch or "git apply", if the original was
> sent in Quoted-Printable and such MIME funnies, which is the whole
> point of having a separate file there for "git am", instead of
> feeding the original.
> 
> I am not sure if we should limit $patch_format to mbox, but I think
> showing this unconditionally regardless of mbox/stgit/hg will teach
> the user only one location to remember, so perhaps like this?
> 
>  Documentation/config.txt | 3 +++
>  git-am.sh                | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e1168c..b1f0a75 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -143,6 +143,9 @@ advice.*::
>  		Advice shown when you used linkgit:git-checkout[1] to
>  		move to the detach HEAD state, to instruct how to create
>  		a local branch after the fact.
> +	amWorkDir::
> +		Advice that shows the location of the patch file when
> +		linkgit:git-am[1] fails to apply it.
>  --
>  
>  core.fileMode::
> diff --git a/git-am.sh b/git-am.sh
> index dc48f87..f1ae932 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -834,9 +834,9 @@ did you forget to use 'git add'?"
>  	if test $apply_status != 0
>  	then
>  		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
> -		if test $patch_format = mbox && test "$last" -ne "1"
> +		if test "$(git config --bool advice.amworkdir)" != false
>  		then
> -			eval_gettextln "You can find the copy of the patch that failed here:
> +			eval_gettextln "The copy of the patch that failed is found in:
>     $dotest/patch"
>  		fi
>  		stop_here_user_resolve $this
> 
