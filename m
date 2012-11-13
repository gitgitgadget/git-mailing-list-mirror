From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 16:19:52 +0100
Message-ID: <CANQwDwd0UfGshpwj-R6iatE+93PRD5p9giC_9dJ09YwXQmL6Wg@mail.gmail.com>
References: <20121111232820.284510@gmx.net> <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net> <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, glpk xypron <xypron.glpk@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIHt-0004vQ-SI
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab2KMPUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:20:14 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47790 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2KMPUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:20:13 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7488538oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YMOTU6Ym0aTyEh35C9rKzNBJVgKttfPqQUuQ1JOOEyw=;
        b=Q+1PALvKt7lDOq8V55VXOSdxdJu097VTVDGSilLIFJwEoq7y6JHgK6JnamUfDeqEuT
         zSSie+QTCc/FJHjaDCpm7zilYUlZhYpI+SO2VW1bjPwDSBW9H26FI8q3FeQqNcP99ZzU
         juOf+KsS5E0MYEPFpeOfV9qnHLCBLu5aI4rI3DvL+e23qdPko4tqtsKTr/28VRVHaQv3
         h6rz89h0ntH0GEUXwyvypHQ9dlYi/83iagHwiLtsl5J5kGnObYX4eaJZjVukGlcqQTmR
         ciq+dU1tbZX8wXEWCaulgV43d5pZ+SvtPTboEKRo46vv2xGeeT6qvraJQ2flWjt21gV6
         rqpQ==
Received: by 10.60.7.106 with SMTP id i10mr17114223oea.5.1352820012526; Tue,
 13 Nov 2012 07:20:12 -0800 (PST)
Received: by 10.76.91.134 with HTTP; Tue, 13 Nov 2012 07:19:52 -0800 (PST)
In-Reply-To: <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209615>

On Tue, Nov 13, 2012 at 3:44 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Mon, Nov 12, 2012 at 3:24 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Nov 12, 2012 at 01:55:46PM -0500, Drew Northup wrote:

>>> +       # No XSS <script></script> inclusions
>>> +       if ($input =~ m!(<script>)(.*)(</script>)!){
>>> +               return undef;
>>> +       }

>> This is the wrong fix for a few reasons:
>>
>>   1. It is on the input-validation side, whereas the real problem is on
>>      the output-quoting side. Your patch means I could not access a file
>>      called "<script>foo</script>". What we really want is to have the
>>      unquoted name internally, but then make sure we quote it when
>>      outputting as part of an HTML (or XML) file.
>
> I don't buy the argument that we don't need to clean up the input as
> well. There are scant few of us that are going to name a file
> "<script>alert("Something Awful")</script>" in this world (I am
> probably one of them). Input validation is key to keeping problems
> like this from coming up repeatedly as those writing the guts of
> programs are typically more interested in getting the "assigned task"
> done and reporting the output to the user in a safe manner.

Input cleanup or blacklisting *does not* prevent code injection (XSS
in this case). This is a myth.

Input validation has its place, and is done by gitweb when possible
(see e.g. evaluate_and_validate_params, validate_project, etc.).

But the proposed solution is not input validation.
'<script>alert("Something Awful")</script>' is a perfectly valid filename.
As is more realistic "<<create>>.uml" or "File > Open screenshot.png".

And last and most important you have to escape output anyway;
filename is not HTML. Without escaping it would be rendered incorrectly.
And HTML escaping prevents XSS.

>> I think the right answer is going to be a well-placed call to esc_html.
>> This already happens automatically when we go through the CGI
>> element-building functions, but obviously we failed to make the call
>> when building the output manually.  This is a great reason why template
>> languages which default to safe expansion should always be used.
>> Unfortunately, gitweb is living in 1995 in terms of web frameworks.
>
> Escaping the output protects the user, but it DOES NOT protect the
> server. We MUST handle both possibilities.

Errr, what?

If you are thinking about shell injection, we are covered.
Gitweb uses list form of open which is for shell what prepared
statements are for SQL. In one or two cases where we need to
use pipe we do shell escaping.

> Besides, inserting one call to esc_html only fixes one attack path. I
> didn't look to see if all others were already covered.

They should be covered. This case slipped.

-- 
Jakub Narebski
