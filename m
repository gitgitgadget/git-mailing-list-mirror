From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 00/27] Clean up update-refs --stdin and implement ref_transaction
Date: Wed, 26 Mar 2014 14:39:34 -0400
Message-ID: <53331EE6.2010100@kitware.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:45:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSspQ-0006an-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbaCZSpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:45:20 -0400
Received: from na6sys009bog014.obsmtp.com ([74.125.150.68]:34863 "HELO
	na6sys009bog014.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755425AbaCZSpS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 14:45:18 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]) (using TLSv1) by na6sys009bob014.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUzMgPmP3LPxNVwFUORiczmIsnEACWIiI@postini.com; Wed, 26 Mar 2014 11:45:18 PDT
Received: by mail-ig0-f171.google.com with SMTP id hl1so858924igb.4
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 11:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=R1TqB3VF3a+5UeMHiW9BI8pXQL74zfu+jsYhZGD3y+o=;
        b=F+CodCWdHbFlMN6RAjXdUYQrUFSIH/A99FEBn6t+WdOO9MNU+Fija5i5sFeYen2Mc+
         svqcp5w4sfuoDKJQd10TGsgzLP77HjpEpSaQFRVzje+e0+mc66RtU/aYXjmx3AnDPksq
         nrkNqV6al9jQOhigj0S6n1R51P/faYSFjyoS8WX26eb8U8bukEchzgKCSepUE1hGeg1I
         NU03S9ocazGXI2ePMNunHgUYudubNBjxZvHeKc+0RzioScWK4I53G2buaLt2MbDdrPT+
         Wx5NeZVlt3x2+UcFtyMg9jpZeOCoX1q6xhVDR2z2xiBmDv25JdcwUMNIJsdYNP324Zjw
         LMZQ==
X-Received: by 10.42.129.9 with SMTP id o9mr62324909ics.38.1395859127578;
        Wed, 26 Mar 2014 11:38:47 -0700 (PDT)
X-Gm-Message-State: ALoCoQlSh8sX7IYjRPnM8JcXAdCagLETJxxasIG1UFXLcxfTyB7qGduC7aPRcL5O7lVVjeetcNm48MEgp4nqmO0FUZlrkdCV+CXd9qQKAbeOJbZuvISBkHKOyGjzWJxKMTqID1i7QLxNpuIfxAK/lBZd/An/+NCo5w==
X-Received: by 10.42.129.9 with SMTP id o9mr62324907ics.38.1395859127515;
        Wed, 26 Mar 2014 11:38:47 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id dz8sm62588igb.5.2014.03.26.11.38.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 11:38:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245206>

On 03/24/2014 01:56 PM, Michael Haggerty wrote:
> Changes relative to v1:
> 
> * Rename the functions associated with ref_transactions to be more
>   reminiscent of database transactions:
> 
>   * create_ref_transaction() -> ref_transaction_begin()
>   * free_ref_transaction() -> ref_transaction_rollback()
>   * queue_update_ref() -> ref_transaction_update()
>   * queue_create_ref() -> ref_transaction_create()
>   * queue_delete_ref() -> ref_transaction_delete()
>   * commit_ref_transaction() -> ref_transaction_commit()

Those new names look better.

> * Fix backwards compatibility of "git update-ref --stdin -z"'s
>   handling of the "create" command: allow <newvalue> to be the empty
>   string, treating it the same zeros.  But deprecate this usage.

The changes related to that look good.  The new documentation is
much clearer than my old wording.

Series v2 looks good to me except for my responses to individual
commits.

Thanks,
-Brad
