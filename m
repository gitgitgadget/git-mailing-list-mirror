From: Alexandre Garnier <zigarn@gmail.com>
Subject: Re: [BUG] Git does not convert CRLF=>LF on files with \r not before \n
Date: Wed, 22 Apr 2015 15:06:38 +0200
Message-ID: <CAFFOgCVkpweSukCW4La737P1uu1hqX8WKr9wF1cLV8ciPu8tuQ@mail.gmail.com>
References: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
	<5536A4CB.9050000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 15:06:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkuMX-0000JR-95
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 15:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbbDVNGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 09:06:40 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:32828 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbDVNGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 09:06:39 -0400
Received: by layy10 with SMTP id y10so174320981lay.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wrwX1KEpg0qSLbcbo/3n8ndmqq3VP1N9WvUMpC3UV2Q=;
        b=n6H2/qPIUEls5NCBLZjkmjoh2h1HjpMaTGGOR/eRQsDg/GHhG1AkqPls6+QsAdFdJp
         wENClfH8jG7E/YkQ58BzLgqpS3fyR4grLmGBhU9yWGqKpfG6vbMnqCTWAobQ7ds1W91w
         CzwRX3LuSs/b1vgVwyvig3btgB/+vAtebaCFuKr06IBgIO7Ht2UivkWi/1731l/dURi0
         23oMm6dvIPrjIkLoycv+rj90bnvutWrUwFrcSykDUXkyBU98+5zsbr4RIxhzHc5IXPNY
         aE2aPCKt1sqq0QVm/WCd/CdtdOcehRB10HL3qA5aLbonvketA48jXDZLPGoyfzqlPgqe
         LgUw==
X-Received: by 10.112.145.136 with SMTP id su8mr24602616lbb.61.1429707998070;
 Wed, 22 Apr 2015 06:06:38 -0700 (PDT)
Received: by 10.25.156.67 with HTTP; Wed, 22 Apr 2015 06:06:38 -0700 (PDT)
In-Reply-To: <5536A4CB.9050000@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267590>

Indeed, when changing the gitattributes for '* text', the replacement i=
s OK.
Thanks for all the explanations.

At first, my use case was some source files (imported from another
VCS) with CR in different contexts:
 - lines ending with CRCRLF
 - all content in LF or CRLF but some CR that should be EOL...
 - CR in the middle of the line for no reason!
=46or all this, I will fix the files during import.

But when digging I found some shell or awk scripts with CR as a valid
char in search/replacement string. I know that the EOL should not be
CRLF in this case, but I don't know if this situation could happen in
DOS batch files or PowerShell scripts with CRLF EOL.

2015-04-21 21:28 GMT+02:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
> On 2015-04-21 15.51, Alexandre Garnier wrote:
>> Here is a test:
>>
>> git init -q crlf-test
>> cd crlf-test
>> echo '*       text=3Dauto' > .gitattributes
>> git add .gitattributes
>> git commit -q -m "Normalize EOL"
>> echo -ne 'some content\r\nother \rcontent with CR\r\ncontent\r\nagai=
n
>> content with\r\r\n' > inline-cr.txt
>> echo "Working directory content:"
>> cat -A inline-cr.txt
>> echo
>> git add inline-cr.txt
>> echo "Indexed content:"
>> git show :inline-cr.txt | cat -A
>>
>> Result
>> ------
>> File content:
>> some content^M$
>> other ^Mcontent with CR^M$
>> content^M$
>> again content with^M^M$
>>
>> Indexed content:
>> some content^M$
>> other ^Mcontent with CR^M$
>> content^M$
>> again content with^M^M$
>>
>> Expected result
>> ---------------
>> File content:
>> some content^M$
>> other ^Mcontent with CR^M$
>> content^M$
>> again content with^M^M$
>>
>> Indexed content:
>> some content$
>> other ^Mcontent with CR$
>> content$
>> again content with^M$
>> # or even 'again content with$' for this last line
>>
>> If you remove the \r that are not at the end of the lines, EOL are
>> converted as expected:
>> File content:
>> some content^M$
>> other content with CR^M$
>> content^M$
>> again content with^M$
>>
>> Indexed content:
>> some content$
>> other content with CR$
>> content$
>> again content with$
>>
>
> First of all, thanks for the info.
>
> The current implementation of Git does an auto-detection
> if a file is text or binary.
>
> For a file which is "suspected to be text", it is expected to have ei=
ther LF or CRLF as
> line endings, but a "bare CR" make Git wonder:
> Should this still be treated as a text file ?
> If yes, should the CR be kept as is, or should it be converted into L=
=46 (or CRLF) ?
>
> The current implementation may simply be explained by the fact that n=
obody has so far asked
> to treat this file as "text", so the implementation assumes it to be =
binary.
>
> (Which makes the code a little bit easier, at the time it was written=
)
>
> So the status of today is that you can force Git to let the CR as is,
> when you specify that the file is "text".
>
> Is there a real life problem behind it ?
> And what should happen to the CRs ?
>
>
>
>
>
