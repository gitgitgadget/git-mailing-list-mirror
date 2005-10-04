From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Return error when not checking out an entry due to dirtiness.
Date: Tue, 04 Oct 2005 15:52:01 -0400
Message-ID: <200510041952.j94Jq1Hs016453@laptop11.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 21:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMsph-00037c-UF
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 21:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVJDTwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 15:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVJDTwK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 15:52:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42699 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964943AbVJDTwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 15:52:09 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j94Jq2Dr018221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 15:52:02 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j94Jq1Hs016453;
	Tue, 4 Oct 2005 15:52:01 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 03 Oct 2005 22:11:03 MST." <7vu0fxhno8.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 04 Oct 2005 15:52:02 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9687>

Junio C Hamano <junkio@cox.net> wrote:
> Without -f flag, 'git-checkout-index foo.c' issued an error message
> when foo.c already existed in the working tree and did not match index.
> However it did not return an error from the underlying checkout_entry()
> function and resulted in a successful exit(0).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  * I've made sure that the existing scripts do not use
>    checkout-index without -f in a way that could be affected by
>    this change.  However, third-party scripts may be affected by
>    this.  Cogito and StGIT should be OK -- they either run
>    checkout with -f, do not check the error return when it does
>    not use -f, or runs checkout without -f in an empty working
>    tree.
> 
>  checkout-index.c |   11 ++++++++---
>  entry.c          |    2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> 5a166f6a9d1b7ca2de673139fbfc4112b1b2e308
> diff --git a/checkout-index.c b/checkout-index.c
> --- a/checkout-index.c
> +++ b/checkout-index.c
> @@ -63,15 +63,20 @@ static int checkout_file(const char *nam
>  
>  static int checkout_all(void)
>  {
> -	int i;
> +	int i, errs;
>  
> -	for (i = 0; i < active_nr ; i++) {
> +	for (errs = i = 0; i < active_nr ; i++) {

This is ugly. Why not just:

        errs = 0;
        for (i = 0; i < active_nr ; i++) {    

(errs is in no way the variable controlled by the for).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
