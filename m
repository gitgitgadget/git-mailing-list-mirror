From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Sat, 7 Sep 2013 20:19:20 +0100
Organization: OPDS
Message-ID: <531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley>
References: <20130906155204.GE12966@inner.h.apk.li><6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley><xmqqfvthyfui.fsf@gitster.dls.corp.google.com><94A71512041A4F9BB402474DB385E310@PhilipOakley> <xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 21:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIO2c-0004Zr-Rp
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 21:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab3IGTTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 15:19:19 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:26356 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756Ab3IGTTT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 15:19:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkEMAIR7K1JOl3GZ/2dsb2JhbABagweJcbkXBAQBgSQXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHCQENBgoJCAIBAgMBhTgHAYISI8NakACDJIEAA4h9hhKFDJVAgyE7
X-IPAS-Result: AkEMAIR7K1JOl3GZ/2dsb2JhbABagweJcbkXBAQBgSQXdGkBAYEfAQEUAQQBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHCQENBgoJCAIBAgMBhTgHAYISI8NakACDJIEAA4h9hhKFDJVAgyE7
X-IronPort-AV: E=Sophos;i="4.90,860,1371078000"; 
   d="scan'208";a="436366042"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 07 Sep 2013 20:19:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234140>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Saturday, September 07, 2013 4:50 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> Does this have any impact on the alleged bug in `git bundle --all`
>>>> (which can then be cloned from) where the current HEAD ref wasn't
>>>> included in the bundle? Or am I mis-remembering?
>>>
>>> Not "current HEAD ref", but "git clone" will fail to check out from
>>> a bundle that does not include HEAD ref (it is easy to just say
>>> "reset --hard master" or whatever after it, though).
>>>
>>> I think I suggested to update "git bundle" to include HEAD when
>>> there is no HEAD specified some time ago, but I do not think anybody
>>> was interested, so this may be a non-issue.
>>>
>> Just had a quick look at a very quick test repo (10 objects, 2
>> branches) and the bundle file does contain the HEAD ref, but again it
>> has the two ref/heads/* are better than one problem, in that the 
>> clone
>> from the bundle checks out master, whilst the source repo has feature
>> checked out.
>
> I do not think the bundle header records symref any differently from
> other refs, so a HEAD that points at a commit that is at the tip of
> more than one ref needs to be guessed at the extraction end, just
> like the network-transfer case discussed in this thread.
>
> But this thread is not about updating the current bundle format to a
> new one, so any of the updates proposed in these patches will not
> affect it.
> --
I was having a quick look at the different bundle/clone routes and tried 
out (on 1.8.1.msysgit.1) the following script to see the differences 
(probably word wrap damaged):

---
cd /c/  # if on Windows to be at the top of c:/
mkdir gitBundleTest1
cd gitBundleTest1
git init
echo AAA >a.txt
git add a.txt
git commit -mfirst
git checkout -b feature
git checkout -b zulu # does this, alphabetically after master, change 
anything?
git status # observe on 'feature' branch
# one repo, one file, one commit, two branches

# test the bundle - clone transfer
git bundle create Repo.bundle --all
git clone Repo.bundle ../gitBundleTest2
cd ../gitBundleTest2
git status  # observe on wrong branch

# back to original repo
cd ../gitBundleTest1
# test the direct clone transfer
git clone . ../gitBundleTest3
cd ../gitBundleTest3
git status  # observe on wrong branch again

# back to top level (wherever that is on Msys Windows ;-)
cd ..
pwd
# test the git protocol clone transfer
# it's file:// followed by abolute path /path/to/dir so ...
# but note msys windows /c/
git clone file:///c/gitBundleTest1 ./gitBundleTest4
cd ./gitBundleTest4
git status  # observe on wrong branch again

cd ~  # return home
---

What I observed was that all the clones had the same HEAD problem, which 
I think comes from clone.c: guess_remote_head().

When I looked in the Repo.bundle file I saw the refs/heads/* listed in 
alphabetic order followed by HEAD, all with the same sha1 (in this 
case), followed by PACK and then the binary data.

My quick look at clone.c suggested to me that there would be a lot of 
commonality between the bundle data stream and the transport streams 
(identical?), and it was just a case of adding into the bundle data the 
same HEAD symref indication that would solve the normal clone problem 
(including backward compatibility). Is that a reasonable assesssment?

Philip
