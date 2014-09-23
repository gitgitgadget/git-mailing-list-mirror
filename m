From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 22:49:39 +0200
Message-ID: <5421DCE3.9090500@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>	<5421CAA6.3040107@redhat.com>	<xmqqsijihzrb.fsf@gitster.dls.corp.google.com>	<5421D8C4.2080009@redhat.com> <xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWX1w-0002D6-SD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809AbaIWUtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:49:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39324 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756273AbaIWUto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:49:44 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKnhHI030041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 16:49:43 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKnep5021799;
	Tue, 23 Sep 2014 16:49:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257443>

On 09/23/14 22:35, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> On 09/23/14 22:02, Junio C Hamano wrote:
>>> Laszlo Ersek <lersek@redhat.com> writes:
>>>
>>>> On 09/23/14 20:54, Junio C Hamano wrote:
>>>> ...
>>>>> SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
>>>>> turn out that what you are trying to do might be an equilvalent of
>>>>>
>>>>> 	git format-patch ... |
>>>>>         # first lose all \r\n
>>>>>         dos2unix | 
>>>>> 	# then make everything \r\n
>>>>>         unix2dos |
>>>>>         # and apply
>>>>>         git am
>>>>>
>>>>> which is not workable in the first place.  I dunno.
>>>>
>>>> I agree with your analysis. It is indeed the MTA...
>>>>>    - CR and LF MUST only occur together as CRLF; they MUST NOT appear
>>>>>      independently in the body.
>>>>
>>>> But why is this situation "not workable"? The same happens with *all*
>>>> patches that people mail around, it's just not visible to them, because
>>>> git-am strips all CRs indiscriminately.
>>>
>>> It is not "git am" or "git apply" that "strips all CRs
>>> indiscriminately".  I just tried to apply 0001-add-f2 without
>>> letting your MTA/MUA corrupt it on "master" branch in the repository
>>> you prepared that patch from, i.e.
>>>
>>> 	git checkout master^0 ;# go back
>>>         git am 0001-add-f2* ;# apply that "+hello world\r\n" patch
>>>         git diff branch ;# nothing
>>
>> When you did this, was am.keepcr=true in effect?
> 
> I actually briefly scratched my head but realized when I saw it work
> "as expected" without me passing "--keep-cr" to "am" myself.
> 
> But I did that experiment in the repository created by following
> your reproduction recipe, in which it had these:
> 
>   git config core.whitespace cr-at-eol
>   git config am.keepcr true
> 
> so yes I had keepcr set.

Thank you for confirming, I expected so.

Because in this case the test doesn't refute my claim that "git-am
strips all CRs indiscriminately".

Git-am *does* strip all CRs indiscriminately, undoing the CRs that the
email servers / clients introduce. Your above test worked out because
you prevented git-am from stripping the CRs, with the keepcr=true
setting. If you turn that off, then either your git am command won't
succeed (because it will run into context conflicts due to different
line endings -- although not in this example), or the final git-diff
will report differences.

In summary:
- the email infrastructure turns all line terminators into CRLFs
- git-am strips these by default, from source code lines and from git
  diff header lines alike,
- this is fine for repos that store files with \n terminators,
- not fine for repos with embedded \r\n terminators -- the default
  stripping behavior of git-am breaks the source code in that case
  (runs into conflicts with existing files, and creates new files with
  wrong line endings)
- if you set am.keepcr=true, then the source code remains intact (no
  conflicts for existing files), but new files cannot be created,
  because the /dev/null\r header lines are rejected.

Thanks
Laszlo
