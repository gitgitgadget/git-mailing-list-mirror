From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: git send-email doesn't take To: addresses from the patch
Date: Wed, 01 Sep 2010 00:50:13 -0700
Message-ID: <4C7E05B5.1050805@gmail.com>
References: <4C7B5853.7010001@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 09:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqi5U-0005tW-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 09:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab0IAHuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 03:50:23 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37337 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0IAHuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 03:50:20 -0400
Received: by pxi10 with SMTP id 10so2746183pxi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=f0vfZNYTg8YzjxkjD4hFCcNDKFDctKnvqh1t0otGJig=;
        b=yIPrV1NGwTPUafqFWgF6riB8IFqToEDEsIvXu+U1z+76Jf5unyJN0dlW0XxIbxN+pZ
         tPTqv+cUoky4rSRv+WingOANfv7Mz0rWXTLqT7ah8ow5Z7OqLuMV0BGTibi5KmB/Sxsu
         7Z+xRugBoSTphz333g+PRWb6X9pVAeu1mVjsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Gh99nMvWmDLuB9zHzJAJOzYqbrCKQ1ol5CQ6CmLT1/M1TmMRhFQU/6et+lcsdC89nT
         p2Ee5XL15rRUGGweJuxL8uHHBizc8iTZIQz050eyKRux9oJwlWaA8WwixsWBhTQhXTSI
         uOOqyxs9SEDS6v2hOaM/8QnRRlqWsG9LB5dU4=
Received: by 10.114.127.10 with SMTP id z10mr8396073wac.62.1283327420431;
        Wed, 01 Sep 2010 00:50:20 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id k23sm18030288waf.5.2010.09.01.00.50.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 00:50:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.7) Gecko/20100805 Lightning/1.0b2pre Thunderbird/3.1.1
In-Reply-To: <4C7B5853.7010001@st.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155021>

  On 08/30/2010 12:05 AM, viresh kumar wrote:
> Hi,
>
> I am using git-1.7.2 and use following command to generate a patch
>
> $ git format-patch --to abc@xyz.com HEAD^
>
> Now when I use git send-email to send this patch, it is not taking the
> To: embedded in the patch as its destination, instead it asks for one
> and if not provided it keeps this field empty.
> On the other hand git send-email is taking the Cc addresses from
> the patch perfectly in to account.
>
> How can I use git send-email to pick To: addresses directly from the
> patch.

You can't. Nobody has bothered to make git-send-email consider the To: field. Can you try this patch out? I think it will mostly work, except I haven't bothered to look at --compose yet and I'm halfway stumbling through this code right now.

---->8-----

Subject: [PATCH] send-email: Use To: headers in patch files

It's a minor annoyance when you take the painstaking time to setup To:
headers for each patch in a large series, and then go out to send the
series with git-send-email and watch git ignore the To: headers in the
patch files.

Therefore, always add To: headers from a patch file to the To: headers
for that message. Keep the prompt for the blanket To: header so as to
not break scripts (and user expectations). This means even if a patch has a
To: header, git will prompt for the To: address. Otherwise, we'll need to
introduce interface breakage to either request the header for each patch
missing a To: header or default the header to whatever To: address is found
first (be it in a patch or from user input). Both of these options don't seem
very obvious/useful.

Reported-by: viresh kumar<viresh.kumar@st.com>
Signed-off-by: Stephen Boyd<bebarino@gmail.com>
---
  git-send-email.perl |    7 +++++++
  1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..06373ed 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1176,6 +1176,13 @@ foreach my $t (@files) {
  					$1, $_) unless $quiet;
  				push @cc, $1;
  			}
+			elsif (/^To:\s+(.*)$/) {
+				foreach my $addr (parse_address_line($1)) {
+					printf("(mbox) Adding to: %s from line '%s'\n",
+						$addr, $_) unless $quiet;
+					push @to, sanitize_address($addr);
+				}
+			}
  			elsif (/^Cc:\s+(.*)$/) {
  				foreach my $addr (parse_address_line($1)) {
  					if (unquote_rfc2047($addr) eq $sender) {
-- 
1.7.2.2.178.gd8a94
