From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/13] Exclude optimizations
Date: Thu, 14 Mar 2013 20:05:57 +0700
Message-ID: <CACsJy8BbS_iNvSRxdg0WVfF4V3oifh1_qTD6qBch6247o5bwxA@mail.gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 14:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG7s2-0004Y1-St
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 14:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702Ab3CNNGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 09:06:30 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42762 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3CNNG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 09:06:29 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so2241208oag.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1dOrqM3MD32kjI7ztLPhj2DH4pLWgEttI37i9nktIk8=;
        b=VA8oOqXCIkax+Zj3LC3LilTdApBOmTAZg9YAMh+nIwKVoY/38z1/gEazPrTiVJLHFM
         VnGDVE+i4sl9uLaifraWjrPPVP6gmhTY177VWfVYF9c+FitNFap0Mc9JBPXkP6GX7gJ5
         k8eKF56rTYfrWXHwBbCQAR/YubXTOw0e1lIzdxQggzLJ3gCMZM4mzg7r2QXNBstmK7+k
         8g2LsX9MB+KYxfy1ysh5Wxrqhieg2CPFQNCy0g3q8oU3t38uqMXsSkRJAPW0T5XH0muC
         RV6rprUPmHThYRWh5XpP2pCvgKNftoeqfWvk32S1Rngtg8y+gu8A8htbXYQUcJVb3nsS
         NlsQ==
X-Received: by 10.182.43.103 with SMTP id v7mr1102777obl.17.1363266388888;
 Thu, 14 Mar 2013 06:06:28 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Thu, 14 Mar 2013 06:05:57 -0700 (PDT)
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218134>

Just thinking out loud. If I'm not mistaken, a directory's mtime is
only changed when files are added are removed in that directory. And
that's all we care about in read_directory. So if we keep a secondary
index containing the list of all (tracked and untracked) .gitignore
files and all untracked files (regardless ignore status), we could
avoid reading a directory if:

 - all relevant .gitignore are unchanged
 - the directory's stat is unchanged

In that case we already have the list of untracked files. Exclude can
be run over to filter out ignored files. And because we know these are
not tracked, we do not need to call index_name_exists (not if
ignore_case == 0).

In the best case, nothing's added or removed, read_directory just
issues a bunch of lstat (like index refresh), filter out ignored files
and _not_ trigger (nor pay penalty for) lazy_init_name_hash. webkit
has 11k untracked files. I don't think we have problems storing that
list as we already have to chew 182k entries in index.

Did I make any mistakes above?
-- 
Duy
