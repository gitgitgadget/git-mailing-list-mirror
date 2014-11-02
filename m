From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Sun, 2 Nov 2014 22:54:57 -0000
Organization: OPDS
Message-ID: <F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net> <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> <20141030213523.GA21017@peff.net> <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley> <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com> <20141101033327.GA8307@peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 23:54:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xl42y-0001aH-76
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 23:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaKBWyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 17:54:52 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:54086 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751463AbaKBWyv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2014 17:54:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqAQANq1VlROl3niPGdsb2JhbABcgw6BLIMGhDeBBMweBAKBGBcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGARIIAgECAwGIJw20bIcAjRksgS2PY4J+NoEeBZIaYIw4hn+ESYwLgUQ9L4JLAQEB
X-IPAS-Result: AqAQANq1VlROl3niPGdsb2JhbABcgw6BLIMGhDeBBMweBAKBGBcBAQEBAQEFAQEBATggG4N9BQEBAQECAQgBARkVHgEBIQUGAgMFAgEDDgcDAgIFIQICFAEEGgYHAxQGARIIAgECAwGIJw20bIcAjRksgS2PY4J+NoEeBZIaYIw4hn+ESYwLgUQ9L4JLAQEB
X-IronPort-AV: E=Sophos;i="5.07,303,1413241200"; 
   d="scan'208";a="530851649"
Received: from host-78-151-121-226.as13285.net (HELO PhilipOakley) ([78.151.121.226])
  by out1.ip03ir2.opaltelecom.net with SMTP; 02 Nov 2014 22:54:44 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Fri, Oct 31, 2014 at 02:48:17PM -0700, Junio C Hamano wrote:
>
>> Programs that read a pack data stream unpack-objects were originally
>> designed to ignore cruft after the pack data stream ends, and
>> because the bundle file format ends with pack data stream, you
>> should have been able to append extra information at the end without
>> breaking older clients.

It's an option, I'd been looking at sneaking the information into the 
refs header section.

>> Alas, this principle is still true for
>> unpack-objects, but index-pack broke it fairly early on, and we use
>> the latter to deal with bundles, so we cannot just tuck extra info
>> at the end of an existing bundle.  You'd instead need a new option
>> to create a bundle that cannot be read by existing clients X-<.
>
> I think you could use a similar NUL-trick to what we do in the online

I like this 'trick'. I'd not appreciated the use of the null separator
 for breaking a line into separate strings that way before (I'd 
understood it, just never appreciated it!).

> protocol, and have a ref section like:
>
>  ...sha1... refs/heads/master
>  ...sha1... refs/heads/confused-with-master
>  ...sha1... HEAD\0symref=refs/heads/master
>
> The current parser reads into a strbuf up to the newline, but we
> ignore
> everything after the NUL, treating it like a C string. Prior to using
> strbufs, we used fgets, which behaves similarly (you could not know
> from
> fgets that there is extra data after the NUL, but that is OK; we only
> want older versions to ignore the data, not do anything useful with
> it).
>

This certainly looks the way to go. The one extra question would be
whether the symref should be included by default when HEAD is present, 
or only if there was possible ambiguity between the other listed refs. 
Previously I'd assumed the latter. The former would appear stronger, as 
long as the symref was within the listed refs, and excluded otherwise.

Philip 
