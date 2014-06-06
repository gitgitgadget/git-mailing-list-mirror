From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] receive-pack: optionally deny case clone refs
Date: Thu, 05 Jun 2014 23:01:15 -0400
Organization: Twitter
Message-ID: <1402023675.18134.192.camel@stross>
References: <1402015954-5320-1-git-send-email-dturner@twitter.com>
	 <CACsJy8ALeYR1+5ox2GE2Rz3TRM5wqd9fxSCAnHoabo9fmuSdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 05:02:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WskPD-0004WI-5c
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 05:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbaFFDBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 23:01:19 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:45227 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbaFFDBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 23:01:18 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so3191671qge.26
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 20:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=RDlECfZw4KbxP7+7UFTo6E6y3nfwSdi7Gr0jcs0qTd0=;
        b=aVh1t077CGaJjJYBRbiUv12OgCQrb6GkBDDqhDVJSVg2B+wylYlN3HGS9aaZ7tiDN1
         jDny67+S0BI6BVE1EnpqdnxZzf6FSXmwZLx+apExchyVjKzwQGuhI7rBxdlNU0xcKumK
         ciyC934fhVf4/gp/Q8dRLxVa/1i7mm3opV8ZbQOlOlAhG+tFiXBhOsWGOnjUSBxL6hKV
         9Rnet+uKZv6e2V6R5hUHXxUhGSUjIhSPGC62k5JGlaZLb20AitBe4uL8MixIURI7tije
         KhDDvIO/F1syyoLZhCHzwhHU1wAIdwbJLFIQVVBImSTzPXz6/DWs/dUIYHI9Flnttvp+
         DzXA==
X-Gm-Message-State: ALoCoQkDJ7WSh1jOikx/d86UsElFnDWIHf1/du4JvpmB00oVweInW8itBuU7ZlKb1TzquMMpdNSO
X-Received: by 10.224.24.134 with SMTP id v6mr3309777qab.88.1402023677752;
        Thu, 05 Jun 2014 20:01:17 -0700 (PDT)
Received: from [172.17.3.196] ([38.104.173.198])
        by mx.google.com with ESMTPSA id z8sm12558234qar.49.2014.06.05.20.01.16
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 20:01:16 -0700 (PDT)
In-Reply-To: <CACsJy8ALeYR1+5ox2GE2Rz3TRM5wqd9fxSCAnHoabo9fmuSdXQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250887>

On Fri, 2014-06-06 at 08:37 +0700, Duy Nguyen wrote:
> On Fri, Jun 6, 2014 at 7:52 AM, David Turner <dturner@twopensource.com> wrote:
> > Create the option receive.denycaseclonerefs, which checks pushed
> > refs to ensure that they are not case clones of an existing
> > ref.  This setting is turned on by default if core.ignorecase is
> > set, but not otherwise.
> 
> Just thinking out loud as I haven't had time to read this patch
> carefully, but I wonder if there's a potential performance problem
> with ref_is_denied_case_clone(). What if the receiver repo has 60k
> refs? Should we use name-hash (or a variant of it)? What if the sender
> pushes 60k refs in one go, will ref_is_denied_case_clone check against
> existing refs only, or it will cover more and more refs from the 60k
> input?

Good news!  The sender can't push 60k refs in one go because that would
require a command-line bigger than ARG_MAX.  (Well, OK, this is not
really good news, since of course someone could hack around this, and
since this is minor bug in git that we should probably fix).

I guess this does present a bit of a DOS attack.  When I discussed the
previous version of this patch with Junio, I did not think it was a huge
problem, since the the ordinary number of refs pushed is small.  But
when I think of it as a DOS, it sounds much worse.

I don't like the idea of creating a hashmap just for this, because
really we need to be storing packed refs in an better on-disk format --
one that allows O(log n) or better access (as has been discussed).  

I'll give this some more thought and see if I can come up with a better
solution.
