From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 05/15] read_tree_recursive: Avoid missing blobs and
 trees in a sparse repository
Date: Sat, 4 Sep 2010 21:16:38 -0600
Message-ID: <AANLkTimsqDbtXArL_EQc+ZCqOd=tYWJ1ZXZpa7T5qUiH@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-6-git-send-email-newren@gmail.com>
	<AANLkTinkz1YG45t3njtzj--LcPs3MPbGMTj9cWG_Nj6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:16:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5in-0000Or-QF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab0IEDQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 23:16:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39252 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0IEDQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 23:16:40 -0400
Received: by fxm13 with SMTP id 13so1993461fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e7ZLu4Gm/kfUZFVS5YoTNaK9YWrv8oM2ZDgKg3aQ0D4=;
        b=V/16f1bsttjFHaJoplDlC0j7rhbE4sBupskKLrjRCvW0QzE34U7XtyvdF4IVrw7xvp
         Nihj29GqLpJSCMCg5HOpVwaIHPzH/AdGHCT5IP3cppu6H6LS3gxUmPYJ9ZPtUEl8iCvH
         tDaFuQHj9U+iAl6INapSBP+E9xjS/T/8rVeNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VR89RtQfuJNRh8bXJAxbg42IPJeUDoP3zMt0OEguA2AcHR+V5hiyl9ymEv1ymoHuk8
         rEW9sOCoqOGsswgda9Y5eUKx3KAO4bKW7tPVKsPiro6Po/lUTYfwtPanQobP0YiS+hwF
         +fZShB3v/D5//Ny/kAHM4Qh89PQiBX8ChS1Fc=
Received: by 10.223.123.79 with SMTP id o15mr856505far.95.1283656598718; Sat,
 04 Sep 2010 20:16:38 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 20:16:38 -0700 (PDT)
In-Reply-To: <AANLkTinkz1YG45t3njtzj--LcPs3MPbGMTj9cWG_Nj6B@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155416>

On Sat, Sep 4, 2010 at 8:00 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wro=
te:
>> @@ -119,6 +119,11 @@ int read_tree_recursive(struct tree *tree,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (git_sparse_pa=
thspecs &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha=
1_object_info(entry.sha1, NULL) <=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;
>> +
>
> I suppose this is temporary and the final solution would have stricte=
r
> checks (i.e. only ignore if those entries are outside sparse zone)?
> This opens a door for broken repo.

Yes, good catch.  Looks like I somehow missed that one, but I agree,
there should be an "&& !tree_entry_interesting(...)" in there.
