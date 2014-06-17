From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC] alias.c: Replace git_config with git_config_get_string
Date: Tue, 17 Jun 2014 11:51:35 -0700
Message-ID: <53A08E37.1040104@gmail.com>
References: <1402910154-417-1-git-send-email-tanayabh@gmail.com> <20140617054357.GC29957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwyTx-0000UR-WB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 20:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbaFQSvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 14:51:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45098 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbaFQSvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 14:51:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so5948839pac.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XBQiHmEsTxvMWASW3B5o/YKZujIHUgRWr2k1Jc3bqro=;
        b=gofqAVg7TJqBw+deSZ0TncfDquUTyVLIh5PVe1fD92eYgKUTQGegbkGJbXTrClTnwr
         HVEpWsQpdoogbNxo8a7+utDbJKGJQTiWeBzy4ViZ7oIBO8LZ2UlpS3gad0rjvaAErvkw
         EzTsv345CZSJVbE3z0mXWjv8fNn3yADyCldKltHBofgI/FlqW+HSMzbcwcJ/+JB2h59H
         Fb4oc9wb+xnioQtdh0sA9FyCj5XBe1gM9fK+60L6tL4iz+S3Xlc1svTYakJ2WHMJi+rI
         ZNRpBKjF4qs59NfhWFjqec23j/SXxKS5O8zxbgIpS/RI1D69eqzm39UbiZVkhQmdwoMe
         2vXw==
X-Received: by 10.66.66.133 with SMTP id f5mr32243876pat.81.1403031101255;
        Tue, 17 Jun 2014 11:51:41 -0700 (PDT)
Received: from [192.168.52.164] ([117.254.223.152])
        by mx.google.com with ESMTPSA id gd7sm88856415pac.34.2014.06.17.11.51.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 11:51:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20140617054357.GC29957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251934>

On 06/16/2014 10:43 PM, Jeff King wrote:

> 
>> +	v = git_config_get_string(alias_key);
>> +	if (!v)
>> +		config_error_nonbool(alias_key);
> 
> What does a NULL output from git_config_get_string mean? I think with
> the current code, it means "no such key was found".  In which case, you
> should be returning NULL here (there is no such alias), not complaining
> with config_error_nonbool.
> 

Yes, you surmised correctly. I totally skipped the fact that git_config() can
return null for values indicating a boolean value. I will correct it in the next
patch.

> Again, this is going to depend on your strategy for storing booleans
> that I mentioned elsewhere.

I have read your other two replies related to it. I suggest the following approach
for git_config_get_string(), it will return,

1. Return null if no value was found for the entered key.

2. Empty string (""), returned for NULL values denoting boolean true in some cases.
   I think it would be much better than converting NULL to "true" or something else
   internally in the function.
   We can easily handle such cases as the above with a strcmp like,

+	v = git_config_get_string(alias_key);
+	if (!strcmp(v, ""))
+		config_error_nonbool(alias_key);

What do you think about this approach?

Thanks for the suggestion, I was pulling my hair out due this bug for last two days.

Cheers,
Tanay Abhra.
