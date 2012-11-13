From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 09:44:06 -0500
Message-ID: <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
References: <20121111232820.284510@gmx.net>
	<CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
	<20121112202413.GD4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 15:44:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYHj0-0000Rg-R0
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 15:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab2KMOoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 09:44:10 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55280 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2KMOoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 09:44:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so580941bkw.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wy9xsyJq/RbyppKwWuWPloOCIevtnrY7uhgRWehsSkY=;
        b=vmp/srvHvVCrs62JvydOtqR2VJcsPqRCdS4XcnLww7jbr4DRfl0fHXHMyk70YaEwLB
         t3Kl/sF+BASM0t/xaJB3yIrxEqLkMfjlnvG7609QAodxRcmOeLyO45cSmIcKTw3Szs4a
         7vNxwFojAgZCkbK3tvyOW5nFm+jqW3XI1wuvBE5iQ84HOP+ilF9oh1KtDHejHgOcfb8c
         8CZN/4u1pdaUykaEwycMqEDV+sOBA9D3ym7hVxdPJaY5utYC9UtfFIeRy0XgI0cnbEtK
         bEnhkEhm5gVSWmBX1p4pFRyXfaQyGkwvyJMQCQdwf78XmtEb8XjsuATXfH+XwvIZIdIR
         kfcQ==
Received: by 10.204.152.28 with SMTP id e28mr5110109bkw.3.1352817846186; Tue,
 13 Nov 2012 06:44:06 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Tue, 13 Nov 2012 06:44:06 -0800 (PST)
In-Reply-To: <20121112202413.GD4623@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209611>

On Mon, Nov 12, 2012 at 3:24 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 12, 2012 at 01:55:46PM -0500, Drew Northup wrote:
>
>> On Sun, Nov 11, 2012 at 6:28 PM, glpk xypron <xypron.glpk@gmx.de> wrote:
>> > Gitweb can be used to generate an RSS feed.
>> >
>> > Arbitrary tags can be inserted into the XML document describing
>> > the RSS feed by careful construction of the URL.
>> [...]
>> Something like this may be useful to defuse the "file" parameter, but
>> I presume a more definitive fix is in order...
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 10ed9e5..af93e65 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1447,6 +1447,10 @@ sub validate_pathname {
>>         if ($input =~ m!\0!) {
>>                 return undef;
>>         }
>> +       # No XSS <script></script> inclusions
>> +       if ($input =~ m!(<script>)(.*)(</script>)!){
>> +               return undef;
>> +       }
>>         return $input;
>>  }
>
> This is the wrong fix for a few reasons:
>
>   1. It is on the input-validation side, whereas the real problem is on
>      the output-quoting side. Your patch means I could not access a file
>      called "<script>foo</script>". What we really want is to have the
>      unquoted name internally, but then make sure we quote it when
>      outputting as part of an HTML (or XML) file.

I don't buy the argument that we don't need to clean up the input as
well. There are scant few of us that are going to name a file
"<script>alert("Something Awful")</script>" in this world (I am
probably one of them). Input validation is key to keeping problems
like this from coming up repeatedly as those writing the guts of
programs are typically more interested in getting the "assigned task"
done and reporting the output to the user in a safe manner.

>   2. Script tags are only part of the problem. They are what make it
>      obviously a security vulnerability, but it is equally incorrect for
>      us to show the filename "<b>foo</b>" as bold. I would also not be
>      surprised if there are other cross-site attacks one can do without
>      using <script>.

Yes, there are. You are typically concerned with anything including
the following:
(1) Executable stuff;
(2) Out of nowhere resources that can reference executable stuff
(style / CSS, iframe, script includes);
(3) Media and other things that activate browser plugins directly.

>   3. Your filter is too simplistic. At the very least, it would not
>      filter out "<SCRIPT>". I am not up to date on all of the
>      sneaking-around-HTML-filters attacks that are available these days,
>      but I wonder if one could also get around it using XML entities or
>      similar.

You will note that I said "a more definitive fix is in order" in my
original. In other words, I claimed it to be utterly incomplete to
start with. I wanted to get some thought going about input validation
(in particular since I am not a perl guru of any sort whatsoever--the
fair number of things I've written from scratch or mangled into shape
notwithstanding).

> I think the right answer is going to be a well-placed call to esc_html.
> This already happens automatically when we go through the CGI
> element-building functions, but obviously we failed to make the call
> when building the output manually.  This is a great reason why template
> languages which default to safe expansion should always be used.
> Unfortunately, gitweb is living in 1995 in terms of web frameworks.

Escaping the output protects the user, but it DOES NOT protect the
server. We MUST handle both possibilities.
Besides, inserting one call to esc_html only fixes one attack path. I
didn't look to see if all others were already covered.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
