From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Wed, 5 Nov 2014 13:41:06 -0000
Organization: OPDS
Message-ID: <95BF305A6E8D485F9F63503ACE7FC2AB@PhilipOakley>
References: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> <20141030213523.GA21017@peff.net> <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley> <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com> <20141101033327.GA8307@peff.net> <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley> <xmqqmw88rvh3.fsf@gitster.dls.corp.google.com> <20141103220408.GA12462@peff.net> <xmqq389zrguw.fsf@gitster.dls.corp.google.com> <xmqq4muepr40.fsf@gitster.dls.corp.google.com> <20141104233215.GA16091@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 14:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xm0mZ-0006Sa-0a
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 14:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbaKENhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 08:37:51 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58913 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754004AbaKENhu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Nov 2014 08:37:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMTAJknWlRZ8YDkPGdsb2JhbABcgw6BLYMGhDeBBMwlBAKBFxcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcCAQICBSECAhQBBBoGBwMMCAYBEggCAQIDAYgnDbNohwGOJAErgS2PZIJ+NoEeBZIhYow+i0mCKYlmgUQ9L4JLAQEB
X-IPAS-Result: AgMTAJknWlRZ8YDkPGdsb2JhbABcgw6BLYMGhDeBBMwlBAKBFxcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcCAQICBSECAhQBBBoGBwMMCAYBEggCAQIDAYgnDbNohwGOJAErgS2PZIJ+NoEeBZIhYow+i0mCKYlmgUQ9L4JLAQEB
X-IronPort-AV: E=Sophos;i="5.07,319,1413241200"; 
   d="scan'208";a="759499118"
Received: from host-89-241-128-228.as13285.net (HELO PhilipOakley) ([89.241.128.228])
  by out1.ip01ir2.opaltelecom.net with SMTP; 05 Nov 2014 13:37:49 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
Subject: Re: [PATCH] use child_process_init() to initialize struct 
child_process variables


> On Tue, Nov 04, 2014 at 01:56:15PM -0800, Junio C Hamano wrote:
>
>> >>   2. Including two lines, like:
>> >>
>> >>         $sha1 HEAD\0symref=refs/heads/master
>> >>         $sha1 HEAD
>> >>
>> >>      which JGit does the right thing with (and git.git seems to, 
>> >> as
>> >>      well).
>> >
>> > Sounds sensible, even though it looks ugly X-<.
>>
>> I have a mild preference for a syntax that is more similar to the
>> on-wire protocol, so that connect.c::parse_feature_value() can be
>> reused to parse it and possibly annotate_refs_with_symref_info() can
>> also be reused by calling it from 
>> transport.c::get_refs_from_bundle().
>
> Yeah, what I wrote above was the simplest thing that could work, and
> does not need to be the final form.  I know that you already know what
> I'm about to describe below, Junio, but I want to expand on the
> situation for the benefit of onlookers (and potential implementers 
> like
> Philip).

I think I'm keeping up ;-)
>
> The online protocol is hampered by the "if you see something after a
> NUL, it is a capabilities string, and you must throw out the previous
> capabilities string and replace it with this one" historical rule. And
> that's why we cannot do:
>
>  $sha1 refs/heads/master\0thin-pack side-band etc
>  $sha1 HEAD\0symref=refs/heads/master
>
> as it would throw out "thin-pack", "side-band", etc. Instead we do it
> more like:
>
>  $sha1 refs/heads/master\0thin-pack side-band etc 
> symref=HEAD:refs/heads/master
>  $sha1 HEAD
>
> to shove _all_ of the symref mappings into the capability string, 
> rather
> than letting them ride along with their respective refs. The downside 
> is
> that we are bounded in the number of symref mappings we can send (by 
> the
> maximum length for a single pkt-line), and therefore send only the 
> value
> of HEAD.
>
> The bundle code is not bound by this historical legacy, and could do 
> it
> in a different (and more efficient and flexible) way. But it is 
> probably
> saner to just keep them identical. It makes the code simpler, and 
> having
> bundle as the only transport which has the extra flexibility does not
> really buy us much (and probably just invites confusion).
>
> -Peff
>
Obviously bundles are always off-line, so it's reasonable to be cautious 
about using an on-line sideband method, though the re-use of a standard 
format is good.

Finding the right parsing method will be important, as well as ensuring 
there are no races from the update of unsorted refs.

Philip 
