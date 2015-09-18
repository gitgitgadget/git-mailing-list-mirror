From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Fri, 18 Sep 2015 18:25:24 -0400
Message-ID: <20150918222524.GA22410@flurp.local>
References: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jan Viktorin <viktorin@rehivetech.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 00:25:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd464-0006ui-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 00:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbbIRWZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 18:25:32 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33502 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbIRWZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 18:25:31 -0400
Received: by igbkq10 with SMTP id kq10so45703435igb.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ykDvcTylsz/YCuvs0G4rYV+PochNLJQDPvtQQefDxc0=;
        b=vCXh0DDOETJ4aAQmC1mypqDL88ciW1YgszqsQtXgKCOiMRabTx6/XWOSVKa853q0RB
         e+Oo+9bPCLw+dP9ZllnmsVI+vjCy4RJlRGvjhIhs74FxnfRRl/LiYYmSi4JEvcAwIpUu
         22Ew+TWM4EFNI6+WfWhPE1pYb5w+swAh990Y6VQ6pMd2JyepaYp05H+go6xJk4RxsrkS
         wvVkLY5HhuxAFEscu0jkNMZwLFW9TUKsmcLpTq7KOPqOdIXgmWht0//W1XSh2U5EfcRI
         JrphTfbhOUdk0knCxnCamzCJ7mEz18bUbVX+ErmrTEXHDlnn7UnXB1hrzD2sfYi7WXAr
         SyQw==
X-Received: by 10.50.83.104 with SMTP id p8mr772798igy.90.1442615130889;
        Fri, 18 Sep 2015 15:25:30 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id bd7sm138543igb.19.2015.09.18.15.25.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Sep 2015 15:25:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278224>

On Fri, Sep 18, 2015 at 03:12:50PM -0700, Brian Norris wrote:
> On the latest version of git-send-email, I see this error just before
> running SMTP auth (I didn't provide any --smtp-auth= parameter):
> 
>   Use of uninitialized value $smtp_auth in pattern match (m//) at /usr/local/google/home/briannorris/git/git/git-send-email.perl line 1139.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index c5a3f766f7fd..e3ff44b4d0cd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1136,7 +1136,7 @@ sub smtp_auth_maybe {
>  
>  	# Check mechanism naming as defined in:
>  	# https://tools.ietf.org/html/rfc4422#page-8
> -	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
> +	if ($smtp_auth && $smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
>  		die "invalid smtp auth: '${smtp_auth}'";
>  	}

Thanks, makes sense. I wonder if moving the check to the point where
$smtp_auth is actually used (despite the noisier diff) would be cleaner,
like this:

--- 8< ---
diff --git a/git-send-email.perl b/git-send-email.perl
index c5a3f76..2a5ceda 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1134,12 +1134,6 @@ sub smtp_auth_maybe {
 		Authen::SASL->import(qw(Perl));
 	};
 
-	# Check mechanism naming as defined in:
-	# https://tools.ietf.org/html/rfc4422#page-8
-	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
-		die "invalid smtp auth: '${smtp_auth}'";
-	}
-
 	# TODO: Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
@@ -1154,6 +1148,12 @@ sub smtp_auth_maybe {
 		my $cred = shift;
 
 		if ($smtp_auth) {
+			# Check mechanism naming as defined in:
+			# https://tools.ietf.org/html/rfc4422#page-8
+			if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
+				die "invalid smtp auth: '${smtp_auth}'";
+			}
+
 			my $sasl = Authen::SASL->new(
 				mechanism => $smtp_auth,
 				callback => {
--- 8< ---
