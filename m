From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 00/26] Clean up update-refs --stdin and implement ref_transaction
Date: Mon, 10 Mar 2014 13:44:28 -0400
Message-ID: <531DF9FC.4070707@kitware.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4F0-0002Uk-GH
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbaCJRnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:43:50 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:54864 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752246AbaCJRnt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 13:43:49 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]) (using TLSv1) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUx3508khAt5UTqQg6XYVyjSX/BnA5oON@postini.com; Mon, 10 Mar 2014 10:43:49 PDT
Received: by mail-ig0-f175.google.com with SMTP id ur14so8844044igb.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 10:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9vWKROUhJNIs0EbpNaf2ccMCJVbk7T37aljO/aDmgNs=;
        b=ekLoJAocFFexRAGUHckVru87bMQJZgtO4CVOTsCIyqFlk1GS8aceu32DCuxXcia6RB
         TRGmuJ3RLD+uO3da8acna2F3s9EWB+8eIMVEJRddyNzfA2bStFN5Hfo8hflrXzLo5ztR
         /Iw0N5ozsko3za4zBWp8krUFdyMr4XmICtyKk95Syb8ch8SntnK94EnHc2TJYkap/DiA
         W4X+RJ1SllI1PvMKNti+l0Bk5l0+EW/yNGuOKNMB85d8DoZ5r7iP8Vo8SsQJokOTtzGZ
         tIinUoelKPajX5j1rDYVVBhXTt2aRNxSTujxzrt7IARfymvCyrvX2d9nG06TWecHE5fB
         CYOQ==
X-Gm-Message-State: ALoCoQl2/i1DRVw3wbnC4rt5BtKgsoOHuTAMpX74neuh4h77V0zl9yP6o8Cw7BS//ak7CVPUw5Ya2q6aQ6yRPYpC0fYBDhVH0BnmDkWVjUETrl5XJlsUk2+N5yi34IPTFJvIIXbsy8zUZ6WrVA/D4g9JvSCQH7DvPA==
X-Received: by 10.50.171.169 with SMTP id av9mr19137267igc.14.1394473426844;
        Mon, 10 Mar 2014 10:43:46 -0700 (PDT)
X-Received: by 10.50.171.169 with SMTP id av9mr19137257igc.14.1394473426737;
        Mon, 10 Mar 2014 10:43:46 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id v5sm39779861igb.0.2014.03.10.10.43.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 10:43:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243779>

Hi Michael,

This is excellent work.

I haven't reviewed every line of logic in detail but the changes
look correct at a high level.  The only exception is that the empty
<newvalue> is supposed to be accepted and treated as zero even in
"--stdin -z" mode.  See my response to that individual change.

On 03/10/2014 08:46 AM, Michael Haggerty wrote:
> The new API for dealing with reference transactions is
> 
>     ref_transaction *transaction = create_ref_transaction();
>     queue_create_ref(transaction, refname, new_sha1, ...);
>     queue_update_ref(transaction, refname, new_sha1, old_sha1, ...);
>     queue_delete_ref(transaction, refname, old_sha1, ...);
>     ...
>     if (commit_ref_transaction(transaction, msg, ...))
>         die(...);

The layout of this API looks good.

The name "queue" is not fully representative of the current behavior.
It implies that the order is meaningful but we currently allow at most
one update to a ref and sort them by refname.  Does your follow-up work
define behavior for multiple updates to one ref?  Can it collapse them
into a single update after checking internal consistency of the sequence?

> So most of the commits in this series are actually cleanups in
> builtin/update-ref.c.  I also spend some time making the error
> messages emitted by that command more uniform.

All good cleanups, thanks.

> Finally, now that refs.c owns the data structures for dealing with
> transactions, it is possible to make a few simplifications.

Yes, it is much nicer to keep the data structures private, especially
as it avoids the copy of the transaction made before sorting.

Thanks,
-Brad
