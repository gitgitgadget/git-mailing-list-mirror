From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sat, 10 May 2014 20:54:53 +0700
Message-ID: <CACsJy8DJq2e149wH6cQb4p1fQx9hubKQvxToMU8LLO+UmP+XmA@mail.gmail.com>
References: <536E2C19.3000202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 15:55:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj7kQ-0006Jh-HQ
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 15:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbaEJNzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 09:55:24 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:50009 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbaEJNzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 09:55:23 -0400
Received: by mail-qa0-f49.google.com with SMTP id cm18so5141870qab.8
        for <git@vger.kernel.org>; Sat, 10 May 2014 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h/4Zx9ZRBu75lK097EIdl5FP3AN23EY1AKBSuWReKvE=;
        b=05E/8LQ5mcpk6ZYoOAvVEuB6HKQSCH00ONKMu07RYO4oMqL0NAwQPzOo6jbty533zI
         OFy+y+Ux9sR0zzjA9vJ7XNBnnNBlH9KNQK28qDqg07p3jobyUcABTNAivSmt8kx8Xd37
         tIqRaurwlrE8Y5hNkOgfBtWedaaDugr2riIfRF1cxoeP/IWM75iCM4QtzJ39kQOEpQ1d
         Fz/6Kc++Cd9lkbKphlfajKGtV9lFT6g2KHzIHFNhMOhO0fFdA2L2GvYbhJMxeU2OTQsa
         3btDnt79cFppEikNCr+63jAHOIT9MGzweIEj5Oc0VF6Q7izWleQ8lTXo4tWDaByYKoaS
         1OOw==
X-Received: by 10.140.91.161 with SMTP id z30mr21957401qgd.65.1399730123141;
 Sat, 10 May 2014 06:55:23 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sat, 10 May 2014 06:54:53 -0700 (PDT)
In-Reply-To: <536E2C19.3000202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248659>

On Sat, May 10, 2014 at 8:39 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Hi,
>
> Is there a trick to optimising a push by telling the receiver to pick up
> missing objects from some other repo on its own server, to cut down even
> more on network traffic?
>
> So, hypothetically,
>
>     git push user@host:repo1 --look-for-objects-in=repo2
>
> I'm aware of the alternates mechanism, but that makes the dependency on
> the other repo sort-of permanent.  I'm looking for a temporary
> dependence, just for the duration of the push.  Naturally, the objects
> should be brought into the target repo for that to happen, except that
> this would be doing more from disk and less from the network.
>
> My gut says this isn't possible, and I've searched enough to almost be
> sure, but before I give up, I wanted to ask.

My feeling is it is possible, assuming that the target sees and reuses
objects from repo2 already. Injecting an alternate repo at runtime
should be possible. We exclude objects from sending at commit level,
not object level. So after the initial exclusion, we may need to run
the to-be-sent objects against the alternate repo to skip some more,
but that should not cost much if repo2 is fully packed. The receiver
always does the connectivity test. So if you make a mistake and
specify repo3 instead, the receiver will reject the push and the
target repo won't be corrupted.
-- 
Duy
