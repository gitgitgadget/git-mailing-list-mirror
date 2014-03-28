From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Git doesn't notice file has changed (Re: Found a "bug" in git 1.9.0
 but can't reproduce it without copyrighted source code.)
Date: Thu, 27 Mar 2014 18:59:21 -0700
Message-ID: <20140328015921.GP15625@google.com>
References: <CA+fYBFdzC-_B2Qfk8Hg0pLUNy4oayySs+8B3vWq7uuBeAx9eJQ@mail.gmail.com>
 <20140328014022.GO15625@google.com>
 <CA+fYBFcqZtCxRjAiZk24VJutc_QT5asQU8EFRKpd0ZYqoN4=1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: yun sheng <uewing@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 02:59:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTM4w-0000e4-AI
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 02:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264AbaC1B7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 21:59:25 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:45945 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068AbaC1B7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 21:59:24 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so4205022pdj.27
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 18:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6WxqQK3//PH2IvkwcgG0txwjP6SOzM8YfsO1PzcjapQ=;
        b=u6K09FlZiadeNAFTeNiMq8bQ5l/+G9EfXw0KXAHweyeM5rvwuCKgRHuy9FWZN4oxcU
         Qeu5jJ7pOs3Dg7g2DfbOHdf5iCYRZUuzAfNqYZ+rU/Am03tBS7Oiyjvpz5usuh5QaASh
         GpIaFfQLzOB3G0BdZ1NAU66bIpl020sH8SxkfdrFY1E9aTzQZ2t/xlbeh/D14eT5tB9/
         n30l9JyuRQmKgY88LjZcyH2kFZHZ4bHjJeDVANve1CQNfitwZRpykgT6O97tkFf7pGdM
         OYLcquIdVD25LDOvPLYMDI6RwRJctzELKOrjmWy3R8mhTkSv/JoWT1qGEEa/KwUOFGOR
         wy0A==
X-Received: by 10.68.88.193 with SMTP id bi1mr5376082pbb.129.1395971963991;
        Thu, 27 Mar 2014 18:59:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h6sm15581226pbl.75.2014.03.27.18.59.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 18:59:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+fYBFcqZtCxRjAiZk24VJutc_QT5asQU8EFRKpd0ZYqoN4=1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245350>

(cc-ing msysgit list, where there are more Windows-knowledgeable people)
yun sheng wrote:
> On Fri, Mar 28, 2014 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> yun sheng wrote:

>>> these two files have the same timestamp, the same size, bug slightly
>>> different contents.
>>
>> How did they get the same timestamp?
>>
>> [...]
>>> Git I'm using is msysgit 1.9.0 on windows 7
>>
>> Unixy operating systems have other fields like inode number and ctime
>> that make it possible to notice that a file might have been changed
>> without actually rereading it.  Unfortunately Git for Windows is
>> limited to what's in the WIN32_FILE_ATTRIBUTE_DATA which means the
>> size, mtime, and mode are basically all it has to go by.
>>
>> Do you know of some other Windows API call that could help?
>
> The files get the same timestamp by using `git difftool -d` to view
> diffs, the diff tool I use id beyond compare 3, this command would
> generate temp files to feed the compare program, so these files get
> the same time stamp, I copied them out from the temp folder.
>
> I have no idea of the second quesiton, I am really not familiar with
> windows API. Do you mean this file may have been changed without
> rereading and git can't detect it?

Sorry for the lack of clarity.  I meant that normally git detects when
a file might have been changed without actually reading the file.  To
do this, it uses heuristics like "If all file attributes are
unchanged, the file is unchanged" which tend to work well on Unix.  My
question was whether there's some similar trick that could work better
on Windows than the current code.

For example, if some interested person ports something like Facebook's
watchman[1] to Windows[2], then Git could take advantage of that work
using something like Duy's file-watcher series[3], which would be one
way to fix this problem.

Thanks,
Jonathan

[1] https://github.com/facebook/watchman
[2] using FindFirstChangeNotification and ReadDirectoryChangesW, perhaps
[3] http://thread.gmane.org/gmane.comp.version-control.git/240339/focus=241395>
