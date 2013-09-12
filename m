From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 17:45:49 +0200
Message-ID: <5231E1AD.6090206@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>, Johannes Sixt <j6t@kdbg.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK95j-0001IS-QT
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab3ILPpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:45:52 -0400
Received: from mail-bk0-f47.google.com ([209.85.214.47]:49103 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3ILPpu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:45:50 -0400
Received: by mail-bk0-f47.google.com with SMTP id mx12so4238164bkb.6
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UOyc45KRvRlmSeJBcTnCrI9aaj8vMMipUPApiVB3FJU=;
        b=sglOYJDoFrrdW0w/7zqk1smLSBjmexXuyva5HVZpsFXk2T8ZVlZqfi1Yg4tk8jHnTU
         WGoGj71p5U+o0lrk+s+0Cet2GPv4Zbf8pHq4PUAodiXyOmJR57JyYYxSi0/BRGVi8wo8
         nCw4JnjEymQb2PHLhRvo/o7Gib/hikNFVXMebbgvJ0faucCMd0Dbww9gwklLj7xP1yiP
         hx8zloA/rteHBQruR7A5Le/LkaW6a55v8gkGMhsyqwvSfKUU/z0rUAT0kbtk5TWdfsf4
         ow57Ba8GMUVBi+FWwVTPnLrjy7wE5nnJMh2BOsd0xZB3Yjryx475nSMipk3GrAJ7XiJn
         cVbg==
X-Received: by 10.205.65.78 with SMTP id xl14mr7165588bkb.1.1379000749401;
        Thu, 12 Sep 2013 08:45:49 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id rj5sm1465986bkb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 08:45:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234658>

Am 12.09.2013 11:12, schrieb Jiang Xin:
> Tvangeste found that the "relative_path" function could not work
> properly on Windows if "in" and "prefix" have dos driver prefix.
> ($gmane/234434)
> 
> e.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
> should return "C:/a/b", but returns "../../C:/a/b", which is wrong.
> 
> So make relative_path honor dos_drive_prefix, and add test cases
> for it in t0060.
> 

I still don't think that cd'ing through the root is a Good Thing for absolute paths, as it is not possible to do so in general.

POSIX says the meaning of '//' is implementation-defined [1].

Cygwin supports //hostname/share/directory/file. You cannot cd to the hostname (i.e. root would be //hostname/share).

On Windows, we have drive letters, UNC paths and namespaces:
C:\directory\file
\\hostname\share\directory\file (same as cygwin)
\\?\C:\directory\file
\\?\UNC\hostname\share\directory\file

I'm not sure about '//' support on other git platforms (the most likely candidate would probably be HP-UX, as HP bought Apollo/DomainOS, which supported '//hostname/directory/file back in 1981).


You could of course handle all these special cases. However, with the POSIX definition above, the only reliable and future-proof way to check if we can cd out of a path component of an _absolute_ path is to actually try it until we get an error. And we probably don't want to do actual IO in relative_path (which is pure string manipulation so far).

[1] http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap04.html#tag_21_04_12
