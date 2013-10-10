From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Feature Request: gitignore recursion
Date: Thu, 10 Oct 2013 09:59:38 +0200
Message-ID: <52565E6A.2020907@gmail.com>
References: <20131007134141.GA23026@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, alljeep@gmail.com,
	Jeff King <peff@peff.net>
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 10 09:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUB9y-0008Uw-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 09:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab3JJH7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 03:59:40 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:50176 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab3JJH7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 03:59:38 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so947217eek.9
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=D1BUKVQnKHauZTN9j1hqMKbuKYECsNj8KHcERBTyOUk=;
        b=svMmhhYQ5SmaTT7fUyWg0FjCjBlr5kWnHJ+1lfnn3o5oBr3jFSiX4MGChFIZuIz+7J
         N5fNhi2FW+It7RjNgROztW/XHLEkPBBLb09bpREGnMi5sWPwqsPJ1DsqjSpi1VUZ5oQE
         aznN97G5boINFJ7hBow8a2bRd526fTm0zz9nlBekzO5yyoF24rtBlg65HIVaSeC9HMAL
         rG2+TG2v1+YcfZAN30F9v0S+o+i8ECiFIKVSfrzvCrFzi1TPsH3E3edpfEIjFRDTqZAz
         Z0saUE9A5CgYGQB2PUNf8Rr/U9g3VqgjPdCgVTW+as6u3GMQfCn3qUOgRIFndXfNLDPf
         kv1Q==
X-Received: by 10.14.0.193 with SMTP id 41mr336798eeb.88.1381391977665;
        Thu, 10 Oct 2013 00:59:37 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b45sm98304974eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 00:59:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <20131007134141.GA23026@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235856>

> On Mon, Oct 07, 2013 at 07:24:11AM -0400, Jeff King wrote:
>> However, one thing I expected to work but didn't is:
>> 
>>   echo '*' >.gitignore
>>   echo '!*' >my_dir/.gitignore
>> 
>> That _does_ work for attributes, like:
>> 
>>   echo '* foo=one' >.gitattributes
>>   echo '* foo=two' >my_dir/.gitattributes
>> 
>> where the more-specific file takes precedence. It works because we keep
>> an attribute stack, and look from most-specific directory to least.

Note that this doesn't work either:

  echo '*' >.gitignore
  echo '!my_dir/*' >>.gitignore

The problem isn't that git doesn't read 'my_dir/.gitignore'. Git simply doesn't recurse into excluded directories, so patterns on excluded content have no effect.

IMO this behavior is reasonable, as there is no way to check whether a negative pattern will match within an excluded untracked directory without scanning the directory.

What about this instead?

--- 8< ---
Subject: [PATCH] gitignore.txt: clarify recursive nature of excluded directories

Additionally, precedence of negated patterns is exactly as outlined in
the description, we don't need to repeat this.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/gitignore.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index f971960..a64a65d 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -79,8 +79,9 @@ PATTERN FORMAT
 
  - An optional prefix "`!`" which negates the pattern; any
    matching file excluded by a previous pattern will become
-   included again.  If a negated pattern matches, this will
-   override lower precedence patterns sources.
+   included again. It is not possible to re-include a file if a parent
+   directory of that file is excluded (i.e. excluding a directory
+   will recursively and irrevocably exclude the entire content).
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
-- 
1.8.4.msysgit.1
