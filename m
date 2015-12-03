From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Thu, 3 Dec 2015 21:34:32 -0000
Organization: OPDS
Message-ID: <46311B14CC814F54AC34764F2520947A@PhilipOakley>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com> <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	"Stefan Beller" <stefanbeller@googlemail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Stefan Naewe" <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 22:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4bg8-0002GM-HK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 22:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbLCVoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 16:44:23 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:56420 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736AbbLCVoW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 16:44:22 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2015 16:44:21 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DyGACltGBWPC5BFlxeGQEBAg8BAQEBgwpTbodMrGRVAYYhhBYhhWcBAwEBgU9NAQEBAQEBBwEBAQFBP0EBAQMLAoNcBQEBAQEBAQEIAQEdER4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAkDCgwJt1OFUw2ETwEBAQcCASCGVIR9glOFU4EVBY1iiH8BgSmEA4VVQ4NSFjODeo52EIdJgnQdgVY+NAEBAYFDgQ+DGgEBAQ
X-IPAS-Result: A2DyGACltGBWPC5BFlxeGQEBAg8BAQEBgwpTbodMrGRVAYYhhBYhhWcBAwEBgU9NAQEBAQEBBwEBAQFBP0EBAQMLAoNcBQEBAQEBAQEIAQEdER4BASELAgMFAgEDFQwlFAEECBIGBwMUBgESCAIBAgMBiAkDCgwJt1OFUw2ETwEBAQcCASCGVIR9glOFU4EVBY1iiH8BgSmEA4VVQ4NSFjODeo52EIdJgnQdgVY+NAEBAYFDgQ+DGgEBAQ
X-IronPort-AV: E=Sophos;i="5.20,378,1444690800"; 
   d="scan'208";a="628954268"
Received: from host-92-22-65-46.as13285.net (HELO PhilipOakley) ([92.22.65.46])
  by out1.ip05ir2.opaltelecom.net with SMTP; 03 Dec 2015 21:49:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281974>

From: "Junio C Hamano" <gitster@pobox.com>
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
>> Two functions dereference a tree pointer before checking
>
> Reading them a bit carefully, a reader would notice that they
> actually do not dereference the pointer at all.  It just computes
> another pointer and that is done by adding the offset of object
> member in the tree struct.

But you can't do that computation (in the error case under consideration). 
Null can't be added to anything (as far as the implications of the standards 
go). These are horrid gotchas because they go against the grain of all that 
binary arithmetic and simplifications we learnt long ago.

That said, the fact that we know it can't be null does save the day, until 
that is, the compiler [via some coding of an interpretation] decides that it 
could be null and thus undefined etc etc (which one would argue as poor 
logic, but standards have no truck with such arguments;-).

There were some discussion on undefined behaviour way back (2013-08-08) when 
Stephan Beller looked at STACK's checking of the Git code, see for example 
http://article.gmane.org/gmane.comp.version-control.git/231945/
"3 issues have been discovered using the STACK tool
The paper regarding that tool can be found at
https://pdos.csail.mit.edu/papers/stack:sosp13.pdf" (link updated)

All their source code is publicly available at 
http://css.csail.mit.edu/stack/

>
>> if the pointer is valid. Fix that by doing the check first.
>>
>> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
>> ---
>> This has been reported through the CppHints newsletter 
>> (http://cpphints.com/hints/40)
>> but doesn't seem to have made its way to the ones who care (the git list
>> that is...)
>
> Nobody would be surprised, unless the newsletter was sent to this
> list, which I do not think it was (but if it was sent while I was
> away, then it is very possible that I didn't see it).
>
>>  revision.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 0fbb684..bb40179 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -104,7 +104,12 @@ static void mark_tree_contents_uninteresting(struct 
>> tree *tree)
>>  {
>>  struct tree_desc desc;
>>  struct name_entry entry;
>> - struct object *obj = &tree->object;
>> + struct object *obj;
>> +
>> + if (!tree)
>> + return;
>> +
>> + obj = &tree->object;
>
> This is questionable; if you check all the callers of this function
> (there are two of them, I think), you would notice that they both
> know that tree cannot be NULL here.
>
>>
>>  if (!has_sha1_file(obj->sha1))
>>  return;
>> @@ -135,10 +140,13 @@ static void mark_tree_contents_uninteresting(struct 
>> tree *tree)
>>
>>  void mark_tree_uninteresting(struct tree *tree)
>>  {
>> - struct object *obj = &tree->object;
>> + struct object *obj;
>>
>>  if (!tree)
>>  return;
>> +
>> + obj = &tree->object;
>> +
>>  if (obj->flags & UNINTERESTING)
>>  return;
>
> This one is not wrong per-se, but an unnecessary change, because no
> deferencing is involved.  At least, please lose the blank line after
> the new assignment.
>
>>  obj->flags |= UNINTERESTING;
>
> Thanks.

--
Philip 
