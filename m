From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/16] revert_or_cherry_pick(): get oneline_body from
 get_oneline()
Date: Wed, 17 Mar 2010 22:16:38 -0500
Message-ID: <20100318031638.GA18193@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
 <20100317121546.GK25641@progeny.tock>
 <780e0a6b1003171309k75b33d3cpb4b1c6370d67942f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 04:16:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns6Db-0006b0-7y
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 04:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0CRDQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 23:16:13 -0400
Received: from mail-yw0-f201.google.com ([209.85.211.201]:50896 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab0CRDQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 23:16:12 -0400
Received: by ywh39 with SMTP id 39so779895ywh.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M4drtkAuKPILx5SjfomBpUvy2PoCv+7mFQRtVG0RriI=;
        b=BOfU6fKxp3cFngtPQFgEiej/GtxkOkuhPUU6UpUjMOqBrJVSyjXTlMls68MaQfW028
         LNEDp66aXb6ooOvfYUnODzlnAw2Cwi4US4uZFCfshakxMvhITLcf4BQUgGbHCRW0/X9K
         RxskxRDF250eYdqClpVOWPpIVmUgN+kMdfY+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UycXU9Fj1fpOEuBA4e+/OxA6OVqcjNdgzAMa1T5h76Bp7MYgvAo/Rs52229pSz82oP
         uMomDEHDEcDiNgA07hZ5cMR24LoxQlHwufDMs9bRx0K03683YkgD67ApcOLh/XomgXZ+
         zckvLeIOetvLTpSaqEpmYSg2WU6N9gj8YRUaA=
Received: by 10.101.108.5 with SMTP id k5mr2795278anm.122.1268882170018;
        Wed, 17 Mar 2010 20:16:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm7112578iwn.9.2010.03.17.20.16.08
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 20:16:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <780e0a6b1003171309k75b33d3cpb4b1c6370d67942f@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142447>

Stephen Boyd wrote:

> Could all this code just use the custom format printing routines in
> pretty.c? It might not be super efficient but at least it wouldn't
> duplicate a bunch of code.

I like this idea, but I wasn=E2=80=99t able to pull it off.  You see,
cmd_revert() uses a few substrings from a single string it generates:

 parent of ca87ef9... Do something very imporant
 ^         ^          ^
 1         2          3

These are put together like so:

=46or the commit message:

 Subject: Revert "[3]Do something very important"

 This reverts commit ca87ef90000000000000000000000000000000000.

=46or the conflict markers:

 <<<<<<< HEAD
 Version from the tip of the current branch.
 ||||||| [2]ca87ef9... Do something very important
 Version from the commit to be reverted.
 =3D=3D=3D=3D=3D=3D=3D
 Version from the parent of the commit to be reverted.
 >>>>>>> [1]parent of ca87ef9... Do something very important

Nevertheless, investigating it did spur me to simplify this part of the
series a little.  I think the following two patches could replace
patches 11, 13, 14, and 15 from this thread.  I do not want to do any
drastic refactoring without libifying this code, though, and that shoul=
d
wait for another series, I think.

Thanks for the feedback.

Jonathan Nieder (2):
  revert: clarify label on conflict hunks
  cherry-pick, revert: add a label for ancestor

 builtin/revert.c                |  129 +++++++++++++++++++++++--------=
--------
 t/t3507-cherry-pick-conflict.sh |    8 +-
 2 files changed, 80 insertions(+), 57 deletions(-)
