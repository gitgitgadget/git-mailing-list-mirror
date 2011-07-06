From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 2/5] svn-fe: allow svnadmin instead of svnrdump in svn helper
Date: Wed, 6 Jul 2011 17:02:10 +0600
Message-ID: <CA+gfSn-mX-Uny1dy=1Xwo42r_pTYosWJibNGafV=sLrsmc-e+A@mail.gmail.com>
References: <1309884350-13415-1-git-send-email-divanorama@gmail.com>
	<1309884350-13415-3-git-send-email-divanorama@gmail.com>
	<CALkWK0=Lqg4vMOdD8zah5RM3GOkBorJ80kBfs4BHEjZrG+rNVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePs1-0007fa-Fe
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab1GFLCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:02:12 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52565 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1GFLCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:02:11 -0400
Received: by qyk29 with SMTP id 29so1997106qyk.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=U4Y+r/v1u0wCNcIun+0rEGjAWjyEOflWQSqKEyFivn8=;
        b=C5WV7sE+0s+dNwabYN7I9XEgG96/1fsWPAtaB8sK10zQtvn2eLUEUeOjk9/shVpYEG
         mbdksoVv0ckRijZmJjnvJzJbG1LCrHFCH5Eo+/ZdLpL6BR25Vu1otHRcl1/QxQhT+ZGT
         ucR9BS6kbUc/WRGzvMy73c08/6dmD/PY8zflU=
Received: by 10.229.18.81 with SMTP id v17mr6404568qca.7.1309950130978; Wed,
 06 Jul 2011 04:02:10 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Wed, 6 Jul 2011 04:02:10 -0700 (PDT)
In-Reply-To: <CALkWK0=Lqg4vMOdD8zah5RM3GOkBorJ80kBfs4BHEjZrG+rNVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176687>

On Wed, Jul 6, 2011 at 4:12 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> Hi,
>
> Dmitry Ivankov writes:
>> svnrdump produces the same stream as svnadmin dump. svnrdump is able
>> to do it via any svn remote protocol while svnadmin needs access to
>> the repository filesystem and can't produce subdirectory dumps.
>> But svnrdump is a newer tool and may be unavailable on some systems.
>>
>> Try to use svnadmin dump for file:// repository urls if there is no
>> svnrdump in the PATH. First of all this is to be used in tests, wher=
e
>> the repository is indeed local most of the time.
>
> svnrdump's output is not identical to svnadmin's output. =A0You'd
> perhaps want to document the differences, and the impact they might
> have?
Hm, I don't see much differences.
Data format is the same SVN-fs-dump-format-version: 3. In my case I
observe following differences:
- svnadmin writes sha1 checksums along with md5 ones
- hashtable dumps can have different elements dump order
- svnrdump sets Prop-delta: true for empty props
- text deltas can be encoded differently (does it affect svn:ann?)
My svnadmin is version 1.6.16 (r1073529)
svnrdump is from r1135490

Anything else I'm missing in a simple dump of a repository root?

>
>> diff --git a/contrib/svn-fe/git-remote-svn-alpha b/contrib/svn-fe/gi=
t-remote-svn-alpha
>> index 61c9b07..84d841e 100755
>> --- a/contrib/svn-fe/git-remote-svn-alpha
>> +++ b/contrib/svn-fe/git-remote-svn-alpha
>> @@ -12,10 +12,32 @@ usage () {
>> =A0 =A0 =A0 =A0exit 129
>> =A0}
>>
>> +try_svnrdump () {
>> + =A0 =A0 =A0 command -v svnrdump >/dev/null &&
>> + =A0 =A0 =A0 echo "svnrdump dump --non-interactive --username=3DGue=
st --password=3D \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --quiet --incremental" ||
>> + =A0 =A0 =A0 true
>> +}
>
> I saw this '--username', '--password' in other patches too. =A0I'm
> probably missing context, but I'm curious to know why this is require=
d
> and what you're planning to do to fix it in the future.
=46or repos with no read restrictions this isn't necessary, like those
in the test script supplied.
It's a placeholder for quick local patch if anyone wants to test a
repo with permissions.
In future it should be allowed to configure credentials in
corresponding remote section of git.config and
pass all these options to helpers. Using ~/.subversion/ configuration
is a valid option too.

>
> Thanks.
>
> -- Ram
>
