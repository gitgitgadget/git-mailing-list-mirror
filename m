From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC v1] git-p4: test case for RCS keyword problem
Date: Tue, 10 May 2011 09:13:57 +0100
Message-ID: <4DC8F3C5.7000904@diamand.org>
References: <1304927397-24614-1-git-send-email-luke@diamand.org> <20110509230034.GC1716@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Horowitz <michael.horowitz@ieee.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue May 10 10:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJi5D-0007tK-6g
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 10:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab1EJIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 04:14:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64800 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1EJIOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 04:14:03 -0400
Received: by fxm17 with SMTP id 17so4131128fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 01:14:01 -0700 (PDT)
Received: by 10.223.57.86 with SMTP id b22mr2464320fah.95.1305015241823;
        Tue, 10 May 2011 01:14:01 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id b17sm2100193fab.23.2011.05.10.01.13.58
        (version=SSLv3 cipher=OTHER);
        Tue, 10 May 2011 01:14:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Icedove/3.1.9
In-Reply-To: <20110509230034.GC1716@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173320>

On 10/05/11 00:00, Pete Wyckoff wrote:
> luke@diamand.org wrote on Mon, 09 May 2011 08:49 +0100:

<snip>

>>
>> You would think you could just tell p4 to not expand RCS keywords
>> in your client view, but sadly that option doesn't exist :-(
>
> One idea.  I snuck in a2b665d "convert filter: supply path to
> external driver" that lets you do:
>
>      git config filter.p4.clean git-p4-filter --clean %f
>      git config filter.p4.smudge git-p4-filter --smudge %f
>      echo "*.c filter=p4">>  .gitattributes
>
> Then your git tree can have expanded keywords too.  The script to
> clean is pretty easy; to smudge you have to ask p4 for the
> information using fstat and filelog.  My script is pretty nasty
> and full of dependencies, but I could clean it up if you think
> this is a good way to go.

Would this cause problems switching from one branch to another? If 
there's a file with $Date:$ or $Revision:$ then every time you do "git 
checkout other_branch" or even just "git stash" git would have to patch 
up all files tagged with ktext (tens of thousands in my case). If you 
didn't you'd be right back at square one.

At that point it would be easier just to submit a one-time change to 
Perforce that simply zapped every RCS keyword in every file (probably 
resulting in all kinds of pain for perforce users though).

My feeling is that there's no way to elegantly handle RCS keywords. 
They're a really nasty horrible hangover from the dark ages, and if 
you've got them in your code base you're going to have to accept that 
anything that tries to deal with them is going to be ugly.


> We'd need to discover text+k files at clone and sync time
> and maintain the .gitattributes accordingly.  Filtering all
> files would be wrong, and slow.
>
> Dhruva's approach has the downside of always including RCS lines
> in every commit when the file changes in p4.
>
>> This isn't a fix, it's just a test case that shows the problem,
>> and doesn't even try to test the whole-file deletion case.
>>
>> I'm hoping someone will suggest a good way to handle this.
>>
>> Otherwise, I've got a possible scheme that involves spotting the
>> failure to apply the patch, patching up RCS keywords in the
>> p4 client shadow and then trying again. It's not pretty but it seems
>> like it ought to work. My current version doesn't handle deletion,
>> and zaps *all* RCS keywords rather than just the ones zapped in git;
>> more work is needed before I can submit it.
>
> I'm a little hazy on how you would identify a patch failure as
> due to an RCS keyword, but maybe it's possible.  The deleted line
> case is surely hard.

My existing patch is pretty crude - if "git apply --check" fails then it 
parses the output, finds the files causing the problem, checks if 
they're +ktext, and then zaps every RCS keyword in the file in the P4 
shadow repo, replacing them with just $Keyword:$.

Amazingly this seems to work, since git then sees the text it is 
expecting and is happy, while untouched RCS keywords go back to $KW:$ 
which P4 is quite happy to re-expand!

I haven't tried to handle the case where the entire file is deleted. 
This is a bit harder - the file won't be opened for edit so I imagine 
you have to do some kind of 'chmod +w' :-(

>
> Curious what you think of switching to having expanded keywords
> in the repo, but using smudge/clean instead.

One of the many things I like about git is that by default it never 
messes with the contents of my files. I've spent too much of my life 
trawling through diffs full of changes that are down to RCS keywords!

>
> Maybe hang onto this test case until we figure out how we want
> to deal with it.

Another option I wondered about is to modify git apply so that it spots 
RCS keywords and ignores them? This would then mimic what p4 itself does.

And another option is to just admit that RCS keywords are stupid and 
can't be sorted out properly, put some explanation into git-p4.txt to 
explain the problem to avoid having these threads pop up, and then 
everyone just has to zap them in Perforce.

Regards!
Luke
