From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 07/25] reflog: avoid constructing .lock path with git_path
Date: Sat, 1 Mar 2014 10:42:51 +0700
Message-ID: <CACsJy8A3mGCJzacaVrVUSxJnqXZ=GUhgOzpheUixpyWtYE6gDw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-8-git-send-email-pclouds@gmail.com> <xmqqr46q4xt6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 04:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJaq5-0002N6-SH
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 04:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaCADnW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 22:43:22 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:57160 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCADnV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 22:43:21 -0500
Received: by mail-qc0-f178.google.com with SMTP id i8so1720123qcq.37
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L81rsRQoI5gMf/UNh1/JHJ1WxbJQc0inG8QLktiZBHg=;
        b=X5nLkwebUbC2tFtu4gBdU8lxXzHPOv4zWkmw/qQTi5iG2iIXJ2a6WXj03vZHshzd1W
         qb+kEPAZ7LbQoO0WafmsV4Zzej6aF+xG7VYTj8lGSHmWp4CvZQNhRoEVx+uFJ6/1tEkt
         ADESlqTctzPQXPwRUetVjSRyruat7FPrnTiBThJg71ohE6RFUp/UcBEsebVrDgF/CoTg
         utiPQAzIfWSSwKrM6/Db/EzQUsUgieDRnKcSKVimlJX9Q2IAYa3tr/CyjZK56w1Y8cfG
         caruaO/rq4pZlfz7Rp2jAJoPT13znGn3KJvwCYFB1SeDPThU4qfNT54N21WJ3WwmDaY6
         Bg1w==
X-Received: by 10.140.47.212 with SMTP id m78mr8122245qga.21.1393645401212;
 Fri, 28 Feb 2014 19:43:21 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 19:42:51 -0800 (PST)
In-Reply-To: <xmqqr46q4xt6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243041>

On Wed, Feb 26, 2014 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> git_path() soon understands the path given to it. Some paths "abc" m=
ay
>> become "def" while other "ghi" may become "ijk". We don't want
>> git_path() to interfere with .lock path construction. Concatenate
>> ".lock" after the path has been resolved by git_path() so if "abc"
>> becomes "def", we'll have "def.lock", not "ijk".
>
> Hmph.  I am not sure if the above is readable (or if I am reading it
> correctly).

Definitely not now that I have had my break from the series and reread =
it.

> If "abc" becomes "def", it would take deliberate work to make
> "abc.lock" into "ijk", and it would be natural to expect that
> "abc.lock" would become "def.lock" without any fancy trick, no?

A better explanation may be, while many paths are not converted by
git_path() ("abc" -> "abc"), some of them will be based on the given
path ("def" -> "ghi"). Giving path def.lock to git_path() may confuse
it and make it believe def.lock should not be converted because the
signature is "def.lock" not "def". But we want the lock file to have
the same base name with the locked file (e.g. "ghi.lock", not
"def.lock"). So it's best to append ".lock" after git_path() has done
its conversion.

The alternative is teach git_path about ".lock", but I don't really
want to put more logic down there.
--=20
Duy
