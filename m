From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save
 As" emails
Date: Fri, 18 Dec 2009 13:59:37 -0800
Message-ID: <1261173577.14059.5.camel@swboyd-laptop>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
	 <1261172078-9174-1-git-send-email-bebarino@gmail.com>
	 <loom.20091218T223918-175@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 22:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkra-0004mB-90
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZLRV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZLRV7t
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:59:49 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60882 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbZLRV7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:59:47 -0500
Received: by ywh12 with SMTP id 12so3895081ywh.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=DzuF5tLYqXSzAgLImAM5ZY/nuIExuiFrOczklsXjTUs=;
        b=frnNb095H9QDlrgcQykxvaESktX1/LqKeCJk+j3i9Mrn/hUVbFuXWx2skyHVwFUTOO
         EIRKytAk0Tz05e7R/UY/KW/XqiQoUEEl/I0lvlzh84pJZ2FbHyVegvba2cd94wBU3Nln
         T/RpJGrbumZHMYDlNah5NkvqrC49DXJP1SzVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qp54tSV3XU0fpbmbmKZQCQyXHDR7f7RWsV2WbtPjJH9pl1e+aWvmFfNSfeZLJbsOBl
         La+CK4HjrNSbV+tyoVryEWk/cg7PLfpBzVzW6Uu2pCDVDZSs1aCzq9QpuRVguCvwPvb0
         Grkriyg/2rXvJOer10miY9g0+N+X5R2cCGLlA=
Received: by 10.150.110.23 with SMTP id i23mr7033583ybc.345.1261173581044;
        Fri, 18 Dec 2009 13:59:41 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 9sm1266332ywe.26.2009.12.18.13.59.39
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 13:59:40 -0800 (PST)
In-Reply-To: <loom.20091218T223918-175@post.gmane.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135442>

On Fri, 2009-12-18 at 21:42 +0000, Eric Blake wrote:
> Stephen Boyd <bebarino <at> gmail.com> writes:
> 
> > +	{
> > +		echo "X-Fake-Field: Line One\015" &&
> 
> echo and \ do not portably mix.  For that matter, shell double quotes and 
> backslash escapes that are not required by POSIX do not portably mix.  To 
> reliably create carriage returns in shell, you need to use printf, or else 
> something like:
> 
> echo "...@" | tr '@' '\015'
> 

Thanks. Hopefully squashing this in will make it even more portable?

--->8---
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7b6269d..19d5ca1 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -84,18 +84,18 @@ test_expect_success setup '
                git format-patch --stdout first | sed -e "1d"
        } > patch1.eml &&
        {
-               echo "X-Fake-Field: Line One\015" &&
-               echo "X-Fake-Field: Line Two\015" &&
-               echo "X-Fake-Field: Line Three\015" &&
+               printf "X-Fake-Field: Line One\015\n" &&
+               printf "X-Fake-Field: Line Two\015\n" &&
+               printf "X-Fake-Field: Line Three\015\n" &&
                git format-patch --stdout first |
                sed -e "1d" -e "3,\$d" | tr -d "\n" &&
-               echo "\015" &&
+               printf "\015\n" &&
                git format-patch --stdout first |
                sed -e "1,2d" -e "4,\$d" | tr -d "\n" &&
-               echo "\015" &&
+               printf "\015\n" &&
                git format-patch --stdout first |
                sed -e "1,3d" -e "5,\$d" | tr -d "\n" &&
-               echo "\015\n\015" &&
+               printf "\015\n\015\n" &&
                git format-patch --stdout first | sed -e "1,5d"
        } > patch1-crlf.eml &&
        sed -n -e "3,\$p" msg >file &&
