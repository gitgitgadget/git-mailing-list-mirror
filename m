From: neubyr <neubyr@gmail.com>
Subject: Re: git repository size / compression
Date: Fri, 9 Sep 2011 09:04:07 -0500
Message-ID: <CALFxCvxmPN_O_3xpkrGUYtdkVfz5nr7eaucMrAYQ3uvi820FBg@mail.gmail.com>
References: <CALFxCvzVjC+u=RDkDCQp0QqPETsv8ROE8tY=37tmMWxmQoJOEw@mail.gmail.com>
	<1315556595.2019.11.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:04:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R21gr-0001LL-OZ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758836Ab1IIOEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 10:04:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50462 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756640Ab1IIOEJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 10:04:09 -0400
Received: by wyh22 with SMTP id 22so1600543wyh.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 07:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=154Yn3fatKUu9rgProjAvrnvx00BF28Q8+jcTodVBp0=;
        b=l+3++o2yF8e4gf3pdcQotILvJiifb1jmkeXqCX7TSYTfxEmGf8vB6O3gnhwdu3N+Lt
         04Y/JBofavY+Y71remgpsg7UZRZ54vq9tZV5anSbXvd+lDWW7psUa6Bl+quVGoXp4WIQ
         t9BkGqTVZPZezGiefBi/snfvQC6NOTe/Hdiuc=
Received: by 10.227.202.70 with SMTP id fd6mr2018786wbb.114.1315577047886;
 Fri, 09 Sep 2011 07:04:07 -0700 (PDT)
Received: by 10.227.145.210 with HTTP; Fri, 9 Sep 2011 07:04:07 -0700 (PDT)
In-Reply-To: <1315556595.2019.11.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181068>

On Fri, Sep 9, 2011 at 3:23 AM, Carlos Mart=EDn Nieto <cmn@elego.de> wr=
ote:
> On Thu, 2011-09-08 at 21:37 -0500, neubyr wrote:
>> I have a test git repository with just two files in it. One of the
>> file in it has a set of two lines that is repeated n times.
>> e.g.:
>> {{{
>> $ for i in {1..5}; do cat ./lexico.txt >> lexico1.txt && =A0cat
>> ./lexico.txt >> lexico1.txt && mv ./lexico1.txt ./lexico.txt; =A0don=
e
>> }}}
>>
>
> So you've just created some data that can be compressed quite
> efficiently.
>
>> I ran above command few times and performed commit after each run. N=
ow
>> disk usage of this repository directory is mentioned below. The 419M
>> is working directory size and 2.7M is git repository/database size.
>>
>> {{{
>> $ du -h -d 1 .
>> 2.7M =A0 =A0./.git
>> 419M =A0 =A0.
>>
>> }}}
>>
>> Is it because of the compression performed by git before storing dat=
a
>> (or before sending commit)??
>>
>
> Yes. Git stores its objects (the commit, the snapshot of the files,
> etc.) compressed. When these objects are stored in a pack, the size c=
an
> be further reduced by storing some objects as deltas which describe t=
he
> difference between itself and some other object in the object-db.
>

Does git store deltas for some files? I thought it uses snapshots
(exact copy of staged files) only.


>> Following were results with subversion:
>>
>> Subversion client (redundant(?) copy exists in .svn/text-base/
>> directory, hence double size in client):
>> {{{
>> $ du -h -d 1
>> 416M =A0 =A0./.svn
>> 832M =A0 =A0.
>> }}}
>
> Subversion stores the "pristines" (which is the status of the files i=
n
> the latest revision) inside the .svn directory. I wouldn't call this
> copy redundant, though, as it allows you to run diff locally. The
> pristines are stored uncompressed, which is why you half of the space=
 is
> taken up by the .svn directory.
>
>>
>> Subversion repo/server:
>> {{{
>> $ du -h -d 1
>> =A012K =A0 =A0./conf
>> 1.2M =A0 =A0./db
>> =A036K =A0 =A0./hooks
>> 8.0K =A0 =A0./locks
>> 1.2M =A0 =A0.
>> }}}
>
> I don't know how the repository is stored in Subversion, but it may a=
lso
> be compressed. You may be able to reduced your git repository size by
> (re)generating packs with 'git repack' and doing some cleanups with '=
git
> gc', but the repository size is not often a concern.
>
> =A0 cmn
>
>
>

that's helpful. thanks.

--
neuby.r
