From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: implement changes for "cat-file --literally
 -t"
Date: Sun, 08 Mar 2015 16:19:16 +0530
Message-ID: <54FC292C.5060405@gmail.com>
References: <54F89D90.6090505@gmail.com> <1425579560-18898-1-git-send-email-karthik.188@gmail.com> <xmqq61af100p.fsf@gitster.dls.corp.google.com> <54F9E6B6.4070105@gmail.com> <xmqq1tl2ylfo.fsf@gitster.dls.corp.google.com> <54FACD30.6080005@gmail.com> <xmqqpp8jsyel.fsf@gitster.dls.corp.google.com> <54FC0CCE.70009@gmail.com> <xmqqegozsvx5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 11:49:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYlx-0007mN-PI
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbbCHKtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 06:49:21 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44869 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbbCHKtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:49:20 -0400
Received: by pdjz10 with SMTP id z10so36626166pdj.11
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MAGUxnnyb1b+3pGagi5UjsBLMHVw8FClRSJ0uObXnAQ=;
        b=Z+tupVJ5/umW/9VK16KcDD5aimnL6jqOxwm+FyRZ1GRD3rc4HgLqW6YS8YgY0/womu
         X7y6NWUdUWVHmh9ogxWw9b3rOrNYBSwgQK3auav6RiVk1m6OsmdhavGvQ5lFNLRgsVW4
         aPNYL2nRJwdm/IGGPOUR7Wfl/28hdPqNKZBJSfqn9Euk9qeu3wWdS8Bm0jNDvvgxQ53I
         gxirT1l3uOmCdR5eQU+i5ylj3BJj9vhiguUkoIxlT2Bv4bG1dmLxWD7KxwPWsTy2yE11
         Qbyl91gVAnyRQfR2djXDDEuE/yes7zjbjgAFEvBHBoZ4TzAMJ1TdlNlkYgKaKfrU+jPb
         QYXQ==
X-Received: by 10.66.141.231 with SMTP id rr7mr36660443pab.72.1425811759582;
        Sun, 08 Mar 2015 03:49:19 -0700 (PDT)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id pa6sm14552037pac.45.2015.03.08.03.49.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:49:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqegozsvx5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265083>


On 03/08/2015 02:33 PM, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
> > What parse_sha1_header() does to get the type is just find the first
> > occurrence of a " " manually and store everything before it as the
> > type. Then it finds the size of the object if needed. And finally
> > returns the type by calling type_from_string(). This is where we get
> > the undefined type error.
>
> Yes, exactly.  The change illustrated in $gmane/264420 may be
> incomplete and some calls from the sha1_object_info_extended() after
> that change may still need to further be tweaked to pay attention to
> LOOKUP_LITERALLY bit; for example, parse_sha1_header() may want to
> learn not to barf when seeing an unexpected typename in the header
> when the caller asks to look up "literally".
>
> I thought I already said that; sorry if I forgot.
>
>
Sorry for the confusion, you did already say that in $gmane/264955 , I'm
talking about how I tackled the issue in $gmane/264855.

Like :

     else if ((flags & LOOKUP_LITERALLY)) {
         size_t typelen = strcspn(hdrbuf.buf, " ");
         strbuf_add(oi->typename, hdrbuf.buf, typelen);
     }
     else if ((status = parse_sha1_header(hdrp, &size)) < 0)
         status = error("unable to parse %s header", sha1_to_hex(sha1));
     else if (oi->sizep)
         *oi->sizep = size;

This way, we don't have to modify parse_sha1_header() to worry if "literally"
is set or not.
