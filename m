From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/7] diff_tree(): Skip skip_uninteresting() when all
 remaining paths interesting
Date: Wed, 25 Aug 2010 17:57:06 -0600
Message-ID: <AANLkTi=Z0nZ7dPqZisPkbpGUBvoFbu9UVxkMq0hucGGg@mail.gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
	<1282704795-29661-6-git-send-email-newren@gmail.com>
	<7v1v9mp95o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 01:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoPqE-0007z4-7o
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab0HYX5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 19:57:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45929 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab0HYX5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 19:57:07 -0400
Received: by fxm13 with SMTP id 13so828498fxm.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8LV/3QJnzI7B5ue0DSV+l5/tSQ/ny4z7Fe/CYmGcw6g=;
        b=F8sMvtzlfVd/TZ/fMRPSWK7xPtSuNYTtK/y4jtDTtDgDxwCJPIQC4RLn4iwNd2epVw
         mz7Z1glZiSEw9t7jITm9JEf+7OIyBRYwSTDet/GwPgK029xN2Htd7P51oKt7gbtNJcWm
         OXvEpa4+qKFKyVKxBADsF+IvJGFkvTJi47dR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XoktPNqCAa0ebvOQCcGBQ7xcsvQ2UirDIKOnPdFllQDuFPpnxSUHxJBx/+1dZZcFOR
         9BLy7ZFWKJV1d0jNyxI+OorONmpgz/Wv/QWlXfnTmLJLiqLsT5fdgqA+74UBO8dYoP3i
         eS8O9JTctTTUm36bw4rau9XqMW254QlaP0ARc=
Received: by 10.223.126.68 with SMTP id b4mr8434961fas.96.1282780626718; Wed,
 25 Aug 2010 16:57:06 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 25 Aug 2010 16:57:06 -0700 (PDT)
In-Reply-To: <7v1v9mp95o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154497>

On Wed, Aug 25, 2010 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> This and the previous patch seem to make sense to me, independent of =
the
> rest.

Thanks.

> As to mixing pathspecs with --objects, I would say it is unfair to Li=
nus
> to call it a bug that that particular use case has not been supported=
=2E =C2=A0I'd
> say it _is_ a bug that we didn't error out when --objects was given w=
ith
> pathspec at the command line level, though, as that is a combination =
we
> knowingly ignored to support.
>
> It simply hasn't been deemed as a sane operation to produce a pack us=
ing
> an output from rev-list with pathspec and --objects, as it will leave=
 some
> trees and blobs that the pack knows about in the result, without actu=
ally
> having them in it. =C2=A0In the context of "narrow clone", these woun=
ds to
> trees are deliberate, and the existence of these wounds alone is not =
the
> reason why I called it insane to produce such a pack.
>
> To make use of such a pack, however, you need to somehow cauterize th=
ese
> deliberate wounds in trees so that fsck, a later run of pack-objects,
> fetch-pack and friends will not choke on them. =C2=A0We didn't plan t=
o have
> such an infrastructure so far, and that is what made such a pack with
> thousands of cuts "insane". =C2=A0As soon as "narrow clone" addresses=
 that
> issue, mixture of pathspecs with --objects stops being an insane use
> case.

Well, I did call it a minor bug, because I figured no one was using it
and so it wasn't hurting anyone.  But saying you knowingly ignored
supporting it is understandable.

I understand that for this combination of options to be useful, all
the other stuff you mention needs to be done.  Duy and I are both
working on separate ways of doing that; I just figured it made sense
to submit any independent pieces early and separately.  I don't think
supporting this would hurt anyone, as I don't think anyone could
accidentally use it at this point.  However, if you'd prefer that I
submitted a patch to just error out with this combination of options
for now, and resubmit this patch later with a full sparse clone
patchset, I can do that.  (Note though that my fix for supporting both
--objects and pathspec isn't correct; there's a bug I'm looking in
to.)
