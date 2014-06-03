From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 36/41] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 3 Jun 2014 11:33:14 -0700
Message-ID: <CAL=YDWkFt6cfHUyTtxYAhd=PU=5FYfh0kULRKGifAH3q0+wjOA@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-37-git-send-email-sahlberg@google.com>
	<20140530181242.GJ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrtWX-0001dQ-1q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933760AbaFCSdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 14:33:17 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:36824 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933717AbaFCSdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 14:33:16 -0400
Received: by mail-vc0-f169.google.com with SMTP id il7so3644458vcb.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 11:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=48OgVLc2UerexSYd8xqHx0+AVVhizFvj3rtgo9JKtBY=;
        b=KSjaytDKLZmsxgkB4L8UejuZ7IsUlnyIwe/39oZPt0uzeCJhtCbfGbyqfZyvaaYmfS
         r+qfUuQ58FhEN2Bz5zi1EuJ+VQw8gNDncnXeremQNYe/U4K2POjDwbh5CxW3r6M/IQs+
         dpnN8VlZhd7vO9J3Z7g+jWKRVZKPwJjFmWFATGyYbghAm3rVkBY9CSdCyIGI0NkXWgun
         tOw+TerDc7J8iFQRvTjevuSyL99hiAdb4vdm8pbHNjSZQ/BqICIFRkQI9rfQex4ezCrE
         Y9NKPSJKce76uRZf8SX9RyyHXh3T7BJ2qwXXJBE7xHcJSIqUz61Ie0e3d30aStIVtQuR
         tCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=48OgVLc2UerexSYd8xqHx0+AVVhizFvj3rtgo9JKtBY=;
        b=e9A5YNsxLmgzL3wR74yHae8C0KPyucPXGjZU/hYfvkL08Mbd1OeEj9VGvdnSQE3pAs
         rO4gclINvP8Y6AyYqbmYhdCXHcmuWPYPksdoZ3N7EclqKgBtqpX+8pTGOLne9JiAUian
         q5cNbKSoFoytAx4t7ssiuQVSktmGEBme07xo6HB45FdhxmEzvbgRx0Tq6pF3ScCVDCaw
         WDc/C1pUpkNn11jXnpy8p4B3OHISiT+wd05YoHTvj+1ky8a7Q7PSzvBK0s5EVh59d6Kc
         hYeHJDC5w03Zh0vXk+AY++66rVMSX/1vf2+tTyPjPKg1XTNB6cIF8k9UlSnwhdT7y79Q
         Tqzw==
X-Gm-Message-State: ALoCoQlQq7p3sjGJ2tbLT63cF8d+aVRj/THBce7IwKr8zaufkfI9ptBIw3FU1A6frd5Zw0pUwY27
X-Received: by 10.58.132.41 with SMTP id or9mr26110440veb.5.1401820395069;
 Tue, 03 Jun 2014 11:33:15 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 11:33:14 -0700 (PDT)
In-Reply-To: <20140530181242.GJ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250639>

On Fri, May 30, 2014 at 11:12 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Move the check for check_refname_format from lock_any_ref_for_update
>> to lock_ref_sha1_basic. At some later stage we will get rid of
>> lock_any_ref_for_update completely.
>
> Do you know if this will cause any functional change?
>
> What is the potential impact?  Is that impact worth it?  (Given how
> broken the recovery codepaths currently are, I suspect this change is
> worth it, but it seems worth documenting in the log message.)

Thanks.

Updated the commit message to mention this.

  This changes semantics for lock_ref_sha1_basic slightly. With this change
  it is no longer possible to open a ref that has a badly name which breaks
  any codepaths that tries to open and repair badly named refs. The normal refs
  API should not allow neither creating nor accessing refs with invalid names.
  If we need such recovery code we could add it as an option to git
fsck and have
  git fsck be the only sanctioned way of bypassing the normal API and checks.

>
> Thanks,
> Jonathan
