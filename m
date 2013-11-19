From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Tue, 19 Nov 2013 23:02:58 +0530
Message-ID: <CALkWK0nKGp4XdJX1Dds-Y+4o2eRXp8XH3qpqU8MNfTG+UdwACA@mail.gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
 <1384796353-18701-7-git-send-email-artagnon@gmail.com> <xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
 <CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com> <xmqqiovo9x2r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 18:33:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VipBM-0008J6-6s
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 18:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab3KSRdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 12:33:42 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:45238 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab3KSRdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 12:33:39 -0500
Received: by mail-ie0-f169.google.com with SMTP id e14so5004735iej.28
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MjKx+7QG2SvB6EkWRtAKVUboevbz5kA8APMhnL+XSPU=;
        b=YSCuXHf30UdsuVW7Z7leOdvfxQGeEwCcKFfL5n/zanXWm7mnwb6thlboUTG5t0wLm4
         B+3Z15Pok22xdfMO2Lox/y/p7o0/YpSGrGNQn+cIVxeEQBDpBWMdpaAXk8ctJ2g/gF+N
         h5W5OlKtt8+NTjOPZYr5IhzFHVEIszVsPzCSPsA8TBEhHQgSxST8Tbmr0jdrHhnr8mdQ
         G4HUYCFnTRtuZllclZvLAEwOaaxtFp7c+dVI34vKrhe6Ob2S08SezY9KcWHbVcVf7OVi
         7seWiPN9vGd08Ss2x2Xgo5LnVAP2OPzJ4KNe2K8Xzg45YorVRDO/nprpkHHqjw4BY4dh
         qpmg==
X-Received: by 10.43.129.130 with SMTP id hi2mr2018132icc.14.1384882418854;
 Tue, 19 Nov 2013 09:33:38 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Tue, 19 Nov 2013 09:32:58 -0800 (PST)
In-Reply-To: <xmqqiovo9x2r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238034>

Junio C Hamano wrote:
> My knee-jerk "adding it to struct refinfo" is not correct, either,
> because what we want to know, i.e. "do we need an extra reset?" is
> not a property for each ref.  It is similar to "what is the set of
> atoms the format string is using?" and "do we need to peel tags in
> order to show all information asked by the format string?"
> (i.e. used_atom[] and need_tagged, respectively).

It's mostly cruft carried over from my reset-color-after-each-token
implementation. My severe distaste for global variables prevented me
from looking for the simpler solution.

> Unlike need_tagged which asks "is there any *refname that asks us to
> peel tags?", however, "is the _last_ color:anything in the format
> string not 'reset'?" depends on the order of appearance of atoms in
> the format string, so this needs to be done in a loop that scans the
> format string from left to right once at the very beginning, and we
> have a perfect place to do so in verify_format().

I should be shot for my laziness and lack of ingenuity. Yeah,
verify_format() is a much better place to put the logic than
populate_value().

> So perhaps like this one on top?
>
>  builtin/for-each-ref.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 04e35ba..5ff51d1 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c

Thanks for taking the time to do this. And apologies for the laziness.
