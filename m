From: =?UTF-8?Q?Pierre=2DFran=C3=A7ois_CLEMENT?= <likeyn@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 10 Jun 2014 01:22:55 +0200
Message-ID: <CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
 <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com> <87vbsayy9w.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uZ-0004KM-S5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934463AbaFIXXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 19:23:18 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:49220 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbaFIXXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 19:23:16 -0400
Received: by mail-ve0-f173.google.com with SMTP id db11so1892163veb.18
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MAOm4Jmz58eDzbAE27eqXu8TS4tlE45/yCo+XsJh2Tc=;
        b=SCmTlgHgQ7TQx4mDobsCXdwHZer4OQgXgVJAKagSpjOlWA3hSHp1Mvq1gRaPidox0I
         j704Pg9B+D2U3/TqoJyZr1x059pERL2jnStSqgxEWrePOdoDbPiX57Uh4zzTILTBvo6c
         yH0yiGGkeYNhm1sWvZ4n4wlheJVsyknEyew1l1v/CtKsNo2EhIPxFXCvVudNzWVHnwjA
         AP7EBl8o4lwidU7wSVNfH5Iztnap+trdr1UPNRDilzzn/qLDm3YtLOkV6tWakUk/58D6
         figiiDOb7At+MwhDdBHiLDfas+VNQ0arAGWO4s6FDW3OLTKkV8CgHDv5uWofa/4/VjAD
         hhZA==
X-Received: by 10.58.160.164 with SMTP id xl4mr6758127veb.38.1402356195999;
 Mon, 09 Jun 2014 16:23:15 -0700 (PDT)
Received: by 10.58.182.104 with HTTP; Mon, 9 Jun 2014 16:22:55 -0700 (PDT)
In-Reply-To: <87vbsayy9w.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251135>

2014-06-09 16:04 GMT+02:00 David Kastrup <dak@gnu.org>:
> Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:
>
>> Hi all,
>>
>> Someone pointed out on the "Git for human beings" Google group
>> (https://groups.google.com/d/topic/git-users/27_FxIV_100/discussion)
>> that using git-reset's hard mode when having staged untracked files
>> simply deletes them from the working dir.
>>
>> Since git-reset specifically doesn't touch untracked files, one coul=
d
>> expect having staged untracked files reset to their previous
>> "untracked" state rather than being deleted.
>>
>> Could this be a bug or a missing feature? Or if it isn't, can someon=
e
>> explain what we got wrong?
>
> git reset --keep maybe?
>
> In a work dir and index without modifications, I expect
>
> git apply --index ...
> git reset --hard
>
> to remove any files that git apply created.  It would not do so using
> your proposal.  I agree that it seems a bit of a borderline, but I
> consider it better that once a file _is_ tracked, git reset --hard wi=
ll
> first physically remove it before untracking it.
>
> --
> David Kastrup

Hm, I didn't think of "git apply --index"... Makes sense for this
special use, but I'm not sure about the other use cases. Consider this
scenario:

You create a new (untracked) file.
You use git-reset's hard mode to go one commit back, the new
(untracked) file's still there.
You add/stage that new file.
You use git-reset's hard mode again to go one commit back, and the new
untracked file you just staged gets deleted.

Also, according to Git-scm
(http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Reposit=
ory):

"Tracked files are files that were in the last snapshot [...].
Untracked files are everything else."

So it seems to me like staged untracked files shouldn't be considered
as tracked files, and thus shouldn't be removed. Or maybe, git-reset's
hard mode should always delete everything including untracked files?
It would also make sense, given the numerous modes it has.

--
Pierre-Fran=C3=A7ois CLEMENT
Application developer at Upcast Social
