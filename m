From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: git_get_project_config requires only $git_dir, not also $project
Date: Sat, 27 Mar 2010 20:27:57 +0100
Message-ID: <201003272027.59216.jnareb@gmail.com>
References: <4BAE4F07.3040806@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Tobias Heinlein <keytoaster@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:28:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvbg7-0005AC-Lt
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab0C0T2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:28:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:63369 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0C0T2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:28:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so457059fgg.1
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=elPPserxHhFMisv44TDWh2vPZdYLMI2uyro79diAMGw=;
        b=W8gBYgD4Oq8Tit8QgDpptBGUUTB3HKmrPUGcNG3axAxCUBriFLPKM5bNRPcijr47xR
         O0KqDl5Ek3ku2LvUJiH5WxocbO2lmsuUUAfxFHrcFJZyAMoozYjY0/NzLhxn/lqtUzxv
         9rzqHS6Q40b5sTcg7lRxAMyUfQiD6FddoY3lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Pa/F4UpCuIiQ1+EWos7bH6NF2Qwinyrp5LfiGD3xXgocTc8FPiy20cNEAlhoi451Py
         mzob9OBkhdqXctbIsh/uZZMYE/6z1Mkwy9MViHUhJHub6rcXXatetl46R9WuclHUPINp
         6RAwRvZwb9mZjTHFmznAuk1BYbGF07FksSb2Y=
Received: by 10.87.20.13 with SMTP id x13mr656530fgi.67.1269718086946;
        Sat, 27 Mar 2010 12:28:06 -0700 (PDT)
Received: from [192.168.1.13] (abvl214.neoplus.adsl.tpnet.pl [83.8.209.214])
        by mx.google.com with ESMTPS id 4sm4078752fgg.22.2010.03.27.12.28.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:28:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BAE4F07.3040806@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143347>

On Sat, 27 Mar 2010, Tobias Heinlein wrote:

> I stumbled upon a small bug in gitweb that was introduced by commit
> 9be3614eff36271d5f1cd460a568a219902cb044.
> 
> The projects list page is no longer able to display the projects'
> descriptions and owners properly when they are set in the git config
> file, e.g. like this:
> 
>   [gitweb]
>           owner = Tobias Heinlein
>           description = test
> 
> This is because git_get_project_owner() calls
> git_get_project_config('owner'):
> 
>   sub git_get_project_config {
>           my ($key, $type) = @_;
> 
>           # do we have project
>           return unless (defined $project && defined $git_dir);
> 
> At this point, $project is not defined (because it doesn't have to;
> $git_dir is defined, though, due to another change in the said
> commit), causing the call to return early at the newly introduced
> line of code. 
> 
> Determining the description fails accordingly.
> 
> I'm afraid I can't provide a patch as my Perl foo isn't that good.

Does the following patch fixes this issue?

-- >8 --
From: Jakub Narebski <jnareb@gmail.com>
Date: Sat, 27 Mar 2010 20:26:59 +0100
Subject: [PATCH] gitweb: git_get_project_config requires only $git_dir, not also $project

Fix overeager early return in git_get_project_config, introduced in 9be3614
(gitweb: Fix project-specific feature override behavior, 2010-03-01).  When
git_get_project_config is called from projects list page via
git_get_project_owner($path) etc., it is called with $git_dir defined (in
git_get_project_owner($path) etc.), but $project variable is not defined.
git_get_project_config doesn't use $project variable anyway.

Reported-by: Tobias Heinlein <keytoaster@gentoo.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a2d2283..c356e95 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2216,8 +2216,7 @@ sub config_to_multi {
 sub git_get_project_config {
 	my ($key, $type) = @_;
 
-	# do we have project
-	return unless (defined $project && defined $git_dir);
+	return unless defined $git_dir;
 
 	# key sanity check
 	return unless ($key);
-- 
1.7.0.1
