From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] builtin/apply.c: report error on failure to recognize input
Date: Mon, 5 Dec 2011 16:38:31 -0600
Message-ID: <CA+sFfMccK8CLygNPfiGJdJ4LDwwBG-+ji6ofs7L9K60T9CYNWg@mail.gmail.com>
References: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
	<1322944550-27344-2-git-send-email-drafnel@gmail.com>
	<7vzkf6lsyx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, artem.bityutskiy@linux.intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:38:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXhBG-0004Il-1D
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab1LEWid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 17:38:33 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45939 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab1LEWic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 17:38:32 -0500
Received: by ggnr5 with SMTP id r5so5548769ggn.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 14:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/X0+aYRqs1aehwl2Ubt8J5CXSMFb1GudEE0aUrCPhiA=;
        b=i5UawTUK89onrOc8d7RnNSzdWOFwIOtSY0C9yte2Vjz0CsCpIp7/s0x5EurCDF10Rg
         ICjyjdSsytbf0byDjp21X0Rq535gbdudnU2+7jhavewzocA48LfrD+hxabnyUj+Bnire
         fPBwInjEY9xk10JeLD43PCtvs6TCJUUOIRurc=
Received: by 10.182.47.100 with SMTP id c4mr2165206obn.79.1323124712307; Mon,
 05 Dec 2011 14:38:32 -0800 (PST)
Received: by 10.182.60.4 with HTTP; Mon, 5 Dec 2011 14:38:31 -0800 (PST)
In-Reply-To: <7vzkf6lsyx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186296>

On Mon, Dec 5, 2011 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> When git apply is passed something that is not a patch, it does not =
produce
>> an error message or exit with a non-zero status if it was not actual=
ly
>> "applying" the patch i.e. --check or --numstat etc were supplied on =
the
>> command line.
>>
>> Fix this by producing an error when apply fails to find any hunks wh=
atsoever
>> while parsing the patch.
>>
>> This will cause some of the output formats (--numstat, --diffstat, e=
tc) to
>> produce an error when they formerly would have reported zero changes=
 and
>> exited successfully. =C2=A0That seems like the correct behavior thou=
gh. =C2=A0Failure
>> to recognize the input as a patch should be an error.
>>
>> Plus, add a test.
>>
>> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>>
>> Initially, I was reluctant to change the error message, thinking tha=
t
>> error messages for plumbing commands were not supposed to change. =C2=
=A0But I
>> think I was wrong in that thought, so I changed the error message so=
 it
>> was a more descriptive "unrecognized input".
>
> I am still reluctant to see
>
> =C2=A0 =C2=A0$ git apply </dev/null
> =C2=A0 =C2=A0error: unrecognized input
>
> instead of "error: No changes", though.

I'm not partial to "unrecognized input", but I thought it was more
descriptive of what happened than "No changes".  This error message is
only printed out when absolutely no hunks were found while parsing the
input.

> "git apply --check" is about asking "do you see anything offending in=
 the
> diff?" and it is not "git apply --dry-run" that asks "do you promise =
if I
> feed this for real to you you will apply it without complaint?".
>
> I am slightly in favor of answering "well you do not have a diff to b=
egin
> with, which in itself is suspicious" to "do you see anything offendin=
g?"
> question, but I have to admit that it is an equally valid answer to s=
ay
> "no, there is nothing offending in the diff.", which is what we do wi=
th
> the current code.
>
> So, I dunno.

I think the current code is a little inconsistent with respect to
empty or bogus non-diff input.

It seems more consistent that if it is an error to tell git apply to
apply zero hunks, then it is also an error to --check zero hunks, or
--stat etc.  In all cases the cause is the same: failure to find any
hunks in the input because the input was not a diff.

Also, the man page description of --check says that it checks "if the
patch is applicable to the current working tree and/or the index".
The new behavior would answer that with "no, this patch is not
applicable ... since no hunks were found", rather than "yes, because
no hunks were found".  But I'm really arguing on the side of
"unrecognized input should be an error", since the new behavior would
also be an error for --stat, --numstat, etc.

-Brandon
