From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Thu, 19 Mar 2015 23:51:42 -0000
Organization: OPDS
Message-ID: <3FAFDE160E204496A38A4B6C53FB9B32@PhilipOakley>
References: <1425827005-9602-1-git-send-email-me@ikke.info><1425934575-19581-1-git-send-email-me@ikke.info><xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com><20150310225509.GA5442@vps892.directvps.nl><xmqqoao0xx9p.fsf@gitster.dls.corp.google.com><20150311184512.GB5442@vps892.directvps.nl><xmqqsidb5m2r.fsf@gitster.dls.corp.google.com><20150316163306.GB11832@vps892.directvps.nl><xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com><065AE7977A54488198B39564E3E174E6@PhilipOakley><xmqqr3sops9f.fsf@gitster.dls.corp.google.com><CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com> <xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Kevin Daudt" <me@ikke.info>, "git" <git@vger.kernel.org>,
	"Christian Couder" <chriscool@tuxfamily.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Christian Couder" <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:51:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYkDP-0008S3-EM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 00:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbbCSXu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 19:50:58 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:16444 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750905AbbCSXu5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2015 19:50:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2D2CQDTXwtVPFtDFlxcgwaBLIY6bcR7BAKBQU0BAQEBAQEGAQEBATg7hAoFAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUBAgklFAEECBIGBwMUBgESCAIBAgMBiAoDCQy4cI97DYUxAQEIAQEBAR6LF4JEgi2DHoEWBYpfhW1hh0CPToYmhBA+MYJDAQEB
X-IPAS-Result: A2D2CQDTXwtVPFtDFlxcgwaBLIY6bcR7BAKBQU0BAQEBAQEGAQEBATg7hAoFAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUBAgklFAEECBIGBwMUBgESCAIBAgMBiAoDCQy4cI97DYUxAQEIAQEBAR6LF4JEgi2DHoEWBYpfhW1hh0CPToYmhBA+MYJDAQEB
X-IronPort-AV: E=Sophos;i="5.11,433,1422921600"; 
   d="scan'208";a="545773554"
Received: from host-92-22-67-91.as13285.net (HELO PhilipOakley) ([92.22.67.91])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 19 Mar 2015 23:50:55 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265852>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, March 17, 2015 6:33 PM
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Mar 16, 2015 at 10:05 PM, Junio C Hamano <gitster@pobox.com> 
>> wrote:
>>
>>> However, you can say "git bisect bad <rev>" (and "git bisect good
>>> <rev>" for that matter) on a rev that is unrelated to what the
>>> current bisection state is.  E.g. after you mark the child of 8 as
>>> "bad", the bisected graph would become
>>>
>>>    G...1---2---3---4---6---8---B
>>>
>>> and you would be offered to test somewhere in the middle, say, 4.
>>> But it is perfectly OK for you to respond with "git bisect bad 7",
>>> if you know 7 is bad.
>>>
>>> I _think_ the current code blindly overwrites the "bad" pointer,
>>> making the bisection state into this graph if you do so.
>>>
>>>    G...1---2---3---4
>>>                     \
>>>                      5---B
>>
>> Yes, we keep only one "bad" pointer.
>>
>>> This is very suboptimal.  The side branch 4-to-7 could be much
>>> longer than the original trunk 4-to-the-tip, in which case we would
>>> have made the suspect space _larger_, not smaller.
>>
>> Yes, but the user is supposed to not change the "bad" pointer for no
>> good reason.
>
> That is irrelevant, no?  Nobody is questioning that the user is
> supposed to judge if a commit is "good" or "bad" correctly.
[...]
>> and/or we could make "git bisect bad" accept any number of bad
>> commitishs.
>
> Yes, that is exactly what I meant.
>
> The way I understand the Philip's point is that the user may have
> a-priori knowledge that a breakage from the same cause appears in
> both tips of these branches.

Just to clarify; my initial query followed on from the way Junio had 
described it with having two tips which were known bad. I hadn't been 
aware of how the bisect worked on a DAG, so I wanted to fully understand 
Junio's comment regarding the expectation of a clean jump to commit 4 
(i.e. shouldn't we test commit 4 before assuming it's actually bad).  I 
was quite happy with a bisect of a linear list, but was unsure about how 
Git dissected DAGs.

I can easily see cases in more complicated product branching where users 
report intermittent operation for various product variants (especially 
if modular) and one wants to seek out those commits that introduced the 
behavious (which is typically some racy condition - otherwise it would 
be deterministic).

Given Junio's explantion with the two bad commits (on different legs) 
I'd sort of assumed it could be both user given, or algorithmically 
determined as part of the bisect.

> In such a case, we can start bisection
> after marking the merge-base of two 'bad' commits, e.g. 4 in the
> illustration in the message you are responding to, instead of
> including 5, 6, and 8 in the suspect set.
>
> You need to be careful, though.  An obvious pitfall is what you
> should do when there is a criss-cross merge.

You end up with possibly two (or more) merges being marked as the source 
of the bad behaviour, especially when racy ;-)

>
> Thanks.
> --

Hope that helps.
Philip
