From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 22:02:02 -0600
Message-ID: <51419b2c0903252102v71de617aiffad2d4934d4d07f@mail.gmail.com>
References: <1238014519-11683-1-git-send-email-newren@gmail.com>
	 <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
	 <7vy6utt0op.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmgod-0002S9-BO
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZCZECJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbZCZECI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:02:08 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:13690 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbZCZECF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:02:05 -0400
Received: by yx-out-2324.google.com with SMTP id 31so347657yxl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PY1UHRtxaU0ulwDQA3ZMCZcmmRm4H0n7oNnFIx0S0Z8=;
        b=e7bLTZkDJYKfmuU+P4VujhiDd5WZygYv7Zy3Cvm2FF2+SGkUyAD+kfNUN82HYGwChj
         0f7YJYs6w58ijXc1DUnjI07kxUzX/qYSCNeLsaYr5pOlFbcMLPfrT6eFAfqEUly8WqjY
         NzQIdR+Ia2eYbHNC4x3vf+04u7u71+XA2WGXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OPDYtt+H+bfmx6Qscxhz7k8go+UnQ3pCEQIE3rrW6baukg4ubMhW4b8iPd1soh6KZu
         8MjgOcH4flXKnWYUuytWlKaW3sklWsHNeu8NTyKEqeiM6waNbOcojqEZ9dEy/3CB8sfZ
         KdAy04y//XR5z49lKN9xM+bEJxCVTpcah5Yd4=
Received: by 10.231.14.72 with SMTP id f8mr88106iba.34.1238040122923; Wed, 25 
	Mar 2009 21:02:02 -0700 (PDT)
In-Reply-To: <7vy6utt0op.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114721>

Hi,

On Wed, Mar 25, 2009 at 9:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, does it?
>
> Shouldn't an export with a bottom commit be always considered an
> incremental?  Why special case --import-marks?
>
> When you say "I want to export master~2..master", isn't the intention
> (unstated, because it is too obvious) that follows it "... because I do
> have master~2 already and I would want to replay the export on top of that
> state"?  If all of master~2, master~1 and master have a file "frotz" with
> exactly the same contents, I thought you wouldn't even have to have that
> same contents repeated in the export datastream.

No, without the --import-marks it doesn't make sense to make it an
incremental.  Think of it this way: git-fast-export converts all
sha1's into integer identifiers (marks).  When you export
master~2..master, then when fast-export comes across master~1, it
notices that there's nothing to convert it's parent sha1sum into since
no information was output for master~2 in the export stream.  The way
around it would be to simply export master~2 anyway, and master~3,
and...
(An alternate way around it, I guess, would be using the sha1sum in
the export stream instead of a mark...but do you have any way of
knowing whether the destination repository you import into will have
that commit?  Using --import-marks seems like a nice way to specify
whether you have that information or not.)

It's perhaps a gotcha, as I know I had the same initial assumption
even after reading the manpage.  Perhaps
Documentation/git-fast-export.txt could be made a bit clearer on this
point.

> Or am I (again) entirely misunderstanding the intended use case?

Exporting master~2..master without specifying --import-marks is a way
of squashing history, essentially.  Perhaps you don't like it serving
this purpose, but it was intentional; looking at the master~2..master
testcase in t/t9301-fast-export.sh, you'll see

   git fast-export master~2..master | sed "s/master/partial/" |
   <snip some other boilerplate> &&  test_must_fail git rev-parse partial~2
