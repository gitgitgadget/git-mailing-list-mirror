From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/44] wrapper: implement xopen()
Date: Mon, 29 Jun 2015 10:18:00 -0700
Message-ID: <xmqqr3oubfhz.fsf@gitster.dls.corp.google.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-2-git-send-email-pyokagan@gmail.com>
	<5590CE10.3020104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:18:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9chA-0006cN-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbF2RSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 13:18:07 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32808 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbF2RSF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:18:05 -0400
Received: by igcur8 with SMTP id ur8so42506729igc.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=HyjIoq+42HjnqT4BNijNjZ6ROS20/vr00+0+MZwIcAo=;
        b=0o+FInCqSOWsVoGsm9G1Bg0nwESuLeOiVPMxqUVoYwU7c+wbu6iA+e1gFfzRYWy+Jd
         J7MP2ViYNXi/TsvigKSpB2rB3vGLxHWUT9FJ4rsTRjNw6XDxVwzVGCxP4Vi6LR08jkQF
         LwUH3lzeQksYYtghxSSNxCZmfhFbMJ9IaYa5SXeaoSJmpLmpm6C0Lapd3WQEUN34cmUp
         ctHT7mTE9t7t2j0qko18Dj/25DfZQ8KuAPkpcjaXETgy7TLitLgixpCl8B9DE+CVSqDr
         CjNCtA/6unFIgU0jvrLDMn9nUhvsaVlhIPKpu2BRZkdfwKmGavt5PJYpml30dTArhE69
         ynvw==
X-Received: by 10.50.79.202 with SMTP id l10mr17387583igx.7.1435598284730;
        Mon, 29 Jun 2015 10:18:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id p8sm5859089iga.13.2015.06.29.10.18.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 10:18:03 -0700 (PDT)
In-Reply-To: <5590CE10.3020104@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 29 Jun 2015 06:48:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272977>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +int xopen(const char *path, int oflag, ...)
>> +{
>> +	mode_t mode =3D 0;
>> +	va_list ap;
>> +
>> +	va_start(ap, oflag);
>> +	if (oflag & O_CREAT)
>> +		mode =3D va_arg(ap, mode_t);
>> +	va_end(ap);
>> +
>> +	assert(path);
>> +
> 2 remarks:
> - I don't know if and why we need the assert() here (but don't know i=
f
> we have a strategie in Git for assert())

There is no bright-line rules, but I think it is sensible to remove
this.  Nobody sane would throw a NULL at open(2) and xopen() is
supposed to imitate that interface.  We do protect ourselves from
careless use of our own API, but no need to clutter the code with
overly zealous check against insane code, I would say.
