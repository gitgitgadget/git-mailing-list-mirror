From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Mon, 11 May 2015 10:10:55 -0700
Message-ID: <CAGZ79kbkfp-nZUqK3nO7hmdL4C+RaTREBTHbkjUtVxFgOeozOQ@mail.gmail.com>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
	<555051C9.7040204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 19:11:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrrEV-0008Py-HC
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 19:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbbEKRLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 13:11:05 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36536 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbbEKRK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 13:10:56 -0400
Received: by iecmd7 with SMTP id md7so35791198iec.3
        for <git@vger.kernel.org>; Mon, 11 May 2015 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5R2IoLanz1AnKiwA0m/88niDUt1jMTw8QTvSm+2mLa8=;
        b=TIR5b8UKgNGVyp8CMHcJJlRAtDjGPrMbJpd3XKuvgcNUwJvvuCnPSSIlRVGxT2tLeF
         nb6gfVFczzUJusQjtAdYaPJlVoJBqqpRfiHwU4dhPYpcVSoqAsi0w9oLifnKKJXGYJDd
         erPjEgYhSdegXF9xaNW/ssjUtjCrHGpNHjD+urWt6j0FVx/k7a7mf/qI+AvoNaHhTiUO
         2NlaUcIYqakb1DScD1qxZdRY1cQ3OQYjLbdxTEnH5EZipWKYNdn5q6CpZtuXseX3G0bS
         swHwWr2FeZtZt91Px6v99oKM7jSCfFCcqM8H/IZAh2ZIPKQcAHGiBCsCJ281w91g28ZI
         BguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5R2IoLanz1AnKiwA0m/88niDUt1jMTw8QTvSm+2mLa8=;
        b=DZCu5keStIDObWUIGSHIQItiDdUEozSBtkxHKQ3YyTViAF2ILy2SskZUeeLiaTgXPE
         zjgeC2gaAKrsSa5N0G4vj6MCbyUK2G3utujOxccwbHhVnG36+4EIN6caPHqAPLPIDlij
         9bnPTj8xmLzStl4Xh+MvddxVAYr80746aV2uLANFGZwCGMErrTUpErrRXLlTgIijYEZ3
         9uKt4rtWVb0EgaatjIuJHabFX6S2NQMmXLDJSENiSy0H3YNQ2K4/CgchXIHIzbv5ENb1
         xQ47/hjewViJp3yqGBOOVacu14YAb1IMFUiJiSXvD8Q4Fn3lYm0zo0rflbvt5onr0HfP
         si+g==
X-Gm-Message-State: ALoCoQnJQ6QrhjxoVUqZIupPG517Ygo7AWiln8yadeigH6wLk0dO/I0lycqqhl7jEavfeCWEek4F
X-Received: by 10.50.102.68 with SMTP id fm4mr14292422igb.25.1431364255932;
 Mon, 11 May 2015 10:10:55 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 10:10:55 -0700 (PDT)
In-Reply-To: <555051C9.7040204@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268799>

On Sun, May 10, 2015 at 11:52 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is exactly the kind of case that "rebase with history" [1] was
> meant to address. But given that our tooling doesn't support such
> complicated histories very well, your plan sounds reasonable.

As a side note to your blog post unrelated to the current series:

I think the new proposed history for "rebase-by-merging-a-patch-at-a-time" also
improves bisectability because you have less long running side branches
(as compared to both in traditional rebase and traditional merge), but a finer
meshed DAG where it is easier to split the commit range into half its size.
When going back one step in history you have more merge nodes where
bisect can decide how many commits to chop off of the new range.

>
> Michael
>
> [1]
> http://softwareswirl.blogspot.de/2009/04/truce-in-merge-vs-rebase-war.html
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
