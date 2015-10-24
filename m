From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Sat, 24 Oct 2015 18:28:07 +0200
Message-ID: <C5352225-D67D-4ECD-83DB-D5E5A8ED13A7@gmail.com>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com> <xmqqmvvd8n7t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 18:28:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zq1gP-00049a-Po
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 18:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbbJXQ2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2015 12:28:12 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33060 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbJXQ2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Oct 2015 12:28:11 -0400
Received: by wijp11 with SMTP id p11so113816972wij.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2015 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LbiM6fUul2OWxKJx16UsBq6gnzmtwuhYcKrBOA88dWU=;
        b=vfKMCJfgXAPsBiahiAbmHZYWyHdosPevpdQtPgXXuP3w2Cvxd5RGwV/r0eE+ZZ2JTS
         KUULMPkpHym3Z/5tUStHTpXGUzsnRoyApFxDuODN6ccg39odTsM6WpTpY4IOTwfEvRPs
         a/haWtXe9kGvo/FEzGKi64TvdPxLJmyCVvrLYLwu33X2ajeKe9Ke77HGTz99VZ3D2eMQ
         DRO/gOm/sNnxbP+GiQbhcTAwKBA2jJb7MSwd1HT1kuUtuVF/fveZ5Ea1QBBZ8IqN0Gas
         Srw7EVrtB50PLTovuW6E58j7vr9l8KGkIKqFb2rWNDMACTRTUNiU8BEchFu2mB2DnhwK
         v9/A==
X-Received: by 10.180.208.82 with SMTP id mc18mr10306163wic.85.1445704089967;
        Sat, 24 Oct 2015 09:28:09 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB60EA.dip0.t-ipconnect.de. [93.219.96.234])
        by smtp.gmail.com with ESMTPSA id iw8sm28867228wjb.5.2015.10.24.09.28.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Oct 2015 09:28:09 -0700 (PDT)
In-Reply-To: <xmqqmvvd8n7t.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280127>


On 20 Oct 2015, at 19:27, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> diff --git a/git-p4.py b/git-p4.py
>> index 0093fa3..6c50c74 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2288,12 +2288,6 @@ class P4Sync(Command, P4UserMap):
>>         filesToDelete = []
>> 
>>         for f in files:
>> -            # if using a client spec, only add the files that have
>> -            # a path in the client
>> -            if self.clientSpecDirs:
>> -                if self.clientSpecDirs.map_in_client(f['path']) == "":
>> -                    continue
>> -
>>             filesForCommit.append(f)
>>             if f['action'] in self.delete_actions:
>>                 filesToDelete.append(f)
> 
> Earlier, the paths outside the clientspec were not in filesToDelete
> (or filesToRead that is below the context here).  Now they all go to
> these arrays, and will hit this loop beyond the context:
> 
>        # deleted files...
>        for f in filesToDelete:
>            self.streamOneP4Deletion(f)
> 
> after leaving the above for loop.  I cannot quite see where this
> "stream one deletion" is turned into a no-op for paths outside after
> this patch gets applied.

Earlier the client spec filtering happened in "def streamP4Files(self, files)". I moved the code up to the caller of this function into "def commit(...)" which now calls "streamP4Files" with an already filtered file list. Therefore the logic should be exactly the same.


> Also I have this suspicion that those who do want to use client spec
> to get a narrowed view into the history would almost always want
> this "ignore empty" behaviour (I'd even say the current behaviour to
> leave empty commits by default is a bug).  What are the advantages
> of keeping empty commits?  If there aren't many, perhaps git-p4
> should by the default skip empties and require p4.keepEmpty
> configuration to keep them?

I agree. 
@Luke: What option do you prefer? "git-p4.keepEmptyCommits" or "git-p4.ignoreEmptyCommits" ?

Thanks,
Lars