From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be 
	used
Date: Sat, 4 Apr 2009 13:20:18 -0500
Message-ID: <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
	 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
	 <20090404180601.GA14888@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 04 20:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqAV8-0003Da-BX
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 20:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbZDDSUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 14:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZDDSUW
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 14:20:22 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:53786 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbZDDSUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 14:20:21 -0400
Received: by ewy9 with SMTP id 9so1378668ewy.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I1dsoGhFfCJZCm9T6EhHm7+ngvXu5b/BrhsuvPQQlk8=;
        b=Z1vy1rr2VGIwA4h4RStkJZTG4ZtcnZIcyi1nHWaBBg1BQXQRdsd4MXYkUHLSJyA8Pi
         h/DPOWFM4uPbZiiNo/ftSpLKB+2HMxq7EL6qqjcKL0aie5Qd/3oxJpg9z27K7Sio8WNh
         BiX+mH7H1yq+bJ89ksawbZtozGfu/Tj9Qbz30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c6xwaPUBOSEHizET1DLuQRdcem3CBkoJ1MfaPzfBbgFPrzOl1aITOKrS+I4Shni3Iu
         VLH9iiiJ6XrWVOO+nmGJsx6Nfo1/nq2wpngSN5ic61pnqKM311Vuxi6IKeZWjRtZwoTk
         TmIJinknFth7Tzpkr6+Tp4yesV1FP0auaG3zc=
Received: by 10.216.26.202 with SMTP id c52mr753402wea.98.1238869218364; Sat, 
	04 Apr 2009 11:20:18 -0700 (PDT)
In-Reply-To: <20090404180601.GA14888@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115591>

On Sat, Apr 4, 2009 at 1:06 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 04, 2009 at 11:59:56AM -0500, Dan McGee wrote:
>
>> In the case of a small repository, pack-objects is smart enough to not start
>> more threads than necessary. However, the output to the user always reports
>> the value of the pack.threads configuration and not the real number of
>> threads to be used. This is easily fixed by moving the printing of the
>> message after we have partitioned our work.
>>
>> (pack.threads is on autodetect and would be set to 4)
>> $ git-repack -a -d -f
>> Counting objects: 55, done.
>> Delta compression using 2 threads.
>> Compressing objects: 100% (48/48), done.
>> Writing objects: 100% (55/55), done.
>> Total 55 (delta 10), reused 0 (delta 0)
>
> That makes sense to me, though I wonder if it may confuse and frustrate
> users who are expecting their awesome quad-core machine to be using 4
> threads when it only uses 2. Is it worth printing both values, or some
> indicator that we could have been using more?

I thought of this, but decided it wasn't really worth it. The default
window size of 10 makes it a very rare case that you will use fewer
than 4 threads. With the default, each thread needs a minimum of 20
objects, so even a 100-object repository would spawn the 4 threads.

I wouldn't be opposed to printing something special when
active_threads != delta_search_threads if other people do think it to
be necessary though.

-Dan
