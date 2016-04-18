From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2 v4] xdiff: implement empty line chunk heuristic
Date: Mon, 18 Apr 2016 16:53:43 -0700
Message-ID: <CAGZ79kZXAtLVdQkU=RJqDrFRvCvPTXjANQ=GPja+NRSn57twAQ@mail.gmail.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
	<xmqqbn564noq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 01:53:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asIzG-0005XN-6T
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 01:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbcDRXxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 19:53:45 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38343 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcDRXxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 19:53:44 -0400
Received: by mail-ig0-f181.google.com with SMTP id y9so2662156igg.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3ltWclcyv4wwF9jGyL/Elp/FKZPsrr+pMpsEMzPeei0=;
        b=Omw/Bz8YLAcxKohCytmupwqyjLkdPs1mo+Ctj6nS1B/OVWjENRw0NyniqJi56NVnEJ
         fodX5eO5LksQfTqXUT7gaYthpc097MlLQlc4xtVw2cz25PY/uxroYdHdNULVii1ivkr0
         WCZIpXAVZd8493HpQI8W8d/t8tr2pNmIelCvPJK5gSgGIIYMo0sfUWReR0isOheNmxfW
         BBZlbG+e6EMynefgJZTPWh/mOmVVelOR5akkw+eUz3qLVICF3yblUPWe18lClAIGTP8t
         asZW/vNTH18aJmCBKoUHXTVCgkYJw0QcQeLF8DW8BPLajih1IWEKnqYQ4srGfZCfMSjQ
         F4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3ltWclcyv4wwF9jGyL/Elp/FKZPsrr+pMpsEMzPeei0=;
        b=efmV5uAyfakPFXF1EjXG9AN6hfvQLHwJfdJXENUDnK7fiu8i7WrVJ2E0Pbgu88/+FK
         HZ/oxrgJ7V2efseBf5eR69n50XBBgxYgkHlgi1szFoiJVCnDjYr2Fh4ODCj0a64+xMoC
         811hB5ILXcAw4YO92W6h2BDGmh0UUQg/gCfT7CS4Erz6N29irZ4DFpIGXcUNGlB7DENP
         oB54AEeSwzh2aiYmQg2aBstPFrkdRPCFsaNeXpJ8q/UlHACps/vQSm0Lruh4Ggg8HCpK
         IF0/LXdZzQzU25G1TdP2diJHR+uMm6Ma5FI0wpRxe97rJGUAcRjdu03tK+4XJ7LfI5vb
         ieVQ==
X-Gm-Message-State: AOPr4FXuK8G0+gmojweXTd6pw5aOg9jE+rcQENOan+dytY+Xaqou/n67rtJudUalgj0bFIIRc1ml667Vxhc+46EA
X-Received: by 10.50.57.50 with SMTP id f18mr22150195igq.93.1461023623403;
 Mon, 18 Apr 2016 16:53:43 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Mon, 18 Apr 2016 16:53:43 -0700 (PDT)
In-Reply-To: <xmqqbn564noq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291838>

On Mon, Apr 18, 2016 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> OK, so perhaps either of you two can do a final version people can
>>> start having fun with?
>>
>> Here we go. I squashed in your patch, although with a minor change:
>>
>> -               if ((flags & XDF_SHORTEST_LINE_HEURISTIC)) {
>> +               if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
>>
>> We did not need that in the "shortest line" heuristic as we know
>> a line with the shortest line length must exist. We do not know about
>> empty lines though.
>
> Makes sense.  The last hunk of
>
> $ git show 9614b8dcf -- update-cache.c
>
> gives an unexpected result without "&& blank_lines" above.  Lack of
> "&& blank_lines" happens to make the result slightly easier to read,
> but at the cost of having an extra line in the hunk.

So without the blank_lines check you get  (A):
    @@ -271,15 +279,14 @@ int main(int argc, char **argv)
                     if (!verify_path(path)) {
                             fprintf(stderr, "Ignoring path %s\n", argv[i]);
                             continue;
    -                }
    -                if (add_file_to_cache(path)) {
    -                        fprintf(stderr, "Unable to add %s to
database\n", path);
    -                        goto out;
                     }
    +                if (add_file_to_cache(path))
    +                        usage("Unable to add %s to database", path);
             }
    ...

and with the heuristic you get (B):

@@ -272,14 +280,13 @@ int main(int argc, char **argv)
    @@ -272,14 +280,13 @@ int main(int argc, char **argv)
                             fprintf(stderr, "Ignoring path %s\n", argv[i]);
                             continue;
                     }
    -                if (add_file_to_cache(path)) {
    -                        fprintf(stderr, "Unable to add %s to
database\n", path);
    -                        goto out;
    -                }
    +                if (add_file_to_cache(path))
    +                        usage("Unable to add %s to database", path);
             }
    ...

In case of (A) the compaction heuristic tries to shift the hunk upwards,
stopping at the first empty line or when lines miss match.
As there is no blank line, it goes until the miss match.

Personally I'd find it less readable, because the intent was not to remove

    -                }
    -                if (add_file_to_cache(path)) {
    -                        fprintf(stderr, "Unable to add %s to
database\n", path);
    -                        goto out;

but rather remove

    -                if (add_file_to_cache(path)) {
    -                        fprintf(stderr, "Unable to add %s to
database\n", path);
    -                        goto out;
    -                }

as that is the logic unit I'd think.

Although you find this instance easier to read the behavior without the
blank_lines check would result in

    Shift hunk upward as much as possible, stop at the first empty line.

For hunks without empty line this just becomes

    Shift hunk upward as much as possible.

which is 50:50 for looking good, so we kept the old behavior as
that is just as good.

Thanks,
Stefan


>
> Thanks.
