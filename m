From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Silent failure to add Windows-style paths in Cygwin Git
Date: Wed, 20 Apr 2016 10:17:47 +0100
Message-ID: <20160420091747.GH2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 11:17:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asoGj-0004Rg-4x
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 11:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbcDTJRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 05:17:52 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37366 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbcDTJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 05:17:50 -0400
Received: by mail-wm0-f51.google.com with SMTP id n3so70841786wmn.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YoVwmmIHbtQ/8UaeqV/HBY7mbV15QAbCUeOmDWKupRM=;
        b=QP/mQj4j8KHKR4dNW92SkiQnbDvv0ElAV8pcwuup891HSVcUzqH9mZlVKRm+X1NmF0
         785oQyMVfZ3VneCf5fDDiyMSXqYmFW3eY13r4rCsSBP3GogN7WW5OuKdpWGPodrc2D8v
         g8y1mQHTjSgc3BFAmpXyJHi5xCnIotkmPQTEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YoVwmmIHbtQ/8UaeqV/HBY7mbV15QAbCUeOmDWKupRM=;
        b=gzvvSYcpXta19P19I6xzmjQZDKcmCBqbx6IUvbZXNJY4yCaP/jxDOLDVp4R1WnAyJN
         bdFjHmC0rnUFLQTl3+gdkG7efx0FBVWi7V9gK7SWbkWfmpl+aEsWBy/mMywrd9+SqmzE
         mmQvNOdiCLHQmeusAcJz29pHss7UTOZQW0jTH3KzECLJb7L8D45VWviHZSGiuo5G00G5
         Iwf6aSHTepXb37NOaTnpiiFTI/m46K21p1w5kOcplAot6/CH02bqrvqH2tt9YjAxa1ww
         QfEXlgzc9SZp+hFXKsfCw0IWt4QpuTkoL2SguGFOLWiSk8lihujv9PzFsmqKKVeODcql
         4/Hg==
X-Gm-Message-State: AOPr4FXiibrsjw9eRFVvJA/ibDr0EV0lD9nhcJAiKacieXUrNP8sA074xd4AFsirtMd7MA==
X-Received: by 10.194.133.161 with SMTP id pd1mr8682846wjb.66.1461143869483;
        Wed, 20 Apr 2016 02:17:49 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id q127sm8582389wmd.13.2016.04.20.02.17.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 20 Apr 2016 02:17:48 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291997>

If I attempt to `git add` an extant file specified using a Windows-style
path on Cygwin Git, this doesn't add the file, and produces no error
message:

    $ pwd  # As seen by Cygwin
    /cygdrive/c/tmp

    $ cygpath -aw .  # As seen by Windows
    C:\tmp

    $ git init
    Initialized empty Git repository in /cygdrive/c/tmp/.git/

    $ git add 'c:\tmp\file' || echo non-zero exit code  # Errors out as expected
    fatal: pathspec 'c:\tmp\file' did not match any files
    non-zero exit code

    $ touch file

    $ git add 'c:\tmp\file' || echo non-zero exit code  # No error this time...

    $ git status  # ...even though the file didn't get added
    On branch master

    Initial commit

    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            file

    nothing added to commit but untracked files present (use "git add" to track)

I wouldn't expect adding the file to actually succeed, but I would
expect it to either succeed or produce an error, rather than silently
failing.

Experimentation shows I get the same behaviour for 'c:\tmp\file',
'c:/tmp/file' and 'subdir\file'.  I'm seeing this on v2.8.0; the
downstream report says the same behaviour occurs on v2.7.4[0], and I've
also seen what appears to be the same behaviour on a v2.0.5 build I
produced to check.

Adam

[0]: https://cygwin.com/ml/cygwin/2016-04/msg00474.html
