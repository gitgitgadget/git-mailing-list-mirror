From: evgeny <illumsoft.org@gmail.com>
Subject: Re: t0005-signals.sh fails with ksh
Date: Sat, 9 May 2015 02:43:00 +0300
Message-ID: <479525721.20150509024300@gmail.com>
References: <31108626.20150508231514@gmail.com> 
  <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
  <20150508205548.GB13457@peff.net> <20150508211453.GA11594@peff.net>
  <xmqqk2wiiwa3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 09 01:37:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqrpD-00082R-5e
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 01:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbbEHXgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 19:36:33 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33425 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbEHXgc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 19:36:32 -0400
Received: by layy10 with SMTP id y10so62411135lay.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:message-id:to:cc:subject:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=12rXBO0CA1eQXvtTOICDyx3l4jNmtHv1+f/npL+y3+4=;
        b=qLtNgiYNKfYYWtzxx32B0mg7YnO8gfoZf2ljzgleoHbJNqLkeqYDTEDwf4tHaIUChH
         T5mvuljsq3Mb3uSdb59HYy3TJKbiIm78Mn8QMFHOWamgGRGJZCH2yPPF9Nzw2/lWpppW
         8Va5utx3jjCiM+ccS+wfj71iDAPt6rZkQnjyl99F1u7EvAwSxk9/9zwYTfWet9oVPoTb
         WWqeJhfqdUCUTMD+Bq+sKkHqWDNhtigB+uJkof4VdmA5y8mQ7skk1r7EER9zDsHC7tBP
         3L2YWK/z1/KkQ0dcSZUmbdj2gRDwygpa3V1bUsAbTWnXcxVC5z6+234E1h3xOq9AIciZ
         /yMw==
X-Received: by 10.153.11.163 with SMTP id ej3mr260186lad.105.1431128190751;
        Fri, 08 May 2015 16:36:30 -0700 (PDT)
Received: from [10.0.2.15] (ppp78-37-187-150.pppoe.avangarddsl.ru. [78.37.187.150])
        by mx.google.com with ESMTPSA id jp18sm1462905lab.34.2015.05.08.16.36.29
        (version=TLSv1.1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 16:36:29 -0700 (PDT)
X-Priority: 3 (Normal)
In-Reply-To: <xmqqk2wiiwa3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268686>

Hi,
just for information about ksh on Linux and OpenIndiana

           ksh93 on Debian GNU/Linux 7 (wheezy)

$ ksh --version
  version         sh (AT&T Research) 93u+ 2012-02-29

$ git init foo && cd foo
Initialized empty Git repository in /var/tmp/foo/.git/
$ (cd .git/objects && ls)
info  pack
$ mkdir subdir && cd subdir
$ ls ../.git/objects
info  pack
$ cd ../.git/objects
/bin/ksh93: cd: /var/tmp/foo/git/objects: [No such file or directory]


           ksh93 on OpenIndiana oi_151.1.9 X86

$ ksh --version
  version         sh (AT&T Research) 93t+ 2010-03-05

$ pwd
/var/tmp
$ git init foo && cd foo
Initialized empty Git repository in /var/tmp/foo/.git/
$ (cd .git/objects && ls)
info  pack
$ mkdir subdir && cd subdir
$ ls ../.git/objects
info  pack
$ cd ../.git/objects
$ pwd
/var/tmp/foo/.git/objects

Looks like older version (or Solaris version?) of ksh did not have this bug.

Saturday, May 9, 2015, 12:39:32 AM, you wrote:

> Jeff King <peff@peff.net> writes:

>> Here's an oddity I isolated based on a failure in t5502:
>>
>>   $ git init foo && cd foo
>>   Initialized empty Git repository in /home/peff/foo/.git/
>>
>>   $ (cd .git/objects && ls)
>>   info pack
>>
>> OK, makes sense. Now...
>>
>>   $ mkdir subdir && cd subdir
>>   $ ls ../.git/objects
>>   info  pack
>>   $ cd ../.git/objects
>>   ksh: cd: /home/peff/foo/git/objects: [No such file or directory]
>>
>> Um, what? Apparently using "../.foo" will eat the "." off of "foo"?

> That is fun.  And doing

>     $ mkdir -p git/objects

> just before you create and chdir into subdir does tell me that the
> last "cd ../.git/objects" is turned into "cd ../git/objects".

> Actually, with that extra thing, changing the last one to

>     $ cd ../..git/objects

> still takes me to ../git/objects, it seems.  But lookie here:

>     $ cd ../.....git/objects
>     ksh: cd: /var/tmp/x/ksh/...git/objects: [No such file or directory]

> WAT.

> I am tempted to say that we should write it off as utterly broken.





-- 
Best regards,
 evgeny                            mailto:illumsoft.org@gmail.com
