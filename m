From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Thu, 31 Mar 2016 10:47:43 -0700
Message-ID: <CAGZ79kYFr8bjEhV9sDzR1KbqAVrO89-DRBN2u+zQBwVYViDP9w@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-4-git-send-email-sbeller@google.com>
	<CAPig+cSE5wVNNwiwkYoOXnfDKUO3tBKqUUbqBHPCTA5ibj-kNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:47:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alghE-0002R7-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbcCaRrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:47:45 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34852 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbcCaRro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:47:44 -0400
Received: by mail-ig0-f171.google.com with SMTP id cl4so131747702igb.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=05oaDAZEN7rkDfFsctICKLpNQsE0db4v7TGyJcgnQjk=;
        b=TweIQ3grlbLPSiSyCGsKpY6riHgivzx4xbNXl7rHuCo9hJc94ZnpOLhbPeMerbRboz
         5h47jhjLKwCGlDb+9yEEP1FYBYZBPed4A/+eoHMmJuGZZJ6yJo1FoTx6poQnz7gKDnRq
         YFjUecG3VBrodzxyg0J0JfP6EMIiUwlmlkBdFa1FveAqd7A3iHfsD3jp53N1U0cvj7YA
         oqNOftWuTHMV4jbMgaqUVn4WzWa0bGjZKabFhSjenFn1DlU+LMHSFys6TOFV895pUKhs
         fpNoj4Q37fquucyIeNyb5aKPFVzHpdNnbM0wQO7TrzvbMuAskMuh79npTeCF+ryqmxu7
         /Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=05oaDAZEN7rkDfFsctICKLpNQsE0db4v7TGyJcgnQjk=;
        b=OVTGVNmt+SP5NCOnX9akrFvbdc+LfUYcxHCGwDmmAt0VNwZMSEHtI3hM99Hkqibm3V
         bPXcnXmErXAQwEZPqAWIEP0v0hSvdb4LWPIYoTRB6TstguZtisG13nQoFDhhQR3xNZ8Y
         w4g8//1UOY7E1iM1wFzxjg5+4mg7tadbFkrpgeYBtkkT91N8IuPUWC1LlgPTCV/4vhcC
         43sHdqbRYejDXvBN3SD+0esrBGsOQSVZhxTADlCSwXZ+BSmNNLdJ+XOOSEIrwGD8hu52
         jzdF0NcryESnUHHttELf67asGK5VXToQ5G3ptg8rJsWjLmADB0x42kwSnS9nyz4GJA44
         1CRg==
X-Gm-Message-State: AD7BkJI2fjTNNACbkAnFWFvQ+Opv9fOwGI+StuQ/Uo4OEicDJNI/NLTnPdaWvtZ2WFLvgu3GqIudktwMxGym+WZJ
X-Received: by 10.50.13.36 with SMTP id e4mr945180igc.85.1459446463810; Thu,
 31 Mar 2016 10:47:43 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 10:47:43 -0700 (PDT)
In-Reply-To: <CAPig+cSE5wVNNwiwkYoOXnfDKUO3tBKqUUbqBHPCTA5ibj-kNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290432>

On Wed, Mar 30, 2016 at 10:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> -       else if (ref_count < 0)
>> -               return -1;
>> +       else if (ref_count < 0) {
>> +               if (!bundle_to_stdout)
>> +                       close(bundle_fd);
>
> Why is this close() here considering that it gets closed by the 'err' path?

Thanks for pointing out; fixed in a reroll.
