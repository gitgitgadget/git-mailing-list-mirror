From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 08:52:21 -0000
Organization: OPDS
Message-ID: <D8169FC37A314B82930152F9DE817682@PhilipOakley>
References: <loom.20151026T065553-934@post.gmane.org><xmqq611ujfn0.fsf@gitster.mtv.corp.google.com> <xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Sivakumar Selvam" <gerritcode@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 09:52:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqzze-0006K4-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 09:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbbJ0Iw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 04:52:29 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:43107 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754558AbbJ0IwZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 04:52:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CnGwBJOi9WPEdMFlxdGQoBAQIBAQIEgweBQ4ZabbkGhhAEBAKBQE0BAQEBAQEHAQEBAUEkG4QtBgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBAgSBgcDFAYBEggCAQIDAYgKAxa6GIcIDYR2hneEfoJQgj2DIYEUBY1RiGYBgSCKDINPkweDX4NwgnQdgVY+NIVuAQEB
X-IPAS-Result: A2CnGwBJOi9WPEdMFlxdGQoBAQIBAQIEgweBQ4ZabbkGhhAEBAKBQE0BAQEBAQEHAQEBAUEkG4QtBgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBAgSBgcDFAYBEggCAQIDAYgKAxa6GIcIDYR2hneEfoJQgj2DIYEUBY1RiGYBgSCKDINPkweDX4NwgnQdgVY+NIVuAQEB
X-IronPort-AV: E=Sophos;i="5.20,204,1444690800"; 
   d="scan'208";a="561754028"
Received: from host-92-22-76-71.as13285.net (HELO PhilipOakley) ([92.22.76.71])
  by out1.ip03ir2.opaltelecom.net with SMTP; 27 Oct 2015 08:52:22 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280246>

From: "Junio C Hamano" <gitster@pobox.com>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sivakumar Selvam <gerritcode@gmail.com> writes:
>>
>>> ... So
>>> I thought of splitting the pack file into 4 GB chunks.
>> ...
>> Hmmm, what is "this issue"?  I do not see anything surprising.
>
> While the explanation might have been enlightening, the knowledge
> conveyed by the explanation by itself would not be of much practical
> use, and enlightment without practical use is never fun.
>
> So let's do another tangent that may be more useful.
>
> In many repositories, older parts of the history often hold the bulk
> of objects that do not change, and it is wasteful to repack them
> over and over.  If your project is at around v40.0 today, and it was
> at around v36.0 6 months ago, for example, you may want to pack
> everything that happened before v36.0 into a single pack just once,
> pack them really well, and have your "repack" not touch that old
> part of the history.
>
>  $ git rev-list --objects v36.0 |
>    git pack-objects --window=200 --depth=128 pack
>
> would produce such a pack [*1*]
>
> The standard output from the above pipeline will give you a 40-hex
> string (e.g. 51c472761b4690a331c02c90ec364e47cca1b3ac, call it
> $HEX), and in the current directory you will find two files,
> pack-$HEX.pack and pack-$HEX.idx.
>
> You can then do this:
>
>  $ echo "v36.0 with W/D 200/128" >pack-$HEX.keep
>  $ mv pack-$HEX.* .git/objects/pack/.
>  $ git repack -a -d
>
> A pack that has an accompanying .keep file is excempt from
> repacking, so once you do this, your future "git repack" will only
> repack objects that are not in the kept packs.
>

I had a quick look at the man pages and couln't find an explanation (such as 
this one) to explain the purpose,  highlight the use of and how to create 
such .keep packs.

Could this form the basis of a short section on .keep packs?(or did I miss 
something)

>
>
> [Footnote]
>
> *1* I won't say 200/128 gives you a good pack; you would need to
> experiment.  In general, larger depth will result in smaller pack
> but it will result in bigger overhead while you use the repository
> every day.  Larger window will spend a lot of cycles while packing,
> but will result in a smaller pack.
> --

Philip 
