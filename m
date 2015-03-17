From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Tue, 17 Mar 2015 17:44:18 +0700
Message-ID: <CACsJy8AO1w0tYmYkOLjB6osw50gYpc01_6iUt5JZLqL0xtDPrw@mail.gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
 <CACsJy8AAsAO6gjWg0nsdiOXFEsZ4583pH9mkUx1Js3Yop5KHHQ@mail.gmail.com> <CABwkPcrF9oFvNkbp6rFV28U3w-szyV9k4LFviYyFkoJvp8pjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:44:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXozZ-0000Op-NV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 11:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbbCQKox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 06:44:53 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34273 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbbCQKot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 06:44:49 -0400
Received: by iecsl2 with SMTP id sl2so5861354iec.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3zuFan5kzpDy1CuAfL3g4EpBI4O768+1clbcqHmkypU=;
        b=ehcHJH1lG5e2HqJYLy4PcIotTvwsCkoOKiMqh/RiyDPyL1IYGR/jfpCUOxoj3R5eHZ
         04P31hm+xG+INDyNQDum41pu18LYyJbHG+9C1CiTBNmcdik1RurPwk47s5ZJ5SbtQh5N
         1KSt0zTW1D1b5lIF/ba1tub7WVbhaDlOs1lxJ2/GiXrHyZ7VHSjOdHJ6aWN57rqzn0e6
         +x9eB08tApxSHygbJJwFdX/Tl/VaZ0ZO47NzcmhV0n8/L+9DpIcRSTmMOO7q+Vtka+a4
         xTrrIWYqRhOlu8QUiUsnQzng50Km5xZotfaatKh/uv5feYQ/mYxekrx+eBUDPeQeATs1
         FfuQ==
X-Received: by 10.50.25.166 with SMTP id d6mr42125240igg.41.1426589088924;
 Tue, 17 Mar 2015 03:44:48 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 17 Mar 2015 03:44:18 -0700 (PDT)
In-Reply-To: <CABwkPcrF9oFvNkbp6rFV28U3w-szyV9k4LFviYyFkoJvp8pjbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265625>

On Mon, Mar 16, 2015 at 11:10 PM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
> Hi Duy,
>
> Sorry for my late response.
>
>> we need to make sure that upload-pack barf if some client sends both "deepen" and
>> "depth".
>
> Actually, in my current design, when client just wants "depth", it
> sends "depth N";
> when it want "deepen", it sends "depth N" as well as "depth_deepen".
> For the latter
> case, it tells upload-pack to collect objects for "deepen N".
>
> Thus, I'm not so sure whether upload-pack needs to check their exclusion.

C Git is not the only client that can talk to upload-pack. A buggy
client may send both. The least we need is make sure it would not
crash or break the server security in any way. But if we have to
consider that, we may as well reject with a clear message, which would
help the client writer. And speaking of clients..

On Mon, Mar 16, 2015 at 11:08 PM, Dongcan Jiang <dongcan.jiang@gmail.com> wrote:
>>> -             if (starts_with(line, "deepen ")) {
>>> +             if (starts_with(line, "depth ")) {
>>>                       char *end;
>>> -                     depth = strtol(line + 7, &end, 0);
>>> -                     if (end == line + 7 || depth <= 0)
>>> -                             die("Invalid deepen: %s", line);
>>> +                     depth = strtol(line + 6, &end, 0);
>>> +                     if (end == line + 6 || depth <= 0)
>>> +                             die("Invalid depth: %s", line);
>>>                       continue;
>>>               }
>>>               if (!starts_with(line, "want ") ||
>>
>> I do not quite understand this hunk.  What happens when this program
>> is talking to an existing fetch-pack that requested "deepen"?
>
> In this hunk, I actually just changed the one command name in upload-pack
> service from "deepen" to "depth". I made this change because the name
> "deepen" here is quite misleading, as it just means "depth". Of course,
> I've changed the caller's sent pack from "deepen" to "depth" too (See below).

You missed Junio's keyword "existing". Your new client will work well
with your new server. But it breaks "git clone --depth" (or "git fetch
--depth") for all existing git installations.
-- 
Duy
