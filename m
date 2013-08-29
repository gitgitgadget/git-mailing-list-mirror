From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] upload-pack: delegate rev walking in shallow fetch to pack-objects
Date: Thu, 29 Aug 2013 16:48:56 +0700
Message-ID: <CACsJy8BMQ=k_W12OhJH8Pod6g-eynVOuTULauBqeERbT1uXdSA@mail.gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com> <1376646727-22318-4-git-send-email-pclouds@gmail.com>
 <20130828145225.GE10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 11:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEyr5-0001wV-Rn
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 11:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab3H2Jt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 05:49:28 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:48005 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530Ab3H2Jt1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 05:49:27 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so189727oag.28
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=HIhMBXyNYpQt5U8xGYFNsdVdWqBx9v+j5X1uekDJVm8=;
        b=C99n6BBxOFie9tqshZflvBGcueazF2SzQDDbGC9i3oP46mX96dm2opTh7IgxH83JDs
         yhCQ0xG6W73/XGzMfXcaWG0xwt7sLzQilvifdnQBaTr77Zx9hsWUa4SUL3n4b6v4XD5G
         0Vb/Ux+TlPmv5MY9iUGLKe0R3RBRSOoIewpxmJTgDKTbNZprxqIewOVyuBlfSmFXXR1i
         ZAOlNe74u7xTDW8sSiG6ibWH/qHPD1vFRTz69iUPAb/3DjgqIUG1BBDVQMVynOz33yco
         gGzzHvPnbW2ErpzXF/z2dFNGs0Jr6NF5tpf5x6KRzN8S/9yGIyxZrI/mMT1wQvufp4tR
         18GA==
X-Received: by 10.182.119.229 with SMTP id kx5mr1813856obb.23.1377769766445;
 Thu, 29 Aug 2013 02:49:26 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Thu, 29 Aug 2013 02:48:56 -0700 (PDT)
In-Reply-To: <20130828145225.GE10217@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233246>

On Wed, Aug 28, 2013 at 9:52 PM, Matthijs Kooijman <matthijs@stdin.nl> =
wrote:
> Hi Nguy,
>
> On Fri, Aug 16, 2013 at 04:52:05PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> upload-pack has a special rev walking code for shallow recipients. I=
t
>> works almost like the similar code in pack-objects except:
>>
>> 1. in upload-pack, graft points could be added for deepening
>>
>> 2. also when the repository is deepened, the shallow point will be
>>    moved further away from the tip, but the old shallow point will b=
e
>>    marked as edge to produce more efficient packs. See 6523078 (make
>>    shallow repository deepening more network efficient - 2009-09-03)
>>
>> pass the file to pack-objects via --shallow-file. This will override
>> $GIT_DIR/shallow and give pack-objects the exact repository shape th=
at
>> upload-pack has.
>>
>> mark edge commits by revision command arguments. Even if old shallow
>> points are passed as "--not" revisions as in this patch, they will n=
ot
>> be picked up by mark_edges_uninteresting() because this function loo=
ks
>> up to parents for edges, while in this case the edge is the children=
,
>> in the opposite direction. This will be fixed in the next patch when
>> all given uninteresting commits are marked as edges.
> This says "the next patch" but it really refers to 6/6, not 5/6. Patc=
h
> 6/6 has the same problem (it says "previous patch"). Perhaps patches =
4
> and 5 should just be swapped?

Yeah. I guess I reordered the patches before sending out and forgot
that the commit message needs a special order. Wil do.
--=20
Duy
