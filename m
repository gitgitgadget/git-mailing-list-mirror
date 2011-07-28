From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH/WIP 4/7] fast-import: fix data corruption in store_tree
Date: Thu, 28 Jul 2011 14:11:47 +0600
Message-ID: <CA+gfSn-62W8TPjaKkSZCbWmxaeNnk_KSWJ-1=x106hGk5cEw=w@mail.gmail.com>
References: <1311828370-30477-1-git-send-email-divanorama@gmail.com>
	<1311828370-30477-5-git-send-email-divanorama@gmail.com>
	<20110728074239.GA5980@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 10:11:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmLhD-00073x-P3
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 10:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab1G1ILu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 04:11:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55063 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab1G1ILs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 04:11:48 -0400
Received: by mail-qy0-f181.google.com with SMTP id 9so1396082qyk.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qI2/pJGqazSy50Als0dW0EDjh1KlE5vWAd+YWeVgi+U=;
        b=DROdmpii/azpx7UcSRvD2vxTlhzvpcPHnV7UCpIHZDWa3cdcSnB6HtnUkiyzvvEVjt
         hRPnECe8Z9uGUPAW8L0VWQwfL7IyIofKcpcxY7C+O2i8HrLjhiQunqQ9aXWAF+X3H6vI
         W1W3fm5aOUNcLNmJwj0dZXTwt+qXRcqn9XJQI=
Received: by 10.229.43.161 with SMTP id w33mr608681qce.112.1311840707701; Thu,
 28 Jul 2011 01:11:47 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Thu, 28 Jul 2011 01:11:47 -0700 (PDT)
In-Reply-To: <20110728074239.GA5980@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178047>

On Thu, Jul 28, 2011 at 1:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Dmitry Ivankov wrote:
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1474,8 +1474,11 @@ static void store_tree(struct tree_entry *roo=
t)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < t->entry_count; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (t->entries[i]->tree)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_tree(t->entries[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!S_ISDIR(t->entries[i]->versions[1].mo=
de))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!t->entries[i]->tree)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 load_tree(t->entries[i]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 store_tree(t->entries[i]);
>
> How can this load_tree call work if t->entries[i]->versions[1].sha1
> is not already in the object database?
Well, it can be in the database and at the same time
t->entries[i]->tree =3D=3D NULL.
In my testcase the commit is like

ls :10386 trunk
M 040000 e1b2ea9d3634cb7914044425ffae91945c41ac6a branches/cygnus
D branches/cygnus/gcc/assert.h
D branches/cygnus/gcc/collect2.c
D branches/cygnus/gcc/cccp.c
D branches/cygnus/gcc/c-parse.gperf
=2E..
only D branches/cygnus/gcc/..... lines
progress done #here we call it, so it's when we store whole tree, some
subdirectory of branches/cygnus

the load_tree really gets called (with whole series applied to
fast-import) and the load works (sha1 =3D
2e90a035614854f626bb35eeac517f41ac84da27)
Though I don't yet see if not loading it breaks anything in my test
(with the whole series).
