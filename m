From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 20:33:54 -0700
Message-ID: <CAGZ79kbgYkjbpnk8LTOyHPRPAKi2s0p+iRk6FkWCN2KpHELgVA@mail.gmail.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
	<20160415000730.26446-1-sbeller@google.com>
	<xmqqbn5bei7x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, davidel@xmailserver.org,
	Jacob Keller <jacob.keller@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 05:34:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aquWB-0001dj-FY
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 05:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbcDODd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 23:33:56 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33903 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcDODdz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 23:33:55 -0400
Received: by mail-io0-f171.google.com with SMTP id 2so123667019ioy.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 20:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=terDRdxKWaNctksbuP6yQV59PQ9uGxJF+0r1Vu3T4jk=;
        b=USFCpzzgFPObyUN/z6e9Wk7kjgPnGxpI+MgeRBsXe6gaTBWbAE8pIdxGZRGxUadIuJ
         58qLrOq16A+6VBZwzCJDNl0MVZHYGiS/RnabBSmKW3S+zfXEPVvbwytTu79LXSXp0XlV
         MIYmFcKMHz2kxMUy4t23sdNP6aKKVRuww1bt4qaoVHcEzjbZ7DHxGeDxeiAXmhypfmSV
         bCm6TOkE4Aiy5i2DJHKjcZvSxGsHX2XCOayzyOLSUS/Izv36gswrkcZPkiraVa/UDIR6
         ILZrUUmLt8QEmsVUYRGxSU1FjC8qh316eDWAJqOqFJqZ8uAZvGC/nANfY8N8XEEPbJvQ
         9WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=terDRdxKWaNctksbuP6yQV59PQ9uGxJF+0r1Vu3T4jk=;
        b=lMggXv30wQTsFIIzNsLpkcfIawumu5ZOj82l/lmmmUQN/phrccxktTjMIZvMkOZbb7
         0i7bso7VfKiHquhECz/IYWELKEJ2XJNA2HVPzF5ra9qzCfmzRXb85b1BQ0pLCC1byLAP
         TfBbqJ1KIgjmXf/PlqltEtQAvosbU1b5ckKN7m4TpNdeOIalCXL25SaCgEOY3uJUoxmV
         7tndjAOXQWoXKF4ly8urnforCTNDImrKhX+a1LjM9WwpmAD4Hb2CxFtsjKpWBgEvm+uQ
         vfu6xjXfiv1jfRdGSxA1AhVqYMfGfv39MaFbtQKd2GH2sChvj2ac7yUOOeMUeW1P3mo9
         zBIw==
X-Gm-Message-State: AOPr4FX7RF8HNfQ+1588PGDmuYA+fZIGjRgwP/hTjAUXWD2/pUpniRaWhNpnBofVMUCJzs7h3rlQLt81hwSWd+Vv
X-Received: by 10.107.184.8 with SMTP id i8mr19872704iof.96.1460691234527;
 Thu, 14 Apr 2016 20:33:54 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 14 Apr 2016 20:33:54 -0700 (PDT)
In-Reply-To: <xmqqbn5bei7x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291598>

On Thu, Apr 14, 2016 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>
>> +static int starts_with_emptyline(const char *recs)
>> +{
>> +     return recs[0] == '\n'; /* CRLF not covered here */
>> +}
>> +
>> +
>
> That's "is-empty-line", not "starts-with" ;-)

heh, ok.
To understand the code, I was debugging it and looking at the
pointers `recs[ix - 1]->ptr` which is pointing into the text file,
i.e. when printing it in the debugger it would read

    '\n\tbla\n\nfoo\n ...'

so I found that a proper description at the time.


>
>> +
>> +             /*
>> +              * If a group can be moved back and forth, see if there is an
>> +              * empty line in the moving space. If there is an empty line,
>> +              * make sure the last empty line is the end of the group.
>> +              *
>> +              * As we shifted the group forward as far as possible, we only
>> +              * need to shift it back if at all.
>> +              */
>
> Sounds sensible.
>
>> +             if (has_emptyline) {
>> +                     while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
>> +                            xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
>> +                            !starts_with_emptyline(recs[ix - 1]->ptr)) {
>
> You probably want to wrap the "hash compares equal and recmatch does
> say they are the same" into a helper function (to be automatically
> inlined by the compiler) to make it more readable here.  I think
> is-empty is a lot cheaper than the recmatch so that should probably
> be done earlier in the && chain.

ok, will do. Given that xdiff upstream and our code diverged over the years,
I could apply this helper function at other places in the code as well.


>
>> +                             rchg[--ixs] = 1;
>> +                             rchg[--ix] = 0;
>> +
>> +                             /*
>> +                              * This change did not join two change groups,
>> +                              * as we did that before already, so there is no
>
> Sorry, cannot quite parse the part before "already".

I think to drop this comment in the final version of this patch.
As I `wrote` this loop by copying it from above, I tried justifying
each change to it. (More to prove to myself I understood the code)

will drop this comment.

>
>> +                              * need to adapt the other-file, i.e.
>> +                              * running
>> +                              *     for (; rchg[ixs - 1]; ixs--);
>> +                              *     while (rchgo[--ixo]);
>> +                              */
>> +                     }
>> +             }
>>       }
>>
>>       return 0;
