From: =?UTF-8?Q?Jens_Lindstr=C3=B6m?= <jl@opera.com>
Subject: Re: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Sat, 24 May 2014 09:54:17 +0200
Message-ID: <CAEef6Wxg2QkWDzjuogh5sjjE=HZ9NRUmiY9AhExSXK7H3pAcNA@mail.gmail.com>
References: <537B2FA4.7020001@opera.com>
	<537B30E7.5020505@opera.com>
	<xmqqtx8kxn7f.fsf@gitster.dls.corp.google.com>
	<xmqqlhtwxkg9.fsf@gitster.dls.corp.google.com>
	<CAEef6WyXGXAdm_DkzNsuLgeFFpQsxvTiuJbK3ypc8-Cz2qD_KQ@mail.gmail.com>
	<xmqq38g0l8we.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 09:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo6md-0006y0-Ul
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 09:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbaEXHyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 May 2014 03:54:19 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:38401 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaEXHyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 May 2014 03:54:18 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so4833490lab.11
        for <git@vger.kernel.org>; Sat, 24 May 2014 00:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CCZZpJuGDu02kvC+V4Fr5xm9NTdgXbjVpE5+DDIOJqA=;
        b=aevmZjuQKVWvIrFmTkGQk5f353+TQSBwlbVYYvw/9jMZRZG1n4nt6UkSyMObTLHHwJ
         MB3mVjrrYhLELT/J8L+RAR22pCI3adYRewtRvZgIOESCWRqix9BSInHTDtsgO0OFAkRI
         O8wGRj9y3NU8lbdXkSrFcy9FOVeDh7S7ZXWi4ZwzWi1UVghixkOVaMpO/Z7OfO2+HMwb
         R+rosoovL1RxaJTrfFV+ry7xb0Iz3WbW1n1rAC/LCECDsSSVH8DOKiAz6Rkn36Eu2Fk2
         flgK/tFf2lbrXTtvA8+JXEDIox3i5oUpY2Gj9atOXRLh3BnZ0XvxjrI5ZGCH6Ae7YcHJ
         3DJw==
X-Gm-Message-State: ALoCoQnngQay6a+RfnqvFk2GF33EIzY80qXAeFzTgBYd+wvHpwefu6ePRU7jCtSCsQ469p1hCim6
X-Received: by 10.112.173.201 with SMTP id bm9mr6855057lbc.16.1400918057184;
 Sat, 24 May 2014 00:54:17 -0700 (PDT)
Received: by 10.112.106.102 with HTTP; Sat, 24 May 2014 00:54:17 -0700 (PDT)
In-Reply-To: <xmqq38g0l8we.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250058>

On Fri, May 23, 2014 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jens Lindstr=C3=B6m <jl@opera.com> writes:
>> One additional change was required in
>> builtin/remote.c:remove_branches().  It used to pass in the expected
>> SHA-1 of the ref to delete_ref(), which only works if the ref exists=
=2E
>> If repack_without_refs() is called first, most refs won't exist,...
>
> Why?  A ref, before you start pruning or removing a remote, could be
> in one of these three states.
>
>  (a) only loose refs/remotes/them/frotz exists
>  (b) both loose and packed refs/remotes/them/nitfol exist
>  (c) only packed refs/remotes/them/xyzzy exists
>
> And then you repack packed-refs file without these three refs.  When
> you do so, you know that you would need to remove frotz and nitfol,
> and also you know you do not want to call delete_ref for xyzzy, no?
>
> In other words, the problem you are describing in remove_branches(),
> that it wants to make sure that the ref-to-be-removed still points
> at the expected object, does not sound like it is doing anything
> inherently wrong---rather, it sounds like you didn't make necessary
> changes to the caller to make sure that you do not call delete_ref()
> on something you know you removed already.
>
> Puzzled....

There is one reason why one would want to call delete_ref() even if
the ref itself was already fully deleted by repack_without_refs()
(because it was only packed) and that is that delete_ref() also
removes the ref log, if there is one.  We could refactor the deletion
to

  1) repack_without_refs() on all refs
  2) delete_ref() on still existing (loose) refs
  3) delete_ref_log() on all refs

to let us only call delete_ref() on existing refs, and then keep the
current value check.

Personally I don't feel that we're solving an important problem here.
Making sure not to overwrite a ref that has been updated since we read
its value is of course of great value for 'receive-pack' and 'commit'
and such, but in this case we're removing a remote and all its
remote-tracking branches and configuration.  If a remote-tracking
branch is updated concurrently, the current value check would fail,
and the remote configuration and that one branch would remain.  But if
the update had happened just an instant earlier, just before we
started removing the remote, we would have happily deleted that
remote-tracking branch as well, throwing away whatever information the
update stored in it.

/ Jens
