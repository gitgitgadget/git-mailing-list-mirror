From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: Make revision display
 configurable
Date: Mon, 03 Nov 2008 15:34:02 -0800
Message-ID: <7vy700tmdx.fsf@gitster.siamese.dyndns.org>
References: <1225668059-12670-1-git-send-email-pgit@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:35:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx8xK-0008Vm-Nk
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 00:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbYKCXeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 18:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbYKCXeU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 18:34:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbYKCXeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 18:34:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF06D75453;
	Mon,  3 Nov 2008 18:34:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 486B97544F; Mon,  3 Nov 2008 18:34:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F006059E-A9FF-11DD-B1DE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100010>

Pete Harlan <pgit@pcharlan.com> writes:

> Add configuration option hooks.showrev, letting the user override how
> revisions will be shown in the commit email.
>
> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
> Acked-By: Andy Parkins <andyparkins@gmail.com>
> @@ -390,8 +396,13 @@ generate_update_branch_email()
>  
>  		echo ""
>  		echo $LOGBEGIN
> -		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
> -		git rev-list --pretty --stdin $oldrev..$newrev
> +		git rev-parse --not --branches |
> +			grep -v $(git rev-parse $refname) |
> +			git rev-list --stdin $oldrev..$newrev |
> +		while read onerev
> +		do
> +			eval $(printf "$showrev" $onerev)
> +		done

This would make the default "non-custom" case much less efficient.  If we
really cared, perhaps we could do something like this...

	git rev-parse --not --branches |
        grep -v "^$(git-rev-parse --not $refname)\$" |
        case "$using_custom_showrev" in
        yes)
		git rev-list --stdin $oldrev..$newrev |
        	while read onerev
                do
                done
                ;;
	*)
        	git rev-list --pretty --stdin $oldrev..newrev
                ;;
	esac

But I suspect we do not care too much about it.

Will apply as submitted.  Thanks
