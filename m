From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH V2] branch.c: replace git_config with git_config_get_string
Date: Sun, 29 Jun 2014 07:06:04 -0400
Message-ID: <CAPig+cRgszpFzvt6JiD=+4DGDyPxdwc=1GBm1bH_DHM1UObD8Q@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-2-git-send-email-tanayabh@gmail.com>
	<CAPig+cTMWKtAjN931voVs7aY7JdEyaRVZj+-qDUiDk0C_Tq6-A@mail.gmail.com>
	<53ABD52B.3030502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 13:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1Cvz-00033I-BN
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jun 2014 13:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaF2LGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2014 07:06:06 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:54165 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbaF2LGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2014 07:06:05 -0400
Received: by mail-yk0-f173.google.com with SMTP id 142so3954100ykq.32
        for <git@vger.kernel.org>; Sun, 29 Jun 2014 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=A2Rxj8hJ+KsSL/IHBzMJqA2qUroLcVPeWioujE+60IY=;
        b=FqRF4Oz2T24KTgczZL4ZYpoUFNGQYvEuRASFBnbY5VJJM8UWMBcA1WbDlW3wiEa/i6
         WAJT+DdxH8xltnN7XxyoDTbNuLGGubPvT8YWG5sOpr82P3VFl4mf68d35tD4J2F5rgR3
         a1OFwim2cVKdZyud4oN17EMFUjXJlua9XD0u3o6kjanp6H7tiKJpM2+1VxjKzGPdC8fb
         sIoey2rzzgTCtx66L81IT2nAzKyDVTUkvQmWF8+kLYMW/AvXFpkrnmSnrf8UsUrsx9uA
         U5Q3ipiwDHha4msRvK2L6ZKfmgThZynUbfAyRIk/D5+1F2NnE29O3Odd3pknyZJOBDsd
         x8Vg==
X-Received: by 10.236.91.229 with SMTP id h65mr2334906yhf.89.1404039964261;
 Sun, 29 Jun 2014 04:06:04 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Sun, 29 Jun 2014 04:06:04 -0700 (PDT)
In-Reply-To: <53ABD52B.3030502@gmail.com>
X-Google-Sender-Auth: 1vEkrRw3gbn5yeA2lg4j3gOmEBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252638>

On Thu, Jun 26, 2014 at 4:09 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>
> On 6/25/2014 10:15 AM, Eric Sunshine wrote:
>> On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>>> diff --git a/branch.c b/branch.c
>>> index 660097b..c9a2a0d 100644
>>> --- a/branch.c
>>> +++ b/branch.c
>>> @@ -140,33 +140,25 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>>>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>>>  {
>>> -       struct branch_desc_cb cb;
>>> +       const char *value = NULL;
>>> +       struct branch_desc desc;
>>>         struct strbuf name = STRBUF_INIT;
>>>         strbuf_addf(&name, "branch.%s.description", branch_name);
>>> -       cb.config_name = name.buf;
>>> -       cb.value = NULL;
>>> -       if (git_config(read_branch_desc_cb, &cb) < 0) {
>>> +       desc.config_name = name.buf;
>>> +       desc.value = NULL;
>>> +       git_config_get_string(desc.config_name, &value);
>>> +       if (git_config_string(&desc.value, desc.config_name, value) < 0) {
>>
>> Although it works in this case, it's somewhat ugly that you ignore the
>> return value of git_config_get_string(), and a person reading the code
>> has to spend extra time digging into git_config_string() to figure out
>> why this is safe. If might be clearer for future readers by rephrasing
>> like this:
>>
>>     if (git_config_get_string(desc.config_name, &value) < 0 ||
>>         git_config_string(&desc.value, desc.config_name, value) < 0) {
>>
>
> Noted, also didn't the old code leak desc.value as it was xstrduped
> by git_config_string()? Thanks for the review.

Looks that way.
