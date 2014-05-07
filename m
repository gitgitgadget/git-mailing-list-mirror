From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH] add a reflog_exists and delete_reflog abstraction
Date: Wed, 7 May 2014 13:47:24 -0700
Message-ID: <CAL=YDW=dhNR3qy9mym9naS9QrHhghSZmoQ=2L1nA47CtmY90=g@mail.gmail.com>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
	<5368FE5E.7020009@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 07 22:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8kT-0001ym-PW
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaEGUrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:47:25 -0400
Received: from mail-ve0-f181.google.com ([209.85.128.181]:35417 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaEGUrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:47:25 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so2020821veb.26
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BO8zAdfT7H44bg7QxJYraN0tCr5P5xmeJvBqlDql0xI=;
        b=MO53jfBijV2729jI0YRtDyr0HUgO6jVx53issKKawrW3chiJxHBW8ysi9dwu/4g9ZT
         3PSy2oKo6BcoqgfWKiw6YfIUw8ZecMzIw7ShTiUElZcj78MPxIwSKrQbIMp/todsrt9J
         4UxZonCkUwgHJ+IGzDC08gI4Tx7hH/7KZI04BYmXU/naUK3lJ2gcCpTu9PqeQIeLz6Kf
         hbdYSSM7PXY8OkLg1qvu6GUea98SEanzX+YWTU5MnvbKP13xCALxM/fZrcXoOhV+73Hr
         fEOurv3XviJ0YGd/3uYU+BGFcae7SMfUmrj1xsBsJT6JhDQzC96sxxC5k3ceQ2Q+gVmR
         2GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BO8zAdfT7H44bg7QxJYraN0tCr5P5xmeJvBqlDql0xI=;
        b=AgGRpwnCw1yxkUboZ3joUWZZtt4pSfSsuPU+iQURRJuoKehz4FLL124kK2p3r651tc
         Cj30Fu6wTBtF/MgeWkxkj8CNK0npSQFs25g2thbstP2ayhZ9tjKAzt5M9Hb8f1LIiCZV
         YEvXmw9Uo5SZjiHk7KRJeCpU5uyF98XgCzTiJy7G6pq5Zgsu3lQwJAvb/EhLzwAZd5AP
         fcN/2fDZsk/8EmbhSgq4QnB4toSY4nsscOS89I0wVZqtreQcsGO3fknuLWW4EQX/Kq+g
         Q9HWCwjEHjgpZr71Mrp2y4oQqL/p9uDGr28n8vur2Ny6HE576/KO+GY06rhryZgyrf1P
         KKeg==
X-Gm-Message-State: ALoCoQlYY1ERsDNzdbQXNxEIZ4RVuInYVRxVW+oCnAEzY2fpU3GqhQe4fQLUJq4QLIbODG2nvUkn
X-Received: by 10.220.106.7 with SMTP id v7mr2699411vco.46.1399495644265; Wed,
 07 May 2014 13:47:24 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Wed, 7 May 2014 13:47:24 -0700 (PDT)
In-Reply-To: <5368FE5E.7020009@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248367>

On Tue, May 6, 2014 at 8:23 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/06/2014 12:57 AM, Ronnie Sahlberg wrote:
>> This is a single patch that adds two new functions to try to hide the reflog
>> implementation details from the callers in checkout.c and reflog.c.
>> It adds new functions to test if a reflog exists and to delete it, thus
>> allowing checkout.c to perform this if-test-then-delete operation without
>> having to know the internal implementation of reflogs (i.e. that they are files
>> that live unde r.git/logs)
>>
>> It also changes checkout.c to use ref_exists when checking for whether a ref
>> exists or not instead of checking if the loose ref file exists or not.
>> Using ref_exists instead both hides the reflog implementation details from
>> checkout.c as well as making the code more robust against future changes.
>> It currently has a hard assumption that the loose ref file must exist at this
>> stage or else it would end up deleting the reflog which is true today, as far
>> as I can tell, but would break if git would change such that we could have
>> a branch checked out without having a loose ref file for that branch.
>
> For single patches, people usually don't send a separate cover letter.
> Any comments that you want to make that are not suitable for the commit
> message can go between the "---" line and the diffstat of the patch email.
>
> Regarding this change, I think before too long we will also need an API
> to turn reflogs on for a reference.  We might want to add a flag to ref
> transaction entries that cause the reflog to be created if it doesn't
> already exist.  Reflogs can currently be created for a reference via the
> config setting "core.logAllRefUpdates" or (for branches) by "git branch
> --create-reflog" (maybe there are others).

Yes. I agree.

I think we need a flag to ref_transaction_create and ref_transaction_update to
create a new reflog.

Then I also think we need to add a new transaction command,
ref_transaction_reflog() that can be used to either append or overwrite the
reflog.  Builtin/reflog.c will need an API to create/overwrite the reflog
with new text.

And finally we also need an api to create symrefs.
ref_transaction_symref() or something.


But this will wait until my current patch series is merged.

>
> Several tests in the test suite currently create reflog files by hand.
> Thus we might also need a way to create reflogs at the command line by
> the time we implement pluggable reference backends.

I can add this once we have an api.

>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
