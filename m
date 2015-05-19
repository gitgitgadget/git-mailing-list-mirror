From: Luke Diamand <luke@diamand.org>
Subject: git-p4: test t9820-git-p4-editor-handling.sh failing
Date: Tue, 19 May 2015 07:40:55 +0100
Message-ID: <555ADAF7.5020001@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 19 08:41:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YubDe-0002pg-1x
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 08:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbbESGld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 02:41:33 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36241 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbbESGlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 02:41:32 -0400
Received: by wgbgq6 with SMTP id gq6so5706474wgb.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9JE5uoqPBEo6UgfXBnvQT6t6qie96vH4EDr2/H365cY=;
        b=HNm+pdsD1L+ZXSGpTrOsrKfn92sMJJCdGX6N+/5HZS9XN5DEyahyl51qmmdNEQ8Z5R
         dXffmZohtmiJ0ob8/JtIkZiGAITwsCCCQK5UXaKpX0quVv0Kzx7RO5MF8SHn08jbughu
         tMM5NsR408SgZQnT2d0Kebm/Y+j7g3JgiM1lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=9JE5uoqPBEo6UgfXBnvQT6t6qie96vH4EDr2/H365cY=;
        b=GY1x7tomAKLqy+nSjx4gmnt3Ov/idYS6NYCNrSn/N1ahRYpEUL6qCMtpaYLj68gRPV
         nSbc0wb5n3fQZotyAVLDHFSnJ667anuvt27tzltBVw+mzFm69SGQcJu6lNwXR9oXU7C4
         hFRUUc8MKlnmuJNeN+iRL+vpBrZ2DJFj5yTTIriD2QxcAr6ZaNFTyj5WFvSd9pAXiKHA
         V5BH3Oq0R4PTGOp96QfL5QDHgWUo9+qC1ZtFVwnT4+sWz/zdLhPNn3iXrRo1wVfJiod5
         ZQSmEtdPFOKKydheslxxMRHcpHkzeenBvJKzdaJuhNr9gFgcQ5R75ZRpNyDpt96QXumz
         zEXA==
X-Gm-Message-State: ALoCoQlVt2VxizowxOIKOmksHcZoupm6AbwW8HWVEv3Vjn/GSQM/J7SYctDKQCHyq50yt4jV5KHX
X-Received: by 10.180.99.2 with SMTP id em2mr4307830wib.59.1432017691288;
        Mon, 18 May 2015 23:41:31 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fa8sm15755732wib.14.2015.05.18.23.41.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 23:41:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269343>

Hi!

The test I put in recently for multi-word editor handling in git-p4, 
t9820-git-p4-editor-handling.sh, has started failing.

It looks like the reason is the change to it that goes:

-	P4EDITOR="touch \"$git/touched\"" git p4 submit &&
+	P4EDITOR=": >\"$git/touched\"" git p4 submit &&

The problem is that git-p4 invokes $P4EDITOR passing it the name of the 
submit template. After it returns, it checks that the editor has 
actually updated the file's modification time.

The first version (somewhat subtly) does this; the second doesn't.

I put the extra check with "$git/touched" in just to check that P4EDITOR 
was being invoked at all, but I guess it's not strictly necessary. I 
wondered about doing this:

+	P4EDITOR=": >\"$git/touched\" && touch" git p4 submit &&

But it's possibly getting a bit obscure. I guess it could be OK with a 
comment.

Could it go back to the original version, or is there some other way to 
achieve a similar effect?

Thanks!
Luke
