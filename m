From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] completion: refactor __gitcomp related tests
Date: Tue, 30 Oct 2012 23:45:58 +0100
Message-ID: <20121030224558.GN12052@goldbirke>
References: <1350869941-22485-1-git-send-email-felipe.contreras@gmail.com>
 <1350869941-22485-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 23:46:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTKZe-0004Cj-SH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 23:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934856Ab2J3WqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 18:46:04 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:65281 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab2J3WqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 18:46:02 -0400
Received: from localhost6.localdomain6 (p5B130686.dip0.t-ipconnect.de [91.19.6.134])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MGXWy-1TXkPe3yQC-00E1PL; Tue, 30 Oct 2012 23:45:59 +0100
Content-Disposition: inline
In-Reply-To: <1350869941-22485-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ZLBKc8faZbFqsHN6bD9aE+WKGgKy3EJ6OudVNtz1Tcr
 wOQZ9rjCpK0DLeB5X8yrr61Ywg1DNt+4VwiiwCMHxzglyZjFXu
 ws5/+Y9BSSDACPZoWWMdtScrKPI7mIHS+FihbdE+cGxFzT5C3Y
 1FLxfnp0AztoGQHrV+eS/5PejnF532waest8mxurkSWDcEKSZE
 VtT9y/2OSaipvt4mipMoNd0QUywFTGtB+OTCaRZz3GULbR90zd
 4AyxhUagL5k8dQuB6bdbmxlTTVO8dTEUpAW2mpWW5scesk3L1N
 rBfXgne8QM252c+8BnPhUIcU2sBpKDyGHSHScMTpsa9yEfDeDH
 PIuaD9SZ1K3aQWo0Wo7PRNpxw3afGbt5BHuwUHB/2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208763>

On Mon, Oct 22, 2012 at 03:39:00AM +0200, Felipe Contreras wrote:
> Lots of duplicated code!
> 
> No functional changes.

I'm not sure.
I'm all for removing duplicated application code, but I'm usually more
conservative when it comes to test code.  The more logic, the more
possibility for bugs in tests.  So tests should be dead simple, even
if that means some duplicated test code or the lack of convenience
functions.
While this might be considered just a matter of personal preference, ...

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 72 ++++++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 49 deletions(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index cbd0fb6..1c6952a 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -72,87 +72,61 @@ test_completion_long ()
>  
>  newline=$'\n'
>  
> -test_expect_success '__gitcomp - trailing space - options' '
> -	sed -e "s/Z$//" >expected <<-\EOF &&
> -	--reuse-message=Z
> -	--reedit-message=Z
> -	--reset-author Z
> -	EOF
> +test_gitcomp ()
> +{
> +	sed -e 's/Z$//' > expected &&
>  	(
>  		local -a COMPREPLY &&
> -		cur="--re" &&
> -		__gitcomp "--dry-run --reuse-message= --reedit-message=
> -				--reset-author" &&
> +		cur="$1" &&
> +		shift &&
> +		__gitcomp "$@" &&

... I was really puzzled by how __gitcomp() gets its arguments here,
and had to think for a while to figure out why it's not broken.
