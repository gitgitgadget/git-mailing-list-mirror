From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 1 Apr 2015 17:01:33 +0700
Message-ID: <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
 <551B5E64.9070906@ubuntu.com> <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 12:02:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdFTO-0005mu-56
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 12:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbbDAKCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 06:02:06 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35571 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbbDAKCE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 06:02:04 -0400
Received: by igcau2 with SMTP id au2so43226762igc.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cFbl1IVaKA8eRDprPbv+PDB2SMR4n4Eh/fiYWMbeu6c=;
        b=ezFtjTomPeWDxZ7dClp5x56/gqcLM2PW1ChX9pzABQfq1b8nqZ713vQIrIeINySFjW
         TH4kq90vL68rYDXAirCkMjQMPkm3CNZVxJ9vZlevmwTd2cS/TRNFV7K4buwYsbEpFRzd
         EkPkefDYQ7CgDwYw1o8xEHTw9Uru91uya0zk9yKBB0PqT/gwVAkA0bFesccixIgmxQzw
         qu5nEPqJaVV2sBgypjhIVSaBUeTr5DVx2IZ4g0SxFzg3jRcBFIvr1fxBvEztyfT4TZhV
         D3LpeSrgns9mbaV4lz1fRXkEmGj5OEO6gSbBEk6Ajn9hDgSrmP/zlKGIbOme5QA4EY1S
         iLmQ==
X-Received: by 10.107.130.145 with SMTP id m17mr9295593ioi.89.1427882523918;
 Wed, 01 Apr 2015 03:02:03 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 03:01:33 -0700 (PDT)
In-Reply-To: <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266599>

On Wed, Apr 1, 2015 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The only way a bundle can record "something" "noting" that it is an
> incomplete history, while allowing it to be read by existing
> implementations of "git bundle unbundle" is to list the commits,
> behind which there is no history available in the bundle, as
> bundle's pre-requisites.  I said that the addition of shallow repository
> support did not enhance "git bundle create" to do so, and you are
> saying "it just needs to put", implying that it currently does not.

Alternatively, we can record SHA-1 in the shallow file as refs whose
name is always ".shallow". This way "unbundle" can recreate the
shallow file if it wants. Having this "remote" shallow file would fit
well in our fetch pipeline. It's harder to recreate shallow file if we
record prerequisite instead: if commit A is in the shallow file, the
ones in prerequisite category would be A's parents. So we would need
to go over the bundle to look for commits whose parents are all in
prerequisite list. It takes more time.

> Now, the only way the existing implementations of "git bundle
> unbundle" can extract from such a bundle with prerequisites is to
> unbundle into a repository that satisifies the prerequisites (these
> incomplete bundle files are designed as a medium for sneaker-net
> incremental updates).  I however suspect "git clone --shallow" from
> such a bundle _might_ work (I never tried it), but I wouldn't be
> surprised if the existing implementations of bundle unpacking code
> refused to unbundle into a repository that lacks prerequiste commits
> (i.e. making the repository a shallow-clone).
-- 
Duy
