From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sat, 9 Feb 2013 15:49:19 -0800
Message-ID: <5116E07F.9020607@nvidia.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com> <1358757627-16682-7-git-send-email-drafnel@gmail.com> <20130122083825.GG6085@elie.Belkin> <CA+sFfMcyupLGPt8-3PWMzwgGR3zrm4ZfA-7KwBh5VkMXmhuTKQ@mail.gmail.com> <7v7gmy12op.fsf@alter.siamese.dyndns.org> <7v7gmhulya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"pclouds@gmail.com" <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4KBL-0008Hn-BD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760886Ab3BIXti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:49:38 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:4722 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760875Ab3BIXth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:49:37 -0500
Received: from hqnvupgp05.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B5116e0850000>; Sat, 09 Feb 2013 15:49:25 -0800
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp05.nvidia.com (PGP Universal service);
  Sat, 09 Feb 2013 15:49:35 -0800
X-PGP-Universal: processed;
	by hqnvupgp05.nvidia.com on Sat, 09 Feb 2013 15:49:35 -0800
Received: from [10.20.76.183] (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.297.1; Sat, 9 Feb 2013
 15:49:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v7gmhulya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215886>

On 2/9/2013 3:06 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> On Tue, Jan 22, 2013 at 12:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>> Brandon Casey wrote:
>>>>
>>>>> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
>>>>> This is in preparation to unify the append_signoff implementations in
>>>>> log-tree.c and sequencer.c.
>>>> [...]
>>>>> --- a/sequencer.c
>>>>> +++ b/sequencer.c
>>>>> @@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>>>>       return pick_commits(todo_list, opts);
>>>>>  }
>>>>>
>>>>> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>>>>> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
>>>>
>>>> Isn't the behavior of passing '1' here just a bug in "format-patch -s"?
>>>
>>> I think that is an open question.
>>
>> Yes. as I said in a previous review round, I think it was a mistake
>> that format-patch chose to pay attention to any S-o-b in the patch
>> trail, not only the last one, and we may want to correcct it once
>> this series solidifies as a separate "bugfix" change on top.
> 
> This is a tangent, but I _think_ (didn't check, though) "git am -s"
> implements this incorrrectly.  Just another LHF somebody may want to
> take a look.

(I haven't checked the 'git am -s' behavior, but ...)

One distinction between commit, cherry-pick, am, and format-patch is
that the first three are related to importing commits _into_ your own
repository while format-patch is related to exporting patches _from_
your repository.

Not sure if an "exporting" operation should be treated differently from
an "importing" operation and mean "add my sign-off only if I did not
previously do so when I did commit, cherry-pick, or am" or whether it
should mean the same thing i.e. "append my sign-off, unless it's already
last".

Just pointing something out that may or may not be useful.

Hmm, actually, this series could provide a data point.  When I submitted
the first series, I used 'format-patch -s' to append my sob.  When
Jonathan reviewed the series, he provided Acked-by and Reviewed-by which
I collected and added as I reworked the series.  When I added Jonathan's
Ack's/Rev-by's, I _appended_ them to the commits that I had already
submitted, so they appeared _after_ my own sob.  When I submitted the
later iterations of the series, I probably used 'format-patch -s' again
and I of course did not want an additional sob to be appended after
Jonathan's Acks.

-Brandon


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
