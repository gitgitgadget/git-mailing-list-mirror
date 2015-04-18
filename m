From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 0/2] git-p4: Improve client path detection
Date: Sat, 18 Apr 2015 23:40:44 +0100
Message-ID: <20150418234044.3adfcff0@pt-vhugo>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<55218C8F.209@diamand.org>
	<20150405235759.392c0f2b@pt-vhugo>
	<xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 00:57:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjbgE-0002mw-FB
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 00:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbbDRWk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 18:40:57 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32860 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbbDRWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 18:40:56 -0400
Received: by wiax7 with SMTP id x7so56928203wia.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LZ2zibxmxffFDCK0dhK1IpcbSsVYh5Byw3RPGawzLU4=;
        b=CJPemL5Fh57Fe6oI3L4gNNefZUh7zue4WdueA8IL5WPn71MxbWdmQNr0tJiJsrItBN
         STPUU1BHtujSuxLQfbjr7HVXHv/tuMWpkSw8NCADqL+vDw0gfz7tD2W9TKt8H+Kb9lj2
         wtd/W+4UVaxfsd+gABJFFVtykNl3/bvkKkjInVYH6tsV87qyhP9TAwwcaYGf0RbpNR4H
         T/dfhRTLEWEEDBoe9OZBotVx6bvzG2/IEx59ykjjQz0clEmaDHXmIoSlUj+vlGfhQuNz
         sNA/K4JVaqsky2lV9zQl90+Wrcb6aziWJhcc0CisUUaUFGaUZ1kqyXJ+GC97Tf7EvYxm
         vNDQ==
X-Received: by 10.180.90.230 with SMTP id bz6mr12679958wib.79.1429396854305;
        Sat, 18 Apr 2015 15:40:54 -0700 (PDT)
Received: from pt-vhugo (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id o6sm8636052wiz.24.2015.04.18.15.40.53
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 18 Apr 2015 15:40:53 -0700 (PDT)
In-Reply-To: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267427>

Hi Junio,

Junio C Hamano <gitster@pobox.com> wrote on Sun, 12 Apr 2015 20:40:58 -0700
> Vitor Antunes <vitor.hda@gmail.com> writes:
>> Luke Diamand <luke@diamand.org> wrote on Sun, 05 Apr 2015 20:27:11 +0100
>>> Vitor, one thing I wondered about with this part of the change:
>>>
>>> -            if entry["depotFile"] == depotPath:
>>> +            if entry["depotFile"].find(depotPath) >= 0:
>>>
>>> Does this mean that if 'p4 where' produces multiple lines of output that
>>> this will get confused, as it's just going to search for an instance of
>>> depotPath.
>>
>> The reason why I introduced that was because in the test case I implemented (and
>> which reflects a scenario I am confronted with in my workplace) the branches
>> have a base directory that is removed in the client view mapping.
>> As such, we will have a situation where depotPath is //depot/branch1/ while
>> runninng "p4 where" will result in //depot/branch1/base/. To overcome this I
>> used find() instead of a direct comparison. Now that I think about that, I could
>> probably have used the simpler `if depotPath in entry["depotFile"]`...
>
> Hmph, is this find() under discussion the string.find() that finds a
> substring?  You are doing >=0 comparison here, but with your example
> that entry["depotFile"] may have "base/" appended to what you
> expect, the result of running string.find() must yield "0", i.e. no
> extra prefix string, no?  I kind of find it hard to believe that it
> is OK to have any extra prefix is fine ...

As usual, you're correct about your assumption. I should in fact be
using "== 0" because what I really want is to guarantee that the path
_starts_ with //depot/branch1.

>>> The example in the Perforce man page for 'p4 where' would trigger this
>>> for example:
>>>
>>> http://www.perforce.com/perforce/r14.2/manuals/cmdref/p4_where.html
>>>
>>> -//a/b/file.txt //client/a/b/file.txt //home/user/root/a/b/file.txt
>>> //a/b/file.txt //client/b/file.txt /home/user/root/b/file.txt
>>
>> These are examples where a simple comparison as was implemented would work.
>
> ... so is this "find()" an attempt to catch prefix like "-"?  Even
> if it that were the reason why you do not limit the acceptable
> return value from find() to zero, it feels a bit too loose to allow
> anything if the only thing you want to allow is a single "-" prefix.

Again, it was just a bad coding from my part.

> Can you explain this a bit better?  I cannot quite tell what is
> going on from what was written in the log message.

I've temporarily modified the script to print out the output of "p4
where", for future reference:

[{'clientFile': '//client/branch1/...',           'code': 'stat',              'depotFile': '//depot/branch1/base/...',           'path': '/path/to/git/t/trash directory.t9801-git-p4-branch/cli/branch1/...'},
 {'clientFile': '//client/branch1/sub_file1',     'code': 'stat', 'unmap': '', 'depotFile': '//depot/branch1/base/sub_file1',     'path': '/path/to/git/t/trash directory.t9801-git-p4-branch/cli/branch1/sub_file1'},
 {'clientFile': '//client/branch1/dir/sub_file1', 'code': 'stat', 'unmap': '', 'depotFile': '//depot/branch1/base/dir/sub_file1', 'path': '/path/to/git/t/trash directory.t9801-git-p4-branch/cli/branch1/dir/sub_file1'},
 {'clientFile': '//client/branch1/sub_file1',     'code': 'stat',              'depotFile': '//depot/branch1/base/dir/sub_file1', 'path': '/path/to/git/t/trash directory.t9801-git-p4-branch/cli/branch1/sub_file1'}]

Note that this is from a modified test case. As you can see, there are
no paths starting with "-", instead there a new attribute called "unmap"
that implements that description.

In the latest version of this update I'm searching for a path starting
with "//depot/branch1" and ending in "/...". This is a much more robust
solution, so I am really grateful for your review.

>>> As an experiment, I hacked git-p4 to always use p4Where rather than
>>> getClientRoot(), which I would have thought ought to work, but while
>>> most of the tests passed, Pete's client-spec torture tests failed.
>>
>> That was exactly my first approach and got to the same conclusion. I would have
>> investigated it further but since I haven't had much free time to invest in
>> solving this problem I decided to implement an intermediary solution that would
>> not introduce any regressions.

Since I'm looking at this more carefully now, I'll also try to see if I
am able to make p4 where work even when not using branch detection.

> Thanks.

No, thank _you_!
