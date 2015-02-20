From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Something wrong with diff --color-words=regexp?
Date: Fri, 20 Feb 2015 08:49:09 +0100
Message-ID: <54E6E6F5.2020202@kdbg.org>
References: <20150219235213.GA1291@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 08:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOiQx-0007pg-LI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 08:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbBTHzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 02:55:31 -0500
Received: from [93.83.142.38] ([93.83.142.38]:60889 "EHLO dx.site"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751332AbbBTHzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 02:55:31 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2015 02:55:30 EST
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 905C25194;
	Fri, 20 Feb 2015 08:49:09 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150219235213.GA1291@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264137>

Am 20.02.2015 um 00:52 schrieb Mike Hommey:
> Hi,
>
> I was trying to use --color-words with a regex to check a diff, and it appears
> it displays things out of order. Am I misunderstanding what my regexp should be
> doing or is there a bug?
>
> $ git diff -U3 HEAD^ dom/base/nsDOMFileReader.cpp
> diff --git a/dom/base/nsDOMFileReader.cpp b/dom/base/nsDOMFileReader.cpp
> index 6267e0e..fa22590 100644
> --- a/dom/base/nsDOMFileReader.cpp
> +++ b/dom/base/nsDOMFileReader.cpp
> @@ -363,7 +363,7 @@ nsDOMFileReader::DoReadData(nsIAsyncInputStream* aStream, uint64_t aCount)
>         return NS_ERROR_OUT_OF_MEMORY;
>       }
>       if (mDataFormat != FILE_AS_ARRAYBUFFER) {
> -      mFileData = (char *) moz_realloc(mFileData, mDataLen + aCount);
> +      mFileData = (char *) realloc(mFileData, mDataLen + aCount);
>         NS_ENSURE_TRUE(mFileData, NS_ERROR_OUT_OF_MEMORY);
>       }
>
> $ git diff -U3 --color-words='[^ ()]' HEAD^ dom/base/nsDOMFileReader.cpp
> diff --git a/dom/base/nsDOMFileReader.cpp b/dom/base/nsDOMFileReader.cpp
> index 6267e0e..fa22590 100644
> --- a/dom/base/nsDOMFileReader.cpp
> +++ b/dom/base/nsDOMFileReader.cpp
> @@ -363,7 +363,7 @@ nsDOMFileReader::DoReadData(nsIAsyncInputStream* aStream, uint64_t aCount)
>        return NS_ERROR_OUT_OF_MEMORY;
>      }
>      if (mDataFormat != FILE_AS_ARRAYBUFFER) {
>        mFileData = (char *moz_) realloc(mFileData, mDataLen + aCount);
>        NS_ENSURE_TRUE(mFileData, NS_ERROR_OUT_OF_MEMORY);
>      }

Your regexp says that every character (with a few exceptions) by itself 
is a word. Your diff says that it deleted the words 'm', 'o', 'z', and 
'_'. So, that is not wrong.

Furthermore, your regexp says that space, '(' and ')' are whitespace. 
Whitespace is *ignored* for computation of the word difference. 
Nevertheless, --color-word mode helpfully keeps the whitespace of the 
post-image to produce readable output. In doing so, it has to choose 
whether to keep the whitespace before or after a word. It chooses to 
keep it before a word. Hence, you see the whitespace sequence ') ' 
attached in front of 'r' (of 'realloc') instead of after '*'. So, the 
procedure is a matter of choice, which sometimes does not match 
expectations.

Perhaps you meant to say

     --color-words='[^ ()]+'

to split the diff text into longer words.

-- Hannes
